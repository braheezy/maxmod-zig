const mm = @import("../maxmod.zig");
const shim = @import("../shim.zig");
const mm_gba = @import("../gba/main_gba.zig");
const mas = @import("mas.zig");
const tables = @import("tables.zig");

const debug_enabled = @import("build_options").xm_debug;
const COMPR_FLAG_NOTE: mm.Word = 1;
const COMPR_FLAG_INSTR: mm.Word = 1 << 1;
const COMPR_FLAG_VOLC: mm.Word = 1 << 2;
const COMPR_FLAG_EFFC: mm.Word = 1 << 3;
const MULT_PERIOD: mm.Word = 133808;
const NOTE_CUT = 254;
const NOTE_OFF = 255;

// For tick 0
pub fn updateChannel_T0(module_channel: [*c]mm.ModuleChannel, mpp_layer: [*c]mm.LayerInfo, channel_counter: mm.Byte) linksection(".iwram") void {
    var state = determineInitialState(module_channel, mpp_layer);
    shim.t0Capture(
        1,
        channel_counter,
        module_channel,
        null,
        module_channel.*.period,
    );

    while (true) {
        switch (state) {
            .dont_start => {
                const act = getActiveChannel(module_channel);
                const actp: ?*const mm.ActiveChannel = if (act) |a| @as(*const mm.ActiveChannel, @ptrCast(a)) else null;
                shim.t0Capture(2, channel_counter, module_channel, actp, module_channel.*.period);
                const act_ch = getActiveChannel(module_channel);
                if (act_ch == null) {
                    updateChannel_TN(module_channel, mpp_layer);
                    return;
                }
                state = .started;
            },
            .glissando_affected => {
                const act_ch = getActiveChannel(module_channel);
                if (act_ch) |ch| {
                    _ = channelStartACHN(module_channel, ch, mpp_layer, channel_counter);
                    module_channel.*.flags &= @as(mm.Byte, @truncate(~@as(mm.Word, @intCast(mas.MF_START))));
                    state = .dont_start;
                } else {
                    state = .start;
                }
            },
            .start => {
                mas.mpp_Channel_NewNote(module_channel, mpp_layer);
                const act_ch = getActiveChannel(module_channel);
                if (act_ch == null) {
                    updateChannel_TN(module_channel, mpp_layer);
                    return;
                }
                const note = channelStartACHN(module_channel, act_ch.?, mpp_layer, channel_counter);
                if (act_ch.?.*.sample != 0) {
                    const sample: [*c]mas.SampleInfo = mas.mpp_SamplePointer(mpp_layer, @as(mm.Word, @intCast(act_ch.?.*.sample)));
                    module_channel.*.period = getPeriod(mpp_layer, sample.*.frequency << 2, note);
                    act_ch.?.*.flags |= mas.MCAF_START;
                }
                const actp: ?*const mm.ActiveChannel = @as(*const mm.ActiveChannel, @ptrCast(act_ch.?));
                shim.t0Capture(3, channel_counter, module_channel, actp, module_channel.*.period);
                state = .started;
            },
            .started => {
                const act = getActiveChannel(module_channel);
                const actp: ?*const mm.ActiveChannel = if (act) |a| @as(*const mm.ActiveChannel, @ptrCast(a)) else null;
                shim.t0Capture(4, channel_counter, module_channel, actp, module_channel.*.period);
                processChannelStarted(module_channel, mpp_layer);
                // Execute the rest as normal
                updateChannel_TN(module_channel, mpp_layer);
                return;
            },
        }
    }
}
// For ticks that are not the first one. Note that mpp_layer->ticks may be zero
// when this function is called (if a channel is active and the row increases).
pub fn updateChannel_TN(module_channel: [*c]mm.ModuleChannel, mpp_layer: [*c]mm.LayerInfo) linksection(".iwram") void {
    // Get channel, if available
    const act_ch = getActiveChannel(module_channel);
    // Get period, edited by other functions...
    var period: mm.Word = module_channel.*.period;

    // Clear variables
    mas.mpp_vars.sampoff = 0;
    mas.mpp_vars.volplus = 0;
    mas.mpp_vars.notedelay = 0;
    mas.mpp_vars.panplus = 0;

    // Update volume commands. Used by S3M, XM and IT. Not used by MOD.
    if ((module_channel.*.flags & mas.MF_HASVCMD) != 0) {
        period = mas.mpp_Process_VolumeCommand(mpp_layer, act_ch, module_channel, period);
    }
    // Update effects
    if ((module_channel.*.flags & mas.MF_HASFX) != 0) {
        period = mas.mpp_Process_Effect(mpp_layer, act_ch, module_channel, period);
    }
    if (act_ch == null) return;
    var volume: i32 = (@as(i32, module_channel.*.volume) * @as(i32, module_channel.*.cvolume)) >> 5;
    act_ch.?.*.volume = @intCast(volume);
    const vol_addition: mm.Sword = @intCast(mas.mpp_vars.volplus);
    volume += @as(i32, vol_addition) << 3;
    // Clamp volume
    if (volume < 0) {
        volume = 0;
    }
    if (volume > 128) {
        volume = 128;
    }
    mas.mpp_vars.afvol = @intCast(volume);
    if (mas.mpp_vars.notedelay != 0) {
        act_ch.?.*.flags |= mas.MCAF_UPDATED;
        return;
    }
    // Copy panning and period
    act_ch.?.*.panning = module_channel.*.panning;
    act_ch.?.*.period = module_channel.*.period;
    // Set to 0 temporarily. Reserved for later use.
    mas.mpp_vars.panplus = 0;
    act_ch.?.*.flags |= mas.MCAF_UPDATED;
    period = mas.mpp_Update_ACHN_notest(
        mpp_layer,
        act_ch.?,
        period,
        @intCast(module_channel.*.alloc),
    );
}
// TODO: Make tuning a bool
pub fn getPeriod(mpp_layer: [*c]mm.LayerInfo, tuning: mm.Word, note: mm.Byte) linksection(".iwram") mm.Word {
    // Tuning not used here with linear periods
    if ((mpp_layer.*.flags & mas.MAS_HEADER_FLAG_FREQ_MODE) != 0) {
        const table_words: [*]const mm.Word = @ptrCast(@alignCast(&tables.IT_PitchTable));
        return table_words[note];
    }
    // (note mod 12) << 1
    const r0: mm.Word = @intCast(tables.note_table_mod[note]);
    // (note / 12)
    const r2: mm.Word = @intCast(tables.note_table_oct[note >> 2]);
    // Uses pre-calculated results of /12 and %12
    var ret_val: mm.Word = @intCast((tables.ST3_FREQTABLE[r0] * MULT_PERIOD) >> @intCast(r2));
    if (tuning != 0) {
        ret_val /= tuning;
    }
    return ret_val;
}
// It returns false on error (if the song tries to use more channels than available
// to Maxmod. On success, it returns true.
pub fn readPattern(mpp_layer: [*c]mm.LayerInfo) linksection(".iwram") bool {
    const instr_count: mm.Word = @intCast(mpp_layer.*.songadr.*.instr_count);
    const flags: mm.Word = @intCast(mpp_layer.*.flags);
    var module_channels: [*c]mm.ModuleChannel = mm_gba.mpp_channels;
    mas.mpp_vars.pattread_p = mpp_layer.*.pattread;
    var pattern: [*c]mm.Byte = mas.mpp_vars.pattread_p;
    var update_bits: mm.Word = 0;
    while (true) {
        const read_byte: mm.Byte = (blk: {
            const ref = &pattern;
            const tmp = ref.*;
            ref.* += 1;
            break :blk tmp;
        }).*;
        // 0 = end of row
        if ((read_byte & 127) == 0) {
            break;
        }
        var pattern_flags: mm.Word = 0;
        const chan_calculation = (read_byte & 127) - 1;
        const chan_num: mm.Byte = chan_calculation;
        // Check that this channel index is inside of the limits of this layer
        if (chan_num >= mm_gba.mpp_nchannels) {
            // Non-XM mode: return error for invalid channels
            return false;
        }
        update_bits |= @as(mm.Word, @intCast(1)) << @intCast(chan_num);
        const module_channel: [*c]mm.ModuleChannel = &module_channels[chan_num];
        // Read new maskvariable if bit was set and save it, otherwise use the
        // previous flags.
        if ((read_byte & (1 << 7)) != 0) {
            module_channel.*.cflags = (blk: {
                const ref = &pattern;
                const tmp = ref.*;
                ref.* += 1;
                break :blk tmp;
            }).*;
        }
        const compr_flags: mm.Word = @intCast(module_channel.*.cflags);
        if ((compr_flags & COMPR_FLAG_NOTE) != 0) {
            const note: mm.Byte = (blk: {
                const ref = &pattern;
                const tmp = ref.*;
                ref.* += 1;
                break :blk tmp;
            }).*;
            if (note == NOTE_CUT) {
                pattern_flags |= mas.MF_NOTECUT;
            } else if (note == NOTE_OFF) {
                pattern_flags |= mas.MF_NOTEOFF;
            } else {
                module_channel.*.pnoter = note;
            }
        }
        if ((compr_flags & COMPR_FLAG_INSTR) != 0) {
            // Read instrument value
            var instr: mm.Byte = (blk: {
                const ref = &pattern;
                const tmp = ref.*;
                ref.* += 1;
                break :blk tmp;
            }).*;
            // Act if it's playing
            if ((pattern_flags & (mas.MF_NOTECUT | mas.MF_NOTEOFF)) == 0) {
                // Validate instrument. Note that instrument index 0 means "no
                // instrument". If instr_count is 10, the minimum valid
                // instrument is 1 and the maximum is 10.
                if (instr > instr_count) {
                    instr = 0;
                }
                if (module_channel.*.inst != instr) {
                    // Check 'mod/s3m' flag
                    if ((flags & mas.MAS_HEADER_FLAG_OLD_MODE) != 0) {
                        pattern_flags |= mas.MF_START;
                    }
                    // Set new instrument flag
                    pattern_flags |= mas.MF_NEWINSTR;
                }
                // Update instrument
                module_channel.*.inst = instr;
            }
        }
        // Copy VCMD
        if ((compr_flags & COMPR_FLAG_VOLC) != 0) {
            module_channel.*.volcmd = (blk: {
                const ref = &pattern;
                const tmp = ref.*;
                ref.* += 1;
                break :blk tmp;
            }).*;
        }
        // Copy Effect and param
        if ((compr_flags & COMPR_FLAG_EFFC) != 0) {
            module_channel.*.effect = (blk: {
                const ref = &pattern;
                const tmp = ref.*;
                ref.* += 1;
                break :blk tmp;
            }).*;
            module_channel.*.param = (blk: {
                const ref = &pattern;
                const tmp = ref.*;
                ref.* += 1;
                break :blk tmp;
            }).*;
        }
        // Map compressed field-presence bits into module_channel.flags upper nibble.
        // Bit layout from C: note=1<<0, inst=1<<1, vol=1<<2, eff=1<<3;
        // runtime flags expect these at bits 4..7. Use right shift by 4 (like C code).
        module_channel.*.flags = @intCast(pattern_flags | (compr_flags >> 4));
    }
    mpp_layer.*.pattread = pattern;
    mpp_layer.*.mch_update = update_bits;
    if (debug_enabled) shim.debug_state.mpp_layer_update_bits = update_bits;
    return true;
}

