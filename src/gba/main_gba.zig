// Debug configuration - can be toggled at build time
const debug_enabled = @import("build_options").xm_debug;

// Debug printing helper that can be compiled out
inline fn debugPrint(comptime fmt: []const u8, args: anytype) void {
    if (debug_enabled) {
        @import("gba").debug.print(fmt, args) catch {};
    }
}

pub const calloc = @import("../shim.zig").calloc;
pub extern fn free(?*anyopaque) void;
pub const mm_word = c_uint;
pub const mm_sword = c_int;
pub const mm_hword = c_ushort;
pub const mm_shword = c_short;
pub const mm_byte = u8;
pub const mm_sbyte = i8;
pub const mm_sfxhand = c_ushort;
pub const mm_bool = u8;
pub const mm_addr = ?*anyopaque;
pub const mm_reg = ?*anyopaque;
pub const MM_MODE_A: c_int = 0;
pub const MM_MODE_B: c_int = 1;
pub const MM_MODE_C: c_int = 2;
pub const mm_mode_enum = c_uint;
pub const MM_MAIN: c_int = 0;
pub const MM_JINGLE: c_int = 1;
pub const mm_layer_type = c_uint;
pub const MM_STREAM_8BIT_MONO: c_int = 0;
pub const MM_STREAM_8BIT_STEREO: c_int = 1;
pub const MM_STREAM_16BIT_MONO: c_int = 2;
pub const MM_STREAM_16BIT_STEREO: c_int = 3;
pub const mm_stream_formats = c_uint;
pub const mm_callback = ?*const fn (mm_word, mm_word) callconv(.c) mm_word;
pub const mm_voidfunc = ?*const fn () callconv(.c) void;
pub const mm_stream_func = ?*const fn (mm_word, mm_addr, mm_stream_formats) callconv(.c) mm_word;
pub const MMRF_MEMORY: c_int = 1;
pub const MMRF_DELAY: c_int = 2;
pub const MMRF_RATE: c_int = 4;
pub const MMRF_FEEDBACK: c_int = 8;
pub const MMRF_PANNING: c_int = 16;
pub const MMRF_LEFT: c_int = 32;
pub const MMRF_RIGHT: c_int = 64;
pub const MMRF_BOTH: c_int = 96;
pub const MMRF_INVERSEPAN: c_int = 128;
pub const MMRF_NODRYLEFT: c_int = 256;
pub const MMRF_NODRYRIGHT: c_int = 512;
pub const MMRF_8BITLEFT: c_int = 1024;
pub const MMRF_16BITLEFT: c_int = 2048;
pub const MMRF_8BITRIGHT: c_int = 4096;
pub const MMRF_16BITRIGHT: c_int = 8192;
pub const MMRF_DRYLEFT: c_int = 16384;
pub const MMRF_DRYRIGHT: c_int = 32768;
pub const mm_reverbflags = c_uint;
pub const MMRC_LEFT: c_int = 1;
pub const MMRC_RIGHT: c_int = 2;
pub const MMRC_BOTH: c_int = 3;
pub const mm_reverbch = c_uint;
pub const struct_mmreverbcfg = extern struct {
    flags: mm_word = @import("std").mem.zeroes(mm_word),
    memory: mm_addr = @import("std").mem.zeroes(mm_addr),
    delay: mm_hword = @import("std").mem.zeroes(mm_hword),
    rate: mm_hword = @import("std").mem.zeroes(mm_hword),
    feedback: mm_hword = @import("std").mem.zeroes(mm_hword),
    panning: mm_byte = @import("std").mem.zeroes(mm_byte),
};
pub const mm_reverb_cfg = struct_mmreverbcfg;
pub const MM_PLAY_LOOP: c_int = 0;
pub const MM_PLAY_ONCE: c_int = 1;
pub const mm_pmode = c_uint;
pub const MixMode = enum(c_uint) {
    _8khz,
    _10khz,
    _13khz,
    _16khz,
    _18khz,
    _21khz,
    _27khz,
    _31khz,
};
pub const MM_TIMER0: c_int = 0;
pub const MM_TIMER1: c_int = 1;
pub const MM_TIMER2: c_int = 2;
pub const MM_TIMER3: c_int = 3;
pub const mm_stream_timer = c_uint;
const union_unnamed_5 = extern union {
    loop_length: mm_word,
    length: mm_word,
};
pub const struct_t_mmdssample = extern struct {
    loop_start: mm_word = @import("std").mem.zeroes(mm_word),
    unnamed_0: union_unnamed_5 = @import("std").mem.zeroes(union_unnamed_5),
    format: mm_byte = @import("std").mem.zeroes(mm_byte),
    repeat_mode: mm_byte = @import("std").mem.zeroes(mm_byte),
    base_rate: mm_hword = @import("std").mem.zeroes(mm_hword),
    data: mm_addr = @import("std").mem.zeroes(mm_addr),
};
pub const mm_ds_sample = struct_t_mmdssample;
const union_unnamed_6 = extern union {
    id: mm_word,
    sample: [*c]mm_ds_sample,
};
pub const struct_t_mmsoundeffect = extern struct {
    unnamed_0: union_unnamed_6 = @import("std").mem.zeroes(union_unnamed_6),
    rate: mm_hword = @import("std").mem.zeroes(mm_hword),
    handle: mm_sfxhand = @import("std").mem.zeroes(mm_sfxhand),
    volume: mm_byte = @import("std").mem.zeroes(mm_byte),
    panning: mm_byte = @import("std").mem.zeroes(mm_byte),
};
pub const mm_sound_effect = struct_t_mmsoundeffect;
pub const struct_t_mmgbasystem = extern struct {
    mixing_mode: MixMode = ._8khz,
    mod_channel_count: mm_word = @import("std").mem.zeroes(mm_word),
    mix_channel_count: mm_word = @import("std").mem.zeroes(mm_word),
    module_channels: mm_addr = @import("std").mem.zeroes(mm_addr),
    active_channels: mm_addr = @import("std").mem.zeroes(mm_addr),
    mixing_channels: mm_addr = @import("std").mem.zeroes(mm_addr),
    mixing_memory: mm_addr = @import("std").mem.zeroes(mm_addr),
    wave_memory: mm_addr = @import("std").mem.zeroes(mm_addr),
    soundbank: mm_addr = @import("std").mem.zeroes(mm_addr),
};
pub const mm_gba_system = struct_t_mmgbasystem;
pub const struct_t_mmdssystem = extern struct {
    mod_count: mm_word = @import("std").mem.zeroes(mm_word),
    samp_count: mm_word = @import("std").mem.zeroes(mm_word),
    mem_bank: [*c]mm_word = @import("std").mem.zeroes([*c]mm_word),
    fifo_channel: mm_word = @import("std").mem.zeroes(mm_word),
};
pub const mm_ds_system = struct_t_mmdssystem;
pub const struct_t_mmstream = extern struct {
    sampling_rate: mm_word = @import("std").mem.zeroes(mm_word),
    buffer_length: mm_word = @import("std").mem.zeroes(mm_word),
    callback: mm_stream_func = @import("std").mem.zeroes(mm_stream_func),
    format: mm_word = @import("std").mem.zeroes(mm_word),
    timer: mm_word = @import("std").mem.zeroes(mm_word),
    manual: mm_bool = @import("std").mem.zeroes(mm_bool),
};
pub const mm_stream = struct_t_mmstream;
pub const struct_t_mmstreamdata = extern struct {
    is_active: mm_bool = @import("std").mem.zeroes(mm_bool),
    format: mm_stream_formats = @import("std").mem.zeroes(mm_stream_formats),
    is_auto: mm_bool = @import("std").mem.zeroes(mm_bool),
    hw_timer_num: mm_byte = @import("std").mem.zeroes(mm_byte),
    clocks: mm_hword = @import("std").mem.zeroes(mm_hword),
    timer: mm_hword = @import("std").mem.zeroes(mm_hword),
    length_cut: mm_hword = @import("std").mem.zeroes(mm_hword),
    length_words: mm_hword = @import("std").mem.zeroes(mm_hword),
    position: mm_hword = @import("std").mem.zeroes(mm_hword),
    reserved2: mm_hword = @import("std").mem.zeroes(mm_hword),
    hw_timer: [*c]volatile mm_hword = @import("std").mem.zeroes([*c]volatile mm_hword),
    wave_memory: mm_addr = @import("std").mem.zeroes(mm_addr),
    work_memory: mm_addr = @import("std").mem.zeroes(mm_addr),
    callback: mm_stream_func = @import("std").mem.zeroes(mm_stream_func),
    remainder: mm_word = @import("std").mem.zeroes(mm_word),
};
pub const mm_stream_data = struct_t_mmstreamdata;
pub const struct_tmm_voice = extern struct {
    source: mm_addr = @import("std").mem.zeroes(mm_addr),
    length: mm_word = @import("std").mem.zeroes(mm_word),
    loop_start: mm_hword = @import("std").mem.zeroes(mm_hword),
    timer: mm_hword = @import("std").mem.zeroes(mm_hword),
    flags: mm_byte = @import("std").mem.zeroes(mm_byte),
    format: mm_byte = @import("std").mem.zeroes(mm_byte),
    repeat: mm_byte = @import("std").mem.zeroes(mm_byte),
    volume: mm_byte = @import("std").mem.zeroes(mm_byte),
    divider: mm_byte = @import("std").mem.zeroes(mm_byte),
    panning: mm_byte = @import("std").mem.zeroes(mm_byte),
    index: mm_byte = @import("std").mem.zeroes(mm_byte),
    reserved: [1]mm_byte = @import("std").mem.zeroes([1]mm_byte),
};
pub const mm_voice = struct_tmm_voice;
pub const MMVF_FREQ: c_int = 2;
pub const MMVF_VOLUME: c_int = 4;
pub const MMVF_PANNING: c_int = 8;
pub const MMVF_SOURCE: c_int = 16;
pub const MMVF_STOP: c_int = 32;
const enum_unnamed_7 = c_uint;
extern fn mmShimSetChannelMask(mask: u32) callconv(.C) void;

