const std = @import("std");
const mm = @import("../maxmod.zig");
const sfx = @import("../core/effect.zig");
const shim = @import("../shim.zig");
const mas = @import("../core/mas.zig");
const mixer = @import("mixer.zig");

// Debug configuration - can be toggled at build time
const debug_enabled = @import("build_options").xm_debug;
const frame_log_enabled = false;
// Debug printing helper that can be compiled out
inline fn debugPrint(comptime fmt: []const u8, args: anytype) void {
    if (debug_enabled) {
        @import("gba").debug.print(fmt, args) catch {};
    }
}

pub export var mm_ch_mask: u32 = 0;
pub extern fn mmMixerMix(samples_count: mm.Word) void;
pub export var mm_mixlen: mm.Word = 0;

pub var layer_main: mm.LayerInfo = .{};
pub var layer_p: [*c]mm.LayerInfo = @ptrFromInt(0);
pub var mpp_channels: [*c]mm.ModuleChannel = @ptrFromInt(0);
pub var mpp_nchannels: mm.Byte = 0;
pub var achannels: [*c]mm.ActiveChannel = @ptrFromInt(0);
pub var pchannels: [*c]mm.ModuleChannel = @ptrFromInt(0);
pub var num_mch: mm.Word = 8;
pub var num_ach: mm.Word = 8;
pub var sample_count: u16 = 0;
pub var sample_table: [*]const u32 = undefined;
pub var bank_base: [*]const u8 = undefined;

var initialized: bool = false;
var module_count: u16 = 0;
var module_table: [*]const u32 = undefined;
var postmix_budget: u32 = 4;
var premix_budget: u32 = 8;
var mixbuffer: [@intFromEnum(MixLen._16khz) / @sizeOf(u32)]u32 = @import("std").mem.zeroes([@intFromEnum(MixLen._16khz) / @sizeOf(u32)]u32);
var mm_init_default_buffer: mm.Addr = @as(?*anyopaque, @ptrFromInt(0));
var mix_debug_budget: u32 = 100;
var stop_log_budget: u32 = 16;
inline fn debugLogMix(stage: []const u8, samples: c_int) void {
    if (!debug_enabled) return;
    if (mix_debug_budget == 0) return;
    mix_debug_budget -= 1;
    const values = [_]u32{
        mixbuffer[0], mixbuffer[1], mixbuffer[2], mixbuffer[3],
        mixbuffer[4], mixbuffer[5], mixbuffer[6], mixbuffer[7],
    };
    const code: u8 = if (stage.len > 0 and stage[0] == 'l') 'L' else 'F';
    shim.mixCapture(code, samples, values);
}

pub const GBASystem = struct {
    mixing_mode: MixMode = ._8khz,
    mod_channel_count: mm.Word = 0,
    mix_channel_count: mm.Word = 0,
    module_channels: mm.Addr = null,
    active_channels: mm.Addr = null,
    mixing_channels: mm.Addr = null,
    mixing_memory: mm.Addr = null,
    wave_memory: mm.Addr = null,
    soundbank: mm.Addr = null,
};