const ChannelState = enum {
    dont_start,
    glissando_affected,
    start,
    started,
};

// Determine initial state based on C logic
fn determineInitialState(module_channel: [*c]mm.ModuleChannel, mpp_layer: [*c]mm.LayerInfo) ChannelState {
    // Test start flag
    if ((module_channel.*.flags & mas.MF_START) == 0) {
        return .dont_start;
    }

    // Test effect flag
    if ((module_channel.*.flags & mas.MF_HASFX) != 0) {
        // Always start channel if it's a new instrument
        if ((module_channel.*.flags & mas.MF_NEWINSTR) != 0) {
            return .start;
        }

        // Check if the effect is glissando
        if (module_channel.*.effect == mas.GLISSANDO_EFFECT) {
            return .glissando_affected;
        }
    }

    // Always start channel if it's a new instrument
    if ((module_channel.*.flags & mas.MF_NEWINSTR) != 0) {
        return .start;
    }

    // Test for volume command
    if ((module_channel.*.flags & mas.MF_HASVCMD) == 0) {
        return .start;
    }

    if ((mpp_layer.*.flags & mas.MAS_HEADER_FLAG_XM_MODE) != 0) {
        // XM effects - Glissando is 193..202
        if ((module_channel.*.volcmd < mas.GLISSANDO_IT_VOLCMD_START) or
            (module_channel.*.volcmd > mas.GLISSANDO_IT_VOLCMD_END))
        {
            return .start;
        }
    } else {
        // IT effects - Glissando is Fx
        if (module_channel.*.volcmd < mas.GLISSANDO_MX_VOLCMD_START) {
            return .start;
        }
    }

    return .glissando_affected;
}
// New note action (NNA)
pub inline fn MCH_BFLAGS_NNA_SET(x: anytype) @TypeOf((x << mas.MCH_BFLAGS_NNA_SHIFT) & mas.MCH_BFLAGS_NNA_MASK) {
    return (x << mas.MCH_BFLAGS_NNA_SHIFT) & mas.MCH_BFLAGS_NNA_MASK;
}
// Process channel started state
fn processChannelStarted(module_channel: [*c]mm.ModuleChannel, mpp_layer: [*c]mm.LayerInfo) void {
    const act_ch = getActiveChannel(module_channel);
    if (act_ch == null) return;

    if ((module_channel.*.flags & mas.MF_DVOL) != 0) {
        if (module_channel.*.inst != 0) {
            // Get instrument pointer
            const instrument = mas.instrumentPointer(mpp_layer, module_channel.*.inst) orelse unreachable;

            // Clear old nna and set the new one
            module_channel.*.bflags &= @as(mm.Hword, @truncate(~@as(mm.Word, @intCast(mas.MCH_BFLAGS_NNA_MASK))));
            module_channel.*.bflags |= MCH_BFLAGS_NNA_SET(instrument.*.nna);

            if ((instrument.*.env_flags & mas.MAS_INSTR_FLAG_VOL_ENV_ENABLED) != 0) {
                act_ch.?.*.flags |= @as(mm.Byte, @intCast(mas.MCAF_VOLENV));
            } else {
                act_ch.?.*.flags &= @as(mm.Byte, @truncate(~@as(mm.Word, @intCast(mas.MCAF_VOLENV))));
            }

            // The MSB determines if we need to set a new panning value
            if ((instrument.*.panning & 0x80) != 0) {
                module_channel.*.panning = (instrument.*.panning & 0x7F) << 1;
            }
        }

        if (act_ch.?.*.sample != 0) {
            // Get sample pointer
            const sample: [*c]mas.SampleInfo = mas.mpp_SamplePointer(mpp_layer, @as(mm.Word, @intCast(act_ch.?.*.sample)));
            module_channel.*.volume = sample.*.default_volume;

            // The MSB determines if we need to set a new panning value
            if ((sample.*.panning & 0x80) != 0) {
                module_channel.*.panning = (sample.*.panning & 0x7F) << 1;
            }
        }
    }

    if ((module_channel.*.flags & (mas.MF_START | mas.MF_DVOL)) != 0) {
        if (((mpp_layer.*.flags & mas.MAS_HEADER_FLAG_XM_MODE) == 0) or ((module_channel.*.flags & mas.MF_DVOL) != 0)) {
            // Reset volume
            act_ch.?.*.fade = 1024; // Max volume
            act_ch.?.*.envc_vol = 0;
            act_ch.?.*.envc_pan = 0;
            act_ch.?.*.envc_pic = 0;
            act_ch.?.*.avib_dep = 0;
            act_ch.?.*.avib_pos = 0;
            act_ch.?.*.envn_vol = 0;
            act_ch.?.*.envn_pan = 0;
            act_ch.?.*.envn_pic = 0;

            // Clear fx memory
            module_channel.*.fxmem = 0;

            // Set keyon and clear envend + fade
            act_ch.?.*.flags |= @as(mm.Byte, @truncate(@as(mm.Word, @intCast(mas.MCAF_KEYON))));
            act_ch.?.*.flags &= @as(mm.Byte, @truncate(~@as(mm.Word, @intCast(mas.MCAF_ENVEND | mas.MCAF_FADE))));
        }
    }

    if ((module_channel.*.flags & mas.MF_NOTEOFF) != 0) {
        act_ch.?.*.flags &= @as(mm.Byte, @truncate(~@as(mm.Word, @intCast(mas.MCAF_KEYON))));

        const is_xm_mode = mpp_layer.*.flags & mas.MAS_HEADER_FLAG_XM_MODE;

        // XM starts fade immediately on note-off
        if (is_xm_mode != 0) {
            act_ch.?.*.flags |= @as(mm.Byte, @intCast(mas.MCAF_FADE));
        }
    }

    if ((module_channel.*.flags & mas.MF_NOTECUT) != 0) {
        module_channel.*.volume = 0;
    }

    module_channel.*.flags &= @as(mm.Byte, @truncate(~@as(mm.Word, @intCast(mas.MF_START))));
}

