const mm = @import("../maxmod.zig");
const mixer = @import("../gba/mixer.zig");
const mm_gba = @import("../gba/main_gba.zig");
const shim = @import("../shim.zig");
const arm = @import("mas_arm.zig");
const tables = @import("tables.zig");
const gba = @import("gba");
const std = @import("std");
// Debug configuration - can be toggled at build time
const debug_enabled = @import("build_options").xm_debug;

inline fn readLe32(ptr: anytype) u32 {
    const bytes: [*]const u8 = @ptrCast(ptr);
    return std.mem.readInt(u32, bytes[0..4], .little);
}
pub const LayerType = enum {
    main,
    jingle,
};
pub extern var mm_ch_mask: mm.Word;

var mmLayerSub: mm.LayerInfo = .{};
var mm_mastertempo: mm.Word = 0;
export var mm_masterpitch: mm.Word = 0;
var mmCallback: mm_callback = @import("std").mem.zeroes(mm_callback);
var mm_schannels: [4]mm.ModuleChannel = .{ .{}, .{}, .{}, .{} };

pub const MpvActiveInfo = extern struct {
    reserved: mm.Word = 0,
    pattread_p: [*c]mm.Byte = @import("std").mem.zeroes([*c]mm.Byte),
    afvol: mm.Byte = 0,
    sampoff: mm.Byte = 0,
    volplus: mm.Sbyte = @import("std").mem.zeroes(mm.Sbyte),
    notedelay: mm.Byte = 0,
    panplus: mm.Hword = 0,
    reserved2: mm.Hword = 0,
};

pub const Instrument = extern struct {
    global_volume: mm.Byte = 0,
    fadeout: mm.Byte = 0,
    random_volume: mm.Byte = 0,
    dct: mm.Byte = 0,
    nna: mm.Byte = 0,
    env_flags: mm.Byte = 0,
    panning: mm.Byte = 0,
    dca: mm.Byte = 0,
    note_map_offset: mm.Hword = 0,
    is_note_map_invalid: mm.Hword = 0,
};
pub var mpp_vars: MpvActiveInfo = .{};
pub const mm_bool = u8;
pub const MM_MAIN: i32 = 0;
pub const MM_JINGLE: i32 = 1;
pub const mm_layer_type = usize;
pub const mm_callback = ?*const fn (mm.Word, LayerType) mm.Word;
pub const MM_PLAY_LOOP: i32 = 0;
pub const MM_PLAY_ONCE: i32 = 1;
pub const mm_pmode = usize;
pub var mpp_clayer: LayerType = .main;

pub fn allocChannel() linksection(".iwram") mm.Word {
    var act_ch: [*c]mm.ActiveChannel = &mm_gba.achannels[0];
    var bitmask: mm.Word = mm_ch_mask;
    var best_channel: mm.Word = 255;
    var best_volume: mm.Word = 2147483648;
    {
        var i: mm.Word = 0;
        while (bitmask != 0) : (_ = blk: {
            _ = blk_1: {
                i +%= 1;
                break :blk_1 blk_2: {
                    const ref = &bitmask;
                    ref.* >>= @intCast(1);
                    break :blk_2 ref.*;
                };
            };
            break :blk blk_1: {
                const ref = &act_ch;
                const tmp = ref.*;
                ref.* += 1;
                break :blk_1 tmp;
            };
        }) {
            if ((bitmask & 1) == 0) continue;
            const fvol: mm.Word = @as(mm.Word, @bitCast(@as(usize, act_ch.*.fvol)));
            const @"type": mm.Word = @as(mm.Word, @bitCast(@as(usize, act_ch.*._type)));
            if (2 < @"type") continue else if (2 > @"type") return i;
            if (best_volume <= (fvol << 23)) continue;
            best_channel = i;
            best_volume = fvol << 23;
        }
    }

    return best_channel;
}
pub fn mmSetEventHandler(handler: mm_callback) void {
    mmCallback = handler;
}
pub fn mmStart(id: mm.Word, mode: mm_pmode) void {
    const mc = mm_gba.getModuleCount();
    if (id >= mc) {
        return;
    }
    mpps_backdoor(id, mode, .main);
}
pub fn mmPause() void {
    if (mm_gba.layer_main.valid == 0) return;
    mm_gba.layer_main.isplaying = 0;
    mpp_suspend(@bitCast(MM_MAIN));
}
pub fn mmResume() void {
    if (mm_gba.layer_main.valid == 0) return;
    mm_gba.layer_main.isplaying = 1;
}
pub fn mmStop() void {
    mpp_clayer = .main;
    mppStop();
}
pub fn mmGetPositionTick() mm.Word {
    return @intCast(mm_gba.layer_main.tick);
}
pub fn mmGetPositionRow() mm.Word {
    return @intCast(mm_gba.layer_main.row);
}
pub fn mmGetPosition() mm.Word {
    return @intCast(mm_gba.layer_main.position);
}
fn mmSetPositionEx(position: mm.Word, row: mm.Word) void {
    mpp_setposition(&mm_gba.layer_main, position);
    if (row != @as(mm.Word, 0)) {
        mpph_FastForward(&mm_gba.layer_main, row);
    }
}
pub fn mmSetPosition(position: mm.Word) void {
    mmSetPositionEx(position, 0);
}
pub fn mmPosition(position: mm.Word) void {
    mmSetPositionEx(position, 0);
}
pub fn mmActive() mm_bool {
    return mm_gba.layer_main.isplaying;
}
pub fn mmSetModuleVolume(volume: mm.Word) void {
    var vol = volume;
    if (vol > 1024) {
        vol = 1024;
    }
    mm_gba.layer_main.volume = @intCast(vol);
}
pub fn mmSetModuleTempo(tempo: mm.Word) void {
    const max: mm.Word = 2048;
    var local_tempo = tempo;
    if (local_tempo > max) {
        local_tempo = max;
    }
    const min: mm.Word = 512;
    if (local_tempo < min) {
        local_tempo = min;
    }
    mm_mastertempo = local_tempo;
    mpp_clayer = .main;
    if (mm_gba.layer_main.bpm != 0) {
        mpp_setbpm(&mm_gba.layer_main, @intCast(mm_gba.layer_main.bpm));
    }
}
pub fn mmSetModulePitch(pitch: mm.Word) void {
    const max: mm.Word = 2048;
    var local_pitch = pitch;
    if (local_pitch > max) {
        local_pitch = max;
    }
    const min: mm.Word = 512;
    if (local_pitch < min) {
        local_pitch = min;
    }
    mm_masterpitch = local_pitch;
}
pub fn mmPlayModule(address: usize, mode: mm.Word, layer: LayerType) void {
    const header: [*c]mm.MasHead = @ptrFromInt(address + @sizeOf(Prefix));
    mpp_clayer = layer;
    var layer_info: [*c]mm.LayerInfo = undefined;
    var channels: [*c]mm.ModuleChannel = undefined;
    var num_ch: mm.Word = undefined;
    if (layer == .main) {
        layer_info = &mm_gba.layer_main;
        channels = mm_gba.pchannels;
        num_ch = mm_gba.num_mch;
    } else {
        layer_info = &mmLayerSub;
        channels = @ptrCast(@alignCast(&mm_schannels[0]));
        num_ch = 4;
    }
    layer_info.*.mode = @intCast(mode);
    layer_info.*.songadr = header;
    mpp_resetchannels(channels, num_ch);

    // Read MAS header fields byte-wise to avoid layout drift
    const instr_count: u8 = header.*.instr_count;
    const sampl_count: u8 = header.*.sampl_count;

    // Setup instrument, sample and pattern tables using the 32-bit offsets
    // stored in MasHead->tables[]. The layout is:
    // tables[0 .. instr_count-1]       -> instrument offsets table address
    // tables[instr_count .. +sampl-1]  -> sample offsets table address
    // tables[instr_count+sampl ..]     -> pattern offsets table address
    const tables_off: usize = 276;
    // Use the MasHead flexible array like C: treat tables[] as an array of u32 offsets.
    const tables_ptr: [*]const u32 = @ptrFromInt(@as(u32, @intFromPtr(header)) + tables_off);
    const inst_tbl_ptr: [*]const u32 = tables_ptr;
    const samp_tbl_ptr: [*]const u32 = tables_ptr + instr_count;
    const patt_tbl_ptr: [*]const u32 = tables_ptr + instr_count + sampl_count;
    // Save pointers to the beginning of each offsets table region
    layer_info.*.insttable = @ptrCast(@constCast(inst_tbl_ptr));
    layer_info.*.samptable = @ptrCast(@constCast(samp_tbl_ptr));
    layer_info.*.patttable = @ptrCast(@constCast(patt_tbl_ptr));

    if (debug_enabled) {
        shim.debug_state.num_instr = instr_count;
        shim.debug_state.num_sampl = sampl_count;

        shim.debug_state.inst_tbl_peek = readLe32(layer_info.*.insttable);
        shim.debug_state.samp_tbl_peek = readLe32(layer_info.*.samptable);
        shim.debug_state.patt_tbl_peek = readLe32(layer_info.*.patttable);
    }

    // limit extra probes now that pattern_data() is used
    mpp_setposition(layer_info, 0);
    mpp_setbpm(layer_info, header.*.initial_tempo);
    layer_info.*.global_volume = header.*.global_volume;
    const flags: mm.Word = header.*.flags;
    layer_info.*.flags = header.*.flags;
    layer_info.*.oldeffects = @intCast((flags >> 1) & 1);
    layer_info.*.speed = header.*.initial_speed;
    layer_info.*.isplaying = 1;
    layer_info.*.valid = 1;
    if (debug_enabled) shim.debug_state.layer1 = layer_info.*;
    mpp_resetvars(layer_info);
    {
        var i: mm.Word = 0;
        while (i < num_ch) : (i +%= 1) {
            channels[i].cvolume = header.*.channel_volume[i];
        }
    }
    {
        var i: mm.Word = 0;
        while (i < num_ch) : (i +%= 1) {
            channels[i].panning = header.*.channel_panning[i];
        }
    }

    if (debug_enabled) {
        shim.debug_state.header_channel_volumes = header.*.channel_volume;
        shim.debug_state.header_channel_panning = header.*.channel_panning;
    }
}
pub fn mmJingleStart(module_ID: mm.Word, mode: mm_pmode) void {
    if (module_ID >= mm_gba.getModuleCount()) return;
    mpps_backdoor(module_ID, mode, .jingle);
}
pub fn mmJingle(module_ID: mm.Word) void {
    mmJingleStart(module_ID, MM_PLAY_ONCE);
}
pub fn mmJinglePause() void {
    if (mmLayerSub.valid == 0) return;
    mmLayerSub.isplaying = 0;
    mpp_suspend(MM_JINGLE);
}
pub fn mmJingleResume() void {
    if (mmLayerSub.valid == 0) return;
    mmLayerSub.isplaying = 1;
}
pub fn mmJingleStop() void {
    mpp_clayer = .jingle;
    mppStop();
}
pub fn mmJingleActive() mm_bool {
    return mmLayerSub.isplaying;
}
pub fn mmSetJingleVolume(arg_volume: mm.Word) void {
    var volume = arg_volume;
    if (volume > 1024) {
        volume = 1024;
    }
    mmLayerSub.volume = @intCast(volume);
}
pub fn mmActiveSub() bool {
    return mmJingleActive();
}
const Envelope = extern struct {
    size: mm.Byte align(2) = 0,
    loop_start: mm.Byte = 0,
    loop_end: mm.Byte = 0,
    sus_start: mm.Byte = 0,
    sus_end: mm.Byte = 0,
    node_count: mm.Byte = 0,
    is_filter: mm.Byte = 0,
    wasted: mm.Byte = 0,
};
pub const SampleInfo = extern struct {
    default_volume: mm.Byte = 0,
    panning: mm.Byte = 0,
    frequency: mm.Hword = 0,
    av_type: mm.Byte = 0,
    av_depth: mm.Byte = 0,
    av_speed: mm.Byte = 0,
    global_volume: mm.Byte = 0,
    av_rate: mm.Hword = 0,
    msl_id: mm.Hword = 0,
    pub fn data(self: anytype) @import("std").zig.c_translation.helpers.FlexibleArrayType(@TypeOf(self), u8) {
        const Intermediate = @import("std").zig.c_translation.helpers.FlexibleArrayType(@TypeOf(self), u8);
        const ReturnType = @import("std").zig.c_translation.helpers.FlexibleArrayType(@TypeOf(self), u8);
        return @as(ReturnType, @ptrCast(@alignCast(@as(Intermediate, @ptrCast(self)) + 12)));
    }
};
// Pattern header + data
pub const Pattern = packed struct {
    row_count: mm.Byte = 0,
    pub fn pattern_data(self: anytype) @import("std").zig.c_translation.helpers.FlexibleArrayType(@TypeOf(self), u8) {
        const Intermediate = @import("std").zig.c_translation.helpers.FlexibleArrayType(@TypeOf(self), u8);
        const ReturnType = @import("std").zig.c_translation.helpers.FlexibleArrayType(@TypeOf(self), u8);
        return @as(ReturnType, @ptrCast(@alignCast(@as(Intermediate, @ptrCast(self)) + 1)));
    }
};