pub fn initDefault(soundbank: mm.Addr, number_of_channels: mm.Word) !void {
    shim.debug_state.soundbank_addr = @intFromPtr(soundbank);
    shim.debug_state.number_of_channels = number_of_channels;

    if (number_of_channels > 32) return error.InvalidNumberOfChannels;

    const size_of_channel: usize = (@sizeOf(mm.ModuleChannel) +% @sizeOf(mm.ActiveChannel)) +% @sizeOf(mm.MixerChannel);
    const size_of_buffer: usize = @intFromEnum(MixLen._16khz) +% (number_of_channels *% size_of_channel);

    const wave_memory = shim.calloc(1, size_of_buffer);
    // Split up buffer
    const module_offset: usize = @intFromEnum(MixLen._16khz);
    const active_offset: usize = module_offset +% (number_of_channels *% @sizeOf(mm.ModuleChannel));
    const mixing_offset: usize = active_offset +% (number_of_channels *% @sizeOf(mm.ActiveChannel));

    shim.debug_state.module_offset = module_offset;
    shim.debug_state.active_offset = active_offset;
    shim.debug_state.mixing_offset = mixing_offset;

    const module_channels = @as(mm.Addr, @ptrFromInt(@as(mm.Word, @intCast(@intFromPtr(wave_memory))) + module_offset));
    const active_channels: mm.Addr = @ptrFromInt(@as(mm.Word, @intCast(@intFromPtr(module_channels))) + active_offset);
    const mixing_channels: mm.Addr = @ptrFromInt(@as(mm.Word, @intCast(@intFromPtr(active_channels))) + mixing_offset);
    var setup: GBASystem = GBASystem{
        .mixing_mode = ._16khz,
        .mod_channel_count = number_of_channels,
        .mix_channel_count = number_of_channels,
        .module_channels = module_channels,
        .active_channels = active_channels,
        .mixing_channels = mixing_channels,
        .mixing_memory = @as(mm.Addr, @ptrCast(&mixbuffer[0])),
        .wave_memory = wave_memory,
        .soundbank = soundbank,
    };
    if (!init(&setup)) {
        return error.FailedToInitialize;
    }
}
pub fn init(setup: *GBASystem) bool {
    parseBankPointers(@ptrCast(@alignCast(setup.*.soundbank)));

    shim.debug_state.sample_count = sample_count;
    shim.debug_state.module_count = module_count;

    achannels = @as([*c]mm.ActiveChannel, @ptrCast(@alignCast(setup.*.active_channels)));
    pchannels = @as([*c]mm.ModuleChannel, @ptrCast(@alignCast(setup.*.module_channels)));
    num_mch = setup.*.mod_channel_count;
    num_ach = setup.*.mix_channel_count;
    shim.debug_state.mod_ch = num_mch;
    shim.debug_state.mix_ch = num_ach;
    if ((num_mch > 32 or (num_ach > 32))) return false;
    mixer.init(setup);
    // Unify mixer and core channel buffers: use mixer-owned channel array
    // const mix_ptr: [*c]mm.MixerChannel = mixer.mm_get_mix_channels_ptr();
    // if (mix_ptr != @as([*c]mm.MixerChannel, @ptrFromInt(0))) {
    //     mixer.mm_mix_channels = mix_ptr;
    // }
    // Avoid undefined shift when mm_num_ach == 32 on 32-bit types
    // Match C: mm_ch_mask = (1U << mm_num_ach) - 1; (32 -> 0xFFFF_FFFF)
    mm_ch_mask = if (num_ach >= 32) 0xFFFF_FFFF else ((@as(u32, 1) << @intCast(num_ach)) - 1);
    shim.debug_state.channel_mask = mm_ch_mask;
    // Propagate to the shared shim symbol (same global)
    // setChannelMask(mm_ch_mask);
    mas.mmSetModuleVolume(1024);
    mas.mmSetJingleVolume(1024);
    sfx.setEffectsVolume(1024);
    mas.mmSetModuleTempo(1024);
    mas.mmSetModulePitch(1024);
    sfx.resetEffects();
    initialized = true;
    return true;
}
inline fn recordStops() void {
    const count = @as(usize, @intCast(mixer.getCount()));
    var i: usize = 0;
    while (i < count) : (i += 1) {
        const src_val = mixer.mm_mix_channels[i].src;
        if ((src_val & shim.MIXCH_GBA_SRC_STOPPED) != 0) {
            mix_stop_pending[i] = true;
            if (debug_enabled and i == 0) {
                debugPrint("[STOPREC] src=0x{x}\n", .{src_val});
            }
        }
    }
}

