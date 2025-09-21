const mm = @import("../maxmod.zig");
const mixer = @import("../gba/mixer.zig");
const mm_gba = @import("../gba/main_gba.zig");
const shim = @import("../shim.zig");
const arm = @import("mas_arm.zig");
const capture = @import("../capture.zig");
const tables = @import("tables.zig");
const gba = @import("gba");
const std = @import("std");
// Debug configuration - can be toggled at build time
const debug_enabled = @import("build_options").xm_debug;
const panchk_log_enabled = false;
inline fn debugPrint(comptime fmt: []const u8, args: anytype) void {
    if (debug_enabled) {
        @import("gba").debug.print(fmt, args) catch {};
    }
}
inline fn readLe32(ptr: anytype) u32 {
    const bytes: [*]const u8 = @ptrCast(ptr);
    return std.mem.readInt(u32, bytes[0..4], .little);
}
// Guard: per-channel last tick we logged [UMIX]/[DISPAN] to avoid duplicate pairs
// Throttle UMIX logging to avoid audio disruption.
// - Only log on tick==0 (first tick of a row)
// - Only log for first two channels to reduce volume
// - Global budget to cap total prints per session
var umix_debug_budget: c_int = 2000;

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
pub const MM_MAIN: c_int = 0;
pub const MM_JINGLE: c_int = 1;
pub const mm_layer_type = c_uint;
pub const mm_callback = ?*const fn (mm.Word, LayerType) mm.Word;
pub const MM_PLAY_LOOP: c_int = 0;
pub const MM_PLAY_ONCE: c_int = 1;
pub const mm_pmode = c_uint;
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
            const fvol: mm.Word = @as(mm.Word, @bitCast(@as(c_uint, act_ch.*.fvol)));
            const @"type": mm.Word = @as(mm.Word, @bitCast(@as(c_uint, act_ch.*._type)));
            if (2 < @"type") continue else if (2 > @"type") return i;
            if (best_volume <= (fvol << 23)) continue;
            best_channel = i;
            best_volume = fvol << 23;
        }
    }
    debugPrint("[allocChannel] return={d} bitmask={x}\n", .{ @as(c_int, @intCast(best_channel)), @as(c_int, @intCast(mm_ch_mask)) });
    return best_channel;
}

pub fn mmSetEventHandler(handler: mm_callback) void {
    mmCallback = handler;
}
pub fn mmStart(id: mm.Word, mode: mm_pmode) void {
    const mc = mm_gba.getModuleCount();
    if (id >= mc) {
        debugPrint("[mmStart] early return: id>=count\n", .{});
        return;
    }
    mpps_backdoor(id, mode, .main);
}
pub fn mmPause() void {
    if (mm_gba.layer_main.valid == 0) return;
    mm_gba.layer_main.isplaying = 0;
    debugPrint("[mmPause] main.isplaying -> 0\n", .{});
    mpp_suspend(@bitCast(MM_MAIN));
}
pub fn mmResume() void {
    if (mm_gba.layer_main.valid == 0) return;
    mm_gba.layer_main.isplaying = 1;
    debugPrint("[mmResume] main.isplaying -> 1\n", .{});
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
    debugPrint("[mmSetPositionEx] position={d} row={d}\n", .{ position, row });
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
    layer_info.*.insttable = @constCast(@ptrCast(inst_tbl_ptr));
    layer_info.*.samptable = @constCast(@ptrCast(samp_tbl_ptr));
    layer_info.*.patttable = @constCast(@ptrCast(patt_tbl_ptr));

    shim.debug_state.num_instr = instr_count;
    shim.debug_state.num_sampl = sampl_count;

    shim.debug_state.inst_tbl_peek = readLe32(layer_info.*.insttable);
    shim.debug_state.samp_tbl_peek = readLe32(layer_info.*.samptable);
    shim.debug_state.patt_tbl_peek = readLe32(layer_info.*.patttable);

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
    shim.debug_state.layer1 = layer_info.*;
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

    shim.debug_state.header_channel_volumes = header.*.channel_volume;
    shim.debug_state.header_channel_panning = header.*.channel_panning;
}
pub fn mmJingleStart(module_ID: mm.Word, mode: mm_pmode) void {
    if (module_ID >= mm_gba.getModuleCount()) return;
    mpps_backdoor(module_ID, mode, .jingle);
}
pub fn mmJingle(module_ID: mm.Word) void {
    mmJingleStart(module_ID, @as(c_uint, @bitCast(MM_PLAY_ONCE)));
}
pub fn mmJinglePause() void {
    if (@as(c_int, @bitCast(@as(c_uint, mmLayerSub.valid))) == 0) return;
    mmLayerSub.isplaying = 0;
    debugPrint("[mmPause JINGLE] sub.isplaying -> 0\n", .{});
    mpp_suspend(@as(c_uint, @bitCast(MM_JINGLE)));
}
pub fn mmJingleResume() void {
    if (@as(c_int, @bitCast(@as(c_uint, mmLayerSub.valid))) == 0) return;
    mmLayerSub.isplaying = 1;
    debugPrint("[mmResume JINGLE] sub.isplaying -> 1\n", .{});
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

// Translate-C produced an opaque for envelope node entries. We only need the
// 2-byte + 2-byte layout { value: i16, delta: i16 } to run the math. Define it.
// Envelope node bitfield layout in C:
//   mm.Shword delta; mm.Hword base:7; mm.Hword range:9;
// Represent as packed and provide accessors.
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
    pub fn data(self: anytype) @import("std").zig.c_translation.FlexibleArrayType(@TypeOf(self), u8) {
        const Intermediate = @import("std").zig.c_translation.FlexibleArrayType(@TypeOf(self), u8);
        const ReturnType = @import("std").zig.c_translation.FlexibleArrayType(@TypeOf(self), u8);
        return @as(ReturnType, @ptrCast(@alignCast(@as(Intermediate, @ptrCast(self)) + 12)));
    }
};
// Pattern header + data
pub const Pattern = packed struct {
    row_count: mm.Byte = 0,
    pub fn pattern_data(self: anytype) @import("std").zig.c_translation.FlexibleArrayType(@TypeOf(self), u8) {
        const Intermediate = @import("std").zig.c_translation.FlexibleArrayType(@TypeOf(self), u8);
        const ReturnType = @import("std").zig.c_translation.FlexibleArrayType(@TypeOf(self), u8);
        return @as(ReturnType, @ptrCast(@alignCast(@as(Intermediate, @ptrCast(self)) + 1)));
    }
};

