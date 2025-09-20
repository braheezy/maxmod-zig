const mm = @import("../maxmod.zig");
const shim = @import("../shim.zig");
const mm_gba = @import("../gba/main_gba.zig");
const mas = @import("mas.zig");
const tables = @import("tables.zig");

const debug_enabled = @import("build_options").xm_debug;

// Debug printing helper that can be compiled out
inline fn debugPrint(comptime fmt: []const u8, args: anytype) void {
    if (debug_enabled) {
        @import("gba").debug.print(fmt, args) catch {};
    }
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

// Setup channel sample (extracted from original logic)
// fn setupChannelSample(module_channel: [*c]mm.ModuleChannel, act_ch: [*c]mm.ActiveChannel, mpp_layer: [*c]mm.LayerInfo, channel_counter: mm.Byte, note: mm.Word) void {
//     const sample: [*c]mas.SampleInfo = mas.mpp_SamplePointer(mpp_layer, @as(mm.Word, @intCast(act_ch.*.sample)));

//     // One-time channel start log (first two channels, tick==0 only)
//     // if (mpp_layer.*.tick == 0 and channel_counter < 2) {
//     //     debugPrint("[CHSTART] ch={d} inst={d} sample={d} src={x} flags={x}\n", .{ @as(c_int, @intCast(channel_counter)), @as(c_int, @intCast(module_channel.*.inst)), @as(c_int, @intCast(act_ch.*.sample)), @intFromPtr(sample), @as(c_int, @intCast(module_channel.*.flags)) });
//     // }

//     // // On new note, seed module channel volume from sample default volume (XM semantics)
//     // module_channel.*.volume = sample.*.default_volume;
//     // // tuning: sample->frequency << 2 (C5Speed * 4)
//     // const tuning: mm.Word = @as(mm.Word, @intCast(@as(u32, sample.*.frequency) << 2));
//     // // Compute initial period like C at T0
//     // module_channel.*.period = getPeriod(mpp_layer, tuning, @as(mm.Byte, @intCast(note)));
//     // // Seed active-channel state so downstream pitch/volume uses correct sample/inst
//     // act_ch.*.period = module_channel.*.period;
//     // act_ch.*.inst = module_channel.*.inst;
//     // // Set VOLENV flag from instrument default like C
//     // const instrument: [*c]mas.Instrument = mas.instrumentPointer(mpp_layer, module_channel.*.inst);
//     // if (@intFromPtr(instrument) != 0) {
//     //     if ((@as(c_int, @intCast(instrument.*.env_flags)) & mas.MAS_INSTR_FLAG_VOL_ENV_ENABLED) != 0) {
//     //         act_ch.*.flags |= @as(mm.Byte, @intCast(mas.MCAF_VOLENV));
//     //     } else {
//     //         act_ch.*.flags = @as(mm.Byte, @intCast(@as(c_int, act_ch.*.flags) & ~mas.MCAF_VOLENV));
//     //     }
//     // }
//     // // On new note: set KEYON and reset envelope/fade state to active, like C
//     // act_ch.*.flags |= @as(mm.Byte, @intCast(mas.MCAF_KEYON));
//     // // Clear ENVEND/FADE bits
//     // act_ch.*.flags = @as(mm.Byte, @intCast(@as(c_int, act_ch.*.flags) & ~(@as(c_int, mas.MCAF_ENVEND) | @as(c_int, mas.MCAF_FADE))));
//     // // Reset envelope counters and nodes at note start
//     // act_ch.*.envc_vol = 0;
//     // act_ch.*.envn_vol = 0;
//     // act_ch.*.envc_pan = 0;
//     // act_ch.*.envn_pan = 0;
//     // act_ch.*.envc_pic = 0;
//     // act_ch.*.envn_pic = 0;
//     // // Ensure fade starts at full (1024) like original C core
//     // if (act_ch.*.fade == 0) {
//     //     act_ch.*.fade = 1024;
//     // }
//     // // Carry channel volume/cvolume into afvol like C does in TN
//     // var volume: c_int = (@as(c_int, @intCast(module_channel.*.volume)) * @as(c_int, @intCast(module_channel.*.cvolume))) >> 5;
//     // if (volume < 0) volume = 0;
//     // if (volume > 128) volume = 128;
//     // mas.mpp_vars.afvol = @as(mm.Byte, @intCast(volume));
//     // // Match C: mark UPDATED here so mpp_Update_ACHN() won't re-enter this tick
//     // act_ch.*.flags |= @as(mm.Byte, @intCast(mas.MCAF_UPDATED));
//     // act_ch.*.flags |= @as(mm.Byte, @intCast(mas.MCAF_START));
// }

pub inline fn MCH_BFLAGS_NNA_SET(x: anytype) @TypeOf((x << mas.MCH_BFLAGS_NNA_SHIFT) & mas.MCH_BFLAGS_NNA_MASK) {
    return (x << mas.MCH_BFLAGS_NNA_SHIFT) & mas.MCH_BFLAGS_NNA_MASK;
}
// Process channel started state (extracted from original logic)
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

pub fn updateChannel_T0(module_channel: [*c]mm.ModuleChannel, mpp_layer: [*c]mm.LayerInfo, channel_counter: mm.Byte) linksection(".iwram") void {
    // Determine initial state based on C logic
    var state = determineInitialState(module_channel, mpp_layer);
    shim.t0Capture(1, channel_counter, module_channel, null, module_channel.*.period);

    while (true) {
        switch (state) {
            .dont_start => {
                {
                    const act = getActiveChannel(module_channel);
                    const actp: ?*const mm.ActiveChannel = if (act) |a| @as(*const mm.ActiveChannel, @ptrCast(a)) else null;
                    shim.t0Capture(2, channel_counter, module_channel, actp, module_channel.*.period);
                }
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
                {
                    const actp: ?*const mm.ActiveChannel = @as(*const mm.ActiveChannel, @ptrCast(act_ch.?));
                    shim.t0Capture(3, channel_counter, module_channel, actp, module_channel.*.period);
                }
                state = .started;
            },
            .started => {
                {
                    const act = getActiveChannel(module_channel);
                    const actp: ?*const mm.ActiveChannel = if (act) |a| @as(*const mm.ActiveChannel, @ptrCast(a)) else null;
                    shim.t0Capture(4, channel_counter, module_channel, actp, module_channel.*.period);
                }
                processChannelStarted(module_channel, mpp_layer);
                updateChannel_TN(module_channel, mpp_layer);
                return;
            },
        }
    }
}
// For ticks that are not the first one. Note that mpp_layer->ticks may be zero
// when this function is called (if a channel is active and the row increases).
pub fn updateChannel_TN(module_channel: [*c]mm.ModuleChannel, mpp_layer: [*c]mm.LayerInfo) linksection(".iwram") void {
    const act_ch = getActiveChannel(module_channel);
    var period: mm.Word = module_channel.*.period;

    mas.mpp_vars.sampoff = 0;
    mas.mpp_vars.volplus = 0;
    mas.mpp_vars.notedelay = 0;
    mas.mpp_vars.panplus = 0;
    if ((module_channel.*.flags & 4) != 0) {
        period = mas.mpp_Process_VolumeCommand(mpp_layer, act_ch, module_channel, period);
    }
    if ((module_channel.*.flags & 8) != 0) {
        period = mas.mpp_Process_Effect(mpp_layer, act_ch, module_channel, period);
    }
    if (act_ch == null) return;
    var volume: i32 = (@as(i32, module_channel.*.volume) * @as(i32, module_channel.*.cvolume)) >> 5;
    act_ch.?.*.volume = @intCast(volume);
    const vol_addition: mm.Sword = @intCast(mas.mpp_vars.volplus);
    volume += @as(i32, vol_addition) << 3;
    if (volume < 0) {
        volume = 0;
    }
    if (volume > 128) {
        volume = 128;
    }
    mas.mpp_vars.afvol = @intCast(volume);
    if (mas.mpp_vars.notedelay != 0) {
        act_ch.?.*.flags |= @as(mm.Byte, @bitCast(@as(i8, @truncate(@as(c_int, 1) << @intCast(3)))));
        return;
    }
    act_ch.?.*.panning = module_channel.*.panning;
    act_ch.?.*.period = module_channel.*.period;
    mas.mpp_vars.panplus = 0;
    act_ch.?.*.flags |= @as(mm.Byte, @bitCast(@as(i8, @truncate(@as(c_int, 1) << @intCast(3)))));
    period = mas.mpp_Update_ACHN_notest(mpp_layer, act_ch.?, period, @as(mm.Word, @bitCast(@as(c_uint, module_channel.*.alloc))));
}
pub fn getPeriod(mpp_layer: [*c]mm.LayerInfo, tuning: mm.Word, note: mm.Byte) linksection(".iwram") mm.Word {
    if ((@as(c_int, @bitCast(@as(c_uint, mpp_layer.*.flags))) & (@as(c_int, 1) << @intCast(2))) != 0) {
        // XM linear period mode: original C reads as 32-bit words from the 16-bit table
        // return ((mm.Word*)IT_PitchTable)[note];
        const table_words: [*]const mm.Word = @ptrCast(@alignCast(&tables.IT_PitchTable));
        return table_words[@as(usize, @intCast(note))];
    }
    const r0: mm.Word = @as(mm.Word, @bitCast(@as(c_uint, tables.note_table_mod[note])));
    const r2: mm.Word = @as(mm.Word, @bitCast(@as(c_uint, tables.note_table_oct[@as(c_uint, @intCast(@as(c_int, @bitCast(@as(c_uint, note))) >> @intCast(2)))])));
    var ret_val: mm.Word = @as(mm.Word, @bitCast((@as(c_int, @bitCast(@as(c_uint, tables.ST3_FREQTABLE[r0]))) * @as(c_int, 133808)) >> @intCast(r2)));
    if (tuning != 0) {
        ret_val /= tuning;
    }
    return ret_val;
}
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
        if ((read_byte & 127) == 0) {
            break;
        }
        var pattern_flags: mm.Word = 0;
        const chan_calculation = (read_byte & 127) - 1;
        const chan_num: mm.Byte = chan_calculation;
        if (chan_num >= mm_gba.mpp_nchannels) {
            // Non-XM mode: return error for invalid channels
            return false;
        }
        update_bits |= @as(mm.Word, @intCast(1)) << @intCast(chan_num);
        const module_channel: [*c]mm.ModuleChannel = &module_channels[chan_num];
        if (read_byte & (@as(c_int, 1) << @intCast(7)) != 0) {
            module_channel.*.cflags = (blk: {
                const ref = &pattern;
                const tmp = ref.*;
                ref.* += 1;
                break :blk tmp;
            }).*;
        }
        const compr_flags: mm.Word = @intCast(module_channel.*.cflags);
        if ((compr_flags & 1) != 0) {
            const note: mm.Byte = (blk: {
                const ref = &pattern;
                const tmp = ref.*;
                ref.* += 1;
                break :blk tmp;
            }).*;
            if (note == 254) {
                pattern_flags |= 128;
            } else if (note == 255) {
                pattern_flags |= 64;
            } else {
                module_channel.*.pnoter = note;
            }
        }
        if ((compr_flags & @as(mm.Word, @bitCast(@as(c_int, 1) << @intCast(1)))) != 0) {
            var instr: mm.Byte = (blk: {
                const ref = &pattern;
                const tmp = ref.*;
                ref.* += 1;
                break :blk tmp;
            }).*;
            if ((pattern_flags & (128 | 64)) == 0) {
                if (instr > instr_count) {
                    instr = 0;
                }
                if (module_channel.*.inst != instr) {
                    if ((flags & @as(mm.Word, @bitCast(@as(c_int, 1) << @intCast(5)))) != 0) {
                        pattern_flags |= 1;
                    }
                    pattern_flags |= 16;
                }
                module_channel.*.inst = instr;
            }
        }
        if ((compr_flags & @as(mm.Word, @bitCast(@as(c_int, 1) << @intCast(2)))) != 0) {
            module_channel.*.volcmd = (blk: {
                const ref = &pattern;
                const tmp = ref.*;
                ref.* += 1;
                break :blk tmp;
            }).*;
        }
        if ((compr_flags & @as(mm.Word, @bitCast(@as(c_int, 1) << @intCast(3)))) != 0) {
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
    shim.debug_state.mpp_layer_update_bits = update_bits;
    return true;
}
fn channelStartACHN(module_channel: [*c]mm.ModuleChannel, active_channel: [*c]mm.ActiveChannel, mpp_layer: [*c]mm.LayerInfo, channel_counter: mm.Byte) linksection(".iwram") mm.Byte {
    module_channel.*.bflags &= @as(mm.Hword, @bitCast(@as(c_short, @truncate(~((@as(c_int, 1) << @intCast(10)) | (@as(c_int, 1) << @intCast(9)))))));
    if (active_channel != null) {
        active_channel.*._type = 3;
        active_channel.*.flags &= @as(mm.Byte, @bitCast(@as(i8, @truncate(~((@as(c_int, 1) << @intCast(6)) | (@as(c_int, 1) << @intCast(7)))))));
        if (mas.mpp_clayer == .jingle) {
            active_channel.*.flags |= @as(mm.Byte, @bitCast(@as(i8, @truncate(@as(c_int, 1) << @intCast(6)))));
        }
        active_channel.*.parent = channel_counter;
        active_channel.*.inst = module_channel.*.inst;
    }
    if (@as(c_int, @bitCast(@as(c_uint, module_channel.*.inst))) == @as(c_int, 0)) return @as(mm.Byte, @bitCast(@as(u8, @truncate(module_channel.*.bflags))));
    const instrument: *mas.Instrument = mas.instrumentPointer(mpp_layer, @as(mm.Word, @bitCast(@as(c_uint, module_channel.*.inst)))) orelse unreachable;
    // Read raw bytes at offset 8 (after 8 mm.Byte fields) and decode manually.
    const inst_bytes: [*]const u8 = @ptrCast(instrument);
    const bitfield_raw: u16 = @as(u16, inst_bytes[8]) | (@as(u16, inst_bytes[9]) << 8);
    const nm_off: usize = @as(usize, @intCast(bitfield_raw & 0x7FFF)); // bits 0-14
    const invalid_map: bool = ((bitfield_raw & 0x8000) != 0); // bit 15
    // One-time detailed dump for mapping on first two channels at tick 0
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
        module_channel.*.note = @as(mm.Byte, @intCast(entry & 0xFF));
        if (active_channel != null) {
            active_channel.*.sample = @as(mm.Byte, @intCast((entry >> 8) & 0xFF));
        }
    }
    // Minimal mapping debug on first channels/tick 0 (guarded)
    return module_channel.*.note;
}
fn getActiveChannel(module_channel: [*c]mm.ModuleChannel) linksection(".iwram") ?[*c]mm.ActiveChannel {
    var act_ch: ?[*c]mm.ActiveChannel = null;
    if (module_channel.*.alloc != 255) {
        act_ch = &mm_gba.achannels[module_channel.*.alloc];
    }
    return act_ch;
}
