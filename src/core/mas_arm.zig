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

pub fn updateChannel_T0(module_channel: [*c]mm.ModuleChannel, mpp_layer: [*c]mm.LayerInfo, channel_counter: mm.Byte) linksection(".iwram") void {
    // Fast path: if no start flag, ensure TN continues or exits
    if ((@as(c_int, @intCast(module_channel.*.flags)) & mas.MF_START) == 0) {
        const act0: [*c]mm.ActiveChannel = getActiveChannel(module_channel);
        if (act0 == @as([*c]mm.ActiveChannel, @ptrFromInt(0))) {
            updateChannel_TN(module_channel, mpp_layer);
            return;
        }
        // Fallthrough to TN
        updateChannel_TN(module_channel, mpp_layer);
        return;
    }

    // Start new note
    mas.mpp_Channel_NewNote(module_channel, mpp_layer);
    const act_ch: [*c]mm.ActiveChannel = getActiveChannel(module_channel);
    var act_ch_mut: [*c]mm.ActiveChannel = act_ch;
    if (act_ch_mut == @as([*c]mm.ActiveChannel, @ptrFromInt(0))) {
        // Fallback: allocate an active channel now if NewNote didn't
        const alloc_idx: mm.Word = mas.allocChannel();
        module_channel.*.alloc = @as(mm.Byte, @intCast(alloc_idx));
        act_ch_mut = getActiveChannel(module_channel);
        // No extra UCT0 debug in C reference
        if (act_ch_mut == @as([*c]mm.ActiveChannel, @ptrFromInt(0))) {
            updateChannel_TN(module_channel, mpp_layer);
            return;
        }
    }

    var note: mm.Word = channelStartACHN(module_channel, act_ch_mut, mpp_layer, channel_counter);
    if (note == 0 and module_channel.*.pnoter != 0) {
        note = module_channel.*.pnoter;
        module_channel.*.note = @as(mm.Byte, @intCast(note));
    }
    // No fallback: rely on mmChannelStartACHN to set sample/note like C
    if (act_ch_mut.*.sample != 0) {
        const sample: [*c]mas.SampleInfo = mas.mpp_SamplePointer(mpp_layer, @as(mm.Word, @intCast(act_ch_mut.*.sample)));

        // One-time channel start log (first two channels, tick==0 only)
        if (mpp_layer.*.tick == 0 and channel_counter < 2) {
            debugPrint("[CHSTART] ch={d} inst={d} sample={d} src={x} flags={x}\n", .{ @as(c_int, @intCast(channel_counter)), @as(c_int, @intCast(module_channel.*.inst)), @as(c_int, @intCast(act_ch_mut.*.sample)), @intFromPtr(sample), @as(c_int, @intCast(module_channel.*.flags)) });
        }

        // On new note, seed module channel volume from sample default volume (XM semantics)
        module_channel.*.volume = sample.*.default_volume;
        // tuning: sample->frequency << 2 (C5Speed * 4)
        const tuning: mm.Word = @as(mm.Word, @intCast(@as(u32, sample.*.frequency) << 2));
        // Compute initial period like C at T0
        module_channel.*.period = getPeriod(mpp_layer, tuning, @as(mm.Byte, @intCast(note)));
        // Seed active-channel state so downstream pitch/volume uses correct sample/inst
        act_ch_mut.*.period = module_channel.*.period;
        act_ch_mut.*.inst = module_channel.*.inst;
        // Set VOLENV flag from instrument default like C
        const instrument: [*c]mas.Instrument = mas.instrumentPointer(mpp_layer, module_channel.*.inst);
        if (@intFromPtr(instrument) != 0) {
            if ((@as(c_int, @intCast(instrument.*.env_flags)) & mas.MAS_INSTR_FLAG_VOL_ENV_ENABLED) != 0) {
                act_ch_mut.*.flags |= @as(mm.Byte, @intCast(mas.MCAF_VOLENV));
            } else {
                act_ch_mut.*.flags = @as(mm.Byte, @intCast(@as(c_int, act_ch_mut.*.flags) & ~mas.MCAF_VOLENV));
            }
        }
        // On new note: set KEYON and reset envelope/fade state to active, like C
        act_ch_mut.*.flags |= @as(mm.Byte, @intCast(mas.MCAF_KEYON));
        // Clear ENVEND/FADE bits
        act_ch_mut.*.flags = @as(mm.Byte, @intCast(@as(c_int, act_ch_mut.*.flags) & ~(@as(c_int, mas.MCAF_ENVEND) | @as(c_int, mas.MCAF_FADE))));
        // Reset envelope counters and nodes at note start
        act_ch_mut.*.envc_vol = 0;
        act_ch_mut.*.envn_vol = 0;
        act_ch_mut.*.envc_pan = 0;
        act_ch_mut.*.envn_pan = 0;
        act_ch_mut.*.envc_pic = 0;
        act_ch_mut.*.envn_pic = 0;
        // Do not use MCAF_VOLENV in Zig port; envelope processing uses instrument flags directly
        // Ensure fade is non-zero before any volume computation on first ACHN update
        if (act_ch_mut.*.fade == 0) act_ch_mut.*.fade = 1024;
        // Ensure fade starts at full (1024) like original C core
        // Without this, volume pipeline multiplies by 0 and results in silence
        if (act_ch_mut.*.fade == 0) {
            act_ch_mut.*.fade = 1024;
        }
        // Carry channel volume/cvolume into afvol like C does in TN
        var volume: c_int = (@as(c_int, @intCast(module_channel.*.volume)) * @as(c_int, @intCast(module_channel.*.cvolume))) >> 5;
        if (volume < 0) volume = 0;
        if (volume > 128) volume = 128;
        mas.mpp_vars.afvol = @as(mm.Byte, @intCast(volume));
        // Match C: mark UPDATED here so mpp_Update_ACHN() won't re-enter this tick
        act_ch_mut.*.flags |= @as(mm.Byte, @intCast(mas.MCAF_UPDATED));
        act_ch_mut.*.flags |= @as(mm.Byte, @intCast(mas.MCAF_START));
        // Capture note start for all channels (low overhead: buffered)
        @import("capture.zig").capture(
            mpp_layer,
            @import("capture.zig").Kind.Start,
            @as(i32, @intCast(channel_counter)),
            @as(i32, @intCast(module_channel.*.inst)),
            @as(i32, @intCast(act_ch_mut.*.sample)),
            @as(i32, @intCast(act_ch_mut.*.flags)),
            0,
        );
        // No extra UCT0 debug in C reference
    }

    // Clear start flag and continue normal processing
    module_channel.*.flags = @as(mm.Byte, @intCast(@as(c_int, @intCast(module_channel.*.flags)) & ~mas.MF_START));
    // No extra UCT0 debug in C reference
    updateChannel_TN(module_channel, mpp_layer);
}
pub fn updateChannel_TN(module_channel: [*c]mm.ModuleChannel, mpp_layer: [*c]mm.LayerInfo) linksection(".iwram") void {
    const act_ch: [*c]mm.ActiveChannel = getActiveChannel(module_channel);
    var period: mm.Word = module_channel.*.period;
    // Guard: if fade is unset, initialize to full (1024) before volume pipeline
    if (act_ch != @as([*c]mm.ActiveChannel, @ptrCast(@alignCast(@as(?*anyopaque, @ptrFromInt(@as(c_int, 0)))))) and act_ch.*.fade == 0) {
        act_ch.*.fade = 1024;
    }
    mas.mpp_vars.sampoff = 0;
    mas.mpp_vars.volplus = 0;
    mas.mpp_vars.notedelay = 0;
    mas.mpp_vars.panplus = 0;
    if ((@as(c_int, @bitCast(@as(c_uint, module_channel.*.flags))) & @as(c_int, 4)) != 0) {
        period = mas.mpp_Process_VolumeCommand(mpp_layer, act_ch, module_channel, period);
    }
    if ((@as(c_int, @bitCast(@as(c_uint, module_channel.*.flags))) & @as(c_int, 8)) != 0) {
        period = mas.mpp_Process_Effect(mpp_layer, act_ch, module_channel, period);
    }
    if (act_ch == @as([*c]mm.ActiveChannel, @ptrCast(@alignCast(@as(?*anyopaque, @ptrFromInt(@as(c_int, 0))))))) return;
    var volume: c_int = (@as(c_int, @bitCast(@as(c_uint, module_channel.*.volume))) * @as(c_int, @bitCast(@as(c_uint, module_channel.*.cvolume)))) >> @intCast(5);
    act_ch.*.volume = @as(mm.Byte, @bitCast(@as(i8, @truncate(volume))));
    const vol_addition: mm.Sword = @as(mm.Sword, @bitCast(@as(c_int, mas.mpp_vars.volplus)));
    volume += @as(c_int, @bitCast(vol_addition << @intCast(3)));
    if (volume < 0) {
        volume = 0;
    }
    if (volume > 128) {
        volume = 128;
    }
    mas.mpp_vars.afvol = @as(mm.Byte, @bitCast(@as(i8, @truncate(volume))));
    if (mas.mpp_vars.notedelay != 0) {
        act_ch.*.flags |= @as(mm.Byte, @bitCast(@as(i8, @truncate(@as(c_int, 1) << @intCast(3)))));
        return;
    }
    act_ch.*.panning = module_channel.*.panning;
    act_ch.*.period = module_channel.*.period;
    mas.mpp_vars.panplus = 0;
    act_ch.*.flags |= @as(mm.Byte, @bitCast(@as(i8, @truncate(@as(c_int, 1) << @intCast(3)))));
    period = mas.mpp_Update_ACHN_notest(mpp_layer, act_ch, period, @as(mm.Word, @bitCast(@as(c_uint, module_channel.*.alloc))));
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
    const instr_count: mm.Word = @as(mm.Word, @bitCast(@as(c_uint, mpp_layer.*.songadr.*.instr_count)));
    const flags: mm.Word = @as(mm.Word, @bitCast(@as(c_uint, mpp_layer.*.flags)));
    var module_channels: [*c]mm.ModuleChannel = mm_gba.mpp_channels;
    mas.mpp_vars.pattread_p = mpp_layer.*.pattread;
    var pattern: [*c]mm.Byte = mas.mpp_vars.pattread_p;
    var update_bits: mm.Word = 0;
    // Reduce readPattern logs to avoid timing distortion
    // Capture start-of-row pattern pointers without printing in hot path
    @import("capture.zig").capture(
        mpp_layer,
        @import("capture.zig").Kind.ReadPatStart,
        @as(i32, @intCast(@intFromPtr(mpp_layer.*.pattread))),
        @as(i32, @intCast(@intFromPtr(mas.mpp_vars.pattread_p))),
        @as(i32, @intCast(mm_gba.mpp_nchannels)),
        @as(i32, @intCast(mpp_layer.*.row)),
        0,
    );
    var debug_detail: bool = false;
    if (mpp_layer.*.row < 10) debug_detail = true;
    while (true) {
        const read_byte: mm.Byte = (blk: {
            const ref = &pattern;
            const tmp = ref.*;
            ref.* += 1;
            break :blk tmp;
        }).*;
        if ((@as(c_int, @bitCast(@as(c_uint, read_byte))) & @as(c_int, 127)) == @as(c_int, 0)) {
            // No extra readPattern break log in C reference
            break;
        }
        var pattern_flags: mm.Word = 0;
        const chan_calculation = (@as(c_int, @bitCast(@as(c_uint, read_byte))) & @as(c_int, 127)) - @as(c_int, 1);
        const chan_num: mm.Byte = @as(mm.Byte, @bitCast(@as(i8, @truncate(chan_calculation))));
        if (@as(c_int, @bitCast(@as(c_uint, chan_num))) >= @as(c_int, @bitCast(@as(c_uint, mm_gba.mpp_nchannels)))) {
            debugPrint(
                "[readPattern] error: chan {d} >= nch {d} (flags={x} row={d})\n",
                .{
                    @as(c_int, @intCast(chan_num)),
                    @as(c_int, @intCast(mm_gba.mpp_nchannels)),
                    @as(c_int, @intCast(read_byte)),
                    @as(c_int, @intCast(mpp_layer.*.row)),
                },
            );
            // Non-XM mode: return error for invalid channels
            return false;
        }
        update_bits |= @as(mm.Word, @bitCast(@as(c_int, 1) << @intCast(@as(c_int, @bitCast(@as(c_uint, chan_num))))));
        const module_channel: [*c]mm.ModuleChannel = &module_channels[chan_num];
        if ((@as(c_int, @bitCast(@as(c_uint, read_byte))) & (@as(c_int, 1) << @intCast(7))) != 0) {
            module_channel.*.cflags = (blk: {
                const ref = &pattern;
                const tmp = ref.*;
                ref.* += 1;
                break :blk tmp;
            }).*;
        }
        const compr_flags: mm.Word = @as(mm.Word, @bitCast(@as(c_uint, module_channel.*.cflags)));
        if ((compr_flags & @as(mm.Word, @bitCast(@as(c_int, 1) << @intCast(0)))) != 0) {
            const note: mm.Byte = (blk: {
                const ref = &pattern;
                const tmp = ref.*;
                ref.* += 1;
                break :blk tmp;
            }).*;
            if (@as(c_int, @bitCast(@as(c_uint, note))) == @as(c_int, 254)) {
                pattern_flags |= @as(mm.Word, @bitCast(@as(c_int, 128)));
            } else if (@as(c_int, @bitCast(@as(c_uint, note))) == @as(c_int, 255)) {
                pattern_flags |= @as(mm.Word, @bitCast(@as(c_int, 64)));
            } else {
                module_channel.*.pnoter = note;
                // Seed note used by T0. This mirrors C's decode state having note ready before T0.
                module_channel.*.note = note;
                // A valid note triggers a new start at T0
                pattern_flags |= @as(mm.Word, @bitCast(@as(c_int, 1)));
            }
        }
        if ((compr_flags & @as(mm.Word, @bitCast(@as(c_int, 1) << @intCast(1)))) != 0) {
            var instr: mm.Byte = (blk: {
                const ref = &pattern;
                const tmp = ref.*;
                ref.* += 1;
                break :blk tmp;
            }).*;
            if ((pattern_flags & @as(mm.Word, @bitCast(@as(c_int, 128) | @as(c_int, 64)))) == @as(mm.Word, @bitCast(@as(c_int, 0)))) {
                if (@as(mm.Word, @bitCast(@as(c_uint, instr))) > instr_count) {
                    instr = 0;
                }
                if (@as(c_int, @bitCast(@as(c_uint, module_channel.*.inst))) != @as(c_int, @bitCast(@as(c_uint, instr)))) {
                    if ((flags & @as(mm.Word, @bitCast(@as(c_int, 1) << @intCast(5)))) != 0) {
                        pattern_flags |= @as(mm.Word, @bitCast(@as(c_int, 1)));
                    }
                    pattern_flags |= @as(mm.Word, @bitCast(@as(c_int, 16)));
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
        module_channel.*.flags = @as(mm.Byte, @bitCast(@as(u8, @truncate(pattern_flags | (compr_flags >> @intCast(4))))));
    }
    mpp_layer.*.pattread = pattern;
    mpp_layer.*.mch_update = update_bits;
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
    if (mpp_layer.*.tick == 0 and channel_counter < 2) {
        const inst_base_dbg: usize = @intFromPtr(instrument);
        const nm_ptr_dbg: usize = inst_base_dbg + nm_off;
        const idx_dbg: usize = @as(usize, @intCast(module_channel.*.pnoter));
        const map_ptr_dbg: [*]const mm.Hword = @ptrFromInt(nm_ptr_dbg);
        const raw_entry_dbg: mm.Hword = map_ptr_dbg[idx_dbg];
        // Dump first 16 bytes of instrument to verify bitfield packing
        const inst_bytes_dbg: [*]const u8 = @ptrFromInt(inst_base_dbg);
        const b0: u8 = inst_bytes_dbg[0];
        const b1: u8 = inst_bytes_dbg[1];
        const b2: u8 = inst_bytes_dbg[2];
        const b3: u8 = inst_bytes_dbg[3];
        const b4: u8 = inst_bytes_dbg[4];
        const b5: u8 = inst_bytes_dbg[5];
        const b6: u8 = inst_bytes_dbg[6];
        const b7: u8 = inst_bytes_dbg[7];
        const b8: u8 = inst_bytes_dbg[8];
        const b9: u8 = inst_bytes_dbg[9];
        const b10: u8 = inst_bytes_dbg[10];
        const b11: u8 = inst_bytes_dbg[11];
        debugPrint(
            "[INST] ch={d} inst_ptr={x} bytes: {x:0>2} {x:0>2} {x:0>2} {x:0>2} {x:0>2} {x:0>2} {x:0>2} {x:0>2} nm_off_lo={x:0>2} nm_off_hi={x:0>2} inv_lo={x:0>2} inv_hi={x:0>2}\n",
            .{ @as(c_int, @intCast(channel_counter)), inst_base_dbg, b0, b1, b2, b3, b4, b5, b6, b7, b8, b9, b10, b11 },
        );
        debugPrint(
            "[MAPDBG] ch={d} inst_ptr={x} nmap_off={x} map_ptr={x} pnoter={d} entry={x} invalid={d}\n",
            .{ @as(c_int, @intCast(channel_counter)), inst_base_dbg, nm_off, nm_ptr_dbg, @as(c_int, @intCast(module_channel.*.pnoter)), @as(c_int, @intCast(raw_entry_dbg)), @as(c_int, @intCast(@intFromBool(invalid_map))) },
        );
    }
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
    if (mpp_layer.*.tick == 0 and channel_counter < 2) {
        debugPrint(
            "[BINDMAP] ch={d} inst={d} pnoter={d} invalid={d} nmap_off={x} note={d} sample={d}\n",
            .{ @as(c_int, @intCast(channel_counter)), @as(c_int, @intCast(module_channel.*.inst)), @as(c_int, @intCast(module_channel.*.pnoter)), @as(c_int, @intCast(@intFromBool(invalid_map))), @as(c_int, @intCast(nm_off)), @as(c_int, @intCast(module_channel.*.note)), if (active_channel != null) @as(c_int, @intCast(active_channel.*.sample)) else 0 },
        );
    }
    return module_channel.*.note;
}
fn getActiveChannel(module_channel: [*c]mm.ModuleChannel) linksection(".iwram") callconv(.c) [*c]mm.ActiveChannel {
    var act_ch: [*c]mm.ActiveChannel = null;
    if (@as(c_int, @bitCast(@as(c_uint, module_channel.*.alloc))) != 255) {
        act_ch = &mm_gba.achannels[module_channel.*.alloc];
    }
    return act_ch;
}