pub inline fn umixChannelIndexFromMix(mix_ch: [*c]volatile mm.MixerChannel) c_int {
    const offset = @intFromPtr(mix_ch) - @intFromPtr(&mixer.mm_mix_channels[0]);
    return @as(c_int, @intCast(offset / @sizeOf(mm.MixerChannel)));
}
pub inline fn umixAllowLogCh(layer: [*c]const mm.LayerInfo, ch_idx: c_int) bool {
    if (umix_debug_budget <= 0) return false;
    // Allow channels 0,1,2,9 for focused tracing
    if (!(ch_idx == 0 or ch_idx == 1 or ch_idx == 2 or ch_idx == 9)) return false;
    // Allow all ticks for channels 0,2 and 9 to catch rebinds
    if (ch_idx == 0 or ch_idx == 2 or ch_idx == 9) return true;
    // Only gate by tick for non-9 channels
    if (layer.*.tick != 0) return false;
    umix_debug_budget -= 1;
    return true;
}
pub fn mppUpdateSub() void {
    if (mmLayerSub.isplaying == 0) return;
    mm_gba.mpp_channels = @ptrCast(@alignCast(&mm_schannels[0]));
    mm_gba.mpp_nchannels = 4;
    mpp_clayer = .jingle;
    mm_gba.layer_p = &mmLayerSub;
    const tickrate: mm.Word = mmLayerSub.tickrate;
    var tickfrac: mm.Word = mmLayerSub.tick_data.tickfrac;
    tickfrac = tickfrac +% (tickrate << @intCast(1));
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
        debugPrint(
            "[UPD] tick={d} row={d} bits=0x{x}\n",
            .{ layer.*.tick, layer.*.row, @as(u32, @intCast(update_bits)) },
        );
        if (layer.*.row >= 6 and layer.*.row <= 20 and layer.*.tick == 0) {
            debugPrint(
                "[ROWSTATE] row={d} pattdelay={d} fpattdelay={d} pattjump={d} pattjump_row={d} ploop_jump={d} ploop_times={d}\n",
                .{
                    @as(c_int, @intCast(layer.*.row)),
                    @as(c_int, @intCast(layer.*.pattdelay)),
                    @as(c_int, @intCast(layer.*.fpattdelay)),
                    @as(c_int, @intCast(layer.*.pattjump)),
                    @as(c_int, @intCast(layer.*.pattjump_row)),
                    @as(c_int, @intCast(layer.*.ploop_jump)),
                    @as(c_int, @intCast(layer.*.ploop_times)),
                },
            );
        }
    }
    if (shim.debug_state.upd_len < shim.debug_state.upd_events.len) {
        const idx = shim.debug_state.upd_len;
        shim.debug_state.upd_events[idx] = .{
            .tick = layer.*.tick,
            .row = layer.*.row,
            .bits = @intCast(update_bits),
        };
        shim.debug_state.upd_len +%= 1;
    }
    {
        var channel_counter: mm.Word = 0;
        while (true) : (channel_counter +%= 1) {
            if ((update_bits & @as(mm.Word, @bitCast(@as(c_int, 1) << @intCast(0)))) != 0) {
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
    }
    var act_ch: [*c]mm.ActiveChannel = &mm_gba.achannels[@as(c_uint, @intCast(@as(c_int, 0)))];
    {
        var ch: mm.Word = 0;
        while (ch < mm_gba.num_ach) : (ch +%= 1) {
            if (act_ch.*._type != 0) {
                if (@intFromEnum(mpp_clayer) == @as(c_uint, @bitCast((@as(c_int, @bitCast(@as(c_uint, act_ch.*.flags))) & ((@as(c_int, 1) << @intCast(6)) | (@as(c_int, 1) << @intCast(7)))) >> @intCast(6)))) {
                    mpp_vars.afvol = act_ch.*.volume;
                    mpp_vars.panplus = 0;
                    mpp_Update_ACHN(layer, act_ch, act_ch.*.period, ch);
                }
            }
            act_ch.*.flags &= @as(mm.Byte, @bitCast(@as(i8, @truncate(~(@as(c_int, 1) << @intCast(3))))));
            act_ch += 1;
        }
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
    if ((@as(c_int, @bitCast(@as(c_uint, header.*.flags))) & (@as(c_int, 1) << @intCast(3))) != 0) {
        if (@as(c_int, @bitCast(@as(c_uint, volcmd))) == @as(c_int, 0)) {} else if (@as(c_int, @bitCast(@as(c_uint, volcmd))) <= @as(c_int, 80)) {
            if (@as(c_int, @bitCast(@as(c_uint, tick))) == 0) {
                channel.*.volume = @as(mm.Byte, @bitCast(@as(i8, @truncate(@as(c_int, @bitCast(@as(c_uint, volcmd))) - @as(c_int, 16)))));
            }
        } else if (@as(c_int, @bitCast(@as(c_uint, volcmd))) < @as(c_int, 128)) {
            if (@as(c_int, @bitCast(@as(c_uint, tick))) == @as(c_int, 0)) return period;
            var volume: c_int = @as(c_int, @bitCast(@as(c_uint, channel.*.volume)));
            _ = &volume;
            var mem: mm.Byte = channel.*.memory[@as(c_uint, @intCast(@as(c_int, 12)))];
            _ = &mem;
            if (@as(c_int, @bitCast(@as(c_uint, volcmd))) < @as(c_int, 112)) {
                volcmd -%= @as(mm.Byte, @bitCast(@as(i8, @truncate(@as(c_int, 96)))));
                var delta: c_int = undefined;
                _ = &delta;
                if (@as(c_int, @bitCast(@as(c_uint, volcmd))) == @as(c_int, 0)) {
                    delta = @as(c_int, @bitCast(@as(c_uint, mem))) & @as(c_int, 15);
                } else {
                    delta = @as(c_int, @bitCast(@as(c_uint, volcmd)));
                    channel.*.memory[@as(c_uint, @intCast(@as(c_int, 12)))] = @as(mm.Byte, @bitCast(@as(i8, @truncate((@as(c_int, @bitCast(@as(c_uint, mem))) & ~@as(c_int, 15)) | @as(c_int, @bitCast(@as(c_uint, volcmd)))))));
                }
                volume -= delta;
                if (volume < @as(c_int, 0)) {
                    volume = 0;
                }
                channel.*.volume = @as(mm.Byte, @bitCast(@as(i8, @truncate(volume))));
            } else {
                volcmd -%= @as(mm.Byte, @bitCast(@as(i8, @truncate(@as(c_int, 112)))));
                var delta: c_int = undefined;
                _ = &delta;
                if (@as(c_int, @bitCast(@as(c_uint, volcmd))) == @as(c_int, 0)) {
                    delta = @as(c_int, @bitCast(@as(c_uint, mem))) >> @intCast(4);
                } else {
                    delta = @as(c_int, @bitCast(@as(c_uint, volcmd)));
                    channel.*.memory[@as(c_uint, @intCast(@as(c_int, 12)))] = @as(mm.Byte, @bitCast(@as(i8, @truncate((@as(c_int, @bitCast(@as(c_uint, volcmd))) << @intCast(4)) | (@as(c_int, @bitCast(@as(c_uint, mem))) & @as(c_int, 15))))));
                }
                volume += delta;
                if (volume > @as(c_int, 64)) {
                    volume = 64;
                }
                channel.*.volume = @as(mm.Byte, @bitCast(@as(i8, @truncate(volume))));
            }
        } else if (@as(c_int, @bitCast(@as(c_uint, volcmd))) < @as(c_int, 160)) {
            if (@as(c_int, @bitCast(@as(c_uint, tick))) != @as(c_int, 0)) return period;
            var volume: c_int = @as(c_int, @bitCast(@as(c_uint, channel.*.volume)));
            _ = &volume;
            var mem: mm.Byte = channel.*.memory[@as(c_uint, @intCast(@as(c_int, 13)))];
            _ = &mem;
            if (@as(c_int, @bitCast(@as(c_uint, volcmd))) < @as(c_int, 144)) {
                volcmd -%= @as(mm.Byte, @bitCast(@as(i8, @truncate(@as(c_int, 128)))));
                var delta: c_int = undefined;
                _ = &delta;
                if (@as(c_int, @bitCast(@as(c_uint, volcmd))) == @as(c_int, 0)) {
                    delta = @as(c_int, @bitCast(@as(c_uint, mem))) & @as(c_int, 15);
                } else {
                    delta = @as(c_int, @bitCast(@as(c_uint, volcmd)));
                    channel.*.memory[@as(c_uint, @intCast(@as(c_int, 13)))] = @as(mm.Byte, @bitCast(@as(i8, @truncate((@as(c_int, @bitCast(@as(c_uint, mem))) & ~@as(c_int, 15)) | @as(c_int, @bitCast(@as(c_uint, volcmd)))))));
                }
                volume -= delta;
                if (volume < @as(c_int, 0)) {
                    volume = 0;
                }
                channel.*.volume = @as(mm.Byte, @bitCast(@as(i8, @truncate(volume))));
            } else {
                volcmd -%= @as(mm.Byte, @bitCast(@as(i8, @truncate(@as(c_int, 144)))));
                var delta: c_int = undefined;
                _ = &delta;
                if (@as(c_int, @bitCast(@as(c_uint, volcmd))) == @as(c_int, 0)) {
                    delta = @as(c_int, @bitCast(@as(c_uint, mem))) >> @intCast(4);
                } else {
                    delta = @as(c_int, @bitCast(@as(c_uint, volcmd)));
                    channel.*.memory[@as(c_uint, @intCast(@as(c_int, 13)))] = @as(mm.Byte, @bitCast(@as(i8, @truncate((@as(c_int, @bitCast(@as(c_uint, volcmd))) << @intCast(4)) | (@as(c_int, @bitCast(@as(c_uint, mem))) & @as(c_int, 15))))));
                }
                volume += delta;
                if (volume > @as(c_int, 64)) {
                    volume = 64;
                }
                channel.*.volume = @as(mm.Byte, @bitCast(@as(i8, @truncate(volume))));
            }
        } else if (@as(c_int, @bitCast(@as(c_uint, volcmd))) < @as(c_int, 192)) {
            if (@as(c_int, @bitCast(@as(c_uint, tick))) == @as(c_int, 0)) return period;
            if (@as(c_int, @bitCast(@as(c_uint, volcmd))) < @as(c_int, 176)) {
                volcmd = @as(mm.Byte, @bitCast(@as(i8, @truncate((@as(c_int, @bitCast(@as(c_uint, volcmd))) - @as(c_int, 160)) << @intCast(2)))));
                if (@as(c_int, @bitCast(@as(c_uint, volcmd))) != @as(c_int, 0)) {
                    channel.*.vibspd = volcmd;
                }
            } else {
                volcmd = @as(mm.Byte, @bitCast(@as(i8, @truncate((@as(c_int, @bitCast(@as(c_uint, volcmd))) - @as(c_int, 176)) << @intCast(3)))));
                if (@as(c_int, @bitCast(@as(c_uint, volcmd))) != @as(c_int, 0)) {
                    channel.*.vibdep = volcmd;
                }
            }
            return mppe_DoVibrato(period, channel, layer);
        } else if (@as(c_int, @bitCast(@as(c_uint, volcmd))) < @as(c_int, 208)) {
            if (@as(c_int, @bitCast(@as(c_uint, tick))) != @as(c_int, 0)) return period;
            var panning: mm.Word = @as(mm.Word, @bitCast((@as(c_int, @bitCast(@as(c_uint, volcmd))) - @as(c_int, 192)) << @intCast(4)));
            _ = &panning;
            if (panning == @as(mm.Word, @bitCast(@as(c_int, 240)))) {
                channel.*.panning = 255;
            } else {
                channel.*.panning = @as(mm.Byte, @bitCast(@as(u8, @truncate(panning))));
            }
        } else if (@as(c_int, @bitCast(@as(c_uint, volcmd))) < @as(c_int, 240)) {
            if (@as(c_int, @bitCast(@as(c_uint, tick))) == @as(c_int, 0)) return period;
            var panning: c_int = @as(c_int, @bitCast(@as(c_uint, channel.*.panning)));
            _ = &panning;
            var mem: mm.Byte = channel.*.memory[@as(c_uint, @intCast(@as(c_int, 7)))];
            _ = &mem;
            if (@as(c_int, @bitCast(@as(c_uint, volcmd))) < @as(c_int, 224)) {
                volcmd -%= @as(mm.Byte, @bitCast(@as(i8, @truncate(@as(c_int, 208)))));
                var delta: c_int = undefined;
                _ = &delta;
                if (@as(c_int, @bitCast(@as(c_uint, volcmd))) == @as(c_int, 0)) {
                    delta = @as(c_int, @bitCast(@as(c_uint, mem))) >> @intCast(4);
                } else {
                    channel.*.memory[@as(c_uint, @intCast(@as(c_int, 7)))] = @as(mm.Byte, @bitCast(@as(i8, @truncate((@as(c_int, @bitCast(@as(c_uint, mem))) & @as(c_int, 15)) | (@as(c_int, @bitCast(@as(c_uint, volcmd))) << @intCast(4))))));
                    delta = @as(c_int, @bitCast(@as(c_uint, volcmd))) & @as(c_int, 15);
                }
                delta <<= @intCast(@as(c_int, 2));
                panning -= delta;
                if (panning < @as(c_int, 0)) {
                    panning = 0;
                }
                channel.*.panning = @as(mm.Byte, @bitCast(@as(i8, @truncate(panning))));
            } else {
                volcmd -%= @as(mm.Byte, @bitCast(@as(i8, @truncate(@as(c_int, 224)))));
                var delta: c_int = undefined;
                _ = &delta;
                if (@as(c_int, @bitCast(@as(c_uint, volcmd))) == @as(c_int, 0)) {
                    delta = @as(c_int, @bitCast(@as(c_uint, mem))) & @as(c_int, 15);
                } else {
                    delta = @as(c_int, @bitCast(@as(c_uint, volcmd)));
                    channel.*.memory[@as(c_uint, @intCast(@as(c_int, 7)))] = @as(mm.Byte, @bitCast(@as(i8, @truncate(@as(c_int, @bitCast(@as(c_uint, volcmd))) | (@as(c_int, @bitCast(@as(c_uint, mem))) & @as(c_int, 15))))));
                }
                delta <<= @intCast(@as(c_int, 2));
                panning += delta;
                if (panning > @as(c_int, 255)) {
                    panning = 255;
                }
                channel.*.panning = @as(mm.Byte, @bitCast(@as(i8, @truncate(panning))));
            }
        } else {
            if (@as(c_int, @bitCast(@as(c_uint, tick))) == @as(c_int, 0)) return period;
            volcmd = @as(mm.Byte, @bitCast(@as(i8, @truncate((@as(c_int, @bitCast(@as(c_uint, volcmd))) - @as(c_int, 240)) << @intCast(4)))));
            if (@as(c_int, @bitCast(@as(c_uint, volcmd))) != @as(c_int, 0)) {
                channel.*.memory[@as(c_uint, @intCast(@as(c_int, 14)))] = volcmd;
            }
            volcmd = channel.*.memory[@as(c_uint, @intCast(@as(c_int, 14)))];
            return mppe_glis_backdoor(@as(mm.Word, @bitCast(@as(c_uint, volcmd))), period, act_ch, channel, layer);
        }
    } else {
        if (@as(c_int, @bitCast(@as(c_uint, volcmd))) <= @as(c_int, 64)) {
            if (@as(c_int, @bitCast(@as(c_uint, tick))) == @as(c_int, 0)) {
                channel.*.volume = volcmd;
            }
        } else if (@as(c_int, @bitCast(@as(c_uint, volcmd))) <= @as(c_int, 84)) {
            if (@as(c_int, @bitCast(@as(c_uint, tick))) != @as(c_int, 0)) return period;
            var volume: c_int = @as(c_int, @bitCast(@as(c_uint, channel.*.volume)));
            _ = &volume;
            if (@as(c_int, @bitCast(@as(c_uint, volcmd))) < @as(c_int, 75)) {
                volcmd -%= @as(mm.Byte, @bitCast(@as(i8, @truncate(@as(c_int, 65)))));
                if (@as(c_int, @bitCast(@as(c_uint, volcmd))) == @as(c_int, 0)) {
                    volcmd = channel.*.memory[@as(c_uint, @intCast(@as(c_int, 14)))];
                } else {
                    channel.*.memory[@as(c_uint, @intCast(@as(c_int, 14)))] = volcmd;
                }
                volume += @as(c_int, @bitCast(@as(c_uint, volcmd)));
                if (volume > @as(c_int, 64)) {
                    volume = 64;
                }
            } else {
                volcmd -%= @as(mm.Byte, @bitCast(@as(i8, @truncate(@as(c_int, 75)))));
                if (@as(c_int, @bitCast(@as(c_uint, volcmd))) == @as(c_int, 0)) {
                    volcmd = channel.*.memory[@as(c_uint, @intCast(@as(c_int, 14)))];
                } else {
                    channel.*.memory[@as(c_uint, @intCast(@as(c_int, 14)))] = volcmd;
                }
                volume -= @as(c_int, @bitCast(@as(c_uint, volcmd)));
                if (volume < @as(c_int, 0)) {
                    volume = 0;
                }
            }
            channel.*.volume = @as(mm.Byte, @bitCast(@as(i8, @truncate(volume))));
        } else if (@as(c_int, @bitCast(@as(c_uint, volcmd))) <= @as(c_int, 104)) {
            if (@as(c_int, @bitCast(@as(c_uint, tick))) == @as(c_int, 0)) return period;
            var volume: c_int = @as(c_int, @bitCast(@as(c_uint, channel.*.volume)));
            _ = &volume;
            if (@as(c_int, @bitCast(@as(c_uint, volcmd))) < @as(c_int, 95)) {
                volcmd -%= @as(mm.Byte, @bitCast(@as(i8, @truncate(@as(c_int, 85)))));
                if (@as(c_int, @bitCast(@as(c_uint, volcmd))) == @as(c_int, 0)) {
                    volcmd = channel.*.memory[@as(c_uint, @intCast(@as(c_int, 14)))];
                } else {
                    channel.*.memory[@as(c_uint, @intCast(@as(c_int, 14)))] = volcmd;
                }
                volume += @as(c_int, @bitCast(@as(c_uint, volcmd)));
                if (volume > @as(c_int, 64)) {
                    volume = 64;
                }
            } else {
                volcmd -%= @as(mm.Byte, @bitCast(@as(i8, @truncate(@as(c_int, 95)))));
                if (@as(c_int, @bitCast(@as(c_uint, volcmd))) == @as(c_int, 0)) {
                    volcmd = channel.*.memory[@as(c_uint, @intCast(@as(c_int, 14)))];
                } else {
                    channel.*.memory[@as(c_uint, @intCast(@as(c_int, 14)))] = volcmd;
                }
                volume -= @as(c_int, @bitCast(@as(c_uint, volcmd)));
                if (volume < @as(c_int, 0)) {
                    volume = 0;
                }
            }
            channel.*.volume = @as(mm.Byte, @bitCast(@as(i8, @truncate(volume))));
        } else if (@as(c_int, @bitCast(@as(c_uint, volcmd))) <= @as(c_int, 124)) {
            if (@as(c_int, @bitCast(@as(c_uint, tick))) == @as(c_int, 0)) return period;
            var r0: mm.Word = undefined;
            _ = &r0;
            if (@as(c_int, @bitCast(@as(c_uint, volcmd))) >= @as(c_int, 115)) {
                volcmd = @as(mm.Byte, @bitCast(@as(i8, @truncate((@as(c_int, @bitCast(@as(c_uint, volcmd))) - @as(c_int, 115)) << @intCast(2)))));
                if (@as(c_int, @bitCast(@as(c_uint, volcmd))) == @as(c_int, 0)) {
                    volcmd = channel.*.memory[@as(c_uint, @intCast(@as(c_int, 2)))];
                }
                channel.*.memory[@as(c_uint, @intCast(@as(c_int, 2)))] = volcmd;
                r0 = mpph_PitchSlide_Up(channel.*.period, @as(mm.Word, @bitCast(@as(c_uint, volcmd))), layer);
            } else {
                volcmd = @as(mm.Byte, @bitCast(@as(i8, @truncate((@as(c_int, @bitCast(@as(c_uint, volcmd))) - @as(c_int, 105)) << @intCast(2)))));
                if (@as(c_int, @bitCast(@as(c_uint, volcmd))) == @as(c_int, 0)) {
                    volcmd = channel.*.memory[@as(c_uint, @intCast(@as(c_int, 2)))];
                }
                channel.*.memory[@as(c_uint, @intCast(@as(c_int, 2)))] = volcmd;
                r0 = mpph_PitchSlide_Down(channel.*.period, @as(mm.Word, @bitCast(@as(c_uint, volcmd))), layer);
            }
            var r1: mm.Word = channel.*.period;
            _ = &r1;
            channel.*.period = period;
            return (period +% r0) -% r1;
        } else if (@as(c_int, @bitCast(@as(c_uint, volcmd))) <= @as(c_int, 192)) {
            if (@as(c_int, @bitCast(@as(c_uint, tick))) == @as(c_int, 0)) {
                var panning: c_int = @as(c_int, @bitCast(@as(c_uint, volcmd))) - @as(c_int, 128);
                _ = &panning;
                panning <<= @intCast(@as(c_int, 2));
                if (panning > @as(c_int, 255)) {
                    panning = 255;
                }
                channel.*.panning = @as(mm.Byte, @bitCast(@as(i8, @truncate(panning))));
            }
        } else if (@as(c_int, @bitCast(@as(c_uint, volcmd))) <= @as(c_int, 202)) {
            if (@as(c_int, @bitCast(@as(c_uint, tick))) == @as(c_int, 0)) return period;
            const vcmd_glissando_table: [10]mm.Byte = [10]mm.Byte{
                0,
                1,
                4,
                8,
                16,
                32,
                64,
                96,
                128,
                255,
            };
            _ = &vcmd_glissando_table;
            volcmd -%= @as(mm.Byte, @bitCast(@as(i8, @truncate(@as(c_int, 193)))));
            var glis: mm.Word = @as(mm.Word, @bitCast(@as(c_uint, vcmd_glissando_table[volcmd])));
            _ = &glis;
            if ((@as(c_int, @bitCast(@as(c_uint, layer.*.flags))) & (@as(c_int, 1) << @intCast(0))) != 0) {
                if (glis == @as(mm.Word, @bitCast(@as(c_int, 0)))) {
                    glis = @as(mm.Word, @bitCast(@as(c_uint, channel.*.memory[@as(c_uint, @intCast(@as(c_int, 2)))])));
                }
                channel.*.memory[@as(c_uint, @intCast(@as(c_int, 2)))] = @as(mm.Byte, @bitCast(@as(u8, @truncate(glis))));
                channel.*.memory[@as(c_uint, @intCast(@as(c_int, 0)))] = @as(mm.Byte, @bitCast(@as(u8, @truncate(glis))));
                var mem: mm.Byte = channel.*.memory[@as(c_uint, @intCast(@as(c_int, 0)))];
                _ = &mem;
                return mppe_glis_backdoor(@as(mm.Word, @bitCast(@as(c_uint, mem))), period, act_ch, channel, layer);
            } else {
                if (glis == @as(mm.Word, @bitCast(@as(c_int, 0)))) {
                    glis = @as(mm.Word, @bitCast(@as(c_uint, channel.*.memory[@as(c_uint, @intCast(@as(c_int, 0)))])));
                }
                channel.*.memory[@as(c_uint, @intCast(@as(c_int, 0)))] = @as(mm.Byte, @bitCast(@as(u8, @truncate(glis))));
                var mem: mm.Byte = channel.*.memory[@as(c_uint, @intCast(@as(c_int, 0)))];
                _ = &mem;
                return mppe_glis_backdoor(@as(mm.Word, @bitCast(@as(c_uint, mem))), period, act_ch, channel, layer);
            }
        } else if (@as(c_int, @bitCast(@as(c_uint, volcmd))) <= @as(c_int, 212)) {
            if (@as(c_int, @bitCast(@as(c_uint, tick))) == @as(c_int, 0)) return period;
            volcmd = @as(mm.Byte, @bitCast(@as(i8, @truncate(@as(c_int, @bitCast(@as(c_uint, volcmd))) - @as(c_int, 203)))));
            if (@as(c_int, @bitCast(@as(c_uint, volcmd))) != @as(c_int, 0)) {
                volcmd = @as(mm.Byte, @bitCast(@as(i8, @truncate(@as(c_int, @bitCast(@as(c_uint, volcmd))) << @intCast(2)))));
                channel.*.vibspd = volcmd;
            }
            return mppe_DoVibrato(@as(mm.Word, @bitCast(@as(c_uint, volcmd))), channel, layer);
        }
    }
    return period;
}
pub fn mpp_Process_Effect(layer: [*c]mm.LayerInfo, act_ch: ?[*c]mm.ActiveChannel, channel: [*c]mm.ModuleChannel, period: mm.Word) mm.Word {
    const param: mm.Word = mpp_Channel_ExchangeMemory(channel.*.effect, channel.*.param, channel, layer);
    const effect: mm.Word = @as(mm.Word, @bitCast(@as(c_uint, channel.*.effect)));
    if (debug_enabled) {
        const row_dbg = @as(c_int, @intCast(layer.*.row));
        const ch_idx_dbg = @as(c_int, @intCast((@intFromPtr(channel) - @intFromPtr(mm_gba.mpp_channels)) / @sizeOf(mm.ModuleChannel)));
        if (row_dbg <= 40 and ch_idx_dbg <= 15) {
            debugPrint(
                "[EFFECT] row={d} tick={d} ch={d} effect=0x{x:0>2} param=0x{x:0>2}\n",
                .{ row_dbg, @as(c_int, @intCast(layer.*.tick)), ch_idx_dbg, @as(u32, @intCast(effect)), @as(u32, @intCast(param)) },
            );
        }
    }
    while (true) {
        switch (effect) {
            @as(mm.Word, @bitCast(@as(c_int, 0))) => return period,
            @as(mm.Word, @bitCast(@as(c_int, 1))) => {
                mppe_SetSpeed(param, layer);
                return period;
            },
            @as(mm.Word, @bitCast(@as(c_int, 2))) => {
                mppe_PositionJump(param, layer);
                return period;
            },
            @as(mm.Word, @bitCast(@as(c_int, 3))) => {
                mppe_PatternBreak(param, layer);
                return period;
            },
            @as(mm.Word, @bitCast(@as(c_int, 4))) => {
                const vol_word = mpph_VolumeSlide64(
                    @as(c_int, @intCast(channel.*.volume)),
                    param,
                    @as(mm.Word, @bitCast(@as(c_uint, layer.*.tick))),
                    layer,
                );
                channel.*.volume = @as(mm.Byte, @intCast(@as(c_int, @intCast(vol_word))));
                return period;
            },
            @as(mm.Word, @bitCast(@as(c_int, 5))), @as(mm.Word, @bitCast(@as(c_int, 6))) => return mppe_Portamento(param, period, channel, layer),
            @as(mm.Word, @bitCast(@as(c_int, 7))) => return mppe_Glissando(param, period, act_ch, channel, layer),
            @as(mm.Word, @bitCast(@as(c_int, 8))) => return mppe_Vibrato(param, period, channel, layer),
            @as(mm.Word, @bitCast(@as(c_int, 9))) => return period,
            @as(mm.Word, @bitCast(@as(c_int, 10))) => return mppe_Arpeggio(param, period, act_ch, channel, layer),
            @as(mm.Word, @bitCast(@as(c_int, 11))) => return mppe_VibratoVolume(param, period, channel, layer),
            @as(mm.Word, @bitCast(@as(c_int, 12))) => return mppe_PortaVolume(param, period, act_ch, channel, layer),
            @as(mm.Word, @bitCast(@as(c_int, 13))) => {
                mppe_ChannelVolume(param, channel, layer);
                return period;
            },
            @as(mm.Word, @bitCast(@as(c_int, 14))) => {
                mppe_ChannelVolumeSlide(param, channel, layer);
                return period;
            },
            @as(mm.Word, @bitCast(@as(c_int, 15))) => {
                mppe_SampleOffset(param, layer);
                return period;
            },
            @as(mm.Word, @bitCast(@as(c_int, 16))) => return period,
            @as(mm.Word, @bitCast(@as(c_int, 17))) => {
                mppe_Retrigger(param, act_ch, channel);
                return period;
            },
            @as(mm.Word, @bitCast(@as(c_int, 18))) => {
                mppe_Tremolo(param, channel, layer);
                return period;
            },
            @as(mm.Word, @bitCast(@as(c_int, 19))) => {
                mppe_Extended(param, act_ch, channel, layer);
                return period;
            },
            @as(mm.Word, @bitCast(@as(c_int, 20))) => {
                mppe_SetTempo(param, layer);
                return period;
            },
            @as(mm.Word, @bitCast(@as(c_int, 21))) => return mppe_FineVibrato(param, period, channel, layer),
            @as(mm.Word, @bitCast(@as(c_int, 22))) => {
                mppe_SetGlobalVolume(param, layer);
                return period;
            },
            @as(mm.Word, @bitCast(@as(c_int, 23))) => {
                mppe_GlobalVolumeSlide(param, layer);
                return period;
            },
            @as(mm.Word, @bitCast(@as(c_int, 24))) => {
                mppe_SetPanning(param, channel, layer);
                return period;
            },
            @as(mm.Word, @bitCast(@as(c_int, 25))) => return period,
            @as(mm.Word, @bitCast(@as(c_int, 26))) => return period,
            @as(mm.Word, @bitCast(@as(c_int, 27))) => {
                mppe_SetVolume(param, channel, layer);
                return period;
            },
            @as(mm.Word, @bitCast(@as(c_int, 28))) => {
                mppe_KeyOff(param, act_ch, layer);
                return period;
            },
            @as(mm.Word, @bitCast(@as(c_int, 29))) => return period,
            @as(mm.Word, @bitCast(@as(c_int, 30))) => {
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
    // Match C ordering exactly:
    // 1) Envelopes -> updated period/afv/fade (instrument must be valid)
    // 2) Auto vibrato -> updated period (sample must be valid or skip)
    // 3) Update/bind mixer (on START)
    // 4) Set pitch + volume
    // 5) Disable/panning

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
            const nm_ptr_bytes: [*]u8 = inst_bytes + @as(usize, @intCast(instrument.*.note_map_offset));
            const note_map: [*]mm.Hword = @ptrCast(@alignCast(nm_ptr_bytes));
            const note: mm.Byte = @as(mm.Byte, @truncate(note_map[@as(usize, @intCast(module_channel.*.note - 1))] & 0xFF));
            if (note == module_channel.*.note) do_dca = true;
        } else if (dct == 2) {
            // DCT Sample
            const inst_bytes: [*]u8 = @ptrCast(@alignCast(instrument));
            const nm_ptr_bytes: [*]u8 = inst_bytes + @as(usize, @intCast(instrument.*.note_map_offset));
            const note_map: [*]mm.Hword = @ptrCast(@alignCast(nm_ptr_bytes));
            const sample_from_map: mm.Byte = @as(mm.Byte, @truncate(note_map[@as(usize, @intCast(module_channel.*.note - 1))] >> 8));
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
                act_ch.*.flags = @as(mm.Byte, @intCast(@as(c_int, act_ch.*.flags) & ~MCAF_KEYON));
                act_ch.*._type = @as(mm.Byte, @intCast(ACHN_BACKGROUND));
                need_alloc = true;
            } else {
                act_ch.*.flags = @as(mm.Byte, @intCast(@as(c_int, act_ch.*.flags) | MCAF_FADE));
                act_ch.*._type = @as(mm.Byte, @intCast(ACHN_BACKGROUND));
                need_alloc = true;
            }
        } else {
            const nna = MCH_BFLAGS_NNA_GET(module_channel.*.bflags);
            if (nna == IT_NNA_CUT) {
                return; // use same channel
            } else if (nna == IT_NNA_CONT) {
                act_ch.*._type = @as(mm.Byte, @intCast(ACHN_BACKGROUND));
                need_alloc = true;
            } else if (nna == IT_NNA_OFF) {
                act_ch.*.flags = @as(mm.Byte, @intCast(@as(c_int, act_ch.*.flags) & ~MCAF_KEYON));
                act_ch.*._type = @as(mm.Byte, @intCast(ACHN_BACKGROUND));
                need_alloc = true;
            } else if (nna == IT_NNA_FADE) {
                act_ch.*.flags = @as(mm.Byte, @intCast(@as(c_int, act_ch.*.flags) | MCAF_FADE));
                act_ch.*._type = @as(mm.Byte, @intCast(ACHN_BACKGROUND));
                need_alloc = true;
            }
        }
    }

    if (need_alloc) {
        const alloc: mm.Word = allocChannel();
        module_channel.*.alloc = @as(mm.Byte, @intCast(alloc));
    }
}
pub inline fn mpp_SamplePointer(layer: [*c]mm.LayerInfo, sampleN: mm.Word) [*c]SampleInfo {
    var base: [*c]mm.Byte = @as([*c]mm.Byte, @ptrCast(@alignCast(layer.*.songadr)));
    const idx: usize = @as(usize, @intCast(sampleN -% @as(mm.Word, @bitCast(@as(c_int, 1)))));
    const off_ptr: [*]u8 = @constCast(@ptrCast(@alignCast(&base[@as(usize, 0)])));
    const samptbl_bytes: [*]const u8 = @ptrCast(@alignCast(layer.*.samptable));
    const p: [*]const u8 = samptbl_bytes + (idx * 4);
    const off: usize = @as(usize, @intCast(std.mem.readInt(u32, p[0..4], .little)));
    return @as([*c]SampleInfo, @ptrCast(@alignCast(off_ptr + off)));
}
pub inline fn instrumentPointer(layer: [*c]mm.LayerInfo, instN: mm.Word) ?*Instrument {
    const base: [*c]mm.Byte = @as([*c]mm.Byte, @ptrCast(@alignCast(layer.*.songadr)));
    const idx: usize = @as(usize, @intCast(instN -% @as(mm.Word, @bitCast(@as(c_int, 1)))));
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
    shim.debug_state.pattern_ptr_offset = off;
    return @ptrCast(@alignCast(@as([*]u8, @ptrCast(base)) + off));
}
pub fn mppe_DoVibrato(period: mm.Word, channel: [*c]mm.ModuleChannel, layer: [*c]mm.LayerInfo) mm.Word {
    var position: mm.Byte = undefined;
    if ((@as(c_int, @bitCast(@as(c_uint, layer.*.oldeffects))) == @as(c_int, 0)) or (@as(c_int, @bitCast(@as(c_uint, layer.*.tick))) != @as(c_int, 0))) {
        position = @as(mm.Byte, @bitCast(@as(i8, @truncate(@as(c_int, @bitCast(@as(c_uint, channel.*.vibspd))) + @as(c_int, @bitCast(@as(c_uint, channel.*.vibpos)))))));
        channel.*.vibpos = position;
    } else {
        position = channel.*.vibpos;
    }
    var value: mm.Sword = @as(mm.Sword, @bitCast(@as(c_int, tables.mpp_TABLE_FineSineData[position])));
    const depth: mm.Sword = @as(mm.Sword, @bitCast(@as(c_uint, channel.*.vibdep)));
    value = (value * depth) >> @intCast(8);
    if (value < @as(c_int, 0)) return mpph_PitchSlide_Down(period, @as(mm.Word, @bitCast(-value)), layer);
    return mpph_PitchSlide_Up(period, @as(mm.Word, @bitCast(value)), layer);
}
pub fn mppe_glis_backdoor(param: mm.Word, period: mm.Word, act_ch: ?[*c]mm.ActiveChannel, channel: [*c]mm.ModuleChannel, layer: [*c]mm.LayerInfo) mm.Word {
    if (act_ch == null) return period;
    const sample: [*c]SampleInfo = mpp_SamplePointer(layer, @as(mm.Word, @bitCast(@as(c_uint, act_ch.?.*.sample))));
    const target_period: mm.Word = arm.getPeriod(layer, @as(mm.Word, @bitCast(@as(c_int, @bitCast(@as(c_uint, sample.*.frequency))) * @as(c_int, 4))), channel.*.note);
    var new_period: mm.Word = undefined;
    if ((@as(c_int, @bitCast(@as(c_uint, layer.*.flags))) & (@as(c_int, 1) << @intCast(2))) != 0) {
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
    const delta: c_int = @as(c_int, @bitCast(new_period -% old_period));
    return period +% @as(mm.Word, @bitCast(delta));
}
pub fn mpp_Update_ACHN(layer: [*c]mm.LayerInfo, act_ch: [*c]mm.ActiveChannel, period: mm.Word, ch: mm.Word) void {
    if ((@as(c_int, @bitCast(@as(c_uint, act_ch.*.flags))) & (@as(c_int, 1) << @intCast(3))) != 0) return;
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
    shim.debug_state.tickrate = layer_info.*.tickrate;
}
pub fn mpp_suspend(layer: mm_layer_type) void {
    var act_ch: [*c]mm.ActiveChannel = &mm_gba.achannels[@as(c_uint, @intCast(@as(c_int, 0)))];
    var mix_ch: [*c]volatile mm.MixerChannel = &mixer.mm_mix_channels[@as(c_uint, @intCast(@as(c_int, 0)))];
    {
        var count: mm.Word = mm_gba.num_ach;
        while (count != @as(mm.Word, @bitCast(@as(c_int, 0)))) : (_ = blk: {
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
            if (@as(c_uint, @bitCast(@as(c_int, @bitCast(@as(c_uint, act_ch.*.flags))) & ((@as(c_int, 1) << @intCast(6)) | (@as(c_int, 1) << @intCast(7))))) != (layer << @intCast(6))) continue;
            mix_ch.*.freq = 0;
        }
    }
}
pub fn mpps_backdoor(id: mm.Word, mode: mm_pmode, layer: LayerType) void {
    // Use exported module table pointer and read entry as LE32 to avoid alignment issues
    const moduleTable_ptr: [*]const u32 = @ptrCast(mm_gba.getModuleTable());
    const module_table_bytes: [*]const u8 = @ptrCast(moduleTable_ptr);
    const ptr_off: [*]const u8 = module_table_bytes + (@as(usize, @intCast(id)) * 4);
    const entry_off: mm.Word = @as(mm.Word, @intCast(@as(u32, ptr_off[0]) | (@as(u32, ptr_off[1]) << 8) | (@as(u32, ptr_off[2]) << 16) | (@as(u32, ptr_off[3]) << 24)));

    // Offsets in the module table point to the start of each MAS file, which
    // begins with an 8-byte mm_mas_prefix. Skip it to reach the module header.
    const full_offset: usize = entry_off;
    const moduleAddress: usize = @intFromPtr(mm_gba.bank_base) + full_offset;

    shim.debug_state.module_address_offset = full_offset;
    shim.debug_state.module_address = moduleAddress;

    mmPlayModule(moduleAddress, @intCast(mode), layer);
}
pub fn mpp_resetchannels(channels: [*c]mm.ModuleChannel, num_ch: mm.Word) void {
    // Clear channel data to 0 and reset alloc to NO_CHANNEL_AVAILABLE
    var i: mm.Word = 0;
    while (i < num_ch) : (i +%= 1) {
        channels[i] = .{};
        channels[i].alloc = @intCast(NO_CHANNEL_AVAILABLE);
    }
    // const mix_ch: [*c]mm.MixerChannel = &mixer.mm_mix_channels[0];
    // const act_ch: [*c]mm.ActiveChannel = &mm_gba.achannels[0];
    var curr_mix_ch: usize = 0;
    var curr_act_ch: usize = 0;
    {
        var j: mm.Word = 0;
        while (j < mm_gba.num_ach) : (j += 1) {
            const act_ch: [*c]mm.ActiveChannel = &mm_gba.achannels[curr_act_ch];
            const mix_ch: [*c]volatile mm.MixerChannel = &mixer.mm_mix_channels[curr_mix_ch];
            if (act_ch.*.flags & (MCAF_SUB | MCAF_EFFECT) >> 6 != @intFromEnum(mpp_clayer)) continue;

            act_ch.* = .{};
            mix_ch.*.src = shim.MIXCH_GBA_SRC_STOPPED;

            curr_act_ch += 1;
            curr_mix_ch += 1;
        }
        // while (j < mm_gba.num_ach) : (_ = blk: {
        //     _ = blk_1: {
        //         j +%= 1;
        //         break :blk_1 blk_2: {
        //             const ref = &act_ch;
        //             const tmp = ref.*;
        //             ref.* += 1;
        //             break :blk_2 tmp;
        //         };
        //     };
        //     break :blk blk_1: {
        //         const ref = &mix_ch;
        //         const tmp = ref.*;
        //         ref.* += 1;
        //         break :blk_1 tmp;
        //     };
        // }) {
        //     if (@as(c_uint, @bitCast((@as(c_int, @bitCast(@as(c_uint, act_ch.*.flags))) & ((@as(c_int, 1) << @intCast(6)) | (@as(c_int, 1) << @intCast(7)))) >> @intCast(6))) != @intFromEnum(mpp_clayer)) continue;
        //     mix_ch.*.src = shim.MIXCH_GBA_SRC_STOPPED;
        // }
    }
}
pub fn mppStop() void {
    var layer_info: [*c]mm.LayerInfo = undefined;
    var channels: [*c]mm.ModuleChannel = undefined;
    var num_ch: mm.Word = undefined;
    if (mpp_clayer == .jingle) {
        layer_info = &mmLayerSub;
        channels = @as([*c]mm.ModuleChannel, @ptrCast(@alignCast(&mm_schannels[@as(usize, @intCast(0))])));
        num_ch = 4;
    } else {
        layer_info = &mm_gba.layer_main;
        channels = mm_gba.pchannels;
        num_ch = mm_gba.num_mch;
    }
    debugPrint("[mppStop] layer={d} isplaying->0 valid->0\n", .{@intFromEnum(mpp_clayer)});
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
        // Read sequence entry via raw bytes to avoid any struct packing drift
        const hbytes: [*]const u8 = @ptrFromInt(@intFromPtr(header));
        const seq_off: usize = 9 + 3 + 32 + 32; // fields(9) + reserved(3) + ch_vol(32) + ch_pan(32)
        entry = @as(mm.Byte, @bitCast(hbytes[seq_off + @as(usize, @intCast(pos))]));
        // Validate that entry index is within pattern table bounds; if not, try pos+1.
        const patt_count: u8 = header.*.pattn_count;
        if (@as(u32, @intCast(entry)) >= @as(u32, patt_count)) {
            pos +%= 1;
            continue;
        }
        // C reference does not log per-step position/entry here
        if (@as(c_int, @bitCast(@as(c_uint, entry))) == @as(c_int, 254)) {
            pos +%= 1;
            continue;
        }
        if (@as(c_int, @bitCast(@as(c_uint, entry))) != @as(c_int, 255)) break;
        if (@as(c_int, @bitCast(@as(c_uint, layer_info.*.mode))) == MM_PLAY_ONCE) {
            mppStop();
            if (mmCallback != @as(mm_callback, @ptrCast(@alignCast(@as(?*anyopaque, @ptrFromInt(@as(c_int, 0))))))) {
                _ = mmCallback.?(@as(mm.Word, @bitCast(@as(c_int, 43))), mpp_clayer);
            }
            return;
        } else {
            pos = @as(mm.Word, @bitCast(@as(c_uint, header.*.repeat_position)));
        }
    }
    shim.debug_state.layer_position = pos;
    shim.debug_state.pattern_entry = entry;
    const patt_pat: [*c]Pattern = mpp_PatternPointer(layer_info, entry);

    layer_info.*.nrows = patt_pat.*.row_count;
    shim.debug_state.layer_nrows = layer_info.*.nrows;
    layer_info.*.tick = 0;
    layer_info.*.row = 0;
    layer_info.*.fpattdelay = 0;
    layer_info.*.pattdelay = 0;
    layer_info.*.pattread = patt_pat.*.pattern_data();
    layer_info.*.ploop_adr = patt_pat.*.pattern_data();
    layer_info.*.ploop_row = 0;
    layer_info.*.ploop_times = 0;

    shim.debug_state.patt_peek = layer_info.*.pattread[0];
}
pub fn mpp_resetvars(layer_info: [*c]mm.LayerInfo) void {
    layer_info.*.pattjump = 255;
    layer_info.*.pattjump_row = 0;
}
pub fn mpp_Channel_GetACHN(channel: [*c]mm.ModuleChannel) [*c]mm.ActiveChannel {
    const alloc: mm.Word = @as(mm.Word, @bitCast(@as(c_uint, channel.*.alloc)));
    if (alloc == 255) return null;
    return &mm_gba.achannels[alloc];
}
pub fn mpph_psu(period: mm.Word, slide_value: mm.Word) mm.Word {
    var per = period;
    if (slide_value >= @as(mm.Word, @bitCast(@as(c_int, 192)))) {
        per *%= @as(mm.Word, @bitCast(@as(c_int, 2)));
    }
    const val: mm.Word = (per >> @intCast(5)) *% @as(mm.Word, @bitCast(@as(c_uint, tables.mpp_TABLE_LinearSlideUpTable[slide_value])));
    const ret: mm.Word = (val >> @intCast(@as(c_int, 16) - @as(c_int, 5))) +% per;
    if ((ret >> @intCast(@as(c_int, 16) + @as(c_int, 5))) > @as(mm.Word, @bitCast(@as(c_int, 0)))) return @as(mm.Word, @bitCast(@as(c_int, 1) << @intCast(@as(c_int, 16) + @as(c_int, 5))));
    return ret;
}
pub fn mpph_psd(period: mm.Word, slide_value: mm.Word) mm.Word {
    const val: mm.Word = (period >> @intCast(5)) *% @as(mm.Word, @bitCast(@as(c_uint, tables.mpp_TABLE_LinearSlideDownTable[slide_value])));
    const ret: mm.Word = val >> @intCast(@as(c_int, 16) - @as(c_int, 5));
    return ret;
}
pub fn mpph_PitchSlide_Up(period: mm.Word, slide_value: mm.Word, layer: [*c]mm.LayerInfo) mm.Word {
    if ((@as(c_int, @bitCast(@as(c_uint, layer.*.flags))) & (@as(c_int, 1) << @intCast(2))) != 0) {
        return mpph_psu(period, slide_value);
    } else {
        const delta: mm.Word = slide_value << @intCast(4);
        if (delta > period) return 0;
        return period -% delta;
    }
    return 0;
}
pub fn mpph_LinearPitchSlide_Up(period: mm.Word, slide_value: mm.Word, layer: [*c]mm.LayerInfo) mm.Word {
    if ((@as(c_int, @bitCast(@as(c_uint, layer.*.flags))) & (@as(c_int, 1) << @intCast(2))) != 0) return mpph_psu(period, slide_value) else return mpph_psd(period, slide_value);
    return 0;
}
pub fn mpph_FinePitchSlide_Up(period: mm.Word, slide_value: mm.Word, layer: [*c]mm.LayerInfo) mm.Word {
    if ((@as(c_int, @bitCast(@as(c_uint, layer.*.flags))) & (@as(c_int, 1) << @intCast(2))) != 0) {
        const val: mm.Word = (period >> @intCast(5)) *% @as(mm.Word, @bitCast(@as(c_uint, tables.mpp_TABLE_FineLinearSlideUpTable[slide_value])));
        const ret: mm.Word = (val >> @intCast(@as(c_int, 16) - @as(c_int, 5))) +% period;
        if ((ret >> @intCast(@as(c_int, 16) + @as(c_int, 5))) > @as(mm.Word, @bitCast(@as(c_int, 0)))) return @as(mm.Word, @bitCast(@as(c_int, 1) << @intCast(@as(c_int, 16) + @as(c_int, 5))));
        return ret;
    } else {
        const delta: mm.Word = slide_value << @intCast(2);
        if (delta > period) return 0;
        return period -% delta;
    }
    return 0;
}
pub fn mpph_PitchSlide_Down(period: mm.Word, slide_value: mm.Word, layer: [*c]mm.LayerInfo) mm.Word {
    var per = period;
    if ((@as(c_int, @bitCast(@as(c_uint, layer.*.flags))) & (@as(c_int, 1) << @intCast(2))) != 0) {
        return mpph_psd(per, slide_value);
    } else {
        const delta: mm.Word = slide_value << @intCast(4);
        per = per +% delta;
        if ((per >> @intCast(@as(c_int, 16) + @as(c_int, 5))) > @as(mm.Word, @bitCast(@as(c_int, 0)))) return @as(mm.Word, @bitCast(@as(c_int, 1) << @intCast(@as(c_int, 16) + @as(c_int, 5))));
        return per;
    }
    return 0;
}
pub fn mpph_LinearPitchSlide_Down(period: mm.Word, slide_value: mm.Word, layer: [*c]mm.LayerInfo) mm.Word {
    if ((@as(c_int, @bitCast(@as(c_uint, layer.*.flags))) & (@as(c_int, 1) << @intCast(2))) != 0) return mpph_psd(period, slide_value) else return mpph_psu(period, slide_value);
    return 0;
}
pub fn mpph_FinePitchSlide_Down(period: mm.Word, slide_value: mm.Word, layer: [*c]mm.LayerInfo) mm.Word {
    var per = period;
    if ((@as(c_int, @bitCast(@as(c_uint, layer.*.flags))) & (@as(c_int, 1) << @intCast(2))) != 0) {
        const val: mm.Word = (per >> @intCast(5)) *% @as(mm.Word, @bitCast(@as(c_uint, tables.mpp_TABLE_FineLinearSlideDownTable[slide_value])));
        const ret: mm.Word = val >> @intCast(@as(c_int, 16) - @as(c_int, 5));
        return ret;
    } else {
        const delta: mm.Word = slide_value << @intCast(2);
        per = per +% delta;
        if ((per >> @intCast(@as(c_int, 16) + @as(c_int, 5))) > @as(mm.Word, @bitCast(@as(c_int, 0)))) return @as(mm.Word, @bitCast(@as(c_int, 1) << @intCast(@as(c_int, 16) + @as(c_int, 5))));
        return per;
    }
    return 0;
}
pub fn mpph_FastForward(layer: [*c]mm.LayerInfo, rows_to_skip: mm.Word) void {
    var rows = rows_to_skip;
    if (rows == @as(mm.Word, @bitCast(@as(c_int, 0)))) return;
    if (rows > @as(mm.Word, @bitCast(@as(c_uint, layer.*.nrows)))) return;
    layer.*.row = @as(mm.Byte, @bitCast(@as(u8, @truncate(rows))));
    while (true) {
        const ok = arm.readPattern(layer);
        if (!ok) {
            mppStop();
            if (mmCallback != @as(mm_callback, @ptrCast(@alignCast(@as(?*anyopaque, @ptrFromInt(@as(c_int, 0))))))) {
                _ = mmCallback.?(@as(mm.Word, @bitCast(@as(c_int, 44))), mpp_clayer);
            }
            break;
        }
        rows -%= 1;
        if (rows == @as(mm.Word, @bitCast(@as(c_int, 0)))) break;
    }
}
pub fn mpp_Channel_ExchangeMemory(effect: mm.Byte, param: mm.Byte, channel: [*c]mm.ModuleChannel, layer: [*c]mm.LayerInfo) mm.Word {
    var table_entry: mm.Sbyte = undefined;
    if ((@as(c_int, @bitCast(@as(c_uint, layer.*.flags))) & (@as(c_int, 1) << @intCast(3))) != 0) {
        table_entry = tables.mpp_effect_memmap_xm[effect];
    } else {
        table_entry = tables.mpp_effect_memmap_it[effect];
    }
    if (@as(c_int, @bitCast(@as(c_int, table_entry))) == -@as(c_int, 1)) return @as(mm.Word, @bitCast(@as(c_uint, param)));
    if (@as(c_int, @bitCast(@as(c_uint, param))) == @as(c_int, 0)) {
        channel.*.param = channel.*.memory[@as(u8, @intCast(table_entry))];
        return @as(mm.Word, @bitCast(@as(c_uint, channel.*.param)));
    } else {
        channel.*.memory[@as(u8, @intCast(table_entry))] = param;
        return @as(mm.Word, @bitCast(@as(c_uint, param)));
    }
    return 0;
}
pub fn mpph_VolumeSlide(volume: c_int, param: mm.Word, tick: mm.Word, max_volume: c_int, layer: [*c]mm.LayerInfo) mm.Word {
    var vol = volume;
    if ((@as(c_int, @bitCast(@as(c_uint, layer.*.flags))) & (@as(c_int, 1) << @intCast(3))) != 0) {
        if (tick != @as(mm.Word, @bitCast(@as(c_int, 0)))) {
            const r3: c_int = @as(c_int, @bitCast(param >> @intCast(4)));
            const r1: c_int = @as(c_int, @bitCast(param & @as(mm.Word, @bitCast(@as(c_int, 15)))));
            var new_val: c_int = (vol + r3) - r1;
            if (new_val > max_volume) {
                new_val = max_volume;
            }
            if (new_val < @as(c_int, 0)) {
                new_val = 0;
            }
            vol = new_val;
        }
        return @as(mm.Word, @bitCast(vol));
    } else {
        if (param == @as(mm.Word, @bitCast(@as(c_int, 15)))) {
            vol -= @as(c_int, 15);
            if (vol < @as(c_int, 0)) return 0;
            return @as(mm.Word, @bitCast(vol));
        }
        if (param == @as(mm.Word, @bitCast(@as(c_int, 240)))) {
            if (tick != @as(mm.Word, @bitCast(@as(c_int, 0)))) return @as(mm.Word, @bitCast(volume));
            vol += @as(c_int, 15);
            if (vol > max_volume) return @as(mm.Word, @bitCast(max_volume));
            return @as(mm.Word, @bitCast(vol));
        }
        if ((param & @as(mm.Word, @bitCast(@as(c_int, 15)))) == @as(mm.Word, @bitCast(@as(c_int, 0)))) {
            if (tick == @as(mm.Word, @bitCast(@as(c_int, 0)))) return @as(mm.Word, @bitCast(vol));
            vol += @as(c_int, @bitCast(param >> @intCast(4)));
            if (vol > max_volume) return @as(mm.Word, @bitCast(max_volume));
            return @as(mm.Word, @bitCast(vol));
        }
        if ((param >> @intCast(4)) == @as(mm.Word, @bitCast(@as(c_int, 0)))) {
            if (tick == @as(mm.Word, @bitCast(@as(c_int, 0)))) return @as(mm.Word, @bitCast(vol));
            vol -= @as(c_int, @bitCast(param & @as(mm.Word, @bitCast(@as(c_int, 15)))));
            if (vol < @as(c_int, 0)) return 0;
            return @as(mm.Word, @bitCast(vol));
        }
        if (tick != @as(mm.Word, @bitCast(@as(c_int, 0)))) return @as(mm.Word, @bitCast(vol));
        if ((param & @as(mm.Word, @bitCast(@as(c_int, 15)))) == @as(mm.Word, @bitCast(@as(c_int, 15)))) {
            vol += @as(c_int, @bitCast(param >> @intCast(4)));
            if (vol > max_volume) return @as(mm.Word, @bitCast(max_volume));
            return @as(mm.Word, @bitCast(vol));
        }
        if ((param >> @intCast(4)) == @as(mm.Word, @bitCast(@as(c_int, 15)))) {
            vol -= @as(c_int, @bitCast(param & @as(mm.Word, @bitCast(@as(c_int, 15)))));
            if (vol < @as(c_int, 0)) return 0;
            return @as(mm.Word, @bitCast(vol));
        }
        return @as(mm.Word, @bitCast(vol));
    }
    return 0;
}
pub fn mpph_VolumeSlide64(volume: c_int, param: mm.Word, tick: mm.Word, layer: [*c]mm.LayerInfo) mm.Word {
    const out = mpph_VolumeSlide(volume, param, tick, 64, layer);
    if (layer.*.row < 6 and layer.*.tick <= 1) {
        debugPrint("[VOL64] tick={d} param={x} in={d} out={d}\n", .{ @as(c_int, @intCast(tick)), @as(c_int, @intCast(param)), @as(c_int, @intCast(volume)), @as(c_int, @intCast(out)) });
    }
    return out;
}
pub fn mppe_SetSpeed(param: mm.Word, layer: [*c]mm.LayerInfo) void {
    if (@as(c_int, @bitCast(@as(c_uint, layer.*.tick))) != @as(c_int, 0)) return;
    if (param != @as(mm.Word, @bitCast(@as(c_int, 0)))) {
        layer.*.speed = @as(mm.Byte, @bitCast(@as(u8, @truncate(param))));
    }
}
pub fn mppe_PositionJump(param: mm.Word, layer: [*c]mm.LayerInfo) void {
    if (@as(c_int, @bitCast(@as(c_uint, layer.*.tick))) != @as(c_int, 0)) return;
    if (debug_enabled) {
        debugPrint(
            "[POSJMP] row={d} param={d} position(before)={d}\n",
            .{ @as(c_int, @intCast(layer.*.row)), @as(c_int, @intCast(param)), @as(c_int, @intCast(layer.*.position)) },
        );
    }
    layer.*.pattjump = @as(mm.Byte, @bitCast(@as(u8, @truncate(param))));
}
pub fn mppe_PatternBreak(param: mm.Word, layer: [*c]mm.LayerInfo) void {
    if (@as(c_int, @bitCast(@as(c_uint, layer.*.tick))) != @as(c_int, 0)) return;
    if (debug_enabled) {
        debugPrint(
            "[PATBRK] row={d} param=0x{x:0>2} position={d} pattjump(before)={d}\n",
            .{ @as(c_int, @intCast(layer.*.row)), @as(u32, @intCast(param)), @as(c_int, @intCast(layer.*.position)), @as(c_int, @intCast(layer.*.pattjump)) },
        );
    }
    layer.*.pattjump_row = @as(mm.Byte, @bitCast(@as(u8, @truncate(param))));
    if (@as(c_int, @bitCast(@as(c_uint, layer.*.pattjump))) == @as(c_int, 255)) {
        layer.*.pattjump = @as(mm.Byte, @bitCast(@as(i8, @truncate(@as(c_int, @bitCast(@as(c_uint, layer.*.position))) + @as(c_int, 1)))));
        if (debug_enabled) {
            debugPrint(
                "[PATBRK] set pattjump={d} pattjump_row={d}\n",
                .{ @as(c_int, @intCast(layer.*.pattjump)), @as(c_int, @intCast(layer.*.pattjump_row)) },
            );
        }
    }
}
pub fn mppe_VolumeSlide(param: mm.Word, channel: [*c]mm.ModuleChannel, layer: [*c]mm.LayerInfo) void {
    const ch_idx_dbg: c_int = @as(c_int, @intCast((@intFromPtr(channel) - @intFromPtr(mm_gba.mpp_channels)) / @sizeOf(mm.ModuleChannel)));
    if (ch_idx_dbg >= 0 and ch_idx_dbg < 2 and layer.*.row < 6) {
        debugPrint("[VOLCMD] ch={d} before vol={d} cvol={d} param={x} tick={d}\n", .{ ch_idx_dbg, @as(c_int, @intCast(channel.*.volume)), @as(c_int, @intCast(channel.*.cvolume)), @as(c_int, @intCast(param)), @as(c_int, @intCast(layer.*.tick)) });
    }
    const vol_word = mpph_VolumeSlide64(
        @as(c_int, @intCast(channel.*.volume)),
        param,
        @as(mm.Word, @bitCast(@as(c_uint, layer.*.tick))),
        layer,
    );
    channel.*.volume = @as(mm.Byte, @intCast(@as(c_int, @intCast(vol_word))));
    if (ch_idx_dbg >= 0 and ch_idx_dbg < 2 and layer.*.row < 6) {
        debugPrint("[VOLCMD] ch={d} after vol={d}\n", .{ ch_idx_dbg, @as(c_int, @intCast(channel.*.volume)) });
    }
}
pub fn mppe_Portamento(param: mm.Word, period: mm.Word, channel: [*c]mm.ModuleChannel, layer: [*c]mm.LayerInfo) mm.Word {
    var par = param;
    var is_fine: bool = false;
    if ((par >> @intCast(4)) == @as(mm.Word, @bitCast(@as(c_int, 14)))) {
        if (@as(c_int, @bitCast(@as(c_uint, layer.*.tick))) != @as(c_int, 0)) return period;
        par &= @as(mm.Word, @bitCast(@as(c_int, 15)));
        is_fine = true;
    } else if ((par >> @intCast(4)) == @as(mm.Word, @bitCast(@as(c_int, 15)))) {
        if (@as(c_int, @bitCast(@as(c_uint, layer.*.tick))) != @as(c_int, 0)) return period;
        par &= @as(mm.Word, @bitCast(@as(c_int, 15)));
    } else {
        if (@as(c_int, @bitCast(@as(c_uint, layer.*.tick))) == @as(c_int, 0)) return period;
    }
    var new_period: mm.Word = undefined;
    _ = &new_period;
    if (@as(c_int, @bitCast(@as(c_uint, channel.*.effect))) == @as(c_int, 5)) {
        if (is_fine) {
            new_period = mpph_FinePitchSlide_Down(channel.*.period, par, layer);
        } else {
            new_period = mpph_PitchSlide_Down(channel.*.period, par, layer);
        }
    } else {
        if (is_fine) {
            new_period = mpph_FinePitchSlide_Up(channel.*.period, par, layer);
        } else {
            new_period = mpph_PitchSlide_Up(channel.*.period, par, layer);
        }
    }
    const old_period: c_int = @as(c_int, @bitCast(channel.*.period));
    channel.*.period = new_period;
    const delta: c_int = @as(c_int, @bitCast(new_period -% @as(mm.Word, @bitCast(old_period))));
    return period +% @as(mm.Word, @bitCast(delta));
}
pub fn mppe_Glissando(param: mm.Word, period: mm.Word, act_ch: ?[*c]mm.ActiveChannel, channel: [*c]mm.ModuleChannel, layer: [*c]mm.LayerInfo) mm.Word {
    var par = param;
    var per = period;
    if (@as(c_int, @bitCast(@as(c_uint, layer.*.tick))) == @as(c_int, 0)) {
        if ((@as(c_int, @bitCast(@as(c_uint, layer.*.flags))) & (@as(c_int, 1) << @intCast(0))) != 0) {
            if (par == @as(mm.Word, @bitCast(@as(c_int, 0)))) {
                par = @as(mm.Word, @bitCast(@as(c_uint, channel.*.memory[@as(c_uint, @intCast(@as(c_int, 2)))])));
                channel.*.param = @as(mm.Byte, @bitCast(@as(u8, @truncate(par))));
            }
            channel.*.memory[@as(c_uint, @intCast(@as(c_int, 2)))] = @as(mm.Byte, @bitCast(@as(u8, @truncate(par))));
            channel.*.memory[@as(c_uint, @intCast(@as(c_int, 0)))] = @as(mm.Byte, @bitCast(@as(u8, @truncate(par))));
        } else {
            if (par == @as(mm.Word, @bitCast(@as(c_int, 0)))) {
                par = @as(mm.Word, @bitCast(@as(c_uint, channel.*.memory[@as(c_uint, @intCast(@as(c_int, 0)))])));
                channel.*.param = @as(mm.Byte, @bitCast(@as(u8, @truncate(par))));
            }
            channel.*.memory[@as(c_uint, @intCast(@as(c_int, 0)))] = @as(mm.Byte, @bitCast(@as(u8, @truncate(par))));
            return period;
        }
    }
    par = @as(mm.Word, @bitCast(@as(c_uint, channel.*.memory[@as(c_uint, @intCast(@as(c_int, 0)))])));
    per = mppe_glis_backdoor(par, per, act_ch, channel, layer);
    return per;
}
pub fn mppe_Vibrato(param: mm.Word, period: mm.Word, channel: [*c]mm.ModuleChannel, layer: [*c]mm.LayerInfo) mm.Word {
    if (@as(c_int, @bitCast(@as(c_uint, layer.*.tick))) != @as(c_int, 0)) return mppe_DoVibrato(period, channel, layer);
    const x: mm.Word = param >> @intCast(4);
    const y: mm.Word = param & @as(mm.Word, @bitCast(@as(c_int, 15)));
    if (x != @as(mm.Word, @bitCast(@as(c_int, 0)))) {
        channel.*.vibspd = @as(mm.Byte, @bitCast(@as(u8, @truncate(x *% @as(mm.Word, @bitCast(@as(c_int, 4)))))));
    }
    if (y != @as(mm.Word, @bitCast(@as(c_int, 0)))) {
        var depth: mm.Word = y *% @as(mm.Word, @bitCast(@as(c_int, 4)));
        _ = &depth;
        channel.*.vibdep = @as(mm.Byte, @bitCast(@as(u8, @truncate(depth << @intCast(@as(c_int, @bitCast(@as(c_uint, layer.*.oldeffects))))))));
        return mppe_DoVibrato(period, channel, layer);
    }
    return period;
}
pub fn mppe_Arpeggio(param: mm.Word, period: mm.Word, act_ch: ?[*c]mm.ActiveChannel, channel: [*c]mm.ModuleChannel, layer: [*c]mm.LayerInfo) mm.Word {
    if (@as(c_int, @bitCast(@as(c_uint, layer.*.tick))) == @as(c_int, 0)) {
        channel.*.fxmem = 0;
    }
    if (act_ch == null) return period;
    var semitones: mm.Word = undefined;
    if (@as(c_int, @bitCast(@as(c_uint, channel.*.fxmem))) > @as(c_int, 1)) {
        channel.*.fxmem = 0;
        semitones = param & @as(mm.Word, @bitCast(@as(c_int, 15)));
    } else if (@as(c_int, @bitCast(@as(c_uint, channel.*.fxmem))) == @as(c_int, 1)) {
        channel.*.fxmem = 2;
        semitones = param >> @intCast(4);
    } else {
        channel.*.fxmem = 1;
        return period;
    }
    semitones *%= @as(mm.Word, @bitCast(@as(c_int, 16)));
    const per = mpph_LinearPitchSlide_Up(period, semitones, layer);
    return per;
}
pub fn mppe_VibratoVolume(param: mm.Word, period: mm.Word, channel: [*c]mm.ModuleChannel, layer: [*c]mm.LayerInfo) mm.Word {
    const new_period: mm.Word = mppe_DoVibrato(period, channel, layer);
    mppe_VolumeSlide(param, channel, layer);
    return new_period;
}
pub fn mppe_PortaVolume(param: mm.Word, period: mm.Word, act_ch: ?[*c]mm.ActiveChannel, channel: [*c]mm.ModuleChannel, layer: [*c]mm.LayerInfo) mm.Word {
    const mem: mm.Word = @as(mm.Word, @bitCast(@as(c_uint, channel.*.memory[@as(c_uint, @intCast(@as(c_int, 0)))])));
    const per = mppe_Glissando(mem, period, act_ch, channel, layer);
    mppe_VolumeSlide(param, channel, layer);
    return per;
}
pub fn mppe_ChannelVolume(param: mm.Word, channel: [*c]mm.ModuleChannel, layer: [*c]mm.LayerInfo) void {
    if (@as(c_int, @bitCast(@as(c_uint, layer.*.tick))) != @as(c_int, 0)) return;
    if (param > @as(mm.Word, @bitCast(@as(c_int, 64)))) return;
    channel.*.cvolume = @as(mm.Byte, @bitCast(@as(u8, @truncate(param))));
}
pub fn mppe_ChannelVolumeSlide(param: mm.Word, channel: [*c]mm.ModuleChannel, layer: [*c]mm.LayerInfo) void {
    channel.*.cvolume = @as(mm.Byte, @bitCast(@as(u8, @truncate(mpph_VolumeSlide64(@as(c_int, @bitCast(@as(c_uint, channel.*.cvolume))), param, @as(mm.Word, @bitCast(@as(c_uint, layer.*.tick))), layer)))));
}
pub fn mppe_SampleOffset(param: mm.Word, layer: [*c]mm.LayerInfo) void {
    if (@as(c_int, @bitCast(@as(c_uint, layer.*.tick))) != @as(c_int, 0)) return;
    mpp_vars.sampoff = @as(mm.Byte, @bitCast(@as(u8, @truncate(param))));
}
pub fn mppe_Retrigger(param: mm.Word, act_ch: ?[*c]mm.ActiveChannel, channel: [*c]mm.ModuleChannel) void {
    var mem: mm.Word = @as(mm.Word, @bitCast(@as(c_uint, channel.*.fxmem)));
    if (mem == @as(mm.Word, @bitCast(@as(c_int, 0)))) {
        channel.*.fxmem = @as(mm.Byte, @bitCast(@as(u8, @truncate((param & @as(mm.Word, @bitCast(@as(c_int, 15)))) +% @as(mm.Word, @bitCast(@as(c_int, 1)))))));
        return;
    }
    mem -%= 1;
    if (mem != @as(mm.Word, @bitCast(@as(c_int, 1)))) {
        channel.*.fxmem = @as(mm.Byte, @bitCast(@as(u8, @truncate(mem))));
        return;
    }
    channel.*.fxmem = @as(mm.Byte, @bitCast(@as(u8, @truncate((param & @as(mm.Word, @bitCast(@as(c_int, 15)))) +% @as(mm.Word, @bitCast(@as(c_int, 1)))))));
    var vol: c_int = @as(c_int, @bitCast(@as(c_uint, channel.*.volume)));
    const arg: mm.Word = param >> @intCast(4);
    if (arg == @as(mm.Word, @bitCast(@as(c_int, 0)))) {} else if (arg <= @as(mm.Word, @bitCast(@as(c_int, 5)))) {
        vol -= @as(c_int, 1) << @intCast(arg -% @as(mm.Word, @bitCast(@as(c_int, 1))));
        if (vol < @as(c_int, 0)) {
            vol = 0;
        }
    } else if (arg == @as(mm.Word, @bitCast(@as(c_int, 6)))) {
        vol = (vol * @as(c_int, 171)) >> @intCast(8);
    } else if (arg == @as(mm.Word, @bitCast(@as(c_int, 7)))) {
        vol >>= @intCast(@as(c_int, 1));
    } else if (arg == @as(mm.Word, @bitCast(@as(c_int, 8)))) {} else if (arg <= @as(mm.Word, @bitCast(@as(c_int, 13)))) {
        vol += @as(c_int, 1) << @intCast(arg -% @as(mm.Word, @bitCast(@as(c_int, 9))));
        if (vol > @as(c_int, 64)) {
            vol = 64;
        }
    } else if (arg == @as(mm.Word, @bitCast(@as(c_int, 14)))) {
        vol = (vol * @as(c_int, 192)) >> @intCast(7);
    } else {
        vol <<= @intCast(@as(c_int, 1));
        if (vol > @as(c_int, 64)) {
            vol = 64;
        }
    }
    channel.*.volume = @as(mm.Byte, @bitCast(@as(i8, @truncate(vol))));
    if (act_ch != null) {
        act_ch.?.*.flags |= @as(mm.Byte, @bitCast(@as(i8, @truncate(@as(c_int, 1) << @intCast(2)))));
    }
}
pub fn mppe_Tremolo(param: mm.Word, channel: [*c]mm.ModuleChannel, layer: [*c]mm.LayerInfo) void {
    if (@as(c_int, @bitCast(@as(c_uint, layer.*.tick))) != @as(c_int, 0)) {
        var position: mm.Word = @as(mm.Word, @bitCast(@as(c_uint, channel.*.fxmem)));
        _ = &position;
        var speed: mm.Word = param >> @intCast(4);
        _ = &speed;
        position +%= speed *% @as(mm.Word, @bitCast(@as(c_int, 4)));
        channel.*.fxmem = @as(mm.Byte, @bitCast(@as(u8, @truncate(position))));
    }
    const position: mm.Word = @as(mm.Word, @bitCast(@as(c_uint, channel.*.fxmem)));
    const sine: mm.Sword = @as(mm.Sword, @bitCast(@as(c_int, tables.mpp_TABLE_FineSineData[position])));
    const depth: mm.Word = param & @as(mm.Word, @bitCast(@as(c_int, 15)));
    var result: mm.Sword = @as(mm.Sword, @bitCast((@as(mm.Word, @bitCast(sine)) *% depth) >> @intCast(6)));
    if ((@as(c_int, @bitCast(@as(c_uint, layer.*.flags))) & (@as(c_int, 1) << @intCast(3))) != 0) {
        result >>= @intCast(@as(c_int, 1));
    }
    mpp_vars.volplus = @as(mm.Sbyte, @bitCast(@as(i8, @truncate(result))));
}
pub fn mppe_SetTempo(param: mm.Word, layer: [*c]mm.LayerInfo) void {
    if (param < @as(mm.Word, @bitCast(@as(c_int, 16)))) {
        if (@as(c_int, @bitCast(@as(c_uint, layer.*.tick))) == @as(c_int, 0)) return;
        var bpm: c_int = @as(c_int, @bitCast(@as(mm.Word, @bitCast(@as(c_uint, layer.*.bpm))) -% param));
        _ = &bpm;
        if (bpm < @as(c_int, 32)) {
            bpm = 32;
        }
        mpp_setbpm(layer, @as(mm.Word, @bitCast(bpm)));
    } else if (param < @as(mm.Word, @bitCast(@as(c_int, 32)))) {
        if (@as(c_int, @bitCast(@as(c_uint, layer.*.tick))) == @as(c_int, 0)) return;
        var bpm: c_int = @as(c_int, @bitCast(@as(mm.Word, @bitCast(@as(c_uint, layer.*.bpm))) +% (param & @as(mm.Word, @bitCast(@as(c_int, 15))))));
        _ = &bpm;
        if (bpm > @as(c_int, 255)) {
            bpm = 255;
        }
        mpp_setbpm(layer, @as(mm.Word, @bitCast(bpm)));
    } else {
        if (@as(c_int, @bitCast(@as(c_uint, layer.*.tick))) != @as(c_int, 0)) return;
        mpp_setbpm(layer, param);
    }
}
pub fn mppe_FineVibrato(param: mm.Word, period: mm.Word, channel: [*c]mm.ModuleChannel, layer: [*c]mm.LayerInfo) mm.Word {
    if (@as(c_int, @bitCast(@as(c_uint, layer.*.tick))) == @as(c_int, 0)) {
        const x: mm.Word = param >> @intCast(4);
        const y: mm.Word = param & @as(mm.Word, @bitCast(@as(c_int, 15)));
        if (x != @as(mm.Word, @bitCast(@as(c_int, 0)))) {
            channel.*.vibspd = @as(mm.Byte, @bitCast(@as(u8, @truncate(x *% @as(mm.Word, @bitCast(@as(c_int, 4)))))));
        }
        if (y != @as(mm.Word, @bitCast(@as(c_int, 0)))) {
            var depth: mm.Word = y *% @as(mm.Word, @bitCast(@as(c_int, 4)));
            _ = &depth;
            channel.*.vibdep = @as(mm.Byte, @bitCast(@as(u8, @truncate(depth << @intCast(@as(c_int, @bitCast(@as(c_uint, layer.*.oldeffects))))))));
        }
    }
    return mppe_DoVibrato(period, channel, layer);
}
pub fn mppe_SetGlobalVolume(param: mm.Word, layer: [*c]mm.LayerInfo) void {
    if (@as(c_int, @bitCast(@as(c_uint, layer.*.tick))) != @as(c_int, 0)) return;
    const mask: mm.Word = @as(mm.Word, @bitCast((@as(c_int, 1) << @intCast(3)) | (@as(c_int, 1) << @intCast(5))));
    var maxvol: mm.Word = undefined;
    if ((@as(mm.Word, @bitCast(@as(c_uint, layer.*.flags))) & mask) != 0) {
        maxvol = 64;
    } else {
        maxvol = 128;
    }
    layer.*.global_volume = @as(mm.Byte, @bitCast(@as(u8, @truncate(if (param < maxvol) param else maxvol))));
}
pub fn mppe_GlobalVolumeSlide(param: mm.Word, layer: [*c]mm.LayerInfo) void {
    var maxvol: mm.Word = undefined;
    if ((@as(c_int, @bitCast(@as(c_uint, layer.*.flags))) & (@as(c_int, 1) << @intCast(3))) != 0) {
        maxvol = 64;
    } else {
        maxvol = 128;
    }
    layer.*.global_volume = @as(mm.Byte, @bitCast(@as(u8, @truncate(mpph_VolumeSlide(@as(c_int, @bitCast(@as(c_uint, layer.*.global_volume))), param, @as(mm.Word, @bitCast(@as(c_uint, layer.*.tick))), @as(c_int, @bitCast(maxvol)), layer)))));
}
pub fn mppe_SetPanning(param: mm.Word, channel: [*c]mm.ModuleChannel, layer: [*c]mm.LayerInfo) void {
    if (@as(c_int, @bitCast(@as(c_uint, layer.*.tick))) == @as(c_int, 0)) {
        channel.*.panning = @as(mm.Byte, @bitCast(@as(u8, @truncate(param))));
    }
}
pub fn mppex_XM_FVolSlideUp(param: mm.Word, channel: [*c]mm.ModuleChannel, layer: [*c]mm.LayerInfo) void {
    if (@as(c_int, @bitCast(@as(c_uint, layer.*.tick))) != @as(c_int, 0)) return;
    var volume: c_int = @as(c_int, @bitCast(@as(mm.Word, @bitCast(@as(c_uint, channel.*.volume))) +% (param & @as(mm.Word, @bitCast(@as(c_int, 15))))));
    if (volume > @as(c_int, 64)) {
        volume = 64;
    }
    channel.*.volume = @as(mm.Byte, @bitCast(@as(i8, @truncate(volume))));
}
pub fn mppex_XM_FVolSlideDown(param: mm.Word, channel: [*c]mm.ModuleChannel, layer: [*c]mm.LayerInfo) void {
    if (@as(c_int, @bitCast(@as(c_uint, layer.*.tick))) != @as(c_int, 0)) return;
    var volume: c_int = @as(c_int, @bitCast(@as(mm.Word, @bitCast(@as(c_uint, channel.*.volume))) -% (param & @as(mm.Word, @bitCast(@as(c_int, 15))))));
    _ = &volume;
    if (volume < @as(c_int, 0)) {
        volume = 0;
    }
    channel.*.volume = @as(mm.Byte, @bitCast(@as(i8, @truncate(volume))));
}
pub fn mppex_OldRetrig(param: mm.Word, act_ch: ?[*c]mm.ActiveChannel, channel: [*c]mm.ModuleChannel, layer: [*c]mm.LayerInfo) void {
    if (@as(c_int, @bitCast(@as(c_uint, layer.*.tick))) == @as(c_int, 0)) {
        channel.*.fxmem = @as(mm.Byte, @bitCast(@as(u8, @truncate(param & @as(mm.Word, @bitCast(@as(c_int, 15)))))));
        return;
    }
    channel.*.fxmem -%= 1;
    if (@as(c_int, @bitCast(@as(c_uint, channel.*.fxmem))) == @as(c_int, 0)) {
        channel.*.fxmem = @as(mm.Byte, @bitCast(@as(u8, @truncate(param & @as(mm.Word, @bitCast(@as(c_int, 15)))))));
        if (act_ch != null) {
            act_ch.?.*.flags |= @as(mm.Byte, @bitCast(@as(i8, @truncate(@as(c_int, 1) << @intCast(2)))));
        }
    }
}
pub fn mppex_FPattDelay(param: mm.Word, layer: [*c]mm.LayerInfo) void {
    if (@as(c_int, @bitCast(@as(c_uint, layer.*.tick))) != @as(c_int, 0)) return;
    layer.*.fpattdelay = @as(mm.Byte, @bitCast(@as(u8, @truncate(param & @as(mm.Word, 15)))));
}
pub fn mppex_InstControl(param: mm.Word, act_ch: ?[*c]mm.ActiveChannel, channel: [*c]mm.ModuleChannel, layer: [*c]mm.LayerInfo) void {
    if (@as(c_int, @bitCast(@as(c_uint, layer.*.tick))) != @as(c_int, 0)) return;
    const subparam: mm.Word = param & @as(mm.Word, @bitCast(@as(c_int, 15)));
    if (subparam <= @as(mm.Word, @bitCast(@as(c_int, 2)))) {} else if (subparam <= @as(mm.Word, 6)) {
        channel.*.bflags &= @as(mm.Hword, @bitCast(@as(c_short, @truncate(~(@as(c_int, 3) << @intCast(6))))));
        channel.*.bflags |= @as(mm.Hword, @bitCast(@as(c_ushort, @truncate(((subparam -% @as(mm.Word, @bitCast(@as(c_int, 3)))) << @intCast(6)) & @as(mm.Word, @bitCast(@as(c_int, 3) << @intCast(6)))))));
    } else if (subparam <= @as(mm.Word, @bitCast(@as(c_int, 8)))) {
        if (act_ch != null) {
            const val: c_int = @as(c_int, @bitCast(subparam -% @as(mm.Word, @bitCast(@as(c_int, 7)))));
            if (val != 0) {
                act_ch.?.*.flags |= @as(mm.Byte, @bitCast(@as(i8, @truncate(@as(c_int, 1) << @intCast(5)))));
            } else {
                act_ch.?.*.flags &= @as(mm.Byte, @bitCast(@as(i8, @truncate(~(@as(c_int, 1) << @intCast(5))))));
            }
        }
    }
}
pub fn mppex_SetPanning(param: mm.Word, channel: [*c]mm.ModuleChannel) void {
    channel.*.panning = @as(mm.Byte, @bitCast(@as(u8, @truncate(param << @intCast(4)))));
}
pub fn mppex_SoundControl(param: mm.Word) void {
    if (param != @as(mm.Word, @bitCast(@as(c_int, 145)))) return;
}
pub fn mppex_PatternLoop(param: mm.Word, layer: [*c]mm.LayerInfo) void {
    if (@as(c_int, @bitCast(@as(c_uint, layer.*.tick))) != @as(c_int, 0)) return;
    const subparam: mm.Word = param & @as(mm.Word, @bitCast(@as(c_int, 15)));
    if (debug_enabled) {
        debugPrint(
            "[PLOOP] row={d} subparam=0x{x:0>2} counter={d}\n",
            .{ @as(c_int, @intCast(layer.*.row)), @as(u32, @intCast(subparam)), @as(c_int, @intCast(layer.*.ploop_times)) },
        );
    }
    if (subparam == @as(mm.Word, @bitCast(@as(c_int, 0)))) {
        layer.*.ploop_row = layer.*.row;
        layer.*.ploop_adr = mpp_vars.pattread_p;
        return;
    }
    const counter: mm.Word = @as(mm.Word, @bitCast(@as(c_uint, layer.*.ploop_times)));
    if (counter == @as(mm.Word, @bitCast(@as(c_int, 0)))) {
        layer.*.ploop_times = @as(mm.Byte, @bitCast(@as(u8, @truncate(subparam))));
        layer.*.ploop_jump = 1;
    } else {
        layer.*.ploop_times = @as(mm.Byte, @bitCast(@as(u8, @truncate(counter -% @as(mm.Word, @bitCast(@as(c_int, 1)))))));
        if (@as(c_int, @bitCast(@as(c_uint, layer.*.ploop_times))) != @as(c_int, 0)) {
            layer.*.ploop_jump = 1;
        }
    }
}
pub fn mppex_NoteCut(param: mm.Word, channel: [*c]mm.ModuleChannel, layer: [*c]mm.LayerInfo) void {
    const reference: mm.Word = param & @as(mm.Word, @bitCast(@as(c_int, 15)));
    if (@as(mm.Word, @bitCast(@as(c_uint, layer.*.tick))) != reference) return;
    channel.*.volume = 0;
}
pub fn mppex_NoteDelay(param: mm.Word, layer: [*c]mm.LayerInfo) void {
    const reference: mm.Word = param & @as(mm.Word, @bitCast(@as(c_int, 15)));
    if (@as(mm.Word, @bitCast(@as(c_uint, layer.*.tick))) >= reference) return;
    mpp_vars.notedelay = @as(mm.Byte, @bitCast(@as(u8, @truncate(reference))));
}
pub fn mppex_PatternDelay(param: mm.Word, layer: [*c]mm.LayerInfo) void {
    if (@as(c_int, @bitCast(@as(c_uint, layer.*.tick))) != @as(c_int, 0)) return;
    if (@as(c_int, @bitCast(@as(c_uint, layer.*.pattdelay))) == @as(c_int, 0)) {
        if (debug_enabled) {
            debugPrint(
                "[PDELAY] row={d} param=0x{x:0>2}\n",
                .{ @as(c_int, @intCast(layer.*.row)), @as(u32, @intCast(param)) },
            );
        }
        layer.*.pattdelay = @as(mm.Byte, @bitCast(@as(u8, @truncate((param & @as(mm.Word, @bitCast(@as(c_int, 15)))) +% @as(mm.Word, @bitCast(@as(c_int, 1)))))));
    }
}
pub fn mppex_SongMessage(param: mm.Word, layer: [*c]mm.LayerInfo) void {
    if (@as(c_int, @bitCast(@as(c_uint, layer.*.tick))) != @as(c_int, 0)) return;
    if (mmCallback != @as(mm_callback, @ptrCast(@alignCast(@as(?*anyopaque, @ptrFromInt(0)))))) {
        const layer_type = param & @as(mm.Word, 15) | (@as(mm.Word, @intFromEnum(mpp_clayer)) << 4);
        _ = mmCallback.?(@as(mm.Word, @bitCast(@as(c_int, 42))), @enumFromInt(layer_type));
    }
}
pub fn mppe_Extended(param: mm.Word, act_ch: ?[*c]mm.ActiveChannel, channel: [*c]mm.ModuleChannel, layer: [*c]mm.LayerInfo) void {
    const subcmd: mm.Word = param >> @intCast(4);
    while (true) {
        switch (subcmd) {
            @as(mm.Word, @bitCast(@as(c_int, 0))) => {
                mppex_XM_FVolSlideUp(param, channel, layer);
                break;
            },
            @as(mm.Word, @bitCast(@as(c_int, 1))) => {
                mppex_XM_FVolSlideDown(param, channel, layer);
                break;
            },
            @as(mm.Word, @bitCast(@as(c_int, 2))) => {
                mppex_OldRetrig(param, act_ch, channel, layer);
                break;
            },
            @as(mm.Word, @bitCast(@as(c_int, 3))) => break,
            @as(mm.Word, @bitCast(@as(c_int, 4))) => break,
            @as(mm.Word, @bitCast(@as(c_int, 5))) => break,
            @as(mm.Word, @bitCast(@as(c_int, 6))) => {
                mppex_FPattDelay(param, layer);
                break;
            },
            @as(mm.Word, @bitCast(@as(c_int, 7))) => {
                mppex_InstControl(param, act_ch, channel, layer);
                break;
            },
            @as(mm.Word, @bitCast(@as(c_int, 8))) => {
                mppex_SetPanning(param, channel);
                break;
            },
            @as(mm.Word, @bitCast(@as(c_int, 9))) => {
                mppex_SoundControl(param);
                break;
            },
            @as(mm.Word, @bitCast(@as(c_int, 10))) => break,
            @as(mm.Word, @bitCast(@as(c_int, 11))) => {
                mppex_PatternLoop(param, layer);
                break;
            },
            @as(mm.Word, @bitCast(@as(c_int, 12))) => {
                mppex_NoteCut(param, channel, layer);
                break;
            },
            @as(mm.Word, @bitCast(@as(c_int, 13))) => {
                mppex_NoteDelay(param, layer);
                break;
            },
            @as(mm.Word, @bitCast(@as(c_int, 14))) => {
                mppex_PatternDelay(param, layer);
                break;
            },
            @as(mm.Word, @bitCast(@as(c_int, 15))) => {
                mppex_SongMessage(param, layer);
                break;
            },
            else => break,
        }
        break;
    }
}
pub fn mppe_SetVolume(param: mm.Word, channel: [*c]mm.ModuleChannel, layer: [*c]mm.LayerInfo) void {
    if (@as(c_int, @bitCast(@as(c_uint, layer.*.tick))) == @as(c_int, 0)) {
        channel.*.volume = @as(mm.Byte, @bitCast(@as(u8, @truncate(param))));
    }
}
pub fn mppe_KeyOff(param: mm.Word, act_ch: ?[*c]mm.ActiveChannel, layer: [*c]mm.LayerInfo) void {
    if (@as(mm.Word, @bitCast(@as(c_uint, layer.*.tick))) != param) return;
    if (act_ch != null) {
        act_ch.?.*.flags &= @as(mm.Byte, @bitCast(@as(i8, @truncate(~(@as(c_int, 1) << @intCast(0))))));
    }
}
pub fn mppe_OldTremor(param: mm.Word, channel: [*c]mm.ModuleChannel, layer: [*c]mm.LayerInfo) void {
    if (@as(c_int, @bitCast(@as(c_uint, layer.*.tick))) == @as(c_int, 0)) return;
    const mem: c_int = @as(c_int, @bitCast(@as(c_uint, channel.*.fxmem)));
    if (mem == @as(c_int, 0)) {
        channel.*.fxmem = @as(mm.Byte, @bitCast(@as(i8, @truncate(mem - @as(c_int, 1)))));
    } else {
        channel.*.bflags ^= @as(mm.Hword, @bitCast(@as(c_short, @truncate((@as(c_int, 1) << @intCast(9)) | (@as(c_int, 1) << @intCast(10))))));
        if ((@as(c_int, @bitCast(@as(c_uint, channel.*.bflags))) & (@as(c_int, 1) << @intCast(10))) != 0) {
            channel.*.fxmem = @as(mm.Byte, @bitCast(@as(u8, @truncate((param >> @intCast(4)) +% @as(mm.Word, @bitCast(@as(c_int, 1)))))));
        } else {
            channel.*.fxmem = @as(mm.Byte, @bitCast(@as(u8, @truncate((param & @as(mm.Word, @bitCast(@as(c_int, 15)))) +% @as(mm.Word, @bitCast(@as(c_int, 1)))))));
        }
    }
    if ((@as(c_int, @bitCast(@as(c_uint, channel.*.bflags))) & (@as(c_int, 1) << @intCast(10))) == @as(c_int, 0)) {
        mpp_vars.volplus = @as(mm.Sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 64)))));
    }
}
pub fn mpph_ProcessEnvelope(count_: [*c]mm.Hword, node_: [*c]mm.Byte, envelope: [*c]Envelope, act_ch: [*c]mm.ActiveChannel, value_mul_64: [*c]mm.Word) mm.Word {
    var count: mm.Hword = count_.*;
    var node: mm.Byte = node_.*;

    const nodes_bytes: [*]const u8 = @as([*]const u8, @ptrCast(@alignCast(envelope))) + @sizeOf(Envelope);
    const stride: usize = 4;
    const node_offset: usize = stride * @as(usize, @intCast(node));
    const node_bytes: [*]const u8 = nodes_bytes + node_offset;

    const delta_raw: i16 = std.mem.readInt(i16, node_bytes[0..2], .little);
    const base_range_raw: u16 = std.mem.readInt(u16, node_bytes[2..4], .little);
    const node_base: mm.Hword = @as(mm.Hword, @intCast(base_range_raw & 0x7F));
    const node_range: mm.Hword = @as(mm.Hword, @intCast((base_range_raw >> 7) & 0x1FF));

    value_mul_64.* = @as(mm.Word, @intCast(@as(i32, @intCast(node_base)) * 64));

    if (count == 0) {
        if (node == envelope.*.loop_end) {
            count_.* = count;
            node_.* = envelope.*.loop_start;
            return 2;
        }
        if ((act_ch.*.flags & @as(mm.Byte, @intCast(MCAF_KEYON))) != 0) {
            if (node == envelope.*.sus_end) {
                count_.* = count;
                node_.* = envelope.*.sus_start;
                return 0;
            }
        }
        const last_node: mm.Hword = if (envelope.*.node_count == 0) 0 else @as(mm.Hword, @intCast(envelope.*.node_count - 1));
        if (node == last_node) {
            count_.* = count;
            node_.* = node;
            return 2;
        }
    } else {
        const interp: i32 = (@as(i32, delta_raw) * @as(i32, @intCast(count))) >> 3;
        const current: i32 = @as(i32, @intCast(value_mul_64.*));
        value_mul_64.* = @as(mm.Word, @intCast(current + interp));
    }

    count +%= 1;
    if (node_range != 0 and count == node_range) {
        count = 0;
        node = @as(mm.Byte, @intCast((@as(usize, node) + 1) & 0xFF));
    }

    count_.* = count;
    node_.* = node;
    return 2;
}

