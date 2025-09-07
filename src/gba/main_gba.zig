const mm = @import("../maxmod.zig");
const sfx = @import("../core/effect.zig");
const shim = @import("../shim.zig");
const mas = @import("../core/mas.zig");
const mixer = @import("mixer.zig");

// Debug configuration - can be toggled at build time
const debug_enabled = @import("build_options").xm_debug;
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
pub var mp_solution: [*c]MSLHead = @import("std").mem.zeroes([*c]MSLHead);

var initialized: bool = false;
// Raw-parsed bank pointers to avoid struct/align drift
var bank_base: [*]const u8 = undefined;
var head_off: usize = 0;
var sample_count: u16 = 0;
var module_count: u16 = 0;
var sample_table: [*]const u32 = undefined;
var module_table: [*]const u32 = undefined;
var postmix_budget: u32 = 4;
var premix_budget: u32 = 8;
var mixbuffer: [264]u32 = @import("std").mem.zeroes([264]u32);
var mm_init_default_buffer: mm.Addr = @as(?*anyopaque, @ptrFromInt(0));

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
    debugPrint("[initDefault] soundbank=0x{x} nch={d}\n", .{ @intFromPtr(soundbank), number_of_channels });

    if (number_of_channels > 32) return error.InvalidNumberOfChannels;

    const size_of_channel: usize = (@sizeOf(mm.ModuleChannel) +% @sizeOf(mm.ActiveChannel)) +% @sizeOf(mm.MixerChannel);
    const size_of_buffer: usize = @intFromEnum(MixLen._16khz) +% (number_of_channels *% size_of_channel);
    const wave_memory = shim.calloc(1, size_of_buffer);
    const module_channels = @as(mm.Addr, @ptrFromInt(@as(mm.Word, @intCast(@intFromPtr(wave_memory))) +% @intFromEnum(MixLen._16khz)));
    const active_channels: mm.Addr = @ptrFromInt(@as(mm.Word, @intCast(@intFromPtr(module_channels))) +% (number_of_channels *% @sizeOf(mm.ModuleChannel)));
    const mixing_channels: mm.Addr = @ptrFromInt(@as(mm.Word, @intCast(@intFromPtr(active_channels))) +% (number_of_channels *% @sizeOf(mm.ActiveChannel)));
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
        debugPrint("[initDefault] init failed\n", .{});
        return error.FailedToInitialize;
    }
    debugPrint("[initDefault] done mm_mixlen={d}\n", .{mm_mixlen});
}
pub fn init(setup: *GBASystem) bool {
    bank_base = @ptrCast(@alignCast(setup.*.soundbank));
    parseBankPointers(bank_base);
    // Match C: mp_solution points to the start of the soundbank (including MAS prefix)
    mp_solution = @constCast(@ptrCast(@alignCast(bank_base)));
    debugPrint("[init] mp_solution=0x{x} sampleCount={d} moduleCount={d}\n", .{ @intFromPtr(mp_solution), @as(c_int, @intCast(sample_count)), @as(c_int, @intCast(module_count)) });
    achannels = @as([*c]mm.ActiveChannel, @ptrCast(@alignCast(setup.*.active_channels)));
    pchannels = @as([*c]mm.ModuleChannel, @ptrCast(@alignCast(setup.*.module_channels)));
    num_mch = setup.*.mod_channel_count;
    num_ach = setup.*.mix_channel_count;
    if ((num_mch > 32 or (num_ach > 32))) return false;
    mixer.init(setup);
    // Unify mixer and core channel buffers: use mixer-owned channel array
    const mix_ptr: [*c]mm.MixerChannel = mixer.mm_get_mix_channels_ptr();
    if (mix_ptr != @as([*c]mm.MixerChannel, @ptrFromInt(0))) {
        mixer.mm_mix_channels = mix_ptr;
    }
    // Log parity with C reference
    debugPrint("[init] init done, mm_num_mch={d} mm_num_ach={d} mm_mixlen={d}\n", .{ num_mch, num_ach, mm_mixlen });
    // Build channel mask safely for up to 32 channels
    // Avoid undefined shift when mm_num_ach == 32 on 32-bit types
    // Match C: mm_ch_mask = (1U << mm_num_ach) - 1; (32 -> 0xFFFF_FFFF)
    mm_ch_mask = if (num_ach >= 32) 0xFFFF_FFFF else ((@as(u32, 1) << @intCast(num_ach)) - 1);
    // Propagate to the shared shim symbol (same global)
    setChannelMask(mm_ch_mask);
    mas.mmSetModuleVolume(1024);
    mas.mmSetJingleVolume(1024);
    sfx.setEffectsVolume(1024);
    mas.mmSetModuleTempo(1024);
    mas.mmSetModulePitch(1024);
    sfx.resetEffects();
    initialized = true;
    return true;
}
pub fn end() bool {
    initialized = false;
    mixer.mmMixerEnd();
    if (mm_init_default_buffer != null) {
        mm_init_default_buffer = @as(?*anyopaque, @ptrFromInt(0));
    }
    return true;
}
pub fn frame() void {
    if (!initialized) return;
    // Update effects and sublayer first to mirror C reference ordering
    sfx.updateEffects();
    mas.mppUpdateSub();

    mpp_channels = pchannels;
    mpp_nchannels = @as(mm.Byte, @truncate(num_mch));
    mas.mpp_clayer = .main;
    layer_p = &layer_main;
    // One-time debug of isplaying to ensure tick path runs (limited prints)
    if (@as(c_int, @bitCast(@as(c_uint, layer_p.*.isplaying))) == @as(c_int, 0)) {
        debugPrint("[FRAME] isplaying=0 (skipping tick)\n", .{});
        // Reduce noisy frame logs to avoid timing impact; keep mixing
        mmMixerMix(mm_mixlen);
        return;
    }
    var remaining_len: c_int = @bitCast(mm_mixlen);
    while (true) {
        var sample_num: c_int = @as(c_int, @bitCast(@as(c_uint, layer_p.*.tickrate)));
        const sampcount: c_int = @as(c_int, @bitCast(@as(c_uint, layer_p.*.tick_data.sampcount)));
        sample_num -= sampcount;
        if (sample_num < @as(c_int, 0)) {
            sample_num = 0;
        }
        if (sample_num >= remaining_len) break;
        layer_p.*.tick_data.sampcount = 0;
        remaining_len -= sample_num;
        mmMixerMix(@as(mm.Word, @bitCast(sample_num)));
        mas.mppProcessTick();
        // Snapshot immediately after tick processing (post-UMIX binding) before next mix
        if (premix_budget > 0 and mixer.mm_mix_channels != @as([*c]mm.MixerChannel, @ptrFromInt(0))) {
            const ch0a: [*c]mm.MixerChannel = mixer.mm_mix_channels;
            debugPrint(
                "[PREMIX] ch0 src={x} read={d} vol={d} freq={d}\n",
                .{ ch0a[0].src, @as(c_int, @intCast(ch0a[0].read)), @as(c_int, @intCast(ch0a[0].vol)), @as(c_int, @intCast(ch0a[0].freq)) },
            );
            premix_budget -= 1;
        }
    }
    layer_p.*.tick_data.sampcount +%= @as(mm.Hword, @bitCast(@as(c_short, @truncate(remaining_len))));
    mmMixerMix(@as(mm.Word, @bitCast(remaining_len)));
    // Bounded post-mix snapshot prints to verify mixer read advancement
    if (postmix_budget > 0 and mixer.mm_mix_channels != @as([*c]mm.MixerChannel, @ptrFromInt(0))) {
        const ch_base_ptr: [*c]mm.MixerChannel = mixer.mm_mix_channels;
        // Print first 4 channels for clarity
        var i: usize = 0;
        while (i < 4) : (i += 1) {
            debugPrint(
                "[POSTMIX] ch{d} src={x} read={d} vol={d} freq={d}\n",
                .{ @as(c_int, @intCast(i)), ch_base_ptr[i].src, @as(c_int, @intCast(ch_base_ptr[i].read)), @as(c_int, @intCast(ch_base_ptr[i].vol)), @as(c_int, @intCast(ch_base_ptr[i].freq)) },
            );
        }
        postmix_budget -= 1;
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
    const b0: u16 = p[0];
    const b1: u16 = p[1];
    return b0 | (b1 << 8);
}
fn parseBankPointers(base: [*]const u8) void {
    // Try without prefix first (head size 12), then with 8-byte prefix
    const candidates = [_]usize{ 0, 8 };
    var chosen: usize = candidates.len;
    var sc: u16 = 0;
    var mc: u16 = 0;
    for (candidates, 0..) |off, idx| {
        const s = readLe16(base + off + 0);
        const m = readLe16(base + off + 2);
        if (m >= 1 and m <= 64 and s >= 1 and s <= 4096) {
            chosen = idx;
            sc = s;
            mc = m;
            break;
        }
    }
    if (chosen == candidates.len) {
        // Fallback to zero to avoid nulls
        chosen = 0;
        sc = readLe16(base + 0);
        mc = readLe16(base + 2);
    }
    head_off = candidates[chosen];
    sample_count = sc;
    module_count = mc;
    const head_size: usize = 12; // two u16 + two u32 reserved
    sample_table = @ptrCast(@alignCast(base + head_off + head_size));
    module_table = sample_table + @as(usize, sc);
}

// MSL head data (exactly like C): 2x u16, then 4-byte padding to align tables
const MSLHeadData = extern struct {
    sample_count: mm.Hword = 0, // u16
    module_count: mm.Hword = 0, // u16
    pad: mm.Word = 0, // u32 padding
};
const MSLHead = extern struct {
    head_data: MSLHeadData align(4) = @import("std").mem.zeroes(MSLHeadData),
    // Immediately followed by two u32 tables: samples then modules
    pub fn sampleTable(self: *const @This()) [*]const u32 {
        const base: [*]const u8 = @ptrCast(@alignCast(self));
        // sizeof(MSLHeadData) == 8; tables start at offset 8, 4-byte aligned
        return @as([*]const u32, @ptrCast(@alignCast(base + 8)));
    }
    pub fn moduleTable(self: *const @This()) [*]const u32 {
        // module table follows sampleCount entries in sample table
        const samples = self.head_data.sample_count;
        const samp_tbl = self.sampleTable();
        return samp_tbl + samples;
    }
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