pub inline fn umixChannelIndexFromMix(mix_ch: [*c]volatile mm.MixerChannel) i32 {
    const offset = @intFromPtr(mix_ch) - @intFromPtr(&mixer.mm_mix_channels[0]);
    return @as(i32, @intCast(offset / @sizeOf(mm.MixerChannel)));
}
pub fn mppUpdateSub() void {
    if (mmLayerSub.isplaying == 0) return;
    mm_gba.mpp_channels = @ptrCast(@alignCast(&mm_schannels[0]));
    mm_gba.mpp_nchannels = 4;
    mpp_clayer = .jingle;
    mm_gba.layer_p = &mmLayerSub;
    const tickrate: mm.Word = mmLayerSub.tickrate;
    var tickfrac: mm.Word = mmLayerSub.tick_data.tickfrac;
    tickfrac += tickrate << @intCast(1);
    mmLayerSub.tick_data.tickfrac = @intCast(tickfrac);
    tickfrac >>= @intCast(16);
    while (tickfrac > 0) {
        mppProcessTick();
        tickfrac -%= 1;
    }
}
pub fn mppProcessTick() linksection(".iwram") void {
    const layer: [*c]mm.LayerInfo = mm_gba.layer_p;
    if (layer.*.isplaying == 0) return;
    if (layer.*.tick == 0 and layer.*.pattdelay == 0) {
        const ok = arm.readPattern(layer);
        if (!ok) {
            mppStop();
            if (mmCallback != @as(mm_callback, @ptrCast(@alignCast(@as(?*anyopaque, @ptrFromInt(0)))))) {
                _ = mmCallback.?(44, mpp_clayer);
            }
            return;
        }
    }
    var update_bits: mm.Word = layer.*.mch_update;
    var module_channels: [*c]mm.ModuleChannel = mm_gba.mpp_channels;
    if (debug_enabled) {
        if (shim.debug_state.upd_len < shim.debug_state.upd_events.len) {
            const idx = shim.debug_state.upd_len;
            shim.debug_state.upd_events[idx] = .{
                .tick = layer.*.tick,
                .row = layer.*.row,
                .bits = @intCast(update_bits),
            };
            shim.debug_state.upd_len +%= 1;
        }
    }
    var channel_counter: mm.Word = 0;
    while (true) : (channel_counter +%= 1) {
        if ((update_bits & @as(mm.Word, @bitCast(@as(i32, 1) << @intCast(0)))) != 0) {
            if (layer.*.tick == 0) {
                arm.updateChannel_T0(module_channels, layer, @intCast(channel_counter));
            } else {
                arm.updateChannel_TN(module_channels, layer);
            }
        }
        module_channels += 1;
        update_bits >>= 1;
        if (update_bits == 0) break;
    }
    var act_ch: [*c]mm.ActiveChannel = &mm_gba.achannels[0];
    var ch: mm.Word = 0;
    while (ch < mm_gba.num_ach) : (ch +%= 1) {
        if (act_ch.*._type != 0) {
            if (@intFromEnum(mpp_clayer) == @as(usize, @bitCast((@as(i32, @bitCast(@as(usize, act_ch.*.flags))) & ((@as(i32, 1) << @intCast(6)) | (@as(i32, 1) << @intCast(7)))) >> @intCast(6)))) {
                mpp_vars.afvol = act_ch.*.volume;
                mpp_vars.panplus = 0;
                mpp_Update_ACHN(layer, act_ch, act_ch.*.period, ch);
            }
        }
        act_ch.*.flags &= @as(mm.Byte, @bitCast(@as(i8, @truncate(~(@as(i32, 1) << @intCast(3))))));
        act_ch += 1;
    }

    const new_tick: mm.Byte = layer.*.tick + 1;
    if (new_tick < layer.*.speed) {
        layer.*.tick = new_tick;
        return;
    }
    if (layer.*.fpattdelay != 0) {
        layer.*.fpattdelay -= 1;
    }
    if (layer.*.pattdelay != 0) {
        layer.*.pattdelay -= 1;
        if (layer.*.pattdelay != 0) {
            layer.*.tick = 0;
            return;
        }
    }
    layer.*.tick = 0;
    if (layer.*.pattjump != 255) {
        mpp_setposition(layer, layer.*.pattjump);
        layer.*.pattjump = 255;
        if (layer.*.pattjump_row == 0) return;
        mpph_FastForward(layer, layer.*.pattjump_row);
        layer.*.pattjump_row = 0;
        return;
    }
    if (layer.*.ploop_jump != 0) {
        layer.*.ploop_jump = 0;
        layer.*.row = layer.*.ploop_row;
        layer.*.pattread = layer.*.ploop_adr;
        return;
    }
    const new_row = layer.*.row + 1;
    if (new_row != layer.*.nrows + 1) {
        // If they are different, continue playing this pattern
        layer.*.row = new_row;
        return;
    }
    mpp_setposition(layer, layer.*.position + 1);
}
pub fn mpp_Process_VolumeCommand(layer: [*c]mm.LayerInfo, act_ch: ?[*c]mm.ActiveChannel, channel: [*c]mm.ModuleChannel, period: mm.Word) mm.Word {
    const tick: mm.Byte = layer.*.tick;
    const header: [*c]mm.MasHead = layer.*.songadr;
    var volcmd: mm.Byte = channel.*.volcmd;
    // XM commands
    if ((header.*.flags & MAS_HEADER_FLAG_XM_MODE) != 0) {
        if (volcmd == 0) {} else if (volcmd <= 80) {
            // Set volume
            if (tick == 0) {
                channel.*.volume = volcmd - 16;
            }
        } else if (volcmd < 128) {
            // Volume slide
            if (tick == 0) return period;
            var volume: i32 = @intCast(channel.*.volume);
            const mem: mm.Byte = channel.*.memory[MPP_XM_VCMD_MEM_VS];
            if (volcmd < 112) {
                volcmd -%= 96;
                var delta: i32 = undefined;
                if (volcmd == 0) {
                    delta = mem & 15;
                } else {
                    delta = volcmd;
                    channel.*.memory[MPP_XM_VCMD_MEM_VS] = (mem & ~@as(u8, 15)) | volcmd;
                }
                volume -= @intCast(delta);
                if (volume < 0) {
                    volume = 0;
                }
                channel.*.volume = @as(mm.Byte, @bitCast(@as(i8, @truncate(volume))));
            } else {
                volcmd -%= 112;
                var delta: i32 = undefined;
                if (volcmd == 0) {
                    delta = mem >> 4;
                } else {
                    delta = volcmd;
                    channel.*.memory[MPP_XM_VCMD_MEM_VS] = (volcmd << 4) | (mem & 15);
                }
                volume += delta;
                if (volume > 64) {
                    volume = 64;
                }
                channel.*.volume = @as(mm.Byte, @bitCast(@as(i8, @truncate(volume))));
            }
        } else if (volcmd < 160) {
            // Fine volume slide
            if (tick != 0) return period;
            var volume: i32 = @intCast(channel.*.volume);
            const mem: mm.Byte = channel.*.memory[MPP_XM_VCMD_MEM_FVS];
            if (volcmd < 144) {
                // mppuv_xm_volslide_down
                volcmd -%= 128;
                var delta: i32 = undefined;
                if (volcmd == 0) {
                    delta = mem & 15;
                } else {
                    delta = volcmd;
                    channel.*.memory[MPP_XM_VCMD_MEM_FVS] = (mem & ~@as(u8, 15)) | volcmd;
                }
                volume -= delta;
                if (volume < 0) {
                    volume = 0;
                }
                channel.*.volume = @as(mm.Byte, @bitCast(@as(i8, @truncate(volume))));
            } else {
                volcmd -%= 144;
                var delta: i32 = undefined;
                if (volcmd == 0) {
                    delta = mem >> 4;
                } else {
                    delta = volcmd;
                    channel.*.memory[MPP_XM_VCMD_MEM_FVS] = (volcmd << 4) | (mem & 15);
                }
                volume += delta;
                if (volume > 64) {
                    volume = 64;
                }
                channel.*.volume = @as(mm.Byte, @bitCast(@as(i8, @truncate(volume))));
            }
        } else if (volcmd < 192) {
            // Vibrato
            if (tick == 0) return period;
            // Sets speed or depth
            if (volcmd < 176) {
                // mppuv_xm_vibspd
                volcmd = (volcmd - 160) << 2;
                if (volcmd != 0) {
                    channel.*.vibspd = volcmd;
                }
            } else {
                // mppuv_xm_vibdepth
                volcmd = (volcmd - 176) << 3;
                if (volcmd != 0) {
                    channel.*.vibdep = volcmd;
                }
            }
            return mppe_DoVibrato(period, channel, layer);
        } else if (volcmd < 208) {
            // Panning
            if (tick != 0) return period;
            const panning: mm.Word = (volcmd - 192) << 4;
            // This is a hack to make the panning reach the maximum value
            if (panning == 240) {
                channel.*.panning = 255;
            } else {
                channel.*.panning = @as(mm.Byte, @bitCast(@as(u8, @truncate(panning))));
            }
        } else if (volcmd < 240) {
            // Panning slide
            if (tick == 0) return period;
            var panning: i32 = @as(i32, @bitCast(@as(usize, channel.*.panning)));
            const mem: mm.Byte = channel.*.memory[MPP_XM_VCMD_MEM_PANSL];
            if (volcmd < 224) {
                // mppuv_xm_panslide_left
                volcmd -%= 208;
                var delta: i32 = undefined;
                if (volcmd == 0) {
                    delta = mem >> 4;
                } else {
                    channel.*.memory[MPP_XM_VCMD_MEM_PANSL] = (mem & 15) | (volcmd << 4);
                    delta = volcmd & 15;
                }
                delta <<= 2;
                panning -= delta;
                if (panning < 0) {
                    panning = 0;
                }
                channel.*.panning = @as(mm.Byte, @bitCast(@as(i8, @truncate(panning))));
            } else {
                // mppuv_xm_panslide_right
                volcmd -%= 224;
                var delta: i32 = undefined;
                if (volcmd == 0) {
                    delta = mem & 15;
                } else {
                    delta = volcmd;
                    channel.*.memory[MPP_XM_VCMD_MEM_PANSL] = volcmd | (mem & 15);
                }
                delta <<= 2;
                panning += delta;
                if (panning > 255) {
                    panning = 255;
                }
                channel.*.panning = @as(mm.Byte, @bitCast(@as(i8, @truncate(panning))));
            }
        } else {
            // Glissando
            // On nonzero ticks, do a regular glissando slide at speed * 16
            if (tick == 0) return period;
            volcmd = (volcmd - 240) << 4;
            if (volcmd != 0) {
                channel.*.memory[MPP_XM_VCMD_MEM_GLIS] = volcmd;
            }
            volcmd = channel.*.memory[MPP_XM_VCMD_MEM_GLIS];
            return mppe_glis_backdoor(volcmd, period, act_ch, channel, layer);
        }
    } else {
        // IT commands
        if (volcmd <= 64) {
            // V: Set volume
            if (tick == 0) channel.*.volume = volcmd;
        } else if (volcmd <= 84) {
            // A, B: Fine volume slide
            if (tick != 0) return period;
            var volume: i32 = @intCast(channel.*.volume);
            if (volcmd < 75) {
                volcmd -= 65;
                if (volcmd == 0) {
                    volcmd = channel.*.memory[MPP_IT_VCMD_MEM];
                } else {
                    channel.*.memory[MPP_IT_VCMD_MEM] = volcmd;
                }
                volume += volcmd;
                if (volume > 64) {
                    volume = 64;
                }
            } else {
                // B: Slide down
                // 75-84 ==> 0-9
                volcmd -= 75;
                if (volcmd == 0) {
                    volcmd = channel.*.memory[MPP_IT_VCMD_MEM];
                } else {
                    channel.*.memory[MPP_IT_VCMD_MEM] = volcmd;
                }
                volume -= volcmd;
                if (volume < 0) {
                    volume = 0;
                }
            }
            channel.*.volume = @as(mm.Byte, @bitCast(@as(i8, @truncate(volume))));
        } else if (volcmd <= 104) {
            if (tick == 0) return period;
            var volume: i32 = @intCast(channel.*.volume);
            if (volcmd < 95) {
                // C: Slide up
                // 85-94 ==> 0-9
                volcmd -= 85;
                if (volcmd == 0) {
                    volcmd = channel.*.memory[MPP_IT_VCMD_MEM];
                } else {
                    channel.*.memory[MPP_IT_VCMD_MEM] = volcmd;
                }
                volume += volcmd;
                if (volume > 64) {
                    volume = 64;
                }
            } else {
                // D: Slide down
                // 95-104 ==> 0-9
                volcmd -= 95;
                if (volcmd == 0) {
                    volcmd = channel.*.memory[MPP_IT_VCMD_MEM];
                } else {
                    channel.*.memory[MPP_IT_VCMD_MEM] = volcmd;
                }
                volume -= volcmd;
                if (volume < 0) {
                    volume = 0;
                }
            }
            channel.*.volume = @as(mm.Byte, @bitCast(@as(i8, @truncate(volume))));
        } else if (volcmd <= 124) {
            // E, F: Pitch slide/Portamento up/down
            if (tick == 0) return period;
            var r0: mm.Word = undefined;
            if (volcmd >= 115) {
                // F: mppuv_porta_up
                volcmd = (volcmd - 115) << 2;
                if (volcmd == 0) {
                    volcmd = channel.*.memory[MPP_IT_PORTA];
                }
                channel.*.memory[MPP_IT_PORTA] = volcmd;
                r0 = mpph_PitchSlide_Up(channel.*.period, volcmd, layer);
            } else {
                // E: mppuv_porta_down
                volcmd = (volcmd - 105) << 2;
                if (volcmd == 0) {
                    volcmd = channel.*.memory[MPP_IT_PORTA];
                }
                channel.*.memory[MPP_IT_PORTA] = volcmd;
                r0 = mpph_PitchSlide_Down(channel.*.period, volcmd, layer);
            }
            const r1: mm.Word = channel.*.period;
            channel.*.period = period;
            return (period + r0) - r1;
        } else if (volcmd <= 192) {
            // P: Panning
            if (tick == 0) {
                // Map to 0->64
                var panning: i32 = volcmd - 128;
                panning <<= 2;
                if (panning > 255) {
                    panning = 255;
                }
                channel.*.panning = @as(mm.Byte, @bitCast(@as(i8, @truncate(panning))));
            }
        } else if (volcmd <= 202) {
            // G: Glissando/Portamento to note
            if (tick == 0) return period;
            volcmd -%= 193;
            var glis: mm.Word = @intCast(tables.vcmd_glissando_table[volcmd]);
            if ((layer.*.flags & MAS_HEADER_FLAG_LINK_GXX) != 0) {
                // Gxx is shared, IT MODE ONLY!!

                // When this flag is enabled, link effect G's memory with the
                // memory used by effects E/F
                if (glis == 0) {
                    glis = channel.*.memory[MPP_IT_PORTA];
                }
                // E/F memory
                channel.*.memory[MPP_IT_PORTA] = @intCast(glis);
                channel.*.memory[MPP_XM_IT_GLIS] = @intCast(glis);
                const mem: mm.Byte = channel.*.memory[MPP_XM_IT_GLIS];
                return mppe_glis_backdoor(mem, period, act_ch, channel, layer);
            } else {
                // Single Gxx
                if (glis == 0) {
                    glis = @as(mm.Word, @bitCast(@as(usize, channel.*.memory[MPP_XM_IT_GLIS])));
                }
                channel.*.memory[MPP_XM_IT_GLIS] = @intCast(glis);
                const mem: mm.Byte = channel.*.memory[MPP_XM_IT_GLIS];
                return mppe_glis_backdoor(mem, period, act_ch, channel, layer);
            }
        } else if (volcmd <= 212) {
            // H: Vibrato (Speed)
            if (tick == 0) return period;
            // VCMD vibrato uses the same memory as effects Hxx/Uxx.
            // Set speed
            volcmd -= 203;
            if (volcmd != 0) {
                volcmd <<= 2;
                channel.*.vibspd = volcmd;
            }
            return mppe_DoVibrato(volcmd, channel, layer);
        }
    }
    return period;
}
// Process pattern effect
pub fn mpp_Process_Effect(layer: [*c]mm.LayerInfo, act_ch: ?[*c]mm.ActiveChannel, channel: [*c]mm.ModuleChannel, period: mm.Word) mm.Word {
    // First, update effect. If "channel.*.param" is zero, the function will
    // return the last parameter provided for the effect specified in
    // "channel.*.effect". Only some effects have memory. If the effect doesn't
    // have memory this function will return "channel.*.param" right away.
    const param: mm.Word = mpp_Channel_ExchangeMemory(channel.*.effect, channel.*.param, channel, layer);
    const effect: mm.Word = channel.*.effect;
    while (true) {
        switch (effect) {
            0 => return period,
            1 => {
                mppe_SetSpeed(param, layer);
                return period;
            },
            2 => {
                mppe_PositionJump(param, layer);
                return period;
            },
            3 => {
                mppe_PatternBreak(param, layer);
                return period;
            },
            4 => {
                const vol_word = mpph_VolumeSlide64(
                    channel.*.volume,
                    param,
                    layer.*.tick,
                    layer,
                );
                channel.*.volume = @intCast(vol_word);
                return period;
            },
            5, 6 => return mppe_Portamento(param, period, channel, layer),
            7 => return mppe_Glissando(param, period, act_ch, channel, layer),
            8 => return mppe_Vibrato(param, period, channel, layer),
            9 => {
                // Tremor
                // TODO: This isn't implemented. Would it work with the OldTremor code?
                return period;
            },
            10 => return mppe_Arpeggio(param, period, act_ch, channel, layer),
            11 => return mppe_VibratoVolume(param, period, channel, layer),
            12 => return mppe_PortaVolume(param, period, act_ch, channel, layer),
            13 => {
                mppe_ChannelVolume(param, channel, layer);
                return period;
            },
            14 => {
                mppe_ChannelVolumeSlide(param, channel, layer);
                return period;
            },
            15 => {
                mppe_SampleOffset(param, layer);
                return period;
            },
            16 => {
                // Panning slide
                // TODO
                return period;
            },
            17 => {
                mppe_Retrigger(param, act_ch, channel);
                return period;
            },
            18 => {
                mppe_Tremolo(param, channel, layer);
                return period;
            },
            19 => {
                mppe_Extended(param, act_ch, channel, layer);
                return period;
            },
            20 => {
                mppe_SetTempo(param, layer);
                return period;
            },
            21 => return mppe_FineVibrato(param, period, channel, layer),
            22 => {
                mppe_SetGlobalVolume(param, layer);
                return period;
            },
            23 => {
                mppe_GlobalVolumeSlide(param, layer);
                return period;
            },
            24 => {
                mppe_SetPanning(param, channel, layer);
                return period;
            },
            25 => {
                // Panbrello
                // TODO
                return period;
            },
            26 => {
                // Set Filter
                // TODO: Not supported
                return period;
            },
            27 => {
                mppe_SetVolume(param, channel, layer);
                return period;
            },
            28 => {
                mppe_KeyOff(param, act_ch, layer);
                return period;
            },
            29 => {
                // Envelope Pos
                // TODO
                return period;
            },
            30 => {
                mppe_OldTremor(param, channel, layer);
                return period;
            },
            else => return period,
        }
        break;
    }
    return 0;
}
pub fn mpp_Update_ACHN_notest(layer: [*c]mm.LayerInfo, act_ch: [*c]mm.ActiveChannel, period: mm.Word, ch: mm.Word) mm.Word {
    var new_period: mm.Word = period;
    new_period = mpp_Update_ACHN_notest_envelopes(layer, act_ch, new_period);
    new_period = mpp_Update_ACHN_notest_auto_vibrato(layer, act_ch, new_period);
    const mix_ch: [*c]volatile mm.MixerChannel = mpp_Update_ACHN_notest_update_mix(layer, act_ch, ch);
    const clipped_vol: mm.Word = mpp_Update_ACHN_notest_set_pitch_volume(layer, act_ch, new_period, mix_ch);
    mpp_Update_ACHN_notest_disable_and_panning(clipped_vol, act_ch, mix_ch);
    return new_period;
}
pub fn mpp_Channel_NewNote(module_channel: [*c]mm.ModuleChannel, layer: [*c]mm.LayerInfo) linksection(".iwram") void {
    if (module_channel.*.inst == 0) return;

    const act_ch: [*c]mm.ActiveChannel = mpp_Channel_GetACHN(module_channel);
    var need_alloc: bool = false;

    if (act_ch == null) {
        need_alloc = true;
    } else {
        const instrument: *Instrument = instrumentPointer(layer, module_channel.*.inst) orelse return;

        var do_dca: bool = false;
        const dct: mm.Byte = instrument.*.dct & 3;
        if (dct == 1) {
            // DCT Note
            const inst_bytes: [*]u8 = @ptrCast(@alignCast(instrument));
            const nm_ptr_bytes: [*]u8 = inst_bytes + instrument.*.note_map_offset;
            const note_map: [*]mm.Hword = @ptrCast(@alignCast(nm_ptr_bytes));
            const note: mm.Byte = @as(mm.Byte, @truncate(note_map[module_channel.*.note - 1] & 0xFF));
            if (note == module_channel.*.note) do_dca = true;
        } else if (dct == 2) {
            // DCT Sample
            const inst_bytes: [*]u8 = @ptrCast(@alignCast(instrument));
            const nm_ptr_bytes: [*]u8 = inst_bytes + instrument.*.note_map_offset;
            const note_map: [*]mm.Hword = @ptrCast(@alignCast(nm_ptr_bytes));
            const sample_from_map: mm.Byte = @as(mm.Byte, @truncate(note_map[module_channel.*.note - 1] >> 8));
            if (sample_from_map == act_ch.*.sample) do_dca = true;
        } else if (dct == 3) {
            // DCT Instrument
            if (module_channel.*.inst == act_ch.*.inst) do_dca = true;
        }

        if (do_dca) {
            const dca = instrument.*.dca;
            if (dca == IT_DCA_CUT) {
                return; // use same channel
            }
            if (dca == IT_DCA_OFF) {
                act_ch.*.flags = act_ch.*.flags & ~MCAF_KEYON;
                act_ch.*._type = ACHN_BACKGROUND;
                need_alloc = true;
            } else {
                act_ch.*.flags = act_ch.*.flags | MCAF_FADE;
                act_ch.*._type = ACHN_BACKGROUND;
                need_alloc = true;
            }
        } else {
            const nna = MCH_BFLAGS_NNA_GET(module_channel.*.bflags);
            if (nna == IT_NNA_CUT) {
                return; // use same channel
            } else if (nna == IT_NNA_CONT) {
                act_ch.*._type = ACHN_BACKGROUND;
                need_alloc = true;
            } else if (nna == IT_NNA_OFF) {
                act_ch.*.flags = act_ch.*.flags & ~MCAF_KEYON;
                act_ch.*._type = ACHN_BACKGROUND;
                need_alloc = true;
            } else if (nna == IT_NNA_FADE) {
                act_ch.*.flags = act_ch.*.flags | MCAF_FADE;
                act_ch.*._type = ACHN_BACKGROUND;
                need_alloc = true;
            }
        }
    }

    if (need_alloc) {
        const alloc: mm.Word = allocChannel();
        module_channel.*.alloc = @intCast(alloc);
    }
}
pub inline fn mpp_SamplePointer(layer: [*c]mm.LayerInfo, sampleN: mm.Word) [*c]align(1) SampleInfo {
    var base: [*c]mm.Byte = @as([*c]mm.Byte, @ptrCast(@alignCast(layer.*.songadr)));
    const idx: usize = @as(usize, @intCast(sampleN -% @as(mm.Word, @bitCast(@as(i32, 1)))));
    const off_ptr: [*]u8 = @ptrCast(@alignCast(@constCast(&base[@as(usize, 0)])));
    const samptbl_bytes: [*]const u8 = @ptrCast(@alignCast(layer.*.samptable));
    const p: [*]const u8 = samptbl_bytes + (idx * 4);
    const off: usize = @as(usize, @intCast(std.mem.readInt(u32, p[0..4], .little)));
    // Return unaligned pointer - SampleInfo may not be properly aligned in soundbank
    return @as([*c]align(1) SampleInfo, @ptrCast(off_ptr + off));
}
pub inline fn instrumentPointer(layer: [*c]mm.LayerInfo, instN: mm.Word) ?*Instrument {
    const base: [*c]mm.Byte = @as([*c]mm.Byte, @ptrCast(@alignCast(layer.*.songadr)));
    const idx: usize = @as(usize, @intCast(instN -% @as(mm.Word, @bitCast(@as(i32, 1)))));
    const insttbl_bytes: [*]const u8 = @ptrCast(@alignCast(layer.*.insttable));
    const p: [*]const u8 = insttbl_bytes + (idx * 4);
    const off: usize = @as(usize, @intCast(std.mem.readInt(u32, p[0..4], .little)));
    const ptr: [*]u8 = @ptrCast(@alignCast(base + off));
    return @ptrCast(@alignCast(ptr));
}
pub inline fn mpp_PatternPointer(layer: [*c]mm.LayerInfo, entry: mm.Word) [*c]Pattern {
    const base: [*c]mm.Byte = @ptrCast(@alignCast(layer.*.songadr));
    const idx: usize = @intCast(entry);
    // Read LE32 offset to pattern via raw bytes to avoid alignment issues
    const patttbl_bytes: [*]const u8 = @ptrCast(@alignCast(layer.*.patttable));
    const p: [*]const u8 = patttbl_bytes + (idx * 4);
    const off: usize = @intCast(std.mem.readInt(u32, p[0..4], .little));
    if (debug_enabled) shim.debug_state.pattern_ptr_offset = off;
    return @ptrCast(@alignCast(@as([*]u8, @ptrCast(base)) + off));
}
pub fn mppe_DoVibrato(period: mm.Word, channel: [*c]mm.ModuleChannel, layer: [*c]mm.LayerInfo) mm.Word {
    var position: mm.Byte = undefined;
    if (layer.*.oldeffects == 0 or layer.*.tick != 0) {
        position = @as(mm.Byte, @truncate(channel.*.vibspd + channel.*.vibpos));
        channel.*.vibpos = position;
    } else {
        position = channel.*.vibpos;
    }
    var value: mm.Sword = tables.mpp_TABLE_FineSineData[position];
    const depth: mm.Sword = @as(mm.Sword, @bitCast(@as(usize, channel.*.vibdep)));
    value = (value * depth) >> @intCast(8);
    if (value < 0) return mpph_PitchSlide_Down(period, @as(mm.Word, @bitCast(-value)), layer);
    return mpph_PitchSlide_Up(period, @as(mm.Word, @bitCast(value)), layer);
}
pub fn mppe_glis_backdoor(param: mm.Word, period: mm.Word, act_ch: ?[*c]mm.ActiveChannel, channel: [*c]mm.ModuleChannel, layer: [*c]mm.LayerInfo) mm.Word {
    if (act_ch == null) return period;
    const sample: [*c]align(1) SampleInfo = mpp_SamplePointer(layer, act_ch.?.*.sample);
    const target_period: mm.Word = arm.getPeriod(layer, sample.*.frequency * 4, channel.*.note);
    var new_period: mm.Word = undefined;
    if (layer.*.flags & MAS_HEADER_FLAG_FREQ_MODE != 0) {
        if (channel.*.period < target_period) {
            new_period = mpph_PitchSlide_Up(channel.*.period, param, layer);
            if (new_period > target_period) {
                new_period = target_period;
            }
        } else if (channel.*.period > target_period) {
            new_period = mpph_PitchSlide_Down(channel.*.period, param, layer);
            if (new_period < target_period) {
                new_period = target_period;
            }
        } else {
            return period;
        }
    } else {
        if (channel.*.period < target_period) {
            new_period = mpph_PitchSlide_Down(channel.*.period, param, layer);
            if (new_period > target_period) {
                new_period = target_period;
            }
        } else if (channel.*.period > target_period) {
            new_period = mpph_PitchSlide_Up(channel.*.period, param, layer);
            if (new_period < target_period) {
                new_period = target_period;
            }
        } else {
            return period;
        }
    }
    const old_period: mm.Word = channel.*.period;
    channel.*.period = new_period;
    const delta: i32 = @as(i32, @bitCast(new_period -% old_period));
    return period +% @as(mm.Word, @bitCast(delta));
}
pub fn mpp_Update_ACHN(layer: [*c]mm.LayerInfo, act_ch: [*c]mm.ActiveChannel, period: mm.Word, ch: mm.Word) void {
    if (act_ch.*.flags & MCAF_EFFECT != 0) return;
    _ = mpp_Update_ACHN_notest(layer, act_ch, period, ch);
}
pub fn mpp_setbpm(layer_info: [*c]mm.LayerInfo, bpm: mm.Word) void {
    layer_info.*.bpm = @intCast(bpm);
    if (mpp_clayer == .main) {
        const tempo: mm.Word = (mm_mastertempo * bpm) >> 10;
        var rate: mm.Word = mixer.mm_bpmdv / tempo;
        rate &= ~@as(mm.Word, 1);
        layer_info.*.tickrate = @intCast(rate);
    } else {
        layer_info.*.tickrate = @intCast((bpm << 15) / 149);
    }
    if (debug_enabled) shim.debug_state.tickrate = layer_info.*.tickrate;
}
pub fn mpp_suspend(layer: mm_layer_type) void {
    var act_ch: [*c]mm.ActiveChannel = &mm_gba.achannels[0];
    var mix_ch: [*c]volatile mm.MixerChannel = &mixer.mm_mix_channels[0];
    var count: mm.Word = mm_gba.num_ach;
    while (count != 0) : (_ = blk: {
        _ = blk_1: {
            count -%= 1;
            break :blk_1 blk_2: {
                const ref = &act_ch;
                const tmp = ref.*;
                ref.* += 1;
                break :blk_2 tmp;
            };
        };
        break :blk blk_1: {
            const ref = &mix_ch;
            const tmp = ref.*;
            ref.* += 1;
            break :blk_1 tmp;
        };
    }) {
        if (act_ch.*.flags & (MCAF_SUB | MCAF_EFFECT) >> 6 != @intFromEnum(layer)) continue;
        mix_ch.*.freq = 0;
    }
}
pub fn mpps_backdoor(id: mm.Word, mode: mm_pmode, layer: LayerType) void {
    // TODO: Use proper struct type
    // Use exported module table pointer and read entry as LE32 to avoid alignment issues
    const moduleTable_ptr: [*]const u32 = @ptrCast(mm_gba.getModuleTable());
    const module_table_bytes: [*]const u8 = @ptrCast(moduleTable_ptr);
    const ptr_off: [*]const u8 = module_table_bytes + (@as(usize, @intCast(id)) * 4);
    const entry_off: mm.Word = @as(mm.Word, @intCast(@as(u32, ptr_off[0]) | (@as(u32, ptr_off[1]) << 8) | (@as(u32, ptr_off[2]) << 16) | (@as(u32, ptr_off[3]) << 24)));

    // Offsets in the module table point to the start of each MAS file, which
    // begins with an 8-byte mm_mas_prefix. Skip it to reach the module header.
    const full_offset: usize = entry_off;
    const moduleAddress: usize = @intFromPtr(mm_gba.bank_base) + full_offset;

    if (debug_enabled) {
        shim.debug_state.module_address_offset = full_offset;
        shim.debug_state.module_address = moduleAddress;
    }

    mmPlayModule(moduleAddress, @intCast(mode), layer);
}
pub fn mpp_resetchannels(channels: [*c]mm.ModuleChannel, num_ch: mm.Word) void {
    // Clear channel data to 0 and reset alloc to NO_CHANNEL_AVAILABLE
    var i: mm.Word = 0;
    while (i < num_ch) : (i +%= 1) {
        channels[i] = .{};
        channels[i].alloc = @intCast(NO_CHANNEL_AVAILABLE);
    }
    var curr_mix_ch: usize = 0;
    var curr_act_ch: usize = 0;
    var j: mm.Word = 0;
    while (j < mm_gba.num_ach) : (j += 1) {
        const act_ch: [*c]mm.ActiveChannel = &mm_gba.achannels[curr_act_ch];
        if (act_ch.*.flags & (MCAF_SUB | MCAF_EFFECT) >> 6 != @intFromEnum(mpp_clayer)) continue;

        act_ch.* = .{};
        // Note: Removed debug code that set mix_ch.*.src to STOPPED - it interfered with hash
        // calculation and wasn't present in the original C implementation

        curr_act_ch += 1;
        curr_mix_ch += 1;
    }
}
pub fn mppStop() void {
    var layer_info: [*c]mm.LayerInfo = undefined;
    var channels: [*c]mm.ModuleChannel = undefined;
    var num_ch: mm.Word = undefined;
    if (mpp_clayer == .jingle) {
        layer_info = &mmLayerSub;
        channels = @as([*c]mm.ModuleChannel, @ptrCast(@alignCast(&mm_schannels[0])));
        num_ch = 4;
    } else {
        layer_info = &mm_gba.layer_main;
        channels = mm_gba.pchannels;
        num_ch = mm_gba.num_mch;
    }
    layer_info.*.isplaying = 0;
    layer_info.*.valid = 0;
    mpp_resetchannels(channels, num_ch);
}
pub fn mpp_setposition(layer_info: [*c]mm.LayerInfo, position: mm.Word) void {
    var pos = position;
    const header: [*c]mm.MasHead = layer_info.*.songadr;
    var entry: mm.Byte = undefined;
    while (true) {
        layer_info.*.position = @as(mm.Byte, @bitCast(@as(u8, @truncate(pos))));
        // TODO: Use proper struct type
        // Read sequence entry via raw bytes to avoid any struct packing drift
        const hbytes: [*]const u8 = @ptrFromInt(@intFromPtr(header));
        const seq_off: usize = 9 + 3 + 32 + 32; // fields(9) + reserved(3) + ch_vol(32) + ch_pan(32)
        entry = @as(mm.Byte, @bitCast(hbytes[seq_off + @as(usize, @intCast(pos))]));
        // Validate that entry index is within pattern table bounds; if not, try pos+1.
        const patt_count: u8 = header.*.pattn_count;
        if (entry >= patt_count) {
            pos +%= 1;
            continue;
        }
        // Value 254 is written by mmutil when an invalid pattern order is found
        // (when it's outside of bounds). Skip pattern orders with 254.
        if (entry == 254) {
            pos +%= 1;
            continue;
        }
        // The last pattern order of the song is marked as 255. If we haven't
        // finished the last pattern, keep playing the song.
        if (entry != 255) break;
        // We have reached the end of the last pattern. If the song is looping,
        // go to the loop starting point. If not, stop the playback.
        if (layer_info.*.mode == MM_PLAY_ONCE) {
            // It's playing once
            mppStop();
            if (mmCallback != null) {
                _ = mmCallback.?(MMCB_SONGFINISHED, mpp_clayer);
            }
            return;
        } else {
            // If looping, set position to the repeat position
            pos = header.*.repeat_position;
        }
    }
    if (debug_enabled) {
        shim.debug_state.layer_position = pos;
        shim.debug_state.pattern_entry = entry;
    }
    const patt_pat: [*c]Pattern = mpp_PatternPointer(layer_info, entry);
    // Save pattern size
    layer_info.*.nrows = patt_pat.*.row_count;
    if (debug_enabled) shim.debug_state.layer_nrows = layer_info.*.nrows;

    // Reset tick/row
    layer_info.*.tick = 0;
    layer_info.*.row = 0;
    layer_info.*.fpattdelay = 0;
    layer_info.*.pattdelay = 0;
    // Store pattern data address
    layer_info.*.pattread = patt_pat.*.pattern_data();
    // Reset pattern loop
    layer_info.*.ploop_adr = patt_pat.*.pattern_data();
    layer_info.*.ploop_row = 0;
    layer_info.*.ploop_times = 0;

    if (debug_enabled) shim.debug_state.patt_peek = layer_info.*.pattread[0];
}
pub fn mpp_resetvars(layer_info: [*c]mm.LayerInfo) void {
    layer_info.*.pattjump = 255;
    layer_info.*.pattjump_row = 0;
}
pub fn mpp_Channel_GetACHN(channel: [*c]mm.ModuleChannel) [*c]mm.ActiveChannel {
    const alloc: mm.Word = channel.*.alloc;
    if (alloc == 255) return null;
    return &mm_gba.achannels[alloc];
}
pub fn mpph_psu(period: mm.Word, slide_value: mm.Word) mm.Word {
    var per = period;
    if (slide_value >= 192) {
        per *= 2;
    }
    const val: mm.Word = (per >> 5) * tables.mpp_TABLE_LinearSlideUpTable[slide_value];
    const ret: mm.Word = (val >> (16 - 5)) + per;
    if ((ret >> (16 + 5)) > 0) return 1 << (16 + 5);
    return ret;
}
pub fn mpph_psd(period: mm.Word, slide_value: mm.Word) mm.Word {
    const val: mm.Word = (period >> 5) * tables.mpp_TABLE_LinearSlideDownTable[slide_value];
    const ret: mm.Word = val >> (16 - 5);
    return ret;
}
pub fn mpph_PitchSlide_Up(period: mm.Word, slide_value: mm.Word, layer: [*c]mm.LayerInfo) mm.Word {
    if ((layer.*.flags & MAS_HEADER_FLAG_FREQ_MODE) != 0) {
        return mpph_psu(period, slide_value);
    } else {
        const delta: mm.Word = slide_value << 4;
        if (delta > period) return 0;
        return period - delta;
    }
    return 0;
}
pub fn mpph_LinearPitchSlide_Up(period: mm.Word, slide_value: mm.Word, layer: [*c]mm.LayerInfo) mm.Word {
    if ((layer.*.flags & MAS_HEADER_FLAG_FREQ_MODE) != 0) return mpph_psu(period, slide_value) else return mpph_psd(period, slide_value);
    return 0;
}
pub fn mpph_FinePitchSlide_Up(period: mm.Word, slide_value: mm.Word, layer: [*c]mm.LayerInfo) mm.Word {
    if ((layer.*.flags & MAS_HEADER_FLAG_FREQ_MODE) != 0) {
        const val: mm.Word = (period >> 5) * tables.mpp_TABLE_FineLinearSlideUpTable[slide_value];
        const ret: mm.Word = (val >> (16 - 5)) + period;
        if ((ret >> (16 + 5)) > 0) return 1 << (16 + 5);
        return ret;
    } else {
        const delta: mm.Word = slide_value << 2;
        if (delta > period) return 0;
        return period - delta;
    }
    return 0;
}
pub fn mpph_PitchSlide_Down(period: mm.Word, slide_value: mm.Word, layer: [*c]mm.LayerInfo) mm.Word {
    var per = period;
    if ((layer.*.flags & MAS_HEADER_FLAG_FREQ_MODE) != 0) {
        return mpph_psd(per, slide_value);
    } else {
        const delta: mm.Word = slide_value << @intCast(4);
        per += delta;
        if ((per >> (16 + 5)) > 0) return 1 << (16 + 5);
        return per;
    }
    return 0;
}
pub fn mpph_LinearPitchSlide_Down(period: mm.Word, slide_value: mm.Word, layer: [*c]mm.LayerInfo) mm.Word {
    if ((layer.*.flags & MAS_HEADER_FLAG_FREQ_MODE) != 0) return mpph_psd(period, slide_value) else return mpph_psu(period, slide_value);
    return 0;
}
pub fn mpph_FinePitchSlide_Down(period: mm.Word, slide_value: mm.Word, layer: [*c]mm.LayerInfo) mm.Word {
    var per = period;
    if ((layer.*.flags & MAS_HEADER_FLAG_FREQ_MODE) != 0) {
        const val: mm.Word = (per >> 5) * tables.mpp_TABLE_FineLinearSlideDownTable[slide_value];
        const ret: mm.Word = val >> (16 - 5);
        return ret;
    } else {
        const delta: mm.Word = slide_value << @intCast(2);
        per = per + delta;
        // Clip to 0.0 ~ 1.0
        if ((per >> (16 + 5)) > 0) return 1 << (16 + 5);
        return per;
    }
    return 0;
}
pub fn mpph_FastForward(layer: [*c]mm.LayerInfo, rows_to_skip: mm.Word) void {
    var rows = rows_to_skip;
    if (rows == 0) return;
    // layer->nrows has the number of rows in the current pattern minus one
    if (rows > layer.*.nrows) return;
    layer.*.row = @intCast(rows);
    while (true) {
        const ok = arm.readPattern(layer);
        // If there was some error (the module uses too many channels, for
        // example), stop it right away.
        if (!ok) {
            mppStop();
            if (mmCallback != null) {
                _ = mmCallback.?(MMCB_SONGERROR, mpp_clayer);
            }
            break;
        }
        rows -= 1;
        if (rows == 0) break;
    }
}
pub fn mpp_Channel_ExchangeMemory(effect: mm.Byte, param: mm.Byte, channel: [*c]mm.ModuleChannel, layer: [*c]mm.LayerInfo) mm.Word {
    // An effect of 0 means custom behaviour, or disabled
    if (effect == 0) return param;

    var table_entry: mm.Sbyte = undefined;
    // Check flags for XM mode
    if ((layer.*.flags & MAS_HEADER_FLAG_XM_MODE) != 0) {
        table_entry = tables.mpp_effect_memmap_xm[effect - 1];
    } else {
        // IT Effects
        table_entry = tables.mpp_effect_memmap_it[effect - 1];
    }
    // If the effect doesn't use the memory table there's nothing left to do
    if (table_entry == -1) return param;
    const table_entry_index: usize = @intCast(table_entry);
    if (param == 0) {
        // If the parameter is empty, load it from memory
        channel.*.param = channel.*.memory[table_entry_index];
        return channel.*.param;
    } else {
        // If the parameter isn't empty, save it to memory
        channel.*.memory[table_entry_index] = param;
        return param;
    }
    return 0;
}
// This is also used for panning slide
pub fn mpph_VolumeSlide(volume: i32, param: mm.Word, tick: mm.Word, max_volume: i32, layer: [*c]mm.LayerInfo) mm.Word {
    var vol = volume;
    if ((layer.*.flags & MAS_HEADER_FLAG_XM_MODE) != 0) {
        if (tick != 0) {
            const r3: i32 = @intCast(param >> 4);
            const r1: i32 = @intCast(param & 15);

            var new_val: i32 = (vol + r3) - r1;
            if (new_val > max_volume) {
                new_val = max_volume;
            }
            if (new_val < 0) {
                new_val = 0;
            }

            vol = new_val;
        }
        return @intCast(vol);
    } else { // mpph_vs_IT
        if (param == 0xF) {
            vol -= 15;
            if (vol < 0) return 0;
            return @intCast(vol);
        }
        if (param == 0xF0) {
            if (tick != 0) return @intCast(volume);
            vol += 15;
            if (vol > max_volume) return @intCast(max_volume);
            return @intCast(vol);
        }
        // Test for Dx0 : mpph_vs_add
        if ((param & 15) == 0) {
            if (tick == 0) return @intCast(vol);
            vol += @intCast(param >> 4);
            if (vol > max_volume) return @intCast(max_volume);
            return @intCast(vol);
        }
        // Test for D0x : mpph_vs_sub
        if ((param >> @intCast(4)) == 0) {
            if (tick == 0) return @intCast(vol);
            vol -= @intCast(param & 15);
            if (vol < 0) return 0;
            return @intCast(vol);
        }
        // Fine slides now... only slide on tick 0
        if (tick != 0) return @intCast(vol);
        // Test for DxF
        if ((param & 15) == 0xF) {
            vol += @intCast(param >> 4);
            if (vol > max_volume) return @intCast(max_volume);
            return @intCast(vol);
        }
        // Test for DFx
        if ((param >> @intCast(4)) == 0xF) {
            vol -= @intCast(param & 15);
            if (vol < 0) return 0;
            return @intCast(vol);
        }
        return @intCast(vol);
    }
    return 0;
}
pub fn mpph_VolumeSlide64(volume: i32, param: mm.Word, tick: mm.Word, layer: [*c]mm.LayerInfo) mm.Word {
    const out = mpph_VolumeSlide(volume, param, tick, 64, layer);
    return out;
}
pub fn mppe_SetSpeed(param: mm.Word, layer: [*c]mm.LayerInfo) void {
    if (layer.*.tick != 0) return;
    if (param != 0) {
        layer.*.speed = @intCast(param);
    }
}
pub fn mppe_PositionJump(param: mm.Word, layer: [*c]mm.LayerInfo) void {
    if (layer.*.tick != 0) return;
    layer.*.pattjump = @intCast(param);
}
pub fn mppe_PatternBreak(param: mm.Word, layer: [*c]mm.LayerInfo) void {
    if (layer.*.tick != 0) return;
    layer.*.pattjump_row = @intCast(param);
    // Check if pattjump is empty
    if (layer.*.pattjump == 255) {
        layer.*.pattjump = @intCast(layer.*.position + 1);
    }
}
pub fn mppe_VolumeSlide(param: mm.Word, channel: [*c]mm.ModuleChannel, layer: [*c]mm.LayerInfo) void {
    const vol_word = mpph_VolumeSlide64(
        @intCast(channel.*.volume),
        param,
        @intCast(layer.*.tick),
        layer,
    );
    channel.*.volume = @intCast(vol_word);
}
pub fn mppe_Portamento(param: mm.Word, period: mm.Word, channel: [*c]mm.ModuleChannel, layer: [*c]mm.LayerInfo) mm.Word {
    var par = param;
    var is_fine: bool = false;
    // Test for Ex param (Extra fine slide)
    if ((par >> 4) == 0xE) {
        // Extra fine slide: only slide on tick 0
        if (layer.*.tick != 0) return period;
        // Mask out slide value
        par &= 15;
        is_fine = true;
    } else if ((par >> 4) == 0xF) {
        // Test for Fx param (Fine slide)
        // Fine slide: only slide on tick 0
        if (layer.*.tick != 0) return period;
        // Mask out slide value
        par &= 15;
    } else {
        // Regular slide
        if (layer.*.tick == 0) return period;
    }
    // Check slide direction
    var new_period: mm.Word = undefined;
    // 5 = portamento down
    if (channel.*.effect == 5) {
        // Slide down
        if (is_fine) {
            new_period = mpph_FinePitchSlide_Down(channel.*.period, par, layer);
        } else {
            new_period = mpph_PitchSlide_Down(channel.*.period, par, layer);
        }
    } else {
        // Slide up
        if (is_fine) {
            new_period = mpph_FinePitchSlide_Up(channel.*.period, par, layer);
        } else {
            new_period = mpph_PitchSlide_Up(channel.*.period, par, layer);
        }
        // TODO: This doesn't seem to have any check to prevent overflows
    }
    const old_period: i32 = @intCast(channel.*.period);
    channel.*.period = new_period;
    const delta: i32 = @as(i32, @intCast(new_period)) - old_period;
    return @intCast(@as(i32, @intCast(period)) + delta);
}
pub fn mppe_Glissando(param: mm.Word, period: mm.Word, act_ch: ?[*c]mm.ActiveChannel, channel: [*c]mm.ModuleChannel, layer: [*c]mm.LayerInfo) mm.Word {
    var par = param;
    var per = period;
    if (layer.*.tick == 0) {
        if ((layer.*.flags & MAS_HEADER_FLAG_LINK_GXX) != 0) {
            // Gxx is shared, IT MODE ONLY!!
            if (par == 0) {
                par = channel.*.memory[MPP_IT_PORTA];
                channel.*.param = @intCast(par);
            }
            channel.*.memory[MPP_IT_PORTA] = @intCast(par);
            // For simplification later
            channel.*.memory[MPP_XM_IT_GLIS] = @intCast(par);
        } else {
            // Gxx is separate
            if (par == 0) {
                par = channel.*.memory[MPP_XM_IT_GLIS];
                channel.*.param = @intCast(par);
            }
            channel.*.memory[MPP_XM_IT_GLIS] = @intCast(par);
            return period;
        }
    }
    par = channel.*.memory[MPP_XM_IT_GLIS];
    per = mppe_glis_backdoor(par, per, act_ch, channel, layer);
    return per;
}
pub fn mppe_Vibrato(param: mm.Word, period: mm.Word, channel: [*c]mm.ModuleChannel, layer: [*c]mm.LayerInfo) mm.Word {
    if (layer.*.tick != 0) return mppe_DoVibrato(period, channel, layer);
    const x: mm.Word = param >> @intCast(4);
    const y: mm.Word = param & 15;
    if (x != 0) {
        channel.*.vibspd = @intCast(x * 4);
    }
    if (y != 0) {
        const depth: mm.Word = y * 4;
        channel.*.vibdep = @intCast(depth << @intCast(layer.*.oldeffects));
        return mppe_DoVibrato(period, channel, layer);
    }
    return period;
}
pub fn mppe_Arpeggio(param: mm.Word, period: mm.Word, act_ch: ?[*c]mm.ActiveChannel, channel: [*c]mm.ModuleChannel, layer: [*c]mm.LayerInfo) mm.Word {
    if (layer.*.tick == 0) {
        channel.*.fxmem = 0;
    }
    if (act_ch == null) return period;
    var semitones: mm.Word = undefined;
    if (channel.*.fxmem > 1) {
        // Set next tick to 0
        channel.*.fxmem = 0;
        // Mask out low nibble of param
        semitones = param & 15;
    } else if (channel.*.fxmem == 1) {
        // Set next tick to 2
        channel.*.fxmem = 2;
        // Mask out high nibble of param
        semitones = param >> 4;
    } else {
        // Do nothing! :)
        channel.*.fxmem = 1;
        return period;
    }
    // The assembly code had the following conditional, but the register used to
    // store the period was overwritten by mpph_LinearPitchSlide_Up() right
    // after jumping to it, even in the original assembly code before the C port
    // started. Is this a bug, or do we need to enable it?
    //
    // See if its >= 12. Double period if so... (set an octave higher)
    //if (semitones >= 12)
    //    period *= 2;
    semitones *%= 16;

    const per = mpph_LinearPitchSlide_Up(period, semitones, layer);
    return per;
}
pub fn mppe_VibratoVolume(param: mm.Word, period: mm.Word, channel: [*c]mm.ModuleChannel, layer: [*c]mm.LayerInfo) mm.Word {
    const new_period: mm.Word = mppe_DoVibrato(period, channel, layer);
    mppe_VolumeSlide(param, channel, layer);
    return new_period;
}
pub fn mppe_PortaVolume(param: mm.Word, period: mm.Word, act_ch: ?[*c]mm.ActiveChannel, channel: [*c]mm.ModuleChannel, layer: [*c]mm.LayerInfo) mm.Word {
    const mem: mm.Word = channel.*.memory[0];
    const per = mppe_Glissando(mem, period, act_ch, channel, layer);
    mppe_VolumeSlide(param, channel, layer);
    return per;
}
pub fn mppe_ChannelVolume(param: mm.Word, channel: [*c]mm.ModuleChannel, layer: [*c]mm.LayerInfo) void {
    if (layer.*.tick != 0) return;
    if (param > 64) return;
    channel.*.cvolume = @intCast(param);
}
pub fn mppe_ChannelVolumeSlide(param: mm.Word, channel: [*c]mm.ModuleChannel, layer: [*c]mm.LayerInfo) void {
    channel.*.cvolume = @intCast(mpph_VolumeSlide64(@intCast(channel.*.cvolume), param, @intCast(layer.*.tick), layer));
}
pub fn mppe_SampleOffset(param: mm.Word, layer: [*c]mm.LayerInfo) void {
    if (layer.*.tick != 0) return;
    mpp_vars.sampoff = @intCast(param);
}
pub fn mppe_Retrigger(param: mm.Word, act_ch: ?[*c]mm.ActiveChannel, channel: [*c]mm.ModuleChannel) void {
    // We don't check layer->tick here. We set channel->fxmem to the parameter
    // and every time this function gets called it goes down by one. When it
    // reaches 1, the command is executed.
    //
    // Note that we can't use 0 as a countdown target. That would be interpreted
    // as "fxmem hasn't been set", so we need to store the count plus 1.

    var mem: mm.Word = channel.*.fxmem;
    if (mem == 0) {
        channel.*.fxmem = @intCast((param & 15) + 1);
        return;
    }
    mem -%= 1;
    if (mem != 1) {
        channel.*.fxmem = @intCast(mem);
        return;
    }
    channel.*.fxmem = @intCast((param & 15) + 1);
    // Handle subcommand
    var vol: i32 = @intCast(channel.*.volume);
    const arg: mm.Word = param >> @intCast(4);
    if (arg == 0) {} else if (arg <= 5) {
        // -1, -2, -4, -8, -16
        vol -= @as(i32, 1) << @intCast(arg - 1);
        if (vol < 0) {
            vol = 0;
        }
    } else if (arg == 6) {
        vol = (vol * 171) >> 8;
    } else if (arg == 7) {
        vol >>= 1;
    } else if (arg == 8) {} else if (arg <= 13) {
        // +1, +2, +4, +8, +16
        vol += @as(i32, 1) << @intCast(arg - 9);
        if (vol > 64) {
            vol = 64;
        }
    } else if (arg == 14) {
        vol = (vol * 192) >> 7;
    } else {
        vol <<= 1;
        if (vol > 64) {
            vol = 64;
        }
    }
    channel.*.volume = @intCast(vol);
    if (act_ch != null) {
        act_ch.?.*.flags |= 1 << 2;
    }
}
pub fn mppe_Tremolo(param: mm.Word, channel: [*c]mm.ModuleChannel, layer: [*c]mm.LayerInfo) void {
    // X = speed, Y = depth
    if (layer.*.tick != 0) {
        // Get sine position
        var position: mm.Word = channel.*.fxmem;
        const speed: mm.Word = param >> 4;
        // Mask out SPEED, multiply by 4 to compensate for larger sine table
        position += speed * 4;
        // Save (value & 255)
        channel.*.fxmem = @intCast(position & 255);
    }
    // Get sine position
    const position: mm.Word = channel.*.fxmem;
    // Load sine table value
    const sine: mm.Sword = tables.mpp_TABLE_FineSineData[position];
    const depth: mm.Word = param & 15;
    // Sine * depth / 64
    var result: mm.Sword = @bitCast((sine * @as(mm.Sword, @intCast(depth))) >> 6);
    if ((layer.*.flags & MAS_HEADER_FLAG_XM_MODE) != 0) {
        result >>= 1;
    }
    mpp_vars.volplus = @intCast(result);
}
pub fn mppe_SetTempo(param: mm.Word, layer: [*c]mm.LayerInfo) void {
    if (param < 16) {
        if (layer.*.tick == 0) return;
        var bpm: i32 = @intCast(layer.*.bpm - param);
        if (bpm < 32) {
            bpm = 32;
        }
        mpp_setbpm(layer, @intCast(bpm));
    } else if (param < 32) {
        if (layer.*.tick == 0) return;
        var bpm: i32 = @intCast(layer.*.bpm + (param & 15));
        if (bpm > 255) {
            bpm = 255;
        }
        mpp_setbpm(layer, @intCast(bpm));
    } else {
        if (layer.*.tick != 0) return;
        mpp_setbpm(layer, param);
    }
}
pub fn mppe_FineVibrato(param: mm.Word, period: mm.Word, channel: [*c]mm.ModuleChannel, layer: [*c]mm.LayerInfo) mm.Word {
    if (layer.*.tick == 0) {
        const x: mm.Word = param >> @intCast(4);
        const y: mm.Word = param & 15;
        if (x != 0) {
            channel.*.vibspd = @intCast(x * 4);
        }
        if (y != 0) {
            var depth: mm.Word = y * 4;
            _ = &depth;
            channel.*.vibdep = @intCast(depth << @intCast(layer.*.oldeffects));
        }
    }
    return mppe_DoVibrato(period, channel, layer);
}
pub fn mppe_SetGlobalVolume(param: mm.Word, layer: [*c]mm.LayerInfo) void {
    if (layer.*.tick != 0) return;
    const mask: mm.Word = MAS_HEADER_FLAG_XM_MODE | MAS_HEADER_FLAG_OLD_MODE;
    var maxvol: mm.Word = undefined;
    if ((layer.*.flags & mask) != 0) {
        maxvol = 64;
    } else {
        maxvol = 128;
    }
    layer.*.global_volume = @intCast(if (param < maxvol) param else maxvol);
}
pub fn mppe_GlobalVolumeSlide(param: mm.Word, layer: [*c]mm.LayerInfo) void {
    var maxvol: mm.Word = undefined;
    if ((layer.*.flags & MAS_HEADER_FLAG_XM_MODE) != 0) {
        maxvol = 64;
    } else {
        maxvol = 128;
    }
    layer.*.global_volume = @intCast(mpph_VolumeSlide(@intCast(layer.*.global_volume), param, @intCast(layer.*.tick), @intCast(maxvol), layer));
}
pub fn mppe_SetPanning(param: mm.Word, channel: [*c]mm.ModuleChannel, layer: [*c]mm.LayerInfo) void {
    if (layer.*.tick == 0) {
        channel.*.panning = @intCast(param);
    }
}
pub fn mppex_XM_FVolSlideUp(param: mm.Word, channel: [*c]mm.ModuleChannel, layer: [*c]mm.LayerInfo) void {
    if (layer.*.tick != 0) return;
    var volume: i32 = @as(i32, @bitCast(@as(mm.Word, @bitCast(@as(usize, channel.*.volume))) +% (param & 15)));
    if (volume > 64) {
        volume = 64;
    }
    channel.*.volume = @intCast(volume);
}
pub fn mppex_XM_FVolSlideDown(param: mm.Word, channel: [*c]mm.ModuleChannel, layer: [*c]mm.LayerInfo) void {
    if (layer.*.tick != 0) return;
    var volume: i32 = @as(i32, @bitCast(@as(mm.Word, @bitCast(@as(usize, channel.*.volume))) -% (param & 15)));
    if (volume < 0) {
        volume = 0;
    }
    channel.*.volume = @intCast(volume);
}
pub fn mppex_OldRetrig(param: mm.Word, act_ch: ?[*c]mm.ActiveChannel, channel: [*c]mm.ModuleChannel, layer: [*c]mm.LayerInfo) void {
    if (layer.*.tick == 0) {
        channel.*.fxmem = @as(mm.Byte, @bitCast(@as(u8, @truncate(param & @as(mm.Word, @bitCast(@as(i32, 15)))))));
        return;
    }
    channel.*.fxmem -%= 1;
    if (channel.*.fxmem == 0) {
        channel.*.fxmem = @intCast(param & 15);
        if (act_ch != null) {
            act_ch.?.*.flags |= MCAF_START;
        }
    }
}
pub fn mppex_FPattDelay(param: mm.Word, layer: [*c]mm.LayerInfo) void {
    if (layer.*.tick != 0) return;
    layer.*.fpattdelay = @intCast(param & 15);
}
pub fn mppex_InstControl(param: mm.Word, act_ch: ?[*c]mm.ActiveChannel, channel: [*c]mm.ModuleChannel, layer: [*c]mm.LayerInfo) void {
    if (layer.*.tick != 0) return;
    const subparam: mm.Word = param & 15;
    // mppex_ic_pastnotes
    if (subparam <= 2) {
        // TODO
    } else if (subparam <= 6) {
        // Overwrite NNA
        channel.*.bflags &= ~MCH_BFLAGS_NNA_MASK;
        channel.*.bflags |= @intCast(arm.MCH_BFLAGS_NNA_SET(subparam - 3));
    } else if (subparam <= 8) {
        if (act_ch != null) {
            // val can be 0 or 1
            const val: i32 = @as(i32, @intCast(subparam)) - 7;
            if (val != 0) {
                act_ch.?.*.flags |= MCAF_VOLENV;
            } else {
                act_ch.?.*.flags &= ~MCAF_VOLENV;
            }
        }
    }
}
pub fn mppex_SetPanning(param: mm.Word, channel: [*c]mm.ModuleChannel) void {
    channel.*.panning = @intCast(param << 4);
}
pub fn mppex_SoundControl(param: mm.Word) void {
    if (param != 145) return;
    // Set surround
    // TODO
}
pub fn mppex_PatternLoop(param: mm.Word, layer: [*c]mm.LayerInfo) void {
    if (layer.*.tick != 0) return;
    const subparam: mm.Word = param & 15;
    if (subparam == 0) {
        layer.*.ploop_row = layer.*.row;
        layer.*.ploop_adr = mpp_vars.pattread_p;
        return;
    }
    const counter: mm.Word = layer.*.ploop_times;
    if (counter == 0) {
        layer.*.ploop_times = @intCast(subparam);
        layer.*.ploop_jump = 1;
    } else {
        layer.*.ploop_times = @intCast(counter - 1);
        if (layer.*.ploop_times != 0) {
            layer.*.ploop_jump = 1;
        }
    }
}
pub fn mppex_NoteCut(param: mm.Word, channel: [*c]mm.ModuleChannel, layer: [*c]mm.LayerInfo) void {
    const reference: mm.Word = param & 15;
    if (layer.*.tick != reference) return;
    channel.*.volume = 0;
}
pub fn mppex_NoteDelay(param: mm.Word, layer: [*c]mm.LayerInfo) void {
    const reference: mm.Word = param & 15;
    if (layer.*.tick >= reference) return;
    mpp_vars.notedelay = @intCast(reference);
}
pub fn mppex_PatternDelay(param: mm.Word, layer: [*c]mm.LayerInfo) void {
    if (layer.*.tick != 0) return;
    if (layer.*.pattdelay == 0) {
        layer.*.pattdelay = @intCast((param & 15) + 1);
    }
}
pub fn mppex_SongMessage(param: mm.Word, layer: [*c]mm.LayerInfo) void {
    if (layer.*.tick != 0) return;
    if (mmCallback != null) {
        const layer_type = (param & 15) | (@as(mm.Word, @intFromEnum(mpp_clayer)) << 4);
        _ = mmCallback.?(@intCast(42), @enumFromInt(layer_type));
    }
}
pub fn mppe_Extended(param: mm.Word, act_ch: ?[*c]mm.ActiveChannel, channel: [*c]mm.ModuleChannel, layer: [*c]mm.LayerInfo) void {
    const subcmd: mm.Word = param >> @intCast(4);
    while (true) {
        switch (subcmd) {
            0 => {
                mppex_XM_FVolSlideUp(param, channel, layer);
                break;
            },
            1 => {
                mppex_XM_FVolSlideDown(param, channel, layer);
                break;
            },
            2 => {
                mppex_OldRetrig(param, act_ch, channel, layer);
                break;
            },
            3 => break,
            4 => break,
            5 => break,
            6 => {
                mppex_FPattDelay(param, layer);
                break;
            },
            7 => {
                mppex_InstControl(param, act_ch, channel, layer);
                break;
            },
            8 => {
                mppex_SetPanning(param, channel);
                break;
            },
            9 => {
                mppex_SoundControl(param);
                break;
            },
            10 => break,
            11 => {
                mppex_PatternLoop(param, layer);
                break;
            },
            12 => {
                mppex_NoteCut(param, channel, layer);
                break;
            },
            13 => {
                mppex_NoteDelay(param, layer);
                break;
            },
            14 => {
                mppex_PatternDelay(param, layer);
                break;
            },
            15 => {
                mppex_SongMessage(param, layer);
                break;
            },
            else => break,
        }
        break;
    }
}
pub fn mppe_SetVolume(param: mm.Word, channel: [*c]mm.ModuleChannel, layer: [*c]mm.LayerInfo) void {
    if (layer.*.tick == 0) {
        channel.*.volume = @intCast(param);
    }
}
pub fn mppe_KeyOff(param: mm.Word, act_ch: ?[*c]mm.ActiveChannel, layer: [*c]mm.LayerInfo) void {
    if (layer.*.tick != param) return;
    if (act_ch != null) {
        act_ch.?.*.flags &= ~MCAF_KEYON;
    }
}
pub fn mppe_OldTremor(param: mm.Word, channel: [*c]mm.ModuleChannel, layer: [*c]mm.LayerInfo) void {
    if (layer.*.tick == 0) return;
    const mem: i32 = @intCast(channel.*.fxmem);
    if (mem == 0) {
        // Old
        channel.*.fxmem = @intCast(mem - 1);
    } else {
        // New
        channel.*.bflags ^= MCH_BFLAGS_TREMOR | MCH_BFLAGS_CUT_VOLUME;
        if ((channel.*.bflags & MCH_BFLAGS_CUT_VOLUME) != 0) {
            channel.*.fxmem = @intCast((param >> 4) + 1);
        } else {
            channel.*.fxmem = @intCast((param & 15) + 1);
        }
    }
    if ((channel.*.bflags & MCH_BFLAGS_CUT_VOLUME) == 0) {
        // Cut note
        mpp_vars.volplus = -64;
    }
}
pub fn mpph_ProcessEnvelope(count_: [*c]mm.Hword, node_: [*c]mm.Byte, envelope: [*c]Envelope, act_ch: [*c]mm.ActiveChannel, value_mul_64: [*c]mm.Word) mm.Word {
    var count: mm.Hword = count_.*;
    var node: mm.Byte = node_.*;

    const nodes_bytes: [*]const u8 = @as([*]const u8, @ptrCast(@alignCast(envelope))) + @sizeOf(Envelope);
    const stride: usize = 4;
    const node_offset = stride * @as(usize, @intCast(node));
    const node_bytes: [*]const u8 = nodes_bytes + node_offset;

    const delta_raw: i16 = std.mem.readInt(i16, node_bytes[0..2], .little);
    const base_range_raw: u16 = std.mem.readInt(u16, node_bytes[2..4], .little);
    const node_base: mm.Hword = @intCast(base_range_raw & 0x7F);
    const node_range: mm.Hword = @intCast((base_range_raw >> 7) & 0x1FF);

    value_mul_64.* = @intCast(node_base * 64);

    if (count == 0) {
        if (node == envelope.*.loop_end) {
            count_.* = count;
            node_.* = envelope.*.loop_start;
            return 2;
        }
        if ((act_ch.*.flags & MCAF_KEYON) != 0) {
            if (node == envelope.*.sus_end) {
                count_.* = count;
                node_.* = envelope.*.sus_start;
                return 0;
            }
        }
        const last_node: mm.Hword = if (envelope.*.node_count == 0) 0 else envelope.*.node_count - 1;
        if (node == last_node) {
            count_.* = count;
            node_.* = node;
            return 2;
        }
    } else {
        const interp: i32 = (@as(i32, delta_raw) * @as(i32, @intCast(count))) >> 3;
        const current: i32 = @intCast(value_mul_64.*);
        value_mul_64.* = @intCast(current + interp);
    }

    count +%= 1;
    if (node_range != 0 and count == node_range) {
        count = 0;
        node = @intCast((node + 1) & 0xFF);
    }

    count_.* = count;
    node_.* = node;
    return 2;
}
pub fn mpp_Update_ACHN_notest_envelopes(layer: [*c]mm.LayerInfo, act_ch: [*c]mm.ActiveChannel, period: mm.Word) mm.Word {
    const instrument: *Instrument = instrumentPointer(layer, act_ch.*.inst) orelse return period;
    // Instrument envelopes and note map data are stored immediately after the
    //  fixed-size instrument header in the MAS blob. The translate-c struct
    //  does not expose the trailing union, so compute the pointer manually.
    const INSTR_HDR_SIZE: usize = 12;
    var env_ptr: [*]mm.Byte = @as([*]mm.Byte, @ptrCast(@alignCast(instrument))) + INSTR_HDR_SIZE;

    var vol_env_active = false;
    if ((instrument.*.env_flags & MAS_INSTR_FLAG_VOL_ENV_EXISTS) != 0) {
        var value_mul_64: mm.Word = 0;
        const env: *Envelope = @ptrCast(@alignCast(env_ptr));
        env_ptr += env_ptr[0];
        if ((act_ch.*.flags & @as(mm.Byte, @intCast(MCAF_VOLENV))) != 0) {
            vol_env_active = true;
            const exit_value = mpph_ProcessEnvelope(&act_ch.*.envc_vol, &act_ch.*.envn_vol, env, act_ch, &value_mul_64);
            if (layer.*.tick != 0) {
                if (exit_value == 1) {
                    if ((layer.*.flags & MAS_HEADER_FLAG_XM_MODE) != 0) {
                        act_ch.*.flags |= MCAF_ENVEND;
                    } else {
                        act_ch.*.flags |= MCAF_ENVEND | MCAF_FADE;
                    }
                } else if (exit_value == 2) {
                    if ((act_ch.*.flags & MCAF_KEYON) == 0) {
                        act_ch.*.flags |= MCAF_FADE;
                    }
                }
            }
            const afv: mm.Sword = @intCast(mpp_vars.afvol);
            mpp_vars.afvol = @intCast((afv * @as(i32, @intCast(value_mul_64))) >> (6 + 6));
        }
    }

    if (!vol_env_active and (act_ch.*.flags & @as(mm.Byte, @intCast(MCAF_KEYON))) == 0) {
        act_ch.*.flags |= @as(mm.Byte, @intCast(MCAF_FADE | MCAF_ENVEND));
        if ((@as(i32, @intCast(layer.*.flags)) & MAS_HEADER_FLAG_XM_MODE) != 0) {
            act_ch.*.fade = 0;
        }
    }

    if ((@as(i32, @intCast(instrument.*.env_flags)) & MAS_INSTR_FLAG_PAN_ENV_EXISTS) != 0) {
        var value_mul_64_pan: mm.Word = 0;
        const env_pan: *Envelope = @ptrCast(@alignCast(env_ptr));
        env_ptr += env_ptr[0];
        _ = mpph_ProcessEnvelope(&act_ch.*.envc_pan, &act_ch.*.envn_pan, env_pan, act_ch, &value_mul_64_pan);
        mpp_vars.panplus += @as(mm.Hword, @intCast((@as(i32, @intCast(value_mul_64_pan)) >> 4) - 128));
    }

    var per = period;

    if ((@as(i32, @intCast(instrument.*.env_flags)) & MAS_INSTR_FLAG_PITCH_ENV_EXISTS) != 0) {
        var value_mul_64_pic: mm.Word = 0;
        const env_pic: *Envelope = @ptrCast(@alignCast(env_ptr));
        if (env_pic.*.is_filter == 0) {
            _ = mpph_ProcessEnvelope(&act_ch.*.envc_pic, &act_ch.*.envn_pic, env_pic, act_ch, &value_mul_64_pic);
            const value: mm.Sword = @as(mm.Sword, @intCast((@as(i32, @intCast(value_mul_64_pic)) >> 3) - 256));
            if (value < 0) {
                per = mpph_LinearPitchSlide_Down(per, @as(mm.Word, @intCast(-value)), layer);
            } else {
                per = mpph_LinearPitchSlide_Up(per, @as(mm.Word, @intCast(value)), layer);
            }
        }
    }

    if ((@as(i32, @intCast(act_ch.*.flags)) & MCAF_FADE) != 0) {
        var value: mm.Sword = @as(mm.Sword, @intCast(act_ch.*.fade)) - @as(mm.Sword, @intCast(instrument.*.fadeout));
        if (value < 0) value = 0;
        act_ch.*.fade = @as(mm.Hword, @intCast(value));
    }

    return period;
}
pub fn mpp_Update_ACHN_notest_auto_vibrato(layer: [*c]mm.LayerInfo, act_ch: [*c]mm.ActiveChannel, period: mm.Word) mm.Word {
    var per = period;
    // Get av-rate, check if auto vibrato is enabled
    const sample: [*c]align(1) SampleInfo = mpp_SamplePointer(layer, act_ch.*.sample);
    const av_rate: mm.Hword = sample.*.av_rate;
    if (av_rate != 0) {
        // Handle depth counter
        var new_rate: mm.Word = @as(mm.Word, @intCast(act_ch.*.avib_dep)) + av_rate;
        if (new_rate > 32768) {
            new_rate = 32768;
        }
        act_ch.*.avib_dep = @intCast(new_rate);
        // Get av-depth
        const new_depth: mm.Sword = @intCast(sample.*.av_depth * new_rate);
        // Add av-speed to table position and wrap to 0->255
        act_ch.*.avib_pos = (act_ch.*.avib_pos + sample.*.av_speed) & 255;
        // Load table value at the current position
        var slide_val: mm.Sword = tables.mpp_TABLE_FineSineData[act_ch.*.avib_pos];
        slide_val = (slide_val * new_depth) >> 23;
        // Perform slide
        if (slide_val >= 0) {
            per = mpph_PitchSlide_Up(period, @bitCast(slide_val), layer);
        } else {
            per = mpph_PitchSlide_Down(period, @bitCast(-slide_val), layer);
        }
    }
    return per;
}
pub fn mpp_Update_ACHN_notest_update_mix(layer: [*c]mm.LayerInfo, act_ch: [*c]mm.ActiveChannel, channel: mm.Word) [*c]volatile mm.MixerChannel {
    const mix_ch: [*c]volatile mm.MixerChannel = &mixer.mm_mix_channels[channel];
    var dbg_msl_id: u16 = 0;
    var dbg_sample_offset: u32 = 0;
    const ch_idx: usize = @intCast(channel);

    var did_bind: bool = false;
    // Update mixing information
    if ((act_ch.*.flags & MCAF_START) != 0) {
        // Start note
        act_ch.*.flags = act_ch.*.flags & ~MCAF_START;
        if (ch_idx < mm_gba.mix_stop_pending.len) {
            mm_gba.mix_stop_pending[ch_idx] = false;
        }
        // must have a valid sample
        if (act_ch.*.sample != 0) {
            const sample: [*c]align(1) SampleInfo = mpp_SamplePointer(layer, act_ch.*.sample);
            dbg_msl_id = @intCast(sample.*.msl_id);
            // Compute MAS GBA header address without relying on aligned struct loads
            var src_addr: usize = 0;
            if (sample.*.msl_id == 0xFFFF) {
                // Embedded sample in module: sample->data() already adds 12 to skip the header
                src_addr = @intFromPtr(sample.*.data());
                dbg_sample_offset = 0xFFFFFFFF; // embedded
            } else {
                // External sample in bank: mp_solution base + sampleTable[msl_id] + MAS prefix
                // The sample table stores u32 values, but they represent u16 offsets
                // Just use the low 16 bits directly
                const samp_tbl: [*]const u32 = mm_gba.getSampleTable();
                const idx: usize = @intCast(sample.*.msl_id);
                const table_val: u32 = samp_tbl[idx];
                const off: usize = table_val & 0xFFFF;
                dbg_sample_offset = @intCast(off);
                const bank_base_addr: usize = @intFromPtr(mm_gba.bank_base);
                const hdr_addr = bank_base_addr + off + @sizeOf(Prefix);
                // data starts 12 bytes after header
                src_addr = hdr_addr + 12;

                // Debug: log sample calculation for first few channels
                const debug_enabled_val = @import("build_options").xm_debug;
                if (debug_enabled_val and channel < 6) {
                    _ = gba.debug.print("[MAS_SMP] ch={d} msl={d} table=0x{x} off=0x{x} src=0x{x}\n", .{
                        channel, sample.*.msl_id, table_val, off, src_addr
                    }) catch {};
                }
            }
            // initialize read pointer and source
            mix_ch.*.src = @intCast(src_addr);

            did_bind = true;
            // initialize read pointer
            mix_ch.*.read = @as(u32, mpp_vars.sampoff) << (MP_SAMPFRAC + 8);
        }
    }
    return mix_ch;
}
// Returns the resulting volume of the channel
pub fn mpp_Update_ACHN_notest_set_pitch_volume(
    layer: [*c]mm.LayerInfo,
    act_ch: [*c]mm.ActiveChannel,
    period: mm.Word,
    mix_ch: [*c]volatile mm.MixerChannel,
) mm.Word {
    // Set pitch

    // Check sample number
    if (act_ch.*.sample == 0) {
        // Mute channel if invalid sample
        act_ch.*.fvol = 0;
        return 0;
    }
    const sample: [*c]align(1) SampleInfo = mpp_SamplePointer(layer, act_ch.*.sample);

    // Work around struct misalignment: read frequency field manually as little-endian u16
    // The soundbank layout causes the SampleInfo struct to be misaligned, resulting in the
    // frequency u16 field only reading 1 byte instead of 2
    // IMPORTANT: Don't use @alignCast - it would round the pointer to wrong address!
    const sample_ptr: [*]const u8 = @ptrCast(sample);
    const freq_corrected: mm.Hword = @as(mm.Hword, sample_ptr[2]) | (@as(mm.Hword, sample_ptr[3]) << 8);

    if ((layer.*.flags & MAS_HEADER_FLAG_FREQ_MODE) != 0) {
        // Linear frequencies
        const speed: mm.Hword = freq_corrected;
        var value: mm.Word = ((period >> 8) * (speed << 2)) >> 8;
        if (mpp_clayer == .main) {
            value = (value * mm_masterpitch) >> 10;
        }
        const scale_xm: mm.Word = 4096 * 65536 / 15768;
        mix_ch.*.freq = (scale_xm * value) >> 16;
    } else {
        // Amiga frequencies
        if (period != 0) {
            var value: mm.Word = MOD_FREQ_DIVIDER_PAL / period;
            if (mpp_clayer == .main) {
                value = (value * mm_masterpitch) >> 10;
            }
            const scale: mm.Word = 4096 * 65536 / 15768;
            mix_ch.*.freq = (scale * value) >> 16;
        }
    }
    // Set volume
    if (act_ch.*.inst == 0) {
        // Mute channel if invalid instrument
        act_ch.*.fvol = 0;
        return 0;
    }
    const inst: ?*Instrument = instrumentPointer(layer, act_ch.*.inst);
    var vol: mm.Word = @intCast(sample.*.global_volume); // SV
    const iv: mm.Word = @intCast((inst.?).*.global_volume); // IV
    const afv: mm.Word = @intCast(mpp_vars.afvol); // AFVOL
    const gv_pre: mm.Word = @intCast(layer.*.global_volume); // GV
    const xm_mode = (layer.*.flags & MAS_HEADER_FLAG_XM_MODE) != 0;
    vol *%= iv;
    vol *%= afv;
    var global_volume: mm.Word = gv_pre;
    if (xm_mode) {
        global_volume <<= 1;
    }
    vol = (vol * global_volume) >> 10;
    vol = (vol *% act_ch.*.fade) >> 10;
    vol *%= layer.*.volume;

    vol = vol >> 19;
    if (vol > 255) vol = 255;
    act_ch.*.fvol = @intCast(vol);

    return vol;
}
pub fn mpp_Update_ACHN_notest_disable_and_panning(
    volume: mm.Word,
    act_ch: [*c]mm.ActiveChannel,
    mix_ch: [*c]volatile mm.MixerChannel,
) void {
    const mix_idx_entry: i32 = @intCast((@intFromPtr(mix_ch) - @intFromPtr(mixer.mm_mix_channels)) / @sizeOf(mm.MixerChannel));
    var stop_pending = false;
    if (mix_idx_entry >= 0 and mix_idx_entry < mm_gba.mix_stop_pending.len) {
        const mix_idx_entry_usize: usize = @intCast(mix_idx_entry);
        if (mm_gba.mix_stop_pending[mix_idx_entry_usize]) {
            stop_pending = true;
            mm_gba.mix_stop_pending[mix_idx_entry_usize] = false;
        }
    }
    if (volume == 0) {
        const env_end = (act_ch.*.flags & MCAF_ENVEND) != 0;
        const key_on = (act_ch.*.flags & MCAF_KEYON) != 0;
        if (env_end and !key_on) {
            mix_ch.*.src = shim.MIXCH_GBA_SRC_STOPPED;
            if (act_ch.*._type == ACHN_FOREGROUND) {
                const parent_idx: usize = @intCast(act_ch.*.parent);
                if (parent_idx < mm_gba.mpp_nchannels) {
                    const parent_mod: [*c]mm.ModuleChannel = &mm_gba.mpp_channels[parent_idx];
                    parent_mod.*.alloc = NO_CHANNEL_AVAILABLE;
                    parent_mod.*.flags &= ~@as(mm.Byte, MF_START | MF_NEWINSTR);
                }
            }
            act_ch.*._type = ACHN_DISABLED;
            return;
        }
    }

    mix_ch.*.vol = @intCast(volume);

    if (stop_pending or (mix_ch.*.src & shim.MIXCH_GBA_SRC_STOPPED) != 0) {
        if (stop_pending and (mix_ch.*.src & shim.MIXCH_GBA_SRC_STOPPED) == 0) {
            mix_ch.*.src = shim.MIXCH_GBA_SRC_STOPPED;
        }
        if (act_ch.*._type == ACHN_FOREGROUND) {
            // Stop channel if channel ended
            const parent_idx: usize = @intCast(act_ch.*.parent);
            if (parent_idx < mm_gba.mpp_nchannels) {
                const parent_mod: [*c]mm.ModuleChannel = &mm_gba.mpp_channels[parent_idx];
                parent_mod.*.alloc = NO_CHANNEL_AVAILABLE;
                parent_mod.*.flags &= ~@as(mm.Byte, MF_START | MF_NEWINSTR);
            }
        }
        mix_ch.*.src = shim.MIXCH_GBA_SRC_STOPPED;
        act_ch.*._type = ACHN_DISABLED;
        return;
    }

    // Set panning
    const panplus: i32 = @intCast(mpp_vars.panplus);
    const old_panning: i32 = @intCast(act_ch.*.panning);
    var newpan: i32 = old_panning + panplus;
    if (newpan < 0) newpan = 0 else if (newpan > 255) newpan = 255;
    mix_ch.*.pan = @intCast(newpan);
}