pub fn mpp_Update_ACHN_notest_envelopes(layer: [*c]mm.LayerInfo, act_ch: [*c]mm.ActiveChannel, period: mm.Word) mm.Word {
    const instrument: *Instrument = instrumentPointer(layer, @as(mm.Word, @intCast(act_ch.*.inst))) orelse return period;
    // Instrument envelopes and note map data are stored immediately after the
    // fixed-size instrument header in the MAS blob. The translate-c struct
    // does not expose the trailing union, so compute the pointer manually.
    const INSTR_HDR_SIZE: usize = 12;
    var env_ptr: [*]mm.Byte = @as([*]mm.Byte, @ptrCast(@alignCast(instrument))) + INSTR_HDR_SIZE;

    var vol_env_active = false;
    if ((@as(c_int, @intCast(instrument.*.env_flags)) & MAS_INSTR_FLAG_VOL_ENV_EXISTS) != 0) {
        var value_mul_64: mm.Word = 0;
        const env: *Envelope = @ptrCast(@alignCast(env_ptr));
        env_ptr += env_ptr[0];
        if ((act_ch.*.flags & @as(mm.Byte, @intCast(MCAF_VOLENV))) != 0) {
            vol_env_active = true;
            const exit_value = mpph_ProcessEnvelope(&act_ch.*.envc_vol, &act_ch.*.envn_vol, env, act_ch, &value_mul_64);
            if (layer.*.tick != 0) {
                if (exit_value == @as(mm.Word, @intCast(1))) {
                    if ((@as(c_int, @intCast(layer.*.flags)) & MAS_HEADER_FLAG_XM_MODE) != 0) {
                        act_ch.*.flags |= @as(mm.Byte, @intCast(MCAF_ENVEND));
                    } else {
                        act_ch.*.flags |= @as(mm.Byte, @intCast(MCAF_ENVEND | MCAF_FADE));
                    }
                } else if (exit_value == @as(mm.Word, @intCast(2))) {
                    if ((@as(c_int, @intCast(act_ch.*.flags)) & MCAF_KEYON) == 0) {
                        act_ch.*.flags |= @as(mm.Byte, @intCast(MCAF_FADE));
                    }
                }
            }
            const afv: mm.Sword = @as(mm.Sword, @intCast(mpp_vars.afvol));
            mpp_vars.afvol = @as(mm.Byte, @intCast((@as(c_int, @intCast(afv)) * @as(c_int, @intCast(value_mul_64))) >> (6 + 6)));
        }
    }

    if (!vol_env_active and (act_ch.*.flags & @as(mm.Byte, @intCast(MCAF_KEYON))) == 0) {
        act_ch.*.flags |= @as(mm.Byte, @intCast(MCAF_FADE | MCAF_ENVEND));
        if ((@as(c_int, @intCast(layer.*.flags)) & MAS_HEADER_FLAG_XM_MODE) != 0) {
            act_ch.*.fade = 0;
        }
    }

    if ((@as(c_int, @intCast(instrument.*.env_flags)) & MAS_INSTR_FLAG_PAN_ENV_EXISTS) != 0) {
        var value_mul_64_pan: mm.Word = 0;
        const env_pan: *Envelope = @ptrCast(@alignCast(env_ptr));
        env_ptr += env_ptr[0];
        _ = mpph_ProcessEnvelope(&act_ch.*.envc_pan, &act_ch.*.envn_pan, env_pan, act_ch, &value_mul_64_pan);
        mpp_vars.panplus += @as(mm.Hword, @intCast((@as(c_int, @intCast(value_mul_64_pan)) >> 4) - 128));
    }

    var per = period;

    if ((@as(c_int, @intCast(instrument.*.env_flags)) & MAS_INSTR_FLAG_PITCH_ENV_EXISTS) != 0) {
        var value_mul_64_pic: mm.Word = 0;
        const env_pic: *Envelope = @ptrCast(@alignCast(env_ptr));
        if (env_pic.*.is_filter == 0) {
            _ = mpph_ProcessEnvelope(&act_ch.*.envc_pic, &act_ch.*.envn_pic, env_pic, act_ch, &value_mul_64_pic);
            const value: mm.Sword = @as(mm.Sword, @intCast((@as(c_int, @intCast(value_mul_64_pic)) >> 3) - 256));
            if (value < 0) {
                per = mpph_LinearPitchSlide_Down(per, @as(mm.Word, @intCast(-value)), layer);
            } else {
                per = mpph_LinearPitchSlide_Up(per, @as(mm.Word, @intCast(value)), layer);
            }
        }
    }

    if ((@as(c_int, @intCast(act_ch.*.flags)) & MCAF_FADE) != 0) {
        var value: mm.Sword = @as(mm.Sword, @intCast(act_ch.*.fade)) - @as(mm.Sword, @intCast(instrument.*.fadeout));
        if (value < 0) value = 0;
        act_ch.*.fade = @as(mm.Hword, @intCast(value));
    }

    return period;
}
pub fn mpp_Update_ACHN_notest_auto_vibrato(layer: [*c]mm.LayerInfo, act_ch: [*c]mm.ActiveChannel, period: mm.Word) mm.Word {
    var per = period;
    const sample: [*c]SampleInfo = mpp_SamplePointer(layer, @as(mm.Word, @bitCast(@as(c_uint, act_ch.*.sample))));
    const av_rate: mm.Hword = sample.*.av_rate;
    if (@as(c_int, @bitCast(@as(c_uint, av_rate))) != @as(c_int, 0)) {
        var new_rate: mm.Word = @as(mm.Word, @bitCast(@as(c_int, @bitCast(@as(c_uint, act_ch.*.avib_dep))) + @as(c_int, @bitCast(@as(c_uint, av_rate)))));
        _ = &new_rate;
        if (new_rate > @as(mm.Word, @bitCast(@as(c_int, 32768)))) {
            new_rate = @as(mm.Word, @bitCast(@as(c_int, 32768)));
        }
        act_ch.*.avib_dep = @as(mm.Hword, @bitCast(@as(c_ushort, @truncate(new_rate))));
        const new_depth: mm.Sword = @as(mm.Sword, @bitCast(@as(mm.Word, @bitCast(@as(c_uint, sample.*.av_depth))) *% new_rate));
        act_ch.*.avib_pos = @as(mm.Hword, @bitCast(@as(c_short, @truncate((@as(c_int, @bitCast(@as(c_uint, act_ch.*.avib_pos))) + @as(c_int, @bitCast(@as(c_uint, sample.*.av_speed)))) & @as(c_int, 255)))));
        var slide_val: mm.Sword = @as(mm.Sword, @bitCast(@as(c_int, tables.mpp_TABLE_FineSineData[act_ch.*.avib_pos])));
        slide_val = (slide_val * new_depth) >> @intCast(23);
        if (slide_val >= @as(c_int, 0)) {
            per = mpph_PitchSlide_Up(period, @as(mm.Word, @bitCast(slide_val)), layer);
        } else {
            per = mpph_PitchSlide_Down(period, @as(mm.Word, @bitCast(-slide_val)), layer);
        }
    }
    return per;
}