pub const MixeLen = enum(u16) {
    _8khz = 544,
    _10khz = 704,
    _13khz = 896,
    _16khz = 1056,
    _18khz = 1216,
    _21khz = 1408,
    _27khz = 1792,
    _31khz = 2112,
};

pub fn mmInitDefault(soundbank: mm_addr, number_of_channels: mm_word) !void {
    debugPrint("[mmInitDefault] soundbank=0x{x} nch={d}\n", .{ @intFromPtr(soundbank), number_of_channels });

    if (number_of_channels > 32) return error.InvalidNumberOfChannels;

    const size_of_channel: usize = (@sizeOf(mm_module_channel) +% @sizeOf(mm_active_channel)) +% @sizeOf(mm_mixer_channel);
    const size_of_buffer: usize = @intFromEnum(MixeLen._16khz) +% (number_of_channels *% size_of_channel);
    const wave_memory = calloc(1, size_of_buffer);
    const module_channels = @as(mm_addr, @ptrFromInt(@as(mm_word, @intCast(@intFromPtr(wave_memory))) +% @intFromEnum(MixeLen._16khz)));
    const active_channels: mm_addr = @ptrFromInt(@as(mm_word, @intCast(@intFromPtr(module_channels))) +% (number_of_channels *% @sizeOf(mm_module_channel)));
    const mixing_channels: mm_addr = @ptrFromInt(@as(mm_word, @intCast(@intFromPtr(active_channels))) +% (number_of_channels *% @sizeOf(mm_active_channel)));
    var setup: mm_gba_system = mm_gba_system{
        .mixing_mode = ._16khz,
        .mod_channel_count = number_of_channels,
        .mix_channel_count = number_of_channels,
        .module_channels = module_channels,
        .active_channels = active_channels,
        .mixing_channels = mixing_channels,
        .mixing_memory = @as(mm_addr, @ptrCast(&mixbuffer[@as(c_uint, @intCast(@as(c_int, 0)))])),
        .wave_memory = wave_memory,
        .soundbank = soundbank,
    };
    if (!mmInit(&setup)) {
        debugPrint("[mmInitDefault] mmInit failed\n", .{});
        return error.FailedToInitialize;
    }
    debugPrint("[mmInitDefault] done mm_mixlen={d}\n", .{mm_mixlen});
}
// MSL head data (exactly like C): 2x u16, then 4-byte padding to align tables
pub const struct_tmslheaddata = extern struct {
    sampleCount: mm_hword = @import("std").mem.zeroes(mm_hword), // u16
    moduleCount: mm_hword = @import("std").mem.zeroes(mm_hword), // u16
    pad: mm_hword = @import("std").mem.zeroes(mm_hword), // u16 padding
    pad2: mm_hword = @import("std").mem.zeroes(mm_hword), // u16 padding
};
pub const msl_head_data = struct_tmslheaddata;
pub const struct_tmslhead = extern struct {
    head_data: msl_head_data align(4) = @import("std").mem.zeroes(msl_head_data),
    // Immediately followed by two u32 tables: samples then modules
    pub fn sampleTable(self: *const @This()) [*]const u32 {
        const base: [*]const u8 = @ptrCast(@alignCast(self));
        // sizeof(msl_head_data) == 8; tables start at offset 8, 4-byte aligned
        return @as([*]const u32, @ptrCast(@alignCast(base + 8)));
    }
    pub fn moduleTable(self: *const @This()) [*]const u32 {
        // module table follows sampleCount entries in sample table
        const samples = self.head_data.sampleCount;
        const samp_tbl = self.sampleTable();
        return samp_tbl + samples;
    }
};
pub const msl_head = struct_tmslhead;
// Raw-parsed bank pointers to avoid struct/align drift
var mm_bank_base: [*]const u8 = undefined;
var mm_head_off: usize = 0;
var mm_sample_count_u16: u16 = 0;
var mm_module_count_u16: u16 = 0;
var mm_sample_table_ptr: [*]const u32 = undefined;
var mm_module_table_ptr: [*]const u32 = undefined;