pub const MAS_HEADER_FLAG_XM_MODE = 1 << 3;
const MAS_HEADER_FLAG_LINK_GXX = 1 << 0;
pub const MAS_INSTR_FLAG_VOL_ENV_EXISTS = 1 << 0;
pub const MAS_INSTR_FLAG_PAN_ENV_EXISTS = 1 << 1;
pub const MAS_INSTR_FLAG_PITCH_ENV_EXISTS = 1 << 2;
pub const MAS_INSTR_FLAG_VOL_ENV_ENABLED = 1 << 3;
pub const MF_START = 1;
pub const MF_DVOL = 2;
pub const MF_HASVCMD = 4;
pub const GLISSANDO_EFFECT = 7;
const MPP_XM_VCMD_MEM_VS = 12;
const MPP_XM_VCMD_MEM_FVS = 13;
const MPP_XM_VCMD_MEM_PANSL = 7;
const MPP_XM_VCMD_MEM_GLIS = 14;
const MPP_IT_VCMD_MEM = 14;
const MPP_XM_IT_GLIS = 0;
const MPP_IT_PORTA = 2;
// 1 = Linear freqs, 0 = Amiga freqs
pub const MAS_HEADER_FLAG_FREQ_MODE = 1 << 2;
pub const MF_HASFX = 8;
pub const MF_NEWINSTR = 16;
pub const MF_NOTEOFF = 64;
// cut channel volume
pub const MCH_BFLAGS_CUT_VOLUME = 1 << 10;
pub const MCH_BFLAGS_TREMOR = 1 << 9;
// 1 = MOD/S3M, 0 = Other
pub const MAS_HEADER_FLAG_OLD_MODE = 1 << 5;
pub const MF_NOTECUT = 128;
pub const MCH_BFLAGS_NNA_SHIFT = 6;
pub const MCH_BFLAGS_NNA_MASK: u16 = 3 << MCH_BFLAGS_NNA_SHIFT;
pub inline fn MCH_BFLAGS_NNA_GET(x: anytype) @TypeOf((x & MCH_BFLAGS_NNA_MASK) >> MCH_BFLAGS_NNA_SHIFT) {
    _ = &x;
    return (x & MCH_BFLAGS_NNA_MASK) >> MCH_BFLAGS_NNA_SHIFT;
}
pub const IT_NNA_CUT = 0;
pub const IT_NNA_CONT = 1;
pub const IT_NNA_OFF = 2;
pub const IT_NNA_FADE = 3;
pub const IT_DCA_CUT = 0;
pub const IT_DCA_OFF = 1;
pub const MCAF_KEYON: u8 = 1 << 0;
pub const MCAF_FADE = 1 << 1;
pub const MCAF_START: u8 = 1 << 2;
pub const MCAF_UPDATED = 1 << 3;
pub const MCAF_ENVEND = 1 << 4;
pub const MCAF_VOLENV: u8 = 1 << 5;
// 1 = Channel is used for an effect, not module or jingle
pub const MCAF_EFFECT = 1 << 7;
// 1 = Channel used for jingle. 0 = Used for main module
pub const MCAF_SUB = 1 << 6;
pub const ACHN_DISABLED = 0;
pub const ACHN_BACKGROUND = 2;
pub const ACHN_CUSTOM = 4;
pub const ACHN_FOREGROUND = 3;
pub const NO_CHANNEL_AVAILABLE = 255;
// Fractionary part of the sample read offset
pub const MP_SAMPFRAC = 12;
pub const GLISSANDO_IT_VOLCMD_START = 193;
pub const GLISSANDO_IT_VOLCMD_END = 202;
pub const GLISSANDO_MX_VOLCMD_START = 0xF0;
const MOD_FREQ_DIVIDER_PAL = 56750314;
const MMCB_SONGFINISHED = 43;
const MMCB_SONGERROR = 44;

const Prefix = extern struct {
    size: mm.Word = 0,
    type: mm.Byte = 0,
    version: mm.Byte = 0,
    reserved: mm.Hword = 0,
};

const MasGbaSample = extern struct {
    length: mm.Word align(4) = 0,
    loop_length: mm.Word = 0,
    format: mm.Byte = 0,
    reserved: mm.Byte = 0,
    default_frequency: mm.Hword = 0,

    pub fn data(self: anytype) std.zig.c_translation.FlexibleArrayType(@TypeOf(self), u8) {
        const Intermediate = std.zig.c_translation.FlexibleArrayType(@TypeOf(self), u8);
        const ReturnType = std.zig.c_translation.FlexibleArrayType(@TypeOf(self), u8);
        return @as(ReturnType, @ptrCast(@alignCast(@as(Intermediate, @ptrCast(self)) + 12)));
    }
};