pub fn mpp_Update_ACHN_notest_update_mix(layer: [*c]mm.LayerInfo, act_ch: [*c]mm.ActiveChannel, channel: mm.Word) [*c]volatile mm.MixerChannel {
    const mix_ch: [*c]volatile mm.MixerChannel = &mixer.mm_mix_channels[@as(usize, @intCast(channel))];
    const sample_idx_entry: u8 = @as(u8, @intCast(act_ch.*.sample));
    var dbg_msl_id: u16 = 0;
    var dbg_sample_offset: u32 = 0;
    const ch_idx: usize = @as(usize, @intCast(channel));
    if (debug_enabled and channel == 0) {
        const flags_entry: u8 = act_ch.*.flags;
        const start_entry = (flags_entry & @as(u8, @intCast(MCAF_START))) != 0;
        shim.umixUpdateCapture(
            .entry,
            0,
            @as(u8, @intCast(layer.*.tick)),
            flags_entry,
            start_entry,
            sample_idx_entry,
            dbg_msl_id,
            dbg_sample_offset,
            @as(u32, @intCast(mix_ch.*.src)),
            @as(u32, @intCast(mix_ch.*.read)),
            @as(u8, @intCast(mix_ch.*.vol)),
        );
    }
    // UMIX trace: snapshot before possible (re)bind — capture only
    if (umixAllowLogCh(layer, @as(c_int, @intCast(channel))))
        capture.capture(
            layer,
            capture.Kind.UmixSnap,
            @as(i32, @intCast(channel)),
            @as(i32, @intCast(act_ch.*.flags)),
            @as(i32, @intCast(act_ch.*.sample)),
            @as(i32, @intCast(mix_ch.*.read)),
            @as(u32, @intCast(mix_ch.*.src)),
        );
    var should_umix_log: bool = false; // detailed log only for early channels

    var umix_len_for_log: u32 = 0;
    var umix_loop_for_log: u32 = 0;
    var did_bind: bool = false;
    if ((@as(c_int, @intCast(act_ch.*.flags)) & MCAF_START) != 0) {
        // Mirror C: clear START immediately on entering start path
        act_ch.*.flags = @as(mm.Byte, @intCast(@as(c_int, @intCast(act_ch.*.flags)) & ~MCAF_START));
        if (ch_idx < mm_gba.mix_stop_pending.len) {
            mm_gba.mix_stop_pending[ch_idx] = false;
        }
        // must have a valid sample
        if (act_ch.*.sample != 0) {
            const sample: [*c]SampleInfo = mpp_SamplePointer(layer, @as(mm.Word, @intCast(act_ch.*.sample)));
            dbg_msl_id = @as(u16, @intCast(sample.*.msl_id));
            // Compute MAS GBA header address without relying on aligned struct loads
            var hdr_addr: usize = 0;
            if (@as(c_uint, @intCast(sample.*.msl_id)) == 0xFFFF) {
                // Embedded sample in module: header starts at sample->data
                hdr_addr = @as(usize, @intCast(@intFromPtr(sample.*.data())));
            } else {
                // External sample in bank: mp_solution base + sampleTable[msl_id] + MAS prefix
                const samp_tbl_words: [*]const mm.Word = mm_gba.getSampleTable();
                const samp_tbl_bytes: [*]const u8 = @ptrCast(samp_tbl_words);
                const idx: usize = @as(usize, @intCast(sample.*.msl_id));
                const p: [*]const u8 = samp_tbl_bytes + (idx * 4);
                const off: usize = @as(usize, @intCast(std.mem.readInt(u32, p[0..4], .little)));
                if (debug_enabled and ch_idx < 3 and mm_gba.layer_p.*.tick == 0) {
                    debugPrint("[BINDDBG] bank=0x{x} off=0x{x} prefix={d}\n", .{ @as(usize, @intCast(@intFromPtr(mm_gba.bank_base))), off, @sizeOf(Prefix) });
                }
                dbg_sample_offset = @as(u32, @intCast(off));
                hdr_addr = (@as(usize, @intCast(@intFromPtr(mm_gba.bank_base))) + off) + @sizeOf(Prefix);
            }
            const hb: [*]const u8 = @ptrFromInt(hdr_addr);
            // Read header fields as little-endian to avoid unaligned word loads
            const len_le: u32 = @as(u32, hb[0]) | (@as(u32, hb[1]) << 8) | (@as(u32, hb[2]) << 16) | (@as(u32, hb[3]) << 24);
            const loop_le: u32 = @as(u32, hb[4]) | (@as(u32, hb[5]) << 8) | (@as(u32, hb[6]) << 16) | (@as(u32, hb[7]) << 24);
            umix_len_for_log = len_le;
            umix_loop_for_log = loop_le;
            // const fmt_b: u8 = hb[8]; // HDR debug disabled in capture path
            const def_le: u16 = @as(u16, hb[10]) | (@as(u16, hb[11]) << 8);
            // initialize read pointer and source to header+12
            mix_ch.*.src = @as(mm.Word, @intCast(hdr_addr + 12));
           if (debug_enabled and ch_idx < 3 and mm_gba.layer_p.*.tick == 0) {
                debugPrint(
                    "[BINDDBG] hdr=0x{x} src=0x{x} len=0x{x} loop=0x{x}\n",
                    .{ hdr_addr, mix_ch.*.src, len_le, loop_le },
                );
            }
            did_bind = true;
            // Gate BIND/HDR like C (only on bind and only early channels/first tick)
            should_umix_log = (mm_gba.layer_p.*.tick == 0 and channel < 2);
            // Always capture a Bind event (buffered, printed post-tick)
            capture.capture(
                layer,
                capture.Kind.Bind,
                @as(i32, @intCast(channel)),
                @as(i32, @intCast(sample.*.msl_id)),
                @as(i32, @intCast(mix_ch.*.src)),
                @as(i32, @intCast(def_le)),
                len_le,
            );
            // initialize read pointer
            mix_ch.*.read = @as(mm.Word, @intCast(@as(u32, mpp_vars.sampoff))) << (MP_SAMPFRAC + 8);
            if (debug_enabled and channel == 0) {
                debugPrint(
                    "[BIND] row={d} tick={d} sampoff={d} src=0x{x} read=0x{x}\n",
                    .{
                        @as(c_int, @intCast(layer.*.row)),
                        @as(c_int, @intCast(layer.*.tick)),
                        @as(u32, @intCast(mpp_vars.sampoff)),
                        @as(usize, mix_ch.*.src),
                        @as(u32, @intCast(mix_ch.*.read)),
                    },
                );
            }
        }
    }

    if (did_bind and should_umix_log) {
        const umix_idx_for_log: u32 = @as(u32, @intCast(mix_ch.*.read)) >> @intCast(MP_SAMPFRAC + 8);
        // Reuse UmixSnap for the post-bind snapshot
        capture.capture(
            layer,
            capture.Kind.UmixSnap,
            @as(i32, @intCast(channel)),
            @as(i32, @intCast(act_ch.*.flags)),
            @as(i32, @intCast(act_ch.*.sample)),
            @as(i32, @intCast(umix_idx_for_log)),
            @as(u32, @intCast(mix_ch.*.src)),
        );
    }
    if (debug_enabled and channel == 0) {
        const flags_exit: u8 = act_ch.*.flags;
        const start_exit = (flags_exit & @as(u8, @intCast(MCAF_START))) != 0;
        shim.umixUpdateCapture(
            .exit,
            0,
            @as(u8, @intCast(layer.*.tick)),
            flags_exit,
            start_exit,
            sample_idx_entry,
            dbg_msl_id,
            dbg_sample_offset,
            @as(u32, @intCast(mix_ch.*.src)),
            @as(u32, @intCast(mix_ch.*.read)),
            @as(u8, @intCast(mix_ch.*.vol)),
        );
    }
    return mix_ch;
}
pub fn mpp_Update_ACHN_notest_set_pitch_volume(layer: [*c]mm.LayerInfo, act_ch: [*c]mm.ActiveChannel, period: mm.Word, mix_ch: [*c]volatile mm.MixerChannel) mm.Word {
    if (@as(c_int, @bitCast(@as(c_uint, act_ch.*.sample))) == @as(c_int, 0)) {
        act_ch.*.fvol = 0;
        return 0;
    }
    var sample: [*c]SampleInfo = mpp_SamplePointer(layer, @as(mm.Word, @bitCast(@as(c_uint, act_ch.*.sample))));
    _ = &sample;
    // Match C translate path exactly: compute value based on mode
    var log_freq: mm.Word = 0;
    if ((@as(c_int, @bitCast(@as(c_uint, layer.*.flags))) & (@as(c_int, 1) << @intCast(2))) != 0) {
        // XM mode
        // Use sample->frequency as C5 speed (C reference), read as LE bytes to avoid struct packing drift
        const sample_bytes: [*]const u8 = @ptrCast(sample);
        const c5speed: u16 = @as(u16, sample_bytes[2]) | (@as(u16, sample_bytes[3]) << 8);
        var value: mm.Word = (((period >> @intCast(8)) *% (@as(mm.Word, @intCast(@as(u32, c5speed))) << @intCast(2))) >> @intCast(8));
        if (mpp_clayer == .main) {
            value = (value *% mm_masterpitch) >> @intCast(10);
        }
        // Store scaled mixer rate like C: (scale * value) >> 16
        const scale_xm: mm.Word = @as(mm.Word, @bitCast(@divTrunc(@as(c_int, 4096) * @as(c_int, 65536), @as(c_int, 15768))));
        const rate_xm: mm.Word = (scale_xm *% value) >> @intCast(16);
        mix_ch.*.freq = rate_xm;
        log_freq = value; // For logging, use unscaled value to match C
        // Instrument ch2 early rows to verify rate path
        // No extra RATEZ in C reference
        // Defer logging until after fvol is computed
    } else {
        if (period != @as(mm.Word, @bitCast(@as(c_int, 0)))) {
            var value: mm.Word = @as(mm.Word, @bitCast(@as(c_int, 56750314))) / period;
            if (mpp_clayer == .main) {
                value = (value *% mm_masterpitch) >> @intCast(10);
            }
            const scale: mm.Word = @as(mm.Word, @bitCast(@divTrunc(@as(c_int, 4096) * @as(c_int, 65536), @as(c_int, 15768))));
            const rate_out: mm.Word = (scale *% value) >> @intCast(16);
            mix_ch.*.freq = rate_out;
            log_freq = value;
            // Defer logging until after fvol is computed
        }
    }
    if (@as(c_int, @bitCast(@as(c_uint, act_ch.*.inst))) == @as(c_int, 0)) {
        act_ch.*.fvol = 0;
        return 0;
    }
    var inst: ?*Instrument = instrumentPointer(layer, @as(mm.Word, @bitCast(@as(c_uint, act_ch.*.inst))));
    _ = &inst;
    if (inst == null) {
        act_ch.*.fvol = 0;
        return 0;
    }
    // Omit SAMP dump for parity with C
    var vol: mm.Word = @as(mm.Word, @bitCast(@as(c_uint, sample.*.global_volume))); // SV
    _ = &vol;
    const iv: mm.Word = @as(mm.Word, @bitCast(@as(c_uint, (inst.?).*.global_volume))); // IV
    const afv: mm.Word = @as(mm.Word, @bitCast(@as(c_uint, mpp_vars.afvol))); // AFVOL
    const gv_pre: mm.Word = @as(mm.Word, @bitCast(@as(c_uint, layer.*.global_volume))); // GV
    const xm_mode: c_int = (@as(c_int, @bitCast(@as(c_uint, layer.*.flags))) & (@as(c_int, 1) << @intCast(3)));
    vol *%= iv;
    vol *%= afv;
    var global_volume: mm.Word = gv_pre;
    _ = &global_volume;
    if (xm_mode != 0) {
        global_volume <<= @intCast(@as(c_int, 1));
    }
    // no VOLDBG: skip retaining this intermediate explicitly
    vol = (vol *% global_volume) >> @intCast(10);
    const fade_word: mm.Word = @as(mm.Word, @bitCast(@as(c_uint, act_ch.*.fade)));
    // no VOLDBG: skip retaining this intermediate explicitly
    vol = (vol *% fade_word) >> @intCast(10);
    const layer_vol: mm.Word = @as(mm.Word, @bitCast(@as(c_uint, layer.*.volume)));
    vol *%= layer_vol;
    // Debug the operands and intermediate volume for the first two mixer channels at tick 0
    {
        // No extra VOLDBG in C reference
    }
    const out: mm.Word = vol >> @intCast(19);
    var clipped: mm.Word = out;
    if (clipped > @as(mm.Word, @intCast(255))) clipped = 255;
    act_ch.*.fvol = @as(mm.Byte, @intCast(clipped));
    const mix_idx: c_int = @as(c_int, @intCast((@intFromPtr(mix_ch) - @intFromPtr(mixer.mm_mix_channels)) / @sizeOf(mm.MixerChannel)));
    if (debug_enabled) {
        var module_vol: u8 = 0;
        var module_cvol: u8 = 0;
        if (mm_gba.mpp_channels != @as([*c]mm.ModuleChannel, @ptrFromInt(0))) {
            const parent_idx: usize = @as(usize, @intCast(act_ch.*.parent));
            if (parent_idx < @as(usize, @intCast(mm_gba.mpp_nchannels))) {
                const module_channel_ptr: [*c]mm.ModuleChannel = &mm_gba.mpp_channels[parent_idx];
                module_vol = module_channel_ptr.*.volume;
                module_cvol = module_channel_ptr.*.cvolume;
            }
        }
        shim.volCapture(
            mix_idx,
            module_vol,
            module_cvol,
            @as(u8, @intCast(mpp_vars.afvol)),
            sample.*.default_volume,
            sample.*.global_volume,
            (inst.?).*.global_volume,
            layer.*.global_volume,
            xm_mode != 0,
            layer.*.volume,
            act_ch.*.fade,
            vol,
            @as(u16, @intCast(clipped)),
            act_ch.*.fvol,
        );
    }
    // Record SPV event for early channels to match C logging
    if (mix_idx >= 0 and (mix_idx == 0 or mix_idx == 1 or mix_idx == 2 or mix_idx == 9)) {
        shim.spvCapture(
            @as(u8, @intCast(mix_idx)),
            period,
            mix_ch.*.freq,
            act_ch.*.fvol,
            act_ch.*.inst,
            act_ch.*.sample,
            (layer.*.flags & MAS_HEADER_FLAG_XM_MODE) != 0,
        );
    }
    // Do not set mix_ch.vol here; the C path applies panning/disable logic before volume write
    return clipped;
}