inline fn read_le16(p: [*]const u8) u16 {
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
        const s = read_le16(base + off + 0);
        const m = read_le16(base + off + 2);
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
        sc = read_le16(base + 0);
        mc = read_le16(base + 2);
    }
    mm_head_off = candidates[chosen];
    mm_sample_count_u16 = sc;
    mm_module_count_u16 = mc;
    const head_size: usize = 12; // two u16 + two u32 reserved
    mm_sample_table_ptr = @ptrCast(@alignCast(base + mm_head_off + head_size));
    mm_module_table_ptr = mm_sample_table_ptr + @as(usize, sc);
}

pub export fn mm_getSampleCount() mm_hword {
    return mm_sample_count_u16;
}

pub export fn mm_getModuleTable() [*]const mm_word {
    return @ptrCast(mm_module_table_ptr);
}

pub export fn mm_getSampleTable() [*]const mm_word {
    return @ptrCast(mm_sample_table_ptr);
}
pub export fn mmInit(arg_setup: [*c]mm_gba_system) bool {
    var setup = arg_setup;
    _ = &setup;
    mm_bank_base = @ptrCast(@alignCast(setup.*.soundbank));
    parseBankPointers(mm_bank_base);
    // Point mp_solution to head_data base (without prefix) for any legacy users
    mp_solution = @constCast(@ptrCast(@alignCast(mm_bank_base + mm_head_off)));
    debugPrint("[mmInit] mp_solution=0x{x} sampleCount={d} moduleCount={d}\n", .{ @intFromPtr(mp_solution), @as(c_int, @intCast(mm_sample_count_u16)), @as(c_int, @intCast(mm_module_count_u16)) });
    mmSampleCount = @as(mm_word, @intCast(mm_sample_count_u16));
    mmModuleCount = @as(mm_word, @intCast(mm_module_count_u16));
    mm_achannels = @as([*c]mm_active_channel, @ptrCast(@alignCast(setup.*.active_channels)));
    mm_pchannels = @as([*c]mm_module_channel, @ptrCast(@alignCast(setup.*.module_channels)));
    mm_num_mch = setup.*.mod_channel_count;
    mm_num_ach = setup.*.mix_channel_count;
    if ((mm_num_mch > @as(mm_word, @bitCast(@as(c_int, 32)))) or (mm_num_ach > @as(mm_word, @bitCast(@as(c_int, 32))))) return @as(c_int, 0) != 0;
    mmMixerInit(setup);
    // Unify mixer and core channel buffers: use mixer-owned channel array
    const mix_ptr: [*c]mm_mixer_channel = mm_get_mix_channels_ptr();
    if (mix_ptr != @as([*c]mm_mixer_channel, @ptrFromInt(0))) {
        mm_mix_channels = mix_ptr;
    }
    // Diagnostics: show mixer channel buffer range
    const ch_base: usize = @intFromPtr(mm_mix_channels);
    const ch_end: usize = @intFromPtr(mm_mixch_end);
    const ch_bytes: usize = if (ch_end > ch_base) ch_end - ch_base else 0;
    _ = ch_bytes; // silence unused in release
    // Log parity with C reference
    debugPrint("[mmInit] mmMixerInit done, mm_num_mch={d} mm_num_ach={d} mm_mixlen={d}\n", .{ mm_num_mch, mm_num_ach, mm_mixlen });
    // Build channel mask safely for up to 32 channels
    // Avoid undefined shift when mm_num_ach == 32 on 32-bit types
    // Match C: mm_ch_mask = (1U << mm_num_ach) - 1; (32 -> 0xFFFF_FFFF)
    const nch: u32 = @intCast(mm_num_ach);
    mm_ch_mask = if (nch >= 32) 0xFFFF_FFFF else ((@as(u32, 1) << @intCast(nch)) - 1);
    // Propagate to the shared shim symbol (same global)
    mmShimSetChannelMask(mm_ch_mask);
    mmSetModuleVolume(@as(mm_word, @bitCast(@as(c_int, 1024))));
    mmSetJingleVolume(@as(mm_word, @bitCast(@as(c_int, 1024))));
    mmSetEffectsVolume(@as(mm_word, @bitCast(@as(c_int, 1024))));
    mmSetModuleTempo(@as(mm_word, @bitCast(@as(c_int, 1024))));
    mmSetModulePitch(@as(mm_word, @bitCast(@as(c_int, 1024))));
    mmResetEffects();
    mm_initialized = @as(c_int, 1) != 0;
    return @as(c_int, 1) != 0;
}
pub export fn mmEnd() bool {
    mm_initialized = @as(c_int, 0) != 0;
    mmMixerEnd();
    if (mm_init_default_buffer != null) {
        free(mm_init_default_buffer);
        mm_init_default_buffer = @as(?*anyopaque, @ptrFromInt(@as(c_int, 0)));
    }
    return @as(c_int, 1) != 0;
}
pub extern fn mmVBlank() void;
pub extern fn mmSetVBlankHandler(function: mm_voidfunc) void;
pub extern fn mmSetEventHandler(handler: mm_callback) void;
var g_postmix_budget: u32 = 4;
var g_premix_budget: u32 = 8;
pub export fn mmFrame() void {
    if (!mm_initialized) return;
    // Update effects and sublayer first to mirror C reference ordering
    mmUpdateEffects();
    mppUpdateSub();

    // mmUpdateEffects();
    // mppUpdateSub(); // Don't call this - it sets mpp_nchannels=4 for jingle mode
    mpp_channels = mm_pchannels;
    mpp_nchannels = @as(mm_byte, @bitCast(@as(u8, @truncate(mm_num_mch))));
    mpp_clayer = @as(c_uint, @bitCast(MM_MAIN));
    mpp_layerp = &mmLayerMain;
    if (@as(c_int, @bitCast(@as(c_uint, mpp_layerp.*.isplaying))) == @as(c_int, 0)) {
        debugPrint("[mmFrame] not playing, mixing {d} (valid={d}) [STOPPING PLAYBACK]\n", .{ mm_mixlen, @as(c_int, @intCast(mpp_layerp.*.valid)) });
        mmMixerMix(mm_mixlen);
        return;
    }
    var remaining_len: c_int = @as(c_int, @bitCast(mm_mixlen));
    _ = &remaining_len;
    while (true) {
        var sample_num: c_int = @as(c_int, @bitCast(@as(c_uint, mpp_layerp.*.tickrate)));
        _ = &sample_num;
        var sampcount: c_int = @as(c_int, @bitCast(@as(c_uint, mpp_layerp.*.unnamed_0.sampcount)));
        _ = &sampcount;
        sample_num -= sampcount;
        debugPrint(
            "[mmFrame] sample logic: tickrate={d} sampcount={d} sample_num={d} remaining_len={d}\n",
            .{ @as(c_int, @intCast(mpp_layerp.*.tickrate)), sampcount, sample_num, remaining_len },
        );
        if (sample_num < @as(c_int, 0)) {
            sample_num = 0;
        }
        if (sample_num >= remaining_len) break;
        mpp_layerp.*.unnamed_0.sampcount = 0;
        remaining_len -= sample_num;
        debugPrint("[MIX] num={d}\n", .{sample_num});
        mmMixerMix(@as(mm_word, @bitCast(sample_num)));
        debugPrint("[mmFrame] calling mppProcessTick() pos={d} row={d} tick={d}\n", .{ @as(c_int, @intCast(mpp_layerp.*.position)), @as(c_int, @intCast(mpp_layerp.*.row)), @as(c_int, @intCast(mpp_layerp.*.tick)) });
        mppProcessTick();
        debugPrint("[mmFrame] after mppProcessTick() pos={d} row={d} tick={d} isplaying={d}\n", .{ @as(c_int, @intCast(mpp_layerp.*.position)), @as(c_int, @intCast(mpp_layerp.*.row)), @as(c_int, @intCast(mpp_layerp.*.tick)), @as(c_int, @intCast(mpp_layerp.*.isplaying)) });
        // Snapshot immediately after tick processing (post-UMIX binding) before next mix
        if (g_premix_budget > 0 and mm_mix_channels != @as([*c]mm_mixer_channel, @ptrFromInt(0))) {
            const ch0a: [*c]mm_mixer_channel = mm_mix_channels;
            debugPrint(
                "[PREMIX] ch0 src={x} read={d} vol={d} freq={d}\n",
                .{ ch0a[0].src, @as(c_int, @intCast(ch0a[0].read)), @as(c_int, @intCast(ch0a[0].vol)), @as(c_int, @intCast(ch0a[0].freq)) },
            );
            g_premix_budget -= 1;
        }
    }
    mpp_layerp.*.unnamed_0.sampcount +%= @as(mm_hword, @bitCast(@as(c_short, @truncate(remaining_len))));
    debugPrint("[MIX] tail={d}\n", .{remaining_len});
    mmMixerMix(@as(mm_word, @bitCast(remaining_len)));
    // Bounded post-mix snapshot prints to verify mixer read advancement
    if (g_postmix_budget > 0 and mm_mix_channels != @as([*c]mm_mixer_channel, @ptrFromInt(0))) {
        const ch_base_ptr: [*c]mm_mixer_channel = mm_mix_channels;
        // Print first 4 channels for clarity
        var i: usize = 0;
        while (i < 4) : (i += 1) {
            debugPrint(
                "[POSTMIX] ch{d} src={x} read={d} vol={d} freq={d}\n",
                .{ @as(c_int, @intCast(i)), ch_base_ptr[i].src, @as(c_int, @intCast(ch_base_ptr[i].read)), @as(c_int, @intCast(ch_base_ptr[i].vol)), @as(c_int, @intCast(ch_base_ptr[i].freq)) },
            );
        }
        g_postmix_budget -= 1;
    }
}
pub export fn mmGetModuleCount() mm_word {
    return mmModuleCount;
}
pub export fn mmGetSampleCount() mm_word {
    return mmSampleCount;
}
pub extern fn mmStart(module_ID: mm_word, mode: mm_pmode) void;
pub extern fn mmPause() void;
pub extern fn mmResume() void;
pub extern fn mmStop() void;
pub extern fn mmGetPositionTick() mm_word;
pub extern fn mmGetPositionRow() mm_word;
pub extern fn mmGetPosition() mm_word;
pub extern fn mmSetPositionEx(position: mm_word, row: mm_word) void;
pub fn mmSetPosition(arg_position: mm_word) callconv(.c) void {
    var position = arg_position;
    _ = &position;
    mmSetPositionEx(position, @as(mm_word, @bitCast(@as(c_int, 0))));
}
pub fn mmPosition(arg_position: mm_word) callconv(.c) void {
    var position = arg_position;
    _ = &position;
    mmSetPositionEx(position, @as(mm_word, @bitCast(@as(c_int, 0))));
}
pub extern fn mmActive() mm_bool;
pub extern fn mmSetModuleVolume(volume: mm_word) void;
pub extern fn mmSetModuleTempo(tempo: mm_word) void;
pub extern fn mmSetModulePitch(pitch: mm_word) void;
pub extern fn mmPlayModule(address: usize, mode: mm_word, layer: mm_word) void;
pub extern fn mmJingleStart(module_ID: mm_word, mode: mm_pmode) void;
pub fn mmJingle(arg_module_ID: mm_word) callconv(.c) void {
    var module_ID = arg_module_ID;
    _ = &module_ID;
    mmJingleStart(module_ID, @as(c_uint, @bitCast(MM_PLAY_ONCE)));
}
pub extern fn mmJinglePause() void;
pub extern fn mmJingleResume() void;
pub extern fn mmJingleStop() void;
pub extern fn mmJingleActive() mm_bool;
pub fn mmActiveSub() callconv(.c) mm_bool {
    return mmJingleActive();
}
pub extern fn mmSetJingleVolume(volume: mm_word) void;
pub extern fn mmEffect(sample_ID: mm_word) mm_sfxhand;
pub extern fn mmEffectEx(sound: [*c]mm_sound_effect) mm_sfxhand;
pub extern fn mmEffectVolume(handle: mm_sfxhand, volume: mm_word) void;
pub extern fn mmEffectPanning(handle: mm_sfxhand, panning: mm_byte) void;
pub extern fn mmEffectRate(handle: mm_sfxhand, rate: mm_word) void;
pub extern fn mmEffectScaleRate(handle: mm_sfxhand, factor: mm_word) void;
pub extern fn mmEffectActive(handle: mm_sfxhand) mm_bool;
pub extern fn mmEffectCancel(handle: mm_sfxhand) mm_word;
pub extern fn mmEffectRelease(handle: mm_sfxhand) void;
// pub extern fn mmSetEffectsVolume(volume: mm_word) void;
const mmSetEffectsVolume = @import("../core/effect.zig").mmSetEffectsVolume;
pub extern fn mmEffectCancelAll() void;
pub const struct_tmm_mas_prefix = extern struct {
    size: mm_word = @import("std").mem.zeroes(mm_word),
    type: mm_byte = @import("std").mem.zeroes(mm_byte),
    version: mm_byte = @import("std").mem.zeroes(mm_byte),
    reserved: [2]mm_byte = @import("std").mem.zeroes([2]mm_byte),
};
pub const mm_mas_prefix = struct_tmm_mas_prefix;
pub const struct_tmm_mas_head = extern struct {
    order_count: mm_byte = @import("std").mem.zeroes(mm_byte),
    instr_count: mm_byte = @import("std").mem.zeroes(mm_byte),
    sampl_count: mm_byte = @import("std").mem.zeroes(mm_byte),
    pattn_count: mm_byte = @import("std").mem.zeroes(mm_byte),
    flags: mm_byte = @import("std").mem.zeroes(mm_byte),
    global_volume: mm_byte = @import("std").mem.zeroes(mm_byte),
    initial_speed: mm_byte = @import("std").mem.zeroes(mm_byte),
    initial_tempo: mm_byte = @import("std").mem.zeroes(mm_byte),
    repeat_position: mm_byte = @import("std").mem.zeroes(mm_byte),
    reserved: [3]mm_byte = @import("std").mem.zeroes([3]mm_byte),
    channel_volume: [32]mm_byte = @import("std").mem.zeroes([32]mm_byte),
    channel_panning: [32]mm_byte = @import("std").mem.zeroes([32]mm_byte),
    sequence: [200]mm_byte = @import("std").mem.zeroes([200]mm_byte),
    pub fn tables(self: anytype) @import("std").zig.c_translation.FlexibleArrayType(@TypeOf(self), ?*anyopaque) {
        const Intermediate = @import("std").zig.c_translation.FlexibleArrayType(@TypeOf(self), u8);
        const ReturnType = @import("std").zig.c_translation.FlexibleArrayType(@TypeOf(self), ?*anyopaque);
        return @as(ReturnType, @ptrCast(@alignCast(@as(Intermediate, @ptrCast(self)) + 276)));
    }
};
pub const mm_mas_head = struct_tmm_mas_head;
// maxmod/include/mm_mas.h:82:17: warning: struct demoted to opaque type - has bitfield
pub const struct_tmm_mas_instrument = extern struct {
    global_volume: mm_byte = @import("std").mem.zeroes(mm_byte),
    fadeout: mm_byte = @import("std").mem.zeroes(mm_byte),
    random_volume: mm_byte = @import("std").mem.zeroes(mm_byte),
    dct: mm_byte = @import("std").mem.zeroes(mm_byte),
    nna: mm_byte = @import("std").mem.zeroes(mm_byte),
    env_flags: mm_byte = @import("std").mem.zeroes(mm_byte),
    panning: mm_byte = @import("std").mem.zeroes(mm_byte),
    dca: mm_byte = @import("std").mem.zeroes(mm_byte),
    note_map_offset: mm_hword = @import("std").mem.zeroes(mm_hword),
    is_note_map_invalid: mm_hword = @import("std").mem.zeroes(mm_hword),
};
pub const mm_mas_instrument = struct_tmm_mas_instrument;
// maxmod/include/mm_mas.h:112:17: warning: struct demoted to opaque type - has bitfield
pub const mm_mas_envelope_node = opaque {};
pub const struct_tmm_mas_envelope = extern struct {
    size: mm_byte align(2) = @import("std").mem.zeroes(mm_byte),
    loop_start: mm_byte = @import("std").mem.zeroes(mm_byte),
    loop_end: mm_byte = @import("std").mem.zeroes(mm_byte),
    sus_start: mm_byte = @import("std").mem.zeroes(mm_byte),
    sus_end: mm_byte = @import("std").mem.zeroes(mm_byte),
    node_count: mm_byte = @import("std").mem.zeroes(mm_byte),
    is_filter: mm_byte = @import("std").mem.zeroes(mm_byte),
    wasted: mm_byte = @import("std").mem.zeroes(mm_byte),
    pub fn env_nodes(self: anytype) @import("std").zig.c_translation.FlexibleArrayType(@TypeOf(self), mm_mas_envelope_node) {
        const Intermediate = @import("std").zig.c_translation.FlexibleArrayType(@TypeOf(self), u8);
        const ReturnType = @import("std").zig.c_translation.FlexibleArrayType(@TypeOf(self), mm_mas_envelope_node);
        return @as(ReturnType, @ptrCast(@alignCast(@as(Intermediate, @ptrCast(self)) + 8)));
    }
};
pub const mm_mas_envelope = struct_tmm_mas_envelope;
pub const struct_tmm_mas_sample_info = extern struct {
    default_volume: mm_byte align(2) = @import("std").mem.zeroes(mm_byte),
    panning: mm_byte = @import("std").mem.zeroes(mm_byte),
    frequency: mm_hword = @import("std").mem.zeroes(mm_hword),
    av_type: mm_byte = @import("std").mem.zeroes(mm_byte),
    av_depth: mm_byte = @import("std").mem.zeroes(mm_byte),
    av_speed: mm_byte = @import("std").mem.zeroes(mm_byte),
    global_volume: mm_byte = @import("std").mem.zeroes(mm_byte),
    av_rate: mm_hword = @import("std").mem.zeroes(mm_hword),
    pub fn data(self: anytype) @import("std").zig.c_translation.FlexibleArrayType(@TypeOf(self), u8) {
        const Intermediate = @import("std").zig.c_translation.FlexibleArrayType(@TypeOf(self), u8);
        const ReturnType = @import("std").zig.c_translation.FlexibleArrayType(@TypeOf(self), u8);
        return @as(ReturnType, @ptrCast(@alignCast(@as(Intermediate, @ptrCast(self)) + 12)));
    }
};
pub const mm_mas_sample_info = struct_tmm_mas_sample_info;
pub const struct_tmm_mas_pattern = extern struct {
    row_count: mm_byte align(1) = @import("std").mem.zeroes(mm_byte),
    pub fn pattern_data(self: anytype) @import("std").zig.c_translation.FlexibleArrayType(@TypeOf(self), u8) {
        const Intermediate = @import("std").zig.c_translation.FlexibleArrayType(@TypeOf(self), u8);
        const ReturnType = @import("std").zig.c_translation.FlexibleArrayType(@TypeOf(self), u8);
        return @as(ReturnType, @ptrCast(@alignCast(@as(Intermediate, @ptrCast(self)) + 1)));
    }
};
pub const mm_mas_pattern = struct_tmm_mas_pattern;
pub const struct_tmm_mas_gba_sample = extern struct {
    length: mm_word align(4) = @import("std").mem.zeroes(mm_word),
    loop_length: mm_word = @import("std").mem.zeroes(mm_word),
    format: mm_byte = @import("std").mem.zeroes(mm_byte),
    reserved: mm_byte = @import("std").mem.zeroes(mm_byte),
    default_frequency: mm_hword = @import("std").mem.zeroes(mm_hword),
    pub fn data(self: anytype) @import("std").zig.c_translation.FlexibleArrayType(@TypeOf(self), u8) {
        const Intermediate = @import("std").zig.c_translation.FlexibleArrayType(@TypeOf(self), u8);
        const ReturnType = @import("std").zig.c_translation.FlexibleArrayType(@TypeOf(self), u8);
        return @as(ReturnType, @ptrCast(@alignCast(@as(Intermediate, @ptrCast(self)) + 12)));
    }
};
pub const mm_mas_gba_sample = struct_tmm_mas_gba_sample;
const union_unnamed_8 = extern union {
    loop_length: mm_word,
    length: mm_word,
};
pub const struct_tmm_mas_ds_sample = extern struct {
    loop_start: mm_word align(4) = @import("std").mem.zeroes(mm_word),
    unnamed_0: union_unnamed_8 = @import("std").mem.zeroes(union_unnamed_8),
    format: mm_byte = @import("std").mem.zeroes(mm_byte),
    repeat_mode: mm_byte = @import("std").mem.zeroes(mm_byte),
    default_frequency: mm_hword = @import("std").mem.zeroes(mm_hword),
    point: mm_word = @import("std").mem.zeroes(mm_word),
    pub fn data(self: anytype) @import("std").zig.c_translation.FlexibleArrayType(@TypeOf(self), u8) {
        const Intermediate = @import("std").zig.c_translation.FlexibleArrayType(@TypeOf(self), u8);
        const ReturnType = @import("std").zig.c_translation.FlexibleArrayType(@TypeOf(self), u8);
        return @as(ReturnType, @ptrCast(@alignCast(@as(Intermediate, @ptrCast(self)) + 16)));
    }
};
pub const mm_mas_ds_sample = struct_tmm_mas_ds_sample;
pub extern fn mmResetEffects() void;
pub extern fn mmUpdateEffects() void;
pub extern fn __assert([*c]const u8, c_int, [*c]const u8) noreturn;
pub extern fn __assert_func([*c]const u8, c_int, [*c]const u8, [*c]const u8) noreturn;
pub const mm_module_channel = extern struct {
    alloc: mm_byte = @import("std").mem.zeroes(mm_byte),
    cflags: mm_byte = @import("std").mem.zeroes(mm_byte),
    panning: mm_byte = @import("std").mem.zeroes(mm_byte),
    volcmd: mm_byte = @import("std").mem.zeroes(mm_byte),
    effect: mm_byte = @import("std").mem.zeroes(mm_byte),
    param: mm_byte = @import("std").mem.zeroes(mm_byte),
    fxmem: mm_byte = @import("std").mem.zeroes(mm_byte),
    note: mm_byte = @import("std").mem.zeroes(mm_byte),
    flags: mm_byte = @import("std").mem.zeroes(mm_byte),
    inst: mm_byte = @import("std").mem.zeroes(mm_byte),
    pflags: mm_byte = @import("std").mem.zeroes(mm_byte),
    vibdep: mm_byte = @import("std").mem.zeroes(mm_byte),
    vibspd: mm_byte = @import("std").mem.zeroes(mm_byte),
    vibpos: mm_byte = @import("std").mem.zeroes(mm_byte),
    volume: mm_byte = @import("std").mem.zeroes(mm_byte),
    cvolume: mm_byte = @import("std").mem.zeroes(mm_byte),
    period: mm_word = @import("std").mem.zeroes(mm_word),
    bflags: mm_hword = @import("std").mem.zeroes(mm_hword),
    pnoter: mm_byte = @import("std").mem.zeroes(mm_byte),
    memory: [15]mm_byte = @import("std").mem.zeroes([15]mm_byte),
    padding: [2]mm_byte = @import("std").mem.zeroes([2]mm_byte),
};
// /opt/devkitpro/devkitARM/arm-none-eabi/include/assert.h:45:24: warning: ignoring StaticAssert declaration
pub const mm_active_channel = extern struct {
    period: mm_word = @import("std").mem.zeroes(mm_word),
    fade: mm_hword = @import("std").mem.zeroes(mm_hword),
    envc_vol: mm_hword = @import("std").mem.zeroes(mm_hword),
    envc_pan: mm_hword = @import("std").mem.zeroes(mm_hword),
    envc_pic: mm_hword = @import("std").mem.zeroes(mm_hword),
    avib_dep: mm_hword = @import("std").mem.zeroes(mm_hword),
    avib_pos: mm_hword = @import("std").mem.zeroes(mm_hword),
    fvol: mm_byte = @import("std").mem.zeroes(mm_byte),
    type: mm_byte = @import("std").mem.zeroes(mm_byte),
    inst: mm_byte = @import("std").mem.zeroes(mm_byte),
    panning: mm_byte = @import("std").mem.zeroes(mm_byte),
    volume: mm_byte = @import("std").mem.zeroes(mm_byte),
    sample: mm_byte = @import("std").mem.zeroes(mm_byte),
    parent: mm_byte = @import("std").mem.zeroes(mm_byte),
    flags: mm_byte = @import("std").mem.zeroes(mm_byte),
    envn_vol: mm_byte = @import("std").mem.zeroes(mm_byte),
    envn_pan: mm_byte = @import("std").mem.zeroes(mm_byte),
    envn_pic: mm_byte = @import("std").mem.zeroes(mm_byte),
    sfx: mm_byte = @import("std").mem.zeroes(mm_byte),
};
// /opt/devkitpro/devkitARM/arm-none-eabi/include/assert.h:45:24: warning: ignoring StaticAssert declaration
pub const mm_mixer_channel = extern struct {
    src: usize = @import("std").mem.zeroes(usize),
    read: mm_word = @import("std").mem.zeroes(mm_word),
    vol: mm_byte = @import("std").mem.zeroes(mm_byte),
    pan: mm_byte = @import("std").mem.zeroes(mm_byte),
    unused_0: mm_byte = @import("std").mem.zeroes(mm_byte),
    unused_1: mm_byte = @import("std").mem.zeroes(mm_byte),
    freq: mm_word = @import("std").mem.zeroes(mm_word),
};
// /opt/devkitpro/devkitARM/arm-none-eabi/include/assert.h:45:24: warning: ignoring StaticAssert declaration