fn channelStartACHN(module_channel: [*c]mm.ModuleChannel, active_channel: [*c]mm.ActiveChannel, mpp_layer: [*c]mm.LayerInfo, channel_counter: mm.Byte) linksection(".iwram") mm.Byte {
    // Clear tremor/cutvol
    module_channel.*.bflags &= ~@as(mm.Hword, mas.MCH_BFLAGS_CUT_VOLUME | mas.MCH_BFLAGS_TREMOR);
    if (active_channel != null) {
        // Set foreground type
        active_channel.*._type = mas.ACHN_FOREGROUND;
        // Clear SUB/EFFECT and store layer
        active_channel.*.flags &= ~@as(mm.Byte, mas.MCAF_SUB | mas.MCAF_EFFECT);
        if (mas.mpp_clayer == .jingle) {
            active_channel.*.flags |= mas.MCAF_SUB;
        }
        // Store parent
        active_channel.*.parent = channel_counter;
        // Copy instrument
        active_channel.*.inst = module_channel.*.inst;
    }
    // Previously, it did not set the return parameter properly
    // TODO: This is what the code does, is it a bug?
    if (module_channel.*.inst == 0) return @intCast(module_channel.*.bflags);

    // Get instrument pointer
    const instrument: *mas.Instrument = mas.instrumentPointer(mpp_layer, module_channel.*.inst) orelse unreachable;

    // TODO: Use Instrument struct properly
    // Read raw bytes at offset 8 (after 8 mm.Byte fields) and decode manually.
    const inst_bytes: [*]const u8 = @ptrCast(instrument);
    const bitfield_raw: u16 = @as(u16, inst_bytes[8]) | (@as(u16, inst_bytes[9]) << 8);
    const nm_off: usize = @as(usize, @intCast(bitfield_raw & 0x7FFF)); // bits 0-14
    const invalid_map: bool = ((bitfield_raw & 0x8000) != 0); // bit 15
    // Check if note_map exists
    // If this is set, it doesn't!
    if (invalid_map) {
        // No valid note map: use instrument default mapping
        if (active_channel != null) {
            active_channel.*.sample = @as(mm.Byte, @intCast(nm_off & 0xFF));
        }
        module_channel.*.note = module_channel.*.pnoter;
    } else {
        // Proper note map: 16-bit little-endian entries, low byte is note, high byte is sample index.
        // Avoid halfword-aligned loads because instrument/map can be at odd addresses in MAS.
        const inst_base: usize = @intFromPtr(instrument);
        const map_bytes: [*]const u8 = @ptrFromInt(inst_base + nm_off);
        const idx: usize = @as(usize, @intCast(module_channel.*.pnoter));
        const lo: u16 = map_bytes[idx * 2];
        const hi: u16 = map_bytes[idx * 2 + 1];
        const entry: u16 = lo | (hi << 8);
        // Write note value
        module_channel.*.note = @as(mm.Byte, @intCast(entry & 0xFF));
        // Write sample value
        if (active_channel != null) {
            active_channel.*.sample = @as(mm.Byte, @intCast((entry >> 8) & 0xFF));
        }
    }
    return module_channel.*.note;
}
fn getActiveChannel(module_channel: [*c]mm.ModuleChannel) linksection(".iwram") ?[*c]mm.ActiveChannel {
    var act_ch: ?[*c]mm.ActiveChannel = null;
    if (module_channel.*.alloc != 255) {
        act_ch = &mm_gba.achannels[module_channel.*.alloc];
    }
    return act_ch;
}