pub fn mpp_Update_ACHN_notest_disable_and_panning(volume: mm.Word, act_ch: [*c]mm.ActiveChannel, mix_ch: [*c]volatile mm.MixerChannel) void {
    const mix_idx_entry: c_int = @as(c_int, @intCast((@intFromPtr(mix_ch) - @intFromPtr(mixer.mm_mix_channels)) / @sizeOf(mm.MixerChannel)));
    var stop_pending = false;
    if (mix_idx_entry >= 0 and @as(usize, @intCast(mix_idx_entry)) < mm_gba.mix_stop_pending.len) {
        if (mm_gba.mix_stop_pending[@as(usize, @intCast(mix_idx_entry))]) {
            stop_pending = true;
            mm_gba.mix_stop_pending[@as(usize, @intCast(mix_idx_entry))] = false;
        }
    }
    if (debug_enabled and mix_idx_entry == 0) {
        const row_dbg = mm_gba.layer_p.*.row;
        if (row_dbg >= 15 and row_dbg <= 30) {
            debugPrint(
                "[STOPDBG] row={d} tick={d} stop_pending={d} src=0x{x} flags=0x{x}\n",
                .{
                    @as(c_int, @intCast(row_dbg)),
                    @as(c_int, @intCast(mm_gba.layer_p.*.tick)),
                    @as(u8, if (stop_pending) 1 else 0),
                    @as(usize, mix_ch.*.src),
                    @as(u8, act_ch.*.flags),
                },
            );
        }
    }
    if (panchk_log_enabled and debug_enabled and mix_idx_entry == 0) {
        const keyon_dbg: u8 = if ((act_ch.*.flags & @as(mm.Byte, @intCast(MCAF_KEYON))) != 0) @as(u8, 1) else @as(u8, 0);
        const envend_dbg: u8 = if ((act_ch.*.flags & @as(mm.Byte, @intCast(MCAF_ENVEND))) != 0) @as(u8, 1) else @as(u8, 0);
        debugPrint(
            "[PANCHK] stage=entry vol={d} flags=0x{x} src=0x{x} type={d} keyon={d} envend={d}\n",
            .{
                @as(u32, @intCast(volume)),
                @as(u8, act_ch.*.flags),
                @as(usize, mix_ch.*.src),
                @as(u8, act_ch.*._type),
                keyon_dbg,
                envend_dbg,
            },
        );
    }
    if (volume == 0) {
        const env_end = (act_ch.*.flags & @as(mm.Byte, @intCast(MCAF_ENVEND))) != 0;
        const key_on = (act_ch.*.flags & @as(mm.Byte, @intCast(MCAF_KEYON))) != 0;
        if (env_end and !key_on) {
            mix_ch.*.src = shim.MIXCH_GBA_SRC_STOPPED;
            if (act_ch.*._type == ACHN_FOREGROUND) {
                const parent_idx: usize = @as(usize, @intCast(act_ch.*.parent));
                if (parent_idx < @as(usize, @intCast(mm_gba.mpp_nchannels))) {
                    const parent_mod: [*c]mm.ModuleChannel = &mm_gba.mpp_channels[parent_idx];
                    parent_mod.*.alloc = NO_CHANNEL_AVAILABLE;
                    parent_mod.*.flags &= @as(mm.Byte, @truncate(~@as(mm.Word, @intCast(MF_START | MF_NEWINSTR))));
                }
            }
            act_ch.*._type = ACHN_DISABLED;
            const mix_idx0: c_int = @as(c_int, @intCast((@intFromPtr(mix_ch) - @intFromPtr(mixer.mm_mix_channels)) / @sizeOf(mm.MixerChannel)));
        if (panchk_log_enabled and debug_enabled and mix_idx_entry == 0) {
            debugPrint(
                "[PANCHK] stage=envzero vol={d} flags=0x{x} src=0x{x} type={d}\n",
                .{
                    @as(u32, @intCast(volume)),
                    @as(u8, act_ch.*.flags),
                        @as(usize, mix_ch.*.src),
                        @as(u8, act_ch.*._type),
                    },
                );
            }
            if (mix_idx0 >= 0 and (mix_idx0 == 0 or mix_idx0 == 1 or mix_idx0 == 2 or mix_idx0 == 9))
                shim.dapCapture(@as(u8, @intCast(mix_idx0)), @as(u8, 0), act_ch.*.panning, mix_ch.*.src, act_ch.*._type);
            return;
        }
    }

    // C writes the raw mm_word into the 8-bit channel volume slot, truncating to 0..255.
    mix_ch.*.vol = @as(mm.Byte, @truncate(volume));

    // Extra safeguard (debug-only): mirror mixer end-of-sample stop when source
    // has no loop and the read cursor has reached or exceeded the sample
    // length. The C mixer (mmMixerMix) sets the STOP sentinel in mix_ch->src.
    // If for any reason the assembler routine hasn't flipped the bit by the
    // time we process channel state, replicate the same behavior so higher-
    // level logic observes a stopped channel at the same frame.
    if ((mix_ch.*.src & shim.MIXCH_GBA_SRC_STOPPED) == 0) {
        // Compute header address (12 bytes before data pointer)
        const src_addr: usize = @as(usize, @intCast(mix_ch.*.src));
        if (src_addr >= 12) {
            const hdr: [*]const u8 = @ptrFromInt(src_addr - 12);
            const len_le: u32 = std.mem.readInt(u32, hdr[0..4], .little);
            const loop_le: u32 = std.mem.readInt(u32, hdr[4..8], .little);
            const read_q12: u32 = @as(u32, @intCast(mix_ch.*.read));
            const len_q12: u32 = len_le << @intCast(MP_SAMPFRAC);
            if (debug_enabled and mix_idx_entry == 0) {
                const row_dbg2 = mm_gba.layer_p.*.row;
                if (row_dbg2 >= 14 and row_dbg2 <= 18) {
                    debugPrint(
                        "[HDRCHK] row={d} tick={d} len=0x{x} loop=0x{x} read_q12=0x{x} src=0x{x}\n",
                        .{ @as(c_int, @intCast(row_dbg2)), @as(c_int, @intCast(mm_gba.layer_p.*.tick)), len_le, loop_le, read_q12, src_addr },
                    );
                }
            }
            // No-loop if MSB set in loop_length; STOP when read passes/equal length
            if (debug_enabled) {
                if (read_q12 >= len_q12 and (loop_le & 0x8000_0000) != 0) {
                    if (mix_idx_entry == 0) {
                        debugPrint(
                            "[STOPDBG] forced stop read_q12=0x{x} len_q12=0x{x} src=0x{x}\n",
                            .{ read_q12, len_q12, src_addr },
                        );
                    }
                    mix_ch.*.src = shim.MIXCH_GBA_SRC_STOPPED;
                }
            }
        }
    }

    if (stop_pending or (mix_ch.*.src & shim.MIXCH_GBA_SRC_STOPPED) != 0) {
        if (debug_enabled and mix_idx_entry == 0) {
            debugPrint(
                "[STOPDBG] stop branch stop_pending={d} src=0x{x}\n",
                .{ @as(u8, if (stop_pending) 1 else 0), @as(usize, mix_ch.*.src) },
            );
        }
        if (stop_pending and (mix_ch.*.src & shim.MIXCH_GBA_SRC_STOPPED) == 0) {
            mix_ch.*.src = shim.MIXCH_GBA_SRC_STOPPED;
        }
        if (act_ch.*._type == ACHN_FOREGROUND) {
            const parent_idx: usize = @as(usize, @intCast(act_ch.*.parent));
            if (parent_idx < @as(usize, @intCast(mm_gba.mpp_nchannels))) {
                const parent_mod: [*c]mm.ModuleChannel = &mm_gba.mpp_channels[parent_idx];
                parent_mod.*.alloc = NO_CHANNEL_AVAILABLE;
                parent_mod.*.flags &= @as(mm.Byte, @truncate(~@as(mm.Word, @intCast(MF_START | MF_NEWINSTR))));
            }
        }
        mix_ch.*.src = shim.MIXCH_GBA_SRC_STOPPED;
        act_ch.*._type = ACHN_DISABLED;
        if (panchk_log_enabled and debug_enabled and mix_idx_entry == 0) {
            debugPrint(
                "[PANCHK] stage=stopped vol={d} flags=0x{x} src=0x{x} type={d}\n",
                .{
                    @as(u32, @intCast(volume)),
                    @as(u8, act_ch.*.flags),
                    @as(usize, mix_ch.*.src),
                    @as(u8, act_ch.*._type),
                },
            );
        }
        return;
    }

    const panplus: mm.Shword = @as(mm.Shword, @bitCast(mpp_vars.panplus));
    const old_panning: mm.Word = act_ch.*.panning;
    var newpan: c_int = @as(c_int, @intCast(old_panning)) + @as(c_int, @intCast(panplus));
    if (newpan < 0) newpan = 0 else if (newpan > 255) newpan = 255;
    mix_ch.*.pan = @as(mm.Byte, @intCast(newpan));

    const mix_idx1: c_int = @as(c_int, @intCast((@intFromPtr(mix_ch) - @intFromPtr(mixer.mm_mix_channels)) / @sizeOf(mm.MixerChannel)));
    if (mix_idx1 >= 0 and (mix_idx1 == 0 or mix_idx1 == 1 or mix_idx1 == 2 or mix_idx1 == 9))
        shim.dapCapture(@as(u8, @intCast(mix_idx1)), mix_ch.*.vol, mix_ch.*.pan, mix_ch.*.src, act_ch.*._type);
    if (panchk_log_enabled and debug_enabled and mix_idx_entry == 0) {
        debugPrint(
            "[PANCHK] stage=final vol={d} flags=0x{x} src=0x{x} pan={d} type={d}\n",
            .{
                @as(u32, @intCast(volume)),
                @as(u8, act_ch.*.flags),
                @as(usize, mix_ch.*.src),
                @as(u8, mix_ch.*.pan),
                @as(u8, act_ch.*._type),
            },
        );
    }
}