// /opt/devkitpro/devkitARM/arm-none-eabi/include/assert.h:45:24: warning: ignoring StaticAssert declaration
const union_unnamed_9 = extern union {
    sampcount: mm_hword,
    tickfrac: mm_hword,
};
pub const mpl_layer_information = extern struct {
    tick: mm_byte = @import("std").mem.zeroes(mm_byte),
    row: mm_byte = @import("std").mem.zeroes(mm_byte),
    position: mm_byte = @import("std").mem.zeroes(mm_byte),
    nrows: mm_byte = @import("std").mem.zeroes(mm_byte),
    global_volume: mm_byte = @import("std").mem.zeroes(mm_byte),
    speed: mm_byte = @import("std").mem.zeroes(mm_byte),
    isplaying: mm_byte = @import("std").mem.zeroes(mm_byte),
    bpm: mm_byte = @import("std").mem.zeroes(mm_byte),
    insttable: [*c]mm_word = @import("std").mem.zeroes([*c]mm_word),
    samptable: [*c]mm_word = @import("std").mem.zeroes([*c]mm_word),
    patttable: [*c]mm_word = @import("std").mem.zeroes([*c]mm_word),
    songadr: [*c]mm_mas_head = @import("std").mem.zeroes([*c]mm_mas_head),
    flags: mm_byte = @import("std").mem.zeroes(mm_byte),
    oldeffects: mm_byte = @import("std").mem.zeroes(mm_byte),
    pattjump: mm_byte = @import("std").mem.zeroes(mm_byte),
    pattjump_row: mm_byte = @import("std").mem.zeroes(mm_byte),
    fpattdelay: mm_byte = @import("std").mem.zeroes(mm_byte),
    pattdelay: mm_byte = @import("std").mem.zeroes(mm_byte),
    ploop_row: mm_byte = @import("std").mem.zeroes(mm_byte),
    ploop_times: mm_byte = @import("std").mem.zeroes(mm_byte),
    ploop_adr: [*c]mm_byte = @import("std").mem.zeroes([*c]mm_byte),
    pattread: [*c]mm_byte = @import("std").mem.zeroes([*c]mm_byte),
    ploop_jump: mm_byte = @import("std").mem.zeroes(mm_byte),
    valid: mm_byte = @import("std").mem.zeroes(mm_byte),
    tickrate: mm_hword = @import("std").mem.zeroes(mm_hword),
    unnamed_0: union_unnamed_9 = @import("std").mem.zeroes(union_unnamed_9),
    mode: mm_byte = @import("std").mem.zeroes(mm_byte),
    reserved2: mm_byte = @import("std").mem.zeroes(mm_byte),
    mch_update: mm_word = @import("std").mem.zeroes(mm_word),
    volume: mm_hword = @import("std").mem.zeroes(mm_hword),
    reserved3: mm_hword = @import("std").mem.zeroes(mm_hword),
};
pub const mpv_active_information = extern struct {
    reserved: mm_word = @import("std").mem.zeroes(mm_word),
    pattread_p: [*c]mm_byte = @import("std").mem.zeroes([*c]mm_byte),
    afvol: mm_byte = @import("std").mem.zeroes(mm_byte),
    sampoff: mm_byte = @import("std").mem.zeroes(mm_byte),
    volplus: mm_sbyte = @import("std").mem.zeroes(mm_sbyte),
    notedelay: mm_byte = @import("std").mem.zeroes(mm_byte),
    panplus: mm_hword = @import("std").mem.zeroes(mm_hword),
    reserved2: mm_hword = @import("std").mem.zeroes(mm_hword),
};
pub extern var mm_ch_mask: mm_word;
pub extern var mmLayerMain: mpl_layer_information;
pub extern var mmLayerSub: mpl_layer_information;
pub extern var mpp_layerp: [*c]mpl_layer_information;
pub extern var mpp_vars: mpv_active_information;
pub extern var mpp_channels: [*c]mm_module_channel;
pub extern var mpp_nchannels: mm_byte;
pub extern var mpp_clayer: mm_layer_type;
pub extern var mm_achannels: [*c]mm_active_channel;
pub extern var mm_pchannels: [*c]mm_module_channel;
pub extern var mm_num_mch: mm_word;
pub extern var mm_num_ach: mm_word;
pub extern var mm_schannels: [4]mm_module_channel;
pub extern fn mmSetResolution(mm_word) void;
pub extern fn mmPulse() void;
pub extern fn mppUpdateSub() void;
pub extern fn mppProcessTick() void;
pub extern fn mmAllocChannel() mm_word;
pub extern fn mmUpdateChannel_T0([*c]mm_module_channel, [*c]mpl_layer_information, mm_byte) void;
pub extern fn mmUpdateChannel_TN([*c]mm_module_channel, [*c]mpl_layer_information) void;
pub extern fn mmGetPeriod([*c]mpl_layer_information, mm_word, mm_byte) mm_word;
pub extern fn mmReadPattern([*c]mpl_layer_information) mm_bool;
pub extern fn mpp_Process_VolumeCommand([*c]mpl_layer_information, [*c]mm_active_channel, [*c]mm_module_channel, mm_word) mm_word;
pub extern fn mpp_Process_Effect([*c]mpl_layer_information, [*c]mm_active_channel, [*c]mm_module_channel, mm_word) mm_word;
pub extern fn mpp_Update_ACHN_notest(layer: [*c]mpl_layer_information, act_ch: [*c]mm_active_channel, period: mm_word, ch: mm_word) mm_word;
pub extern fn mpp_Channel_NewNote([*c]mm_module_channel, [*c]mpl_layer_information) void;
pub inline fn mpp_SamplePointer(arg_layer: [*c]mpl_layer_information, arg_sampleN: mm_word) [*c]mm_mas_sample_info {
    var layer = arg_layer;
    _ = &layer;
    var sampleN = arg_sampleN;
    _ = &sampleN;
    var base: [*c]mm_byte = @as([*c]mm_byte, @ptrCast(@alignCast(layer.*.songadr)));
    _ = &base;
    return @as([*c]mm_mas_sample_info, @ptrCast(@alignCast(base + layer.*.samptable[sampleN -% @as(mm_word, @bitCast(@as(c_int, 1)))])));
}
pub inline fn mpp_InstrumentPointer(arg_layer: [*c]mpl_layer_information, arg_instN: mm_word) ?*mm_mas_instrument {
    var layer = arg_layer;
    _ = &layer;
    var instN = arg_instN;
    _ = &instN;
    var base: [*c]mm_byte = @as([*c]mm_byte, @ptrCast(@alignCast(layer.*.songadr)));
    _ = &base;
    return @as(?*mm_mas_instrument, @ptrCast(base + layer.*.insttable[instN -% @as(mm_word, @bitCast(@as(c_int, 1)))]));
}
pub inline fn mpp_PatternPointer(arg_layer: [*c]mpl_layer_information, arg_entry: mm_word) [*c]mm_mas_pattern {
    var layer = arg_layer;
    _ = &layer;
    var entry = arg_entry;
    _ = &entry;
    var base: [*c]mm_byte = @as([*c]mm_byte, @ptrCast(@alignCast(layer.*.songadr)));
    _ = &base;
    return @as([*c]mm_mas_pattern, @ptrCast(@alignCast(base + layer.*.patttable[entry])));
}
pub extern fn mmMixerSetVolume(channel: c_int, volume: mm_word) void;
pub extern fn mmMixerSetPan(channel: c_int, panning: mm_byte) void;
pub extern fn mmMixerSetFreq(channel: c_int, rate: mm_word) void;
pub extern fn mmMixerMulFreq(channel: c_int, factor: mm_word) void;
pub extern fn mmMixerStopChannel(channel: c_int) void;
pub extern var mm_mix_channels: [*c]mm_mixer_channel;
pub extern var mm_mixlen: mm_word;
pub extern var mm_bpmdv: mm_word;
pub extern fn mmMixerInit(setup: [*c]mm_gba_system) void;
pub extern fn mmMixerMix(samples_count: mm_word) void;
// Getter provided by GBA mixer module to access its channel buffer
pub extern fn mm_get_mix_channels_ptr() [*c]mm_mixer_channel;
// End pointer provided by mixer to delimit channel array
pub extern var mm_mixch_end: [*c]mm_mixer_channel;
pub extern fn mmMixerSetRead(channel: c_int, value: mm_word) void;
pub extern fn mmMixerEnd() void;
pub var mixbuffer: [264]u32 = @import("std").mem.zeroes([264]u32);
pub export var mp_solution: [*c]msl_head = @import("std").mem.zeroes([*c]msl_head);
pub export var mmModuleCount: mm_word = @import("std").mem.zeroes(mm_word);
pub export var mmSampleCount: mm_word = @import("std").mem.zeroes(mm_word);
pub var mm_init_default_buffer: mm_addr = @as(?*anyopaque, @ptrFromInt(@as(c_int, 0)));
pub var mm_initialized: bool = @as(c_int, 0) != 0;