pub fn end() bool {
    initialized = false;
    mixer.mmMixerEnd();
    if (mm_init_default_buffer != null) {
        mm_init_default_buffer = @as(?*anyopaque, @ptrFromInt(0));
    }
    return true;
}
var idx: usize = 0;
var get_rem: bool = true;
pub var mix_stop_pending: [32]bool = [_]bool{false} ** 32;
pub fn frame() void {
    if (!initialized) return;
    // Update effects and sublayer first to mirror C reference ordering
    sfx.updateEffects();
    mas.mppUpdateSub();

    mpp_channels = pchannels;
    mpp_nchannels = @as(mm.Byte, @truncate(num_mch));
    mas.mpp_clayer = .main;
    layer_p = &layer_main;
    if (layer_p.*.isplaying == 0) {
        // Main layer isn't active, mix full amount
        mmMixerMix(mm_mixlen);
        return;
    }
    var remaining_len: c_int = @intCast(mm_mixlen);
    while (true) {
        var sample_num: c_int = @as(c_int, @bitCast(@as(c_uint, layer_p.*.tickrate)));
        const sampcount: c_int = @as(c_int, @bitCast(@as(c_uint, layer_p.*.tick_data.sampcount)));
        sample_num -= sampcount;
        if (sample_num < 0) {
            sample_num = 0;
        }
        if (frame_log_enabled and debug_enabled) {
            debugPrint(
                "[FRAME] sample_num={d} remaining_len={d} sampcount={d}\n",
                .{ sample_num, remaining_len, @as(c_int, @intCast(layer_p.*.tick_data.sampcount)) },
            );
        }
        if (sample_num >= remaining_len) break;
        layer_p.*.tick_data.sampcount = 0;
        remaining_len -= sample_num;
        mmMixerMix(@intCast(sample_num));
        debugLogMix("loop", sample_num);
        if (debug_enabled and stop_log_budget > 0) {
            const src0 = mixer.mm_mix_channels[0].src;
            if ((src0 & shim.MIXCH_GBA_SRC_STOPPED) != 0) {
                stop_log_budget -= 1;
                debugPrint("[STOPCHK] stage=loop src=0x{x}\n", .{src0});
            }
        }
        mas.mppProcessTick();
    }
    if (get_rem) {
        shim.debug_state.remaining_lens[idx] = @intCast(remaining_len);
        idx += 1;
        if (idx == 4) get_rem = false;
    }
    layer_p.*.tick_data.sampcount +%= @intCast(remaining_len);
    shim.debug_state.tick_data_sampcount = @intCast(layer_p.*.tick_data.sampcount);
    if (frame_log_enabled and debug_enabled) {
        debugPrint(
            "[FRAME] remaining_len={d} sampcount={d}\n",
            .{ remaining_len, @as(c_int, @intCast(layer_p.*.tick_data.sampcount)) },
        );
    }
    mmMixerMix(@intCast(remaining_len));
    debugLogMix("final", @intCast(remaining_len));
    recordStops();
    if (debug_enabled and stop_log_budget > 0) {
        const src0 = mixer.mm_mix_channels[0].src;
        if ((src0 & shim.MIXCH_GBA_SRC_STOPPED) != 0) {
            stop_log_budget -= 1;
            debugPrint("[STOPCHK] stage=final src=0x{x}\n", .{src0});
        }
    }
}
pub fn getModuleTable() [*]const mm.Word {
    return @ptrCast(module_table);
}
pub fn getSampleTable() [*]const mm.Word {
    return @ptrCast(sample_table);
}
pub fn getSampleCount() mm.Word {
    return @intCast(sample_count);
}
pub fn getModuleCount() mm.Word {
    return @intCast(module_count);
}
// Explicit setter so other modules set the same global symbol
fn setChannelMask(mask: u32) void {
    mm_ch_mask = mask;
}
inline fn readLe16(p: [*]const u8) u16 {
    return std.mem.readInt(u16, p[0..2], .little);
}

inline fn readLe32(p: [*]const u8) u32 {
    return std.mem.readInt(u32, p[0..4], .little);
}
fn parseBankPointers(base: [*]const u8) void {
    bank_base = base;

    // Parse MSL header structure as defined in mm_msl.h
    const msl_head_data = @as(*const MSLHeadData, @ptrCast(@alignCast(base)));

    sample_count = msl_head_data.sample_count;
    module_count = msl_head_data.module_count;

    // Head data is 12 bytes: 2 u16 + 2 u32 reserved
    const head_size: usize = @sizeOf(MSLHeadData);

    // Sample table starts immediately after head data
    sample_table = @ptrCast(@alignCast(base + head_size));

    // Module table starts after sample table (sample_count entries)
    module_table = sample_table + @as(usize, sample_count);
}

// MSL head data (exactly like C): 2x u16, then 4-byte padding to align tables
const MSLHeadData = extern struct {
    sample_count: mm.Hword = 0, // u16
    module_count: mm.Hword = 0, // u16
    pad: [2]mm.Word = @import("std").mem.zeroes([2]mm.Word),
};
const MSLHead = struct {
    head_data: MSLHeadData align(4) = @import("std").mem.zeroes(MSLHeadData),
    // Immediately followed by two u32 tables: samples then modules
    sample_table: []mm.Addr,
    // pub fn sampleTable(self: *const @This()) [*]const u32 {
    //     const base: [*]const u8 = @ptrCast(@alignCast(self));
    //     // sizeof(MSLHeadData) == 8; tables start at offset 8, 4-byte aligned
    //     return @as([*]const u32, @ptrCast(@alignCast(base + 8)));
    // }
};

const MixLen = enum(u16) {
    _8khz = 544,
    _10khz = 704,
    _13khz = 896,
    _16khz = 1056,
    _18khz = 1216,
    _21khz = 1408,
    _27khz = 1792,
    _31khz = 2112,
};

const MixMode = enum(c_uint) {
    _8khz,
    _10khz,
    _13khz,
    _16khz,
    _18khz,
    _21khz,
    _27khz,
    _31khz,
};