pub const MAS_HEADER_FLAG_XM_MODE = @as(c_int, 1) << @as(c_int, 3);
pub const MAS_INSTR_FLAG_VOL_ENV_EXISTS = @as(c_int, 1) << @as(c_int, 0);
pub const MAS_INSTR_FLAG_PAN_ENV_EXISTS = @as(c_int, 1) << @as(c_int, 1);
pub const MAS_INSTR_FLAG_PITCH_ENV_EXISTS = @as(c_int, 1) << @as(c_int, 2);
pub const MAS_INSTR_FLAG_VOL_ENV_ENABLED = @as(c_int, 1) << @as(c_int, 3);
pub const MF_START = @as(c_int, 1);
pub const MF_DVOL = @as(c_int, 2);
pub const MF_HASVCMD = @as(c_int, 4);
pub const GLISSANDO_EFFECT = 7;
pub const MF_HASFX = @as(c_int, 8);
pub const MF_NEWINSTR = 16;
pub const MF_NOTEOFF = @as(c_int, 64);
pub const MF_NOTECUT = @as(c_int, 128);
pub const MCH_BFLAGS_NNA_SHIFT = 6;
pub const MCH_BFLAGS_NNA_MASK = 3 << MCH_BFLAGS_NNA_SHIFT;
pub inline fn MCH_BFLAGS_NNA_GET(x: anytype) @TypeOf((x & MCH_BFLAGS_NNA_MASK) >> MCH_BFLAGS_NNA_SHIFT) {
    _ = &x;
    return (x & MCH_BFLAGS_NNA_MASK) >> MCH_BFLAGS_NNA_SHIFT;
}
pub const IT_NNA_CUT = @as(c_int, 0);
pub const IT_NNA_CONT = @as(c_int, 1);
pub const IT_NNA_OFF = @as(c_int, 2);
pub const IT_NNA_FADE = @as(c_int, 3);
pub const IT_DCA_CUT = @as(c_int, 0);
pub const IT_DCA_OFF = @as(c_int, 1);
pub const MCAF_KEYON = @as(c_int, 1) << @as(c_int, 0);
pub const MCAF_FADE = @as(c_int, 1) << @as(c_int, 1);
pub const MCAF_START = @as(c_int, 1) << @as(c_int, 2);
pub const MCAF_UPDATED = @as(c_int, 1) << @as(c_int, 3);
pub const MCAF_ENVEND = @as(c_int, 1) << @as(c_int, 4);
pub const MCAF_VOLENV = @as(c_int, 1) << @as(c_int, 5);
const MCAF_SUB = @as(c_int, 1) << @as(c_int, 6);
const MCAF_EFFECT = @as(c_int, 1) << @as(c_int, 7);
pub const ACHN_DISABLED = @as(c_int, 0);
pub const ACHN_BACKGROUND = @as(c_int, 2);
pub const ACHN_FOREGROUND = @as(c_int, 3);
pub const NO_CHANNEL_AVAILABLE = 255;
pub const MP_SAMPFRAC = @as(c_int, 12);
pub const GLISSANDO_IT_VOLCMD_START = 193;
pub const GLISSANDO_IT_VOLCMD_END = 202;
pub const GLISSANDO_MX_VOLCMD_START = 0xF0;

const Prefix = extern struct {
    size: mm.Word = 0,
    type: mm.Byte = 0,
    version: mm.Byte = 0,
    reserved: mm.Hword = 0,
};