pub const MM_TYPES_H__ = "";
pub const MMCB_SONGMESSAGE = @as(c_int, 0x2A);
pub const MMCB_SONGFINISHED = @as(c_int, 0x2B);
pub const MMCB_SONGERROR = @as(c_int, 0x2C);
pub const MM_SIZEOF_MODCH = @as(c_int, 40);
pub const MM_SIZEOF_ACTCH = @as(c_int, 28);
pub const MM_SIZEOF_MIXCH = @as(c_int, 12) + @import("std").zig.c_translation.sizeof(usize);
pub const MM_MAS_H__ = "";
pub const MAS_TYPE_SONG = @as(c_int, 0);
pub const MAS_TYPE_SAMPLE_GBA = @as(c_int, 1);
pub const MAS_TYPE_SAMPLE_NDS = @as(c_int, 2);
pub const MAS_HEADER_FLAG_LINK_GXX = @as(c_int, 1) << @as(c_int, 0);
pub const MAS_HEADER_FLAG_OLD_EFFECTS = @as(c_int, 1) << @as(c_int, 1);
pub const MAS_HEADER_FLAG_FREQ_MODE = @as(c_int, 1) << @as(c_int, 2);
pub const MAS_HEADER_FLAG_XM_MODE = @as(c_int, 1) << @as(c_int, 3);
pub const MAS_HEADER_FLAG_MSL_DEP = @as(c_int, 1) << @as(c_int, 4);
pub const MAS_HEADER_FLAG_OLD_MODE = @as(c_int, 1) << @as(c_int, 5);
pub const MAS_INSTR_FLAG_VOL_ENV_EXISTS = @as(c_int, 1) << @as(c_int, 0);
pub const MAS_INSTR_FLAG_PAN_ENV_EXISTS = @as(c_int, 1) << @as(c_int, 1);
pub const MAS_INSTR_FLAG_PITCH_ENV_EXISTS = @as(c_int, 1) << @as(c_int, 2);
pub const MAS_INSTR_FLAG_VOL_ENV_ENABLED = @as(c_int, 1) << @as(c_int, 3);
pub const MM_SFORMAT_8BIT = @as(c_int, 0);
pub const MM_SFORMAT_16BIT = @as(c_int, 1);
pub const MM_SFORMAT_ADPCM = @as(c_int, 2);
pub const MM_SREPEAT_FORWARD = @as(c_int, 1);
pub const MM_SREPEAT_OFF = @as(c_int, 2);
pub const MM_MSL_H__ = "";
pub const MM_CORE_EFFECT_H__ = "";
pub const EFFECT_CHANNELS = @as(c_int, 16);
pub const MM_CORE_MAS_H__ = "";
pub const MM_CORE_CHANNEL_TYPES_H__ = "";
// /opt/devkitpro/devkitARM/arm-none-eabi/include/assert.h:45:10
pub const MF_START = @as(c_int, 1);
pub const MF_DVOL = @as(c_int, 2);
pub const MF_HASVCMD = @as(c_int, 4);
pub const MF_HASFX = @as(c_int, 8);
pub const MF_NEWINSTR = @as(c_int, 16);
pub const MF_NOTEOFF = @as(c_int, 64);
pub const MF_NOTECUT = @as(c_int, 128);
pub const MCH_BFLAGS_NNA_SHIFT = @as(c_int, 6);
pub const MCH_BFLAGS_NNA_MASK = @as(c_int, 3) << MCH_BFLAGS_NNA_SHIFT;
pub inline fn MCH_BFLAGS_NNA_GET(x: anytype) @TypeOf((x & MCH_BFLAGS_NNA_MASK) >> MCH_BFLAGS_NNA_SHIFT) {
    _ = &x;
    return (x & MCH_BFLAGS_NNA_MASK) >> MCH_BFLAGS_NNA_SHIFT;
}
pub inline fn MCH_BFLAGS_NNA_SET(x: anytype) @TypeOf((x << MCH_BFLAGS_NNA_SHIFT) & MCH_BFLAGS_NNA_MASK) {
    _ = &x;
    return (x << MCH_BFLAGS_NNA_SHIFT) & MCH_BFLAGS_NNA_MASK;
}
pub const MCH_BFLAGS_TREMOR = @as(c_int, 1) << @as(c_int, 9);
pub const MCH_BFLAGS_CUT_VOLUME = @as(c_int, 1) << @as(c_int, 10);
pub const IT_NNA_CUT = @as(c_int, 0);
pub const IT_NNA_CONT = @as(c_int, 1);
pub const IT_NNA_OFF = @as(c_int, 2);
pub const IT_NNA_FADE = @as(c_int, 3);
pub const IT_DCA_CUT = @as(c_int, 0);
pub const IT_DCA_OFF = @as(c_int, 1);
pub const IT_DCA_FADE = @as(c_int, 2);
pub const MCAF_KEYON = @as(c_int, 1) << @as(c_int, 0);
pub const MCAF_FADE = @as(c_int, 1) << @as(c_int, 1);
pub const MCAF_START = @as(c_int, 1) << @as(c_int, 2);
pub const MCAF_UPDATED = @as(c_int, 1) << @as(c_int, 3);
pub const MCAF_ENVEND = @as(c_int, 1) << @as(c_int, 4);
pub const MCAF_VOLENV = @as(c_int, 1) << @as(c_int, 5);
pub const MCAF_SUB = @as(c_int, 1) << @as(c_int, 6);
pub const MCAF_EFFECT = @as(c_int, 1) << @as(c_int, 7);
pub const ACHN_DISABLED = @as(c_int, 0);
pub const ACHN_RESERVED = @as(c_int, 1);
pub const ACHN_BACKGROUND = @as(c_int, 2);
pub const ACHN_FOREGROUND = @as(c_int, 3);
pub const ACHN_CUSTOM = @as(c_int, 4);
pub const MIXCH_GBA_SRC_STOPPED: usize = (@as(usize, 1) << (@bitSizeOf(usize) - 1));
pub const MM_CORE_PLAYER_TYPES_H__ = "";
pub const MP_SCHANNELS = @as(c_int, 4);
pub const NO_CHANNEL_AVAILABLE = @as(c_int, 255);
pub const MM_CORE_MIXER_H__ = "";
pub const MM_GBA_MIXER_H = "";
pub const MP_SAMPFRAC = @as(c_int, 12);

// maxmod/source/gba/mixer.h:34:9
pub const mixlen = MixeLen._16khz;
pub const mmreverbcfg = struct_mmreverbcfg;
pub const t_mmdssample = struct_t_mmdssample;
pub const t_mmsoundeffect = struct_t_mmsoundeffect;
pub const t_mmgbasystem = struct_t_mmgbasystem;
pub const t_mmdssystem = struct_t_mmdssystem;
pub const t_mmstream = struct_t_mmstream;
pub const t_mmstreamdata = struct_t_mmstreamdata;
pub const tmm_voice = struct_tmm_voice;
pub const tmslheaddata = struct_tmslheaddata;
pub const tmslhead = struct_tmslhead;
pub const tmm_mas_prefix = struct_tmm_mas_prefix;
pub const tmm_mas_head = struct_tmm_mas_head;
pub const tmm_mas_instrument = struct_tmm_mas_instrument;
pub const tmm_mas_envelope = struct_tmm_mas_envelope;
pub const tmm_mas_sample_info = struct_tmm_mas_sample_info;
pub const tmm_mas_pattern = struct_tmm_mas_pattern;
pub const tmm_mas_gba_sample = struct_tmm_mas_gba_sample;
pub const tmm_mas_ds_sample = struct_tmm_mas_ds_sample;
