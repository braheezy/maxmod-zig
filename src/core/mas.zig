// Debug configuration - can be toggled at build time
const debug_enabled = @import("build_options").xm_debug;
const std = @import("std");

// Debug printing helper that can be compiled out
inline fn debugPrint(comptime fmt: []const u8, args: anytype) void {
    if (debug_enabled) {
        @import("gba").debug.print(fmt, args) catch {};
    }
}

pub export var mmLayerMain: mpl_layer_information = .{};
pub const wint_t = c_int;
const union_unnamed_1 = extern union {
    __wch: wint_t,
    __wchb: [4]u8,
};
pub const _mbstate_t = extern struct {
    __count: c_int = @import("std").mem.zeroes(c_int),
    __value: union_unnamed_1 = @import("std").mem.zeroes(union_unnamed_1),
};

pub extern fn memset(?*anyopaque, c_int, usize) ?*anyopaque;
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
pub const MM_MIX_8KHZ: c_int = 0;
pub const MM_MIX_10KHZ: c_int = 1;
pub const MM_MIX_13KHZ: c_int = 2;
pub const MM_MIX_16KHZ: c_int = 3;
pub const MM_MIX_18KHZ: c_int = 4;
pub const MM_MIX_21KHZ: c_int = 5;
pub const MM_MIX_27KHZ: c_int = 6;
pub const MM_MIX_31KHZ: c_int = 7;
pub const mm_mixmode = c_uint;
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
    mixing_mode: mm_mixmode = @import("std").mem.zeroes(mm_mixmode),
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
pub const MM_MIXLEN_8KHZ: c_int = 544;
pub const MM_MIXLEN_10KHZ: c_int = 704;
pub const MM_MIXLEN_13KHZ: c_int = 896;
pub const MM_MIXLEN_16KHZ: c_int = 1056;
pub const MM_MIXLEN_18KHZ: c_int = 1216;
pub const MM_MIXLEN_21KHZ: c_int = 1408;
pub const MM_MIXLEN_27KHZ: c_int = 1792;
pub const MM_MIXLEN_31KHZ: c_int = 2112;
pub const mm_mixlen_enum = c_uint;
pub extern fn mmInitDefault(soundbank: mm_addr, number_of_channels: mm_word) bool;
pub extern fn mmInit(setup: [*c]mm_gba_system) bool;
pub extern fn mmEnd() bool;
pub extern fn mmVBlank() void;
pub extern fn mmSetVBlankHandler(function: mm_voidfunc) void;
pub extern fn mm_getSampleCount() mm_hword;
pub extern fn mm_getModuleTable() [*]const mm_word;
pub extern fn mm_getSampleTable() [*]const mm_word;
pub export fn mmSetEventHandler(arg_handler: mm_callback) void {
    var handler = arg_handler;
    _ = &handler;
    mmCallback = handler;
}
pub extern fn mmFrame() void;
pub extern fn mmGetModuleCount() mm_word;
pub extern fn mmGetSampleCount() mm_word;
pub export fn mmStart(arg_id: mm_word, arg_mode: mm_pmode) void {
    var id = arg_id;
    _ = &id;
    var mode = arg_mode;
    _ = &mode;
    const mc = mmGetModuleCount();
    // C reference does not log mmStart internals beyond the caller's message
    if (id >= mc) {
        debugPrint("[mmStart] early return: id>=count\n", .{});
        return;
    }
    mpps_backdoor(id, mode, @as(c_uint, @bitCast(MM_MAIN)));
}
pub export fn mmPause() void {
    if (@as(c_int, @bitCast(@as(c_uint, mmLayerMain.valid))) == @as(c_int, 0)) return;
    mmLayerMain.isplaying = 0;
    debugPrint("[mmPause] main.isplaying -> 0\n", .{});
    mpp_suspend(@as(c_uint, @bitCast(MM_MAIN)));
}
pub export fn mmResume() void {
    if (@as(c_int, @bitCast(@as(c_uint, mmLayerMain.valid))) == @as(c_int, 0)) return;
    mmLayerMain.isplaying = 1;
    debugPrint("[mmResume] main.isplaying -> 1\n", .{});
}
pub export fn mmStop() void {
    mpp_clayer = @as(c_uint, @bitCast(MM_MAIN));
    mppStop();
}
pub export fn mmGetPositionTick() mm_word {
    return @as(mm_word, @bitCast(@as(c_uint, mmLayerMain.tick)));
}
pub export fn mmGetPositionRow() mm_word {
    return @as(mm_word, @bitCast(@as(c_uint, mmLayerMain.row)));
}
pub export fn mmGetPosition() mm_word {
    return @as(mm_word, @bitCast(@as(c_uint, mmLayerMain.position)));
}
pub export fn mmSetPositionEx(arg_position: mm_word, arg_row: mm_word) void {
    var position = arg_position;
    _ = &position;
    var row = arg_row;
    _ = &row;
    debugPrint("[mmSetPositionEx] position={d} row={d}\n", .{ position, row });
    mpp_setposition(&mmLayerMain, position);
    if (row != @as(mm_word, @bitCast(@as(c_int, 0)))) {
        mpph_FastForward(&mmLayerMain, row);
    }
}
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
pub export fn mmActive() mm_bool {
    return mmLayerMain.isplaying;
}
pub export fn mmSetModuleVolume(arg_volume: mm_word) void {
    var volume = arg_volume;
    _ = &volume;
    if (volume > @as(mm_word, @bitCast(@as(c_int, 1024)))) {
        volume = @as(mm_word, @bitCast(@as(c_int, 1024)));
    }
    mmLayerMain.volume = @as(mm_hword, @bitCast(@as(c_ushort, @truncate(volume))));
}
pub export fn mmSetModuleTempo(arg_tempo: mm_word) void {
    var tempo = arg_tempo;
    _ = &tempo;
    var max: mm_word = @as(mm_word, @bitCast(@as(c_int, 2048)));
    _ = &max;
    if (tempo > max) {
        tempo = max;
    }
    var min: mm_word = @as(mm_word, @bitCast(@as(c_int, 512)));
    _ = &min;
    if (tempo < min) {
        tempo = min;
    }
    mm_mastertempo = tempo;
    mpp_clayer = @as(c_uint, @bitCast(MM_MAIN));
    if (@as(c_int, @bitCast(@as(c_uint, mmLayerMain.bpm))) != @as(c_int, 0)) {
        mpp_setbpm(&mmLayerMain, @as(mm_word, @bitCast(@as(c_uint, mmLayerMain.bpm))));
    }
}
pub export fn mmSetModulePitch(arg_pitch: mm_word) void {
    var pitch = arg_pitch;
    _ = &pitch;
    var max: mm_word = @as(mm_word, @bitCast(@as(c_int, 2048)));
    _ = &max;
    if (pitch > max) {
        pitch = max;
    }
    var min: mm_word = @as(mm_word, @bitCast(@as(c_int, 512)));
    _ = &min;
    if (pitch < min) {
        pitch = min;
    }
    mm_masterpitch = pitch;
}
pub const struct_tmm_mas_head = @import("mas_arm.zig").struct_tmm_mas_head;
pub const mm_mas_head = struct_tmm_mas_head;
pub export fn mmPlayModule(arg_address: usize, arg_mode: mm_word, arg_layer: mm_word) void {
    var address = arg_address;
    _ = &address;
    var mode = arg_mode;
    _ = &mode;
    var layer = arg_layer;
    _ = &layer;
    debugPrint("[mmPlayModule] address=0x{x} mode={d} layer={d}\n", .{ address, mode, layer });
    // Read MAS header fields byte-wise to avoid layout drift
    const hptr: [*]const u8 = @ptrFromInt(address);
    const order_count: u8 = hptr[0];
    const instr_count: u8 = hptr[1];
    const sampl_count: u8 = hptr[2];
    const pattn_count: u8 = hptr[3];
    const flags_b: u8 = hptr[4];
    const gvol_b: u8 = hptr[5];
    const spd_b: u8 = hptr[6];
    const tempo_b: u8 = hptr[7];
    const rpt_b: u8 = hptr[8];
    _ = rpt_b;
    const header: [*c]mm_mas_head = @ptrFromInt(address);
    mpp_clayer = @as(c_uint, @bitCast(layer));
    var layer_info: [*c]mpl_layer_information = undefined;
    _ = &layer_info;
    var channels: [*c]mm_module_channel = undefined;
    _ = &channels;
    var num_ch: mm_word = undefined;
    _ = &num_ch;
    if (layer == @as(mm_word, @bitCast(MM_MAIN))) {
        layer_info = &mmLayerMain;
        channels = mm_pchannels;
        num_ch = mm_num_mch;
    } else {
        layer_info = &mmLayerSub;
        channels = @as([*c]mm_module_channel, @ptrCast(@alignCast(&mm_schannels[@as(usize, @intCast(0))])));
        num_ch = 4;
    }
    debugPrint(
        "[mmPlayModule] num_ch={d} channels_ptr=0x{x} layer_info=0x{x}\n",
        .{ num_ch, @intFromPtr(channels), @intFromPtr(layer_info) },
    );
    // Print header info after num_ch to match C ordering
    debugPrint(
        "[mmPlayModule] hdr: orders={d} instr={d} sampl={d} pattn={d} flags={x} spd={d} tempo={d} gvol={d}\n",
        .{
            @as(c_int, @intCast(order_count)),
            @as(c_int, @intCast(instr_count)),
            @as(c_int, @intCast(sampl_count)),
            @as(c_int, @intCast(pattn_count)),
            @as(c_int, @intCast(flags_b)),
            @as(c_int, @intCast(spd_b)),
            @as(c_int, @intCast(tempo_b)),
            @as(c_int, @intCast(gvol_b)),
        },
    );
    layer_info.*.mode = @as(mm_byte, @bitCast(@as(u8, @truncate(mode))));
    layer_info.*.songadr = header;
    // C reference does not log pre-reset internals here
    mpp_resetchannels(channels, num_ch);
    // Setup instrument, sample and pattern tables - use the tables array directly like C version
    const instn_size: usize = @as(usize, @intCast(instr_count));
    const sampn_size: usize = @as(usize, @intCast(sampl_count));
    const tables_ptr = header.*.tables();
    layer_info.*.insttable = @constCast(@ptrCast(@alignCast(&tables_ptr[0])));
    layer_info.*.samptable = @constCast(@ptrCast(@alignCast(&tables_ptr[instn_size])));
    layer_info.*.patttable = @constCast(@ptrCast(@alignCast(&tables_ptr[instn_size + sampn_size])));
    debugPrint(
        "[mmPlayModule] tables inst=0x{x} samp=0x{x} patt=0x{x}\n",
        .{ @intFromPtr(layer_info.*.insttable), @intFromPtr(layer_info.*.samptable), @intFromPtr(layer_info.*.patttable) },
    );
    mpp_setposition(layer_info, @as(mm_word, @bitCast(@as(c_int, 0))));
    debugPrint("[mmPlayModule] after setposition pos={d} row={d} tick={d}\n", .{ @as(c_int, @intCast(layer_info.*.position)), @as(c_int, @intCast(layer_info.*.row)), @as(c_int, @intCast(layer_info.*.tick)) });
    mpp_setbpm(layer_info, @as(mm_word, @bitCast(@as(c_uint, header.*.initial_tempo))));
    debugPrint("[mpp_setbpm] MAIN tickrate={d}\n", .{@as(c_int, @intCast(layer_info.*.tickrate))});
    layer_info.*.global_volume = header.*.global_volume;
    var flags: mm_word = @as(mm_word, @bitCast(@as(c_uint, header.*.flags)));
    _ = &flags;
    layer_info.*.flags = @as(mm_byte, @bitCast(@as(u8, @truncate(flags))));
    layer_info.*.oldeffects = @as(mm_byte, @bitCast(@as(u8, @truncate((flags >> @intCast(1)) & @as(mm_word, @bitCast(@as(c_int, 1)))))));
    layer_info.*.speed = header.*.initial_speed;
    // C reference does not emit a separate line here; omit
    layer_info.*.isplaying = 1;
    layer_info.*.valid = 1;
    debugPrint(
        "[mmPlayModule] set isplaying={d} valid={d} speed={d} tempo={d}\n",
        .{ @as(c_int, @intCast(layer_info.*.isplaying)), @as(c_int, @intCast(layer_info.*.valid)), @as(c_int, @intCast(layer_info.*.speed)), @as(c_int, @intCast(header.*.initial_tempo)) },
    );
    mpp_resetvars(layer_info);
    {
        var i: mm_word = 0;
        _ = &i;
        while (i < num_ch) : (i +%= 1) {
            channels[i].cvolume = header.*.channel_volume[i];
        }
    }
    {
        var i: mm_word = 0;
        _ = &i;
        while (i < num_ch) : (i +%= 1) {
            channels[i].panning = header.*.channel_panning[i];
        }
    }
    // Initialize per-channel volume to XM default (64) to avoid zero afvol at T0
    {
        var i: mm_word = 0;
        _ = &i;
        while (i < num_ch) : (i +%= 1) {
            channels[i].volume = @as(mm_byte, @intCast(64));
        }
    }
    // C reference does not log an extra exit line here
    debugPrint(
        "[mmPlayModule] end isplaying={d} valid={d} pos={d} row={d} tick={d}\n",
        .{ @as(c_int, @intCast(layer_info.*.isplaying)), @as(c_int, @intCast(layer_info.*.valid)), @as(c_int, @intCast(layer_info.*.position)), @as(c_int, @intCast(layer_info.*.row)), @as(c_int, @intCast(layer_info.*.tick)) },
    );
}
pub export fn mmJingleStart(arg_module_ID: mm_word, arg_mode: mm_pmode) void {
    var module_ID = arg_module_ID;
    _ = &module_ID;
    var mode = arg_mode;
    _ = &mode;
    if (module_ID >= mmGetModuleCount()) return;
    mpps_backdoor(module_ID, mode, @as(c_uint, @bitCast(MM_JINGLE)));
}
pub fn mmJingle(arg_module_ID: mm_word) callconv(.c) void {
    var module_ID = arg_module_ID;
    _ = &module_ID;
    mmJingleStart(module_ID, @as(c_uint, @bitCast(MM_PLAY_ONCE)));
}
pub export fn mmJinglePause() void {
    if (@as(c_int, @bitCast(@as(c_uint, mmLayerSub.valid))) == @as(c_int, 0)) return;
    mmLayerSub.isplaying = 0;
    debugPrint("[mmPause JINGLE] sub.isplaying -> 0\n", .{});
    mpp_suspend(@as(c_uint, @bitCast(MM_JINGLE)));
}
pub export fn mmJingleResume() void {
    if (@as(c_int, @bitCast(@as(c_uint, mmLayerSub.valid))) == @as(c_int, 0)) return;
    mmLayerSub.isplaying = 1;
    debugPrint("[mmResume JINGLE] sub.isplaying -> 1\n", .{});
}
pub export fn mmJingleStop() void {
    mpp_clayer = @as(c_uint, @bitCast(MM_JINGLE));
    mppStop();
}
pub export fn mmJingleActive() mm_bool {
    return mmLayerSub.isplaying;
}
pub fn mmActiveSub() callconv(.c) mm_bool {
    return mmJingleActive();
}
pub export fn mmSetJingleVolume(arg_volume: mm_word) void {
    var volume = arg_volume;
    _ = &volume;
    if (volume > @as(mm_word, @bitCast(@as(c_int, 1024)))) {
        volume = @as(mm_word, @bitCast(@as(c_int, 1024)));
    }
    mmLayerSub.volume = @as(mm_hword, @bitCast(@as(c_ushort, @truncate(volume))));
}
pub extern fn mmEffect(sample_ID: mm_word) mm_sfxhand;
pub extern fn mmEffectEx(sound: [*c]mm_sound_effect) mm_sfxhand;
pub extern fn mmEffectVolume(handle: mm_sfxhand, volume: mm_word) void;
pub extern fn mmEffectPanning(handle: mm_sfxhand, panning: mm_byte) void;
pub extern fn mmEffectRate(handle: mm_sfxhand, rate: mm_word) void;
pub extern fn mmEffectScaleRate(handle: mm_sfxhand, factor: mm_word) void;
pub extern fn mmEffectActive(handle: mm_sfxhand) mm_bool;
pub extern fn mmEffectCancel(handle: mm_sfxhand) mm_word;
pub extern fn mmEffectRelease(handle: mm_sfxhand) void;
pub extern fn mmEffectCancelAll() void;
pub const struct_tmm_mas_prefix = extern struct {
    size: mm_word = @import("std").mem.zeroes(mm_word),
    type: mm_byte = @import("std").mem.zeroes(mm_byte),
    version: mm_byte = @import("std").mem.zeroes(mm_byte),
    reserved: [2]mm_byte = @import("std").mem.zeroes([2]mm_byte),
};
pub const mm_mas_prefix = struct_tmm_mas_prefix;
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
// Translate-C produced an opaque for envelope node entries. We only need the
// 2-byte + 2-byte layout { value: i16, delta: i16 } to run the math. Define it.
// Envelope node bitfield layout in C:
//   mm_shword delta; mm_hword base:7; mm_hword range:9;
// Represent as packed and provide accessors.
pub const mm_mas_envelope_node = extern struct {
    delta: mm_shword, // signed 16-bit delta
    bits: mm_hword, // [range:9 | base:7]
};
inline fn env_node_base(n: mm_mas_envelope_node) mm_hword {
    return @as(mm_hword, n.bits & @as(mm_hword, 0x7F));
}
inline fn env_node_range(n: mm_mas_envelope_node) mm_hword {
    return @as(mm_hword, n.bits >> 7);
}
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
    // Exact 1-byte packing like C; no extra alignment on first field
    default_volume: mm_byte = @import("std").mem.zeroes(mm_byte),
    panning: mm_byte = @import("std").mem.zeroes(mm_byte),
    frequency: mm_hword = @import("std").mem.zeroes(mm_hword),
    av_type: mm_byte = @import("std").mem.zeroes(mm_byte),
    av_depth: mm_byte = @import("std").mem.zeroes(mm_byte),
    av_speed: mm_byte = @import("std").mem.zeroes(mm_byte),
    global_volume: mm_byte = @import("std").mem.zeroes(mm_byte),
    av_rate: mm_hword = @import("std").mem.zeroes(mm_hword),
    msl_id: mm_hword = @import("std").mem.zeroes(mm_hword),
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
// Guard: per-channel last tick we logged [UMIX]/[DISPAN] to avoid duplicate pairs
// Throttle UMIX logging to avoid audio disruption.
// - Only log on tick==0 (first tick of a row)
// - Only log for first two channels to reduce volume
// - Global budget to cap total prints per session
var umix_debug_budget: c_int = 2000;
pub inline fn umix_channel_index_from_mix(mix_ch: [*c]const mm_mixer_channel) c_int {
    const offset = @intFromPtr(mix_ch) - @intFromPtr(&mm_mix_channels[0]);
    return @as(c_int, @intCast(offset / @sizeOf(mm_mixer_channel)));
}
pub inline fn umix_allow_log_ch(layer: [*c]const mpl_layer_information, ch_idx: c_int) bool {
    if (umix_debug_budget <= 0) return false;
    // Allow channels 0,1,9 for focused early-audio tracing (cymbal/drums/bassline)
    if (!(ch_idx == 0 or ch_idx == 1 or ch_idx == 9)) return false;
    // Allow all ticks for channel 9 debugging
    if (ch_idx == 9) return true;
    // Only gate by tick for non-9 channels
    if (layer.*.tick != 0) return false;
    umix_debug_budget -= 1;
    return true;
} // No per-channel tick suppression: match C's umix_allow_log_ch behavior
// (only ticks==0 and first two channels are gated; no duplicate suppression).
pub const struct_tmslheaddata = extern struct {
    sampleCount: mm_hword = @import("std").mem.zeroes(mm_hword),
    moduleCount: mm_hword = @import("std").mem.zeroes(mm_hword),
    pad: mm_hword = @import("std").mem.zeroes(mm_hword),
    pad2: mm_hword = @import("std").mem.zeroes(mm_hword),
};
pub const msl_head_data = struct_tmslheaddata;
pub const struct_tmslhead = extern struct {
    head_data: msl_head_data align(4) = @import("std").mem.zeroes(msl_head_data),
    pub fn sampleTable(self: *const @This()) [*]const u32 {
        const base: [*]const u8 = @ptrCast(@alignCast(self));
        return @as([*]const u32, @ptrCast(@alignCast(base + 8)));
    }
    pub fn moduleTable(self: *const @This()) [*]const u32 {
        const samples = self.head_data.sampleCount;
        const samp_tbl = self.sampleTable();
        return samp_tbl + samples;
    }
};
pub const msl_head = struct_tmslhead;
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
pub const mpl_layer_information = @import("mas_arm.zig").mpl_layer_information;
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
pub export fn mppUpdateSub() void {
    if (@as(c_int, @bitCast(@as(c_uint, mmLayerSub.isplaying))) == @as(c_int, 0)) return;
    mpp_channels = @as([*c]mm_module_channel, @ptrCast(@alignCast(&mm_schannels[@as(usize, @intCast(0))])));
    mpp_nchannels = 4;
    mpp_clayer = @as(c_uint, @bitCast(MM_JINGLE));
    mpp_layerp = &mmLayerSub;
    var tickrate: mm_word = @as(mm_word, @bitCast(@as(c_uint, mmLayerSub.tickrate)));
    _ = &tickrate;
    var tickfrac: mm_word = @as(mm_word, @bitCast(@as(c_uint, mmLayerSub.unnamed_0.tickfrac)));
    _ = &tickfrac;
    tickfrac = tickfrac +% (tickrate << @intCast(1));
    mmLayerSub.unnamed_0.tickfrac = @as(mm_hword, @bitCast(@as(c_ushort, @truncate(tickfrac))));
    tickfrac >>= @intCast(@as(c_int, 16));
    while (tickfrac > @as(mm_word, @bitCast(@as(c_int, 0)))) {
        mppProcessTick();
        tickfrac -%= 1;
    }
}
pub export fn mppProcessTick() linksection(".iwram") void {
    var layer: [*c]mpl_layer_information = mpp_layerp;
    _ = &layer;
    if (@as(c_int, @bitCast(@as(c_uint, layer.*.isplaying))) == @as(c_int, 0)) return;
    if ((@as(c_int, @bitCast(@as(c_uint, layer.*.pattdelay))) == @as(c_int, 0)) and (@as(c_int, @bitCast(@as(c_uint, layer.*.tick))) == @as(c_int, 0))) {
        // No extra mppProcessTick pre-read log in C reference
        var ok: mm_bool = mmReadPattern(layer);
        _ = &ok;
        if (@as(c_int, @bitCast(@as(c_uint, ok))) == @as(c_int, 0)) {
            // No extra failure log in C reference
            mppStop();
            if (mmCallback != @as(mm_callback, @ptrCast(@alignCast(@as(?*anyopaque, @ptrFromInt(@as(c_int, 0))))))) {
                _ = mmCallback.?(@as(mm_word, @bitCast(@as(c_int, 44))), @as(mm_word, @bitCast(mpp_clayer)));
            }
            return;
        }
    }
    var update_bits: mm_word = layer.*.mch_update;
    _ = &update_bits;
    var module_channels: [*c]mm_module_channel = mpp_channels;
    _ = &module_channels;
    {
        var channel_counter: mm_word = 0;
        _ = &channel_counter;
        while (true) : (channel_counter +%= 1) {
            if ((update_bits & @as(mm_word, @bitCast(@as(c_int, 1) << @intCast(0)))) != 0) {
                if (@as(c_int, @bitCast(@as(c_uint, layer.*.tick))) == @as(c_int, 0)) {
                    mmUpdateChannel_T0(module_channels, layer, @as(mm_byte, @bitCast(@as(u8, @truncate(channel_counter)))));
                } else {
                    mmUpdateChannel_TN(module_channels, layer);
                }
            }
            module_channels += 1;
            update_bits >>= @intCast(@as(c_int, 1));
            if (update_bits == @as(mm_word, @bitCast(@as(c_int, 0)))) break;
        }
    }
    var act_ch: [*c]mm_active_channel = &mm_achannels[@as(c_uint, @intCast(@as(c_int, 0)))];
    _ = &act_ch;
    {
        var ch: mm_word = 0;
        _ = &ch;
        while (ch < mm_num_ach) : (ch +%= 1) {
            if (@as(c_int, @bitCast(@as(c_uint, act_ch.*.type))) != @as(c_int, 0)) {
                if (mpp_clayer == @as(c_uint, @bitCast((@as(c_int, @bitCast(@as(c_uint, act_ch.*.flags))) & ((@as(c_int, 1) << @intCast(6)) | (@as(c_int, 1) << @intCast(7)))) >> @intCast(6)))) {
                    mpp_vars.afvol = act_ch.*.volume;
                    mpp_vars.panplus = 0;
                    mpp_Update_ACHN(layer, act_ch, act_ch.*.period, ch);
                }
            }
            act_ch.*.flags &= @as(mm_byte, @bitCast(@as(i8, @truncate(~(@as(c_int, 1) << @intCast(3))))));
            act_ch += 1;
        }
    }
    var new_tick: mm_word = @as(mm_word, @bitCast(@as(c_int, @bitCast(@as(c_uint, layer.*.tick))) + @as(c_int, 1)));
    _ = &new_tick;
    // No extra tick delta log in C reference
    if (new_tick < @as(mm_word, @bitCast(@as(c_uint, layer.*.speed)))) {
        layer.*.tick = @as(mm_byte, @bitCast(@as(u8, @truncate(new_tick))));
        // No extra early-return log in C reference
        return;
    }
    if (@as(c_int, @bitCast(@as(c_uint, layer.*.fpattdelay))) != @as(c_int, 0)) {
        layer.*.fpattdelay -%= 1;
    }
    if (@as(c_int, @bitCast(@as(c_uint, layer.*.pattdelay))) != @as(c_int, 0)) {
        layer.*.pattdelay -%= 1;
        if (@as(c_int, @bitCast(@as(c_uint, layer.*.pattdelay))) != @as(c_int, 0)) {
            layer.*.tick = 0;
            return;
        }
    }
    layer.*.tick = 0;
    // No extra row-advance log in C reference
    if (@as(c_int, @bitCast(@as(c_uint, layer.*.pattjump))) != @as(c_int, 255)) {
        mpp_setposition(layer, @as(mm_word, @bitCast(@as(c_uint, layer.*.pattjump))));
        layer.*.pattjump = 255;
        if (@as(c_int, @bitCast(@as(c_uint, layer.*.pattjump_row))) == @as(c_int, 0)) return;
        mpph_FastForward(layer, @as(mm_word, @bitCast(@as(c_uint, layer.*.pattjump_row))));
        layer.*.pattjump_row = 0;
        return;
    }
    if (@as(c_int, @bitCast(@as(c_uint, layer.*.ploop_jump))) != @as(c_int, 0)) {
        layer.*.ploop_jump = 0;
        layer.*.row = layer.*.ploop_row;
        layer.*.pattread = layer.*.ploop_adr;
        return;
    }
    var new_row: c_int = @as(c_int, @bitCast(@as(c_uint, layer.*.row))) + @as(c_int, 1);
    _ = &new_row;
    if (new_row != (@as(c_int, @bitCast(@as(c_uint, layer.*.nrows))) + @as(c_int, 1))) {
        layer.*.row = @as(mm_byte, @bitCast(@as(i8, @truncate(new_row))));
        return;
    }
    mpp_setposition(layer, @as(mm_word, @bitCast(@as(c_int, @bitCast(@as(c_uint, layer.*.position))) + @as(c_int, 1))));
}
pub extern fn mmAllocChannel() mm_word;
pub extern fn mmUpdateChannel_T0([*c]mm_module_channel, [*c]mpl_layer_information, mm_byte) void;
pub extern fn mmUpdateChannel_TN([*c]mm_module_channel, [*c]mpl_layer_information) void;
pub extern fn mmGetPeriod([*c]mpl_layer_information, mm_word, mm_byte) mm_word;
const mmReadPattern = @import("mas_arm.zig").mmReadPattern;
pub export fn mpp_Process_VolumeCommand(arg_layer: [*c]mpl_layer_information, arg_act_ch: [*c]mm_active_channel, arg_channel: [*c]mm_module_channel, arg_period: mm_word) mm_word {
    var layer = arg_layer;
    _ = &layer;
    var act_ch = arg_act_ch;
    _ = &act_ch;
    var channel = arg_channel;
    _ = &channel;
    var period = arg_period;
    _ = &period;
    var tick: mm_byte = layer.*.tick;
    _ = &tick;
    var header: [*c]mm_mas_head = layer.*.songadr;
    _ = &header;
    var volcmd: mm_byte = channel.*.volcmd;
    _ = &volcmd;
    if ((@as(c_int, @bitCast(@as(c_uint, header.*.flags))) & (@as(c_int, 1) << @intCast(3))) != 0) {
        if (@as(c_int, @bitCast(@as(c_uint, volcmd))) == @as(c_int, 0)) {} else if (@as(c_int, @bitCast(@as(c_uint, volcmd))) <= @as(c_int, 80)) {
            if (@as(c_int, @bitCast(@as(c_uint, tick))) == @as(c_int, 0)) {
                channel.*.volume = @as(mm_byte, @bitCast(@as(i8, @truncate(@as(c_int, @bitCast(@as(c_uint, volcmd))) - @as(c_int, 16)))));
            }
        } else if (@as(c_int, @bitCast(@as(c_uint, volcmd))) < @as(c_int, 128)) {
            if (@as(c_int, @bitCast(@as(c_uint, tick))) == @as(c_int, 0)) return period;
            var volume: c_int = @as(c_int, @bitCast(@as(c_uint, channel.*.volume)));
            _ = &volume;
            var mem: mm_byte = channel.*.memory[@as(c_uint, @intCast(@as(c_int, 12)))];
            _ = &mem;
            if (@as(c_int, @bitCast(@as(c_uint, volcmd))) < @as(c_int, 112)) {
                volcmd -%= @as(mm_byte, @bitCast(@as(i8, @truncate(@as(c_int, 96)))));
                var delta: c_int = undefined;
                _ = &delta;
                if (@as(c_int, @bitCast(@as(c_uint, volcmd))) == @as(c_int, 0)) {
                    delta = @as(c_int, @bitCast(@as(c_uint, mem))) & @as(c_int, 15);
                } else {
                    delta = @as(c_int, @bitCast(@as(c_uint, volcmd)));
                    channel.*.memory[@as(c_uint, @intCast(@as(c_int, 12)))] = @as(mm_byte, @bitCast(@as(i8, @truncate((@as(c_int, @bitCast(@as(c_uint, mem))) & ~@as(c_int, 15)) | @as(c_int, @bitCast(@as(c_uint, volcmd)))))));
                }
                volume -= delta;
                if (volume < @as(c_int, 0)) {
                    volume = 0;
                }
                channel.*.volume = @as(mm_byte, @bitCast(@as(i8, @truncate(volume))));
            } else {
                volcmd -%= @as(mm_byte, @bitCast(@as(i8, @truncate(@as(c_int, 112)))));
                var delta: c_int = undefined;
                _ = &delta;
                if (@as(c_int, @bitCast(@as(c_uint, volcmd))) == @as(c_int, 0)) {
                    delta = @as(c_int, @bitCast(@as(c_uint, mem))) >> @intCast(4);
                } else {
                    delta = @as(c_int, @bitCast(@as(c_uint, volcmd)));
                    channel.*.memory[@as(c_uint, @intCast(@as(c_int, 12)))] = @as(mm_byte, @bitCast(@as(i8, @truncate((@as(c_int, @bitCast(@as(c_uint, volcmd))) << @intCast(4)) | (@as(c_int, @bitCast(@as(c_uint, mem))) & @as(c_int, 15))))));
                }
                volume += delta;
                if (volume > @as(c_int, 64)) {
                    volume = 64;
                }
                channel.*.volume = @as(mm_byte, @bitCast(@as(i8, @truncate(volume))));
            }
        } else if (@as(c_int, @bitCast(@as(c_uint, volcmd))) < @as(c_int, 160)) {
            if (@as(c_int, @bitCast(@as(c_uint, tick))) != @as(c_int, 0)) return period;
            var volume: c_int = @as(c_int, @bitCast(@as(c_uint, channel.*.volume)));
            _ = &volume;
            var mem: mm_byte = channel.*.memory[@as(c_uint, @intCast(@as(c_int, 13)))];
            _ = &mem;
            if (@as(c_int, @bitCast(@as(c_uint, volcmd))) < @as(c_int, 144)) {
                volcmd -%= @as(mm_byte, @bitCast(@as(i8, @truncate(@as(c_int, 128)))));
                var delta: c_int = undefined;
                _ = &delta;
                if (@as(c_int, @bitCast(@as(c_uint, volcmd))) == @as(c_int, 0)) {
                    delta = @as(c_int, @bitCast(@as(c_uint, mem))) & @as(c_int, 15);
                } else {
                    delta = @as(c_int, @bitCast(@as(c_uint, volcmd)));
                    channel.*.memory[@as(c_uint, @intCast(@as(c_int, 13)))] = @as(mm_byte, @bitCast(@as(i8, @truncate((@as(c_int, @bitCast(@as(c_uint, mem))) & ~@as(c_int, 15)) | @as(c_int, @bitCast(@as(c_uint, volcmd)))))));
                }
                volume -= delta;
                if (volume < @as(c_int, 0)) {
                    volume = 0;
                }
                channel.*.volume = @as(mm_byte, @bitCast(@as(i8, @truncate(volume))));
            } else {
                volcmd -%= @as(mm_byte, @bitCast(@as(i8, @truncate(@as(c_int, 144)))));
                var delta: c_int = undefined;
                _ = &delta;
                if (@as(c_int, @bitCast(@as(c_uint, volcmd))) == @as(c_int, 0)) {
                    delta = @as(c_int, @bitCast(@as(c_uint, mem))) >> @intCast(4);
                } else {
                    delta = @as(c_int, @bitCast(@as(c_uint, volcmd)));
                    channel.*.memory[@as(c_uint, @intCast(@as(c_int, 13)))] = @as(mm_byte, @bitCast(@as(i8, @truncate((@as(c_int, @bitCast(@as(c_uint, volcmd))) << @intCast(4)) | (@as(c_int, @bitCast(@as(c_uint, mem))) & @as(c_int, 15))))));
                }
                volume += delta;
                if (volume > @as(c_int, 64)) {
                    volume = 64;
                }
                channel.*.volume = @as(mm_byte, @bitCast(@as(i8, @truncate(volume))));
            }
        } else if (@as(c_int, @bitCast(@as(c_uint, volcmd))) < @as(c_int, 192)) {
            if (@as(c_int, @bitCast(@as(c_uint, tick))) == @as(c_int, 0)) return period;
            if (@as(c_int, @bitCast(@as(c_uint, volcmd))) < @as(c_int, 176)) {
                volcmd = @as(mm_byte, @bitCast(@as(i8, @truncate((@as(c_int, @bitCast(@as(c_uint, volcmd))) - @as(c_int, 160)) << @intCast(2)))));
                if (@as(c_int, @bitCast(@as(c_uint, volcmd))) != @as(c_int, 0)) {
                    channel.*.vibspd = volcmd;
                }
            } else {
                volcmd = @as(mm_byte, @bitCast(@as(i8, @truncate((@as(c_int, @bitCast(@as(c_uint, volcmd))) - @as(c_int, 176)) << @intCast(3)))));
                if (@as(c_int, @bitCast(@as(c_uint, volcmd))) != @as(c_int, 0)) {
                    channel.*.vibdep = volcmd;
                }
            }
            return mppe_DoVibrato(period, channel, layer);
        } else if (@as(c_int, @bitCast(@as(c_uint, volcmd))) < @as(c_int, 208)) {
            if (@as(c_int, @bitCast(@as(c_uint, tick))) != @as(c_int, 0)) return period;
            var panning: mm_word = @as(mm_word, @bitCast((@as(c_int, @bitCast(@as(c_uint, volcmd))) - @as(c_int, 192)) << @intCast(4)));
            _ = &panning;
            if (panning == @as(mm_word, @bitCast(@as(c_int, 240)))) {
                channel.*.panning = 255;
            } else {
                channel.*.panning = @as(mm_byte, @bitCast(@as(u8, @truncate(panning))));
            }
        } else if (@as(c_int, @bitCast(@as(c_uint, volcmd))) < @as(c_int, 240)) {
            if (@as(c_int, @bitCast(@as(c_uint, tick))) == @as(c_int, 0)) return period;
            var panning: c_int = @as(c_int, @bitCast(@as(c_uint, channel.*.panning)));
            _ = &panning;
            var mem: mm_byte = channel.*.memory[@as(c_uint, @intCast(@as(c_int, 7)))];
            _ = &mem;
            if (@as(c_int, @bitCast(@as(c_uint, volcmd))) < @as(c_int, 224)) {
                volcmd -%= @as(mm_byte, @bitCast(@as(i8, @truncate(@as(c_int, 208)))));
                var delta: c_int = undefined;
                _ = &delta;
                if (@as(c_int, @bitCast(@as(c_uint, volcmd))) == @as(c_int, 0)) {
                    delta = @as(c_int, @bitCast(@as(c_uint, mem))) >> @intCast(4);
                } else {
                    channel.*.memory[@as(c_uint, @intCast(@as(c_int, 7)))] = @as(mm_byte, @bitCast(@as(i8, @truncate((@as(c_int, @bitCast(@as(c_uint, mem))) & @as(c_int, 15)) | (@as(c_int, @bitCast(@as(c_uint, volcmd))) << @intCast(4))))));
                    delta = @as(c_int, @bitCast(@as(c_uint, volcmd))) & @as(c_int, 15);
                }
                delta <<= @intCast(@as(c_int, 2));
                panning -= delta;
                if (panning < @as(c_int, 0)) {
                    panning = 0;
                }
                channel.*.panning = @as(mm_byte, @bitCast(@as(i8, @truncate(panning))));
            } else {
                volcmd -%= @as(mm_byte, @bitCast(@as(i8, @truncate(@as(c_int, 224)))));
                var delta: c_int = undefined;
                _ = &delta;
                if (@as(c_int, @bitCast(@as(c_uint, volcmd))) == @as(c_int, 0)) {
                    delta = @as(c_int, @bitCast(@as(c_uint, mem))) & @as(c_int, 15);
                } else {
                    delta = @as(c_int, @bitCast(@as(c_uint, volcmd)));
                    channel.*.memory[@as(c_uint, @intCast(@as(c_int, 7)))] = @as(mm_byte, @bitCast(@as(i8, @truncate(@as(c_int, @bitCast(@as(c_uint, volcmd))) | (@as(c_int, @bitCast(@as(c_uint, mem))) & @as(c_int, 15))))));
                }
                delta <<= @intCast(@as(c_int, 2));
                panning += delta;
                if (panning > @as(c_int, 255)) {
                    panning = 255;
                }
                channel.*.panning = @as(mm_byte, @bitCast(@as(i8, @truncate(panning))));
            }
        } else {
            if (@as(c_int, @bitCast(@as(c_uint, tick))) == @as(c_int, 0)) return period;
            volcmd = @as(mm_byte, @bitCast(@as(i8, @truncate((@as(c_int, @bitCast(@as(c_uint, volcmd))) - @as(c_int, 240)) << @intCast(4)))));
            if (@as(c_int, @bitCast(@as(c_uint, volcmd))) != @as(c_int, 0)) {
                channel.*.memory[@as(c_uint, @intCast(@as(c_int, 14)))] = volcmd;
            }
            volcmd = channel.*.memory[@as(c_uint, @intCast(@as(c_int, 14)))];
            return mppe_glis_backdoor(@as(mm_word, @bitCast(@as(c_uint, volcmd))), period, act_ch, channel, layer);
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
                volcmd -%= @as(mm_byte, @bitCast(@as(i8, @truncate(@as(c_int, 65)))));
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
                volcmd -%= @as(mm_byte, @bitCast(@as(i8, @truncate(@as(c_int, 75)))));
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
            channel.*.volume = @as(mm_byte, @bitCast(@as(i8, @truncate(volume))));
        } else if (@as(c_int, @bitCast(@as(c_uint, volcmd))) <= @as(c_int, 104)) {
            if (@as(c_int, @bitCast(@as(c_uint, tick))) == @as(c_int, 0)) return period;
            var volume: c_int = @as(c_int, @bitCast(@as(c_uint, channel.*.volume)));
            _ = &volume;
            if (@as(c_int, @bitCast(@as(c_uint, volcmd))) < @as(c_int, 95)) {
                volcmd -%= @as(mm_byte, @bitCast(@as(i8, @truncate(@as(c_int, 85)))));
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
                volcmd -%= @as(mm_byte, @bitCast(@as(i8, @truncate(@as(c_int, 95)))));
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
            channel.*.volume = @as(mm_byte, @bitCast(@as(i8, @truncate(volume))));
        } else if (@as(c_int, @bitCast(@as(c_uint, volcmd))) <= @as(c_int, 124)) {
            if (@as(c_int, @bitCast(@as(c_uint, tick))) == @as(c_int, 0)) return period;
            var r0: mm_word = undefined;
            _ = &r0;
            if (@as(c_int, @bitCast(@as(c_uint, volcmd))) >= @as(c_int, 115)) {
                volcmd = @as(mm_byte, @bitCast(@as(i8, @truncate((@as(c_int, @bitCast(@as(c_uint, volcmd))) - @as(c_int, 115)) << @intCast(2)))));
                if (@as(c_int, @bitCast(@as(c_uint, volcmd))) == @as(c_int, 0)) {
                    volcmd = channel.*.memory[@as(c_uint, @intCast(@as(c_int, 2)))];
                }
                channel.*.memory[@as(c_uint, @intCast(@as(c_int, 2)))] = volcmd;
                r0 = mpph_PitchSlide_Up(channel.*.period, @as(mm_word, @bitCast(@as(c_uint, volcmd))), layer);
            } else {
                volcmd = @as(mm_byte, @bitCast(@as(i8, @truncate((@as(c_int, @bitCast(@as(c_uint, volcmd))) - @as(c_int, 105)) << @intCast(2)))));
                if (@as(c_int, @bitCast(@as(c_uint, volcmd))) == @as(c_int, 0)) {
                    volcmd = channel.*.memory[@as(c_uint, @intCast(@as(c_int, 2)))];
                }
                channel.*.memory[@as(c_uint, @intCast(@as(c_int, 2)))] = volcmd;
                r0 = mpph_PitchSlide_Down(channel.*.period, @as(mm_word, @bitCast(@as(c_uint, volcmd))), layer);
            }
            var r1: mm_word = channel.*.period;
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
                channel.*.panning = @as(mm_byte, @bitCast(@as(i8, @truncate(panning))));
            }
        } else if (@as(c_int, @bitCast(@as(c_uint, volcmd))) <= @as(c_int, 202)) {
            if (@as(c_int, @bitCast(@as(c_uint, tick))) == @as(c_int, 0)) return period;
            const vcmd_glissando_table: [10]mm_byte = [10]mm_byte{
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
            volcmd -%= @as(mm_byte, @bitCast(@as(i8, @truncate(@as(c_int, 193)))));
            var glis: mm_word = @as(mm_word, @bitCast(@as(c_uint, vcmd_glissando_table[volcmd])));
            _ = &glis;
            if ((@as(c_int, @bitCast(@as(c_uint, layer.*.flags))) & (@as(c_int, 1) << @intCast(0))) != 0) {
                if (glis == @as(mm_word, @bitCast(@as(c_int, 0)))) {
                    glis = @as(mm_word, @bitCast(@as(c_uint, channel.*.memory[@as(c_uint, @intCast(@as(c_int, 2)))])));
                }
                channel.*.memory[@as(c_uint, @intCast(@as(c_int, 2)))] = @as(mm_byte, @bitCast(@as(u8, @truncate(glis))));
                channel.*.memory[@as(c_uint, @intCast(@as(c_int, 0)))] = @as(mm_byte, @bitCast(@as(u8, @truncate(glis))));
                var mem: mm_byte = channel.*.memory[@as(c_uint, @intCast(@as(c_int, 0)))];
                _ = &mem;
                return mppe_glis_backdoor(@as(mm_word, @bitCast(@as(c_uint, mem))), period, act_ch, channel, layer);
            } else {
                if (glis == @as(mm_word, @bitCast(@as(c_int, 0)))) {
                    glis = @as(mm_word, @bitCast(@as(c_uint, channel.*.memory[@as(c_uint, @intCast(@as(c_int, 0)))])));
                }
                channel.*.memory[@as(c_uint, @intCast(@as(c_int, 0)))] = @as(mm_byte, @bitCast(@as(u8, @truncate(glis))));
                var mem: mm_byte = channel.*.memory[@as(c_uint, @intCast(@as(c_int, 0)))];
                _ = &mem;
                return mppe_glis_backdoor(@as(mm_word, @bitCast(@as(c_uint, mem))), period, act_ch, channel, layer);
            }
        } else if (@as(c_int, @bitCast(@as(c_uint, volcmd))) <= @as(c_int, 212)) {
            if (@as(c_int, @bitCast(@as(c_uint, tick))) == @as(c_int, 0)) return period;
            volcmd = @as(mm_byte, @bitCast(@as(i8, @truncate(@as(c_int, @bitCast(@as(c_uint, volcmd))) - @as(c_int, 203)))));
            if (@as(c_int, @bitCast(@as(c_uint, volcmd))) != @as(c_int, 0)) {
                volcmd = @as(mm_byte, @bitCast(@as(i8, @truncate(@as(c_int, @bitCast(@as(c_uint, volcmd))) << @intCast(2)))));
                channel.*.vibspd = volcmd;
            }
            return mppe_DoVibrato(@as(mm_word, @bitCast(@as(c_uint, volcmd))), channel, layer);
        }
    }
    return period;
}
pub export fn mpp_Process_Effect(arg_layer: [*c]mpl_layer_information, arg_act_ch: [*c]mm_active_channel, arg_channel: [*c]mm_module_channel, arg_period: mm_word) mm_word {
    var layer = arg_layer;
    _ = &layer;
    var act_ch = arg_act_ch;
    _ = &act_ch;
    var channel = arg_channel;
    _ = &channel;
    var period = arg_period;
    _ = &period;
    var param: mm_word = mpp_Channel_ExchangeMemory(channel.*.effect, channel.*.param, channel, layer);
    _ = &param;
    var effect: mm_word = @as(mm_word, @bitCast(@as(c_uint, channel.*.effect)));
    _ = &effect;
    while (true) {
        switch (effect) {
            @as(mm_word, @bitCast(@as(c_int, 0))) => return period,
            @as(mm_word, @bitCast(@as(c_int, 1))) => {
                mppe_SetSpeed(param, layer);
                return period;
            },
            @as(mm_word, @bitCast(@as(c_int, 2))) => {
                mppe_PositionJump(param, layer);
                return period;
            },
            @as(mm_word, @bitCast(@as(c_int, 3))) => {
                mppe_PatternBreak(param, layer);
                return period;
            },
            @as(mm_word, @bitCast(@as(c_int, 4))) => {
                const vol_word = mpph_VolumeSlide64(
                    @as(c_int, @intCast(channel.*.volume)),
                    param,
                    @as(mm_word, @bitCast(@as(c_uint, layer.*.tick))),
                    layer,
                );
                channel.*.volume = @as(mm_byte, @intCast(@as(c_int, @intCast(vol_word))));
                return period;
            },
            @as(mm_word, @bitCast(@as(c_int, 5))), @as(mm_word, @bitCast(@as(c_int, 6))) => return mppe_Portamento(param, period, channel, layer),
            @as(mm_word, @bitCast(@as(c_int, 7))) => return mppe_Glissando(param, period, act_ch, channel, layer),
            @as(mm_word, @bitCast(@as(c_int, 8))) => return mppe_Vibrato(param, period, channel, layer),
            @as(mm_word, @bitCast(@as(c_int, 9))) => return period,
            @as(mm_word, @bitCast(@as(c_int, 10))) => return mppe_Arpeggio(param, period, act_ch, channel, layer),
            @as(mm_word, @bitCast(@as(c_int, 11))) => return mppe_VibratoVolume(param, period, channel, layer),
            @as(mm_word, @bitCast(@as(c_int, 12))) => return mppe_PortaVolume(param, period, act_ch, channel, layer),
            @as(mm_word, @bitCast(@as(c_int, 13))) => {
                mppe_ChannelVolume(param, channel, layer);
                return period;
            },
            @as(mm_word, @bitCast(@as(c_int, 14))) => {
                mppe_ChannelVolumeSlide(param, channel, layer);
                return period;
            },
            @as(mm_word, @bitCast(@as(c_int, 15))) => {
                mppe_SampleOffset(param, layer);
                return period;
            },
            @as(mm_word, @bitCast(@as(c_int, 16))) => return period,
            @as(mm_word, @bitCast(@as(c_int, 17))) => {
                mppe_Retrigger(param, act_ch, channel);
                return period;
            },
            @as(mm_word, @bitCast(@as(c_int, 18))) => {
                mppe_Tremolo(param, channel, layer);
                return period;
            },
            @as(mm_word, @bitCast(@as(c_int, 19))) => {
                mppe_Extended(param, act_ch, channel, layer);
                return period;
            },
            @as(mm_word, @bitCast(@as(c_int, 20))) => {
                mppe_SetTempo(param, layer);
                return period;
            },
            @as(mm_word, @bitCast(@as(c_int, 21))) => return mppe_FineVibrato(param, period, channel, layer),
            @as(mm_word, @bitCast(@as(c_int, 22))) => {
                mppe_SetGlobalVolume(param, layer);
                return period;
            },
            @as(mm_word, @bitCast(@as(c_int, 23))) => {
                mppe_GlobalVolumeSlide(param, layer);
                return period;
            },
            @as(mm_word, @bitCast(@as(c_int, 24))) => {
                mppe_SetPanning(param, channel, layer);
                return period;
            },
            @as(mm_word, @bitCast(@as(c_int, 25))) => return period,
            @as(mm_word, @bitCast(@as(c_int, 26))) => return period,
            @as(mm_word, @bitCast(@as(c_int, 27))) => {
                mppe_SetVolume(param, channel, layer);
                return period;
            },
            @as(mm_word, @bitCast(@as(c_int, 28))) => {
                mppe_KeyOff(param, act_ch, layer);
                return period;
            },
            @as(mm_word, @bitCast(@as(c_int, 29))) => return period,
            @as(mm_word, @bitCast(@as(c_int, 30))) => {
                mppe_OldTremor(param, channel, layer);
                return period;
            },
            else => return period,
        }
        break;
    }
    return @import("std").mem.zeroes(mm_word);
}
// /Users/braheezy/personal/gba/maxmod-zig/maxmod/source/core/mas.c:3520:9: warning: TODO implement translation of stmt class GotoStmtClass

// /Users/braheezy/personal/gba/maxmod-zig/maxmod/source/core/mas.c:3508:9: warning: unable to translate function, demoted to extern
pub extern fn mpp_Update_ACHN_notest(arg_layer: [*c]mpl_layer_information, arg_act_ch: [*c]mm_active_channel, arg_period: mm_word, arg_ch: mm_word) mm_word;
// /Users/braheezy/personal/gba/maxmod-zig/maxmod/source/core/mas.c:667:9: warning: TODO implement translation of stmt class GotoStmtClass

// /Users/braheezy/personal/gba/maxmod-zig/maxmod/source/core/mas.c:660:17: warning: unable to translate function, demoted to extern
pub export fn mpp_Channel_NewNote(arg_module_channel: [*c]mm_module_channel, arg_layer: [*c]mpl_layer_information) linksection(".iwram") callconv(.c) void {
    const module_channel = arg_module_channel;
    const layer = arg_layer;

    if (module_channel.*.inst == 0) return;

    const act_ch: [*c]mm_active_channel = mpp_Channel_GetACHN(module_channel);
    var need_alloc: bool = false;

    if (act_ch == null) {
        need_alloc = true;
    } else {
        const instrument: *mm_mas_instrument = mpp_InstrumentPointer(layer, module_channel.*.inst) orelse return;

        var do_dca: bool = false;
        const dct: mm_byte = instrument.*.dct & 3;
        if (dct == 1) {
            // DCT Note
            const inst_bytes: [*]u8 = @ptrCast(@alignCast(instrument));
            const nm_ptr_bytes: [*]u8 = inst_bytes + @as(usize, @intCast(instrument.*.note_map_offset));
            const note_map: [*]mm_hword = @ptrCast(@alignCast(nm_ptr_bytes));
            const note: mm_byte = @as(mm_byte, @truncate(note_map[@as(usize, @intCast(module_channel.*.note - 1))] & 0xFF));
            if (note == module_channel.*.note) do_dca = true;
        } else if (dct == 2) {
            // DCT Sample
            const inst_bytes: [*]u8 = @ptrCast(@alignCast(instrument));
            const nm_ptr_bytes: [*]u8 = inst_bytes + @as(usize, @intCast(instrument.*.note_map_offset));
            const note_map: [*]mm_hword = @ptrCast(@alignCast(nm_ptr_bytes));
            const sample_from_map: mm_byte = @as(mm_byte, @truncate(note_map[@as(usize, @intCast(module_channel.*.note - 1))] >> 8));
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
                act_ch.*.flags = @as(mm_byte, @intCast(@as(c_int, act_ch.*.flags) & ~MCAF_KEYON));
                act_ch.*.type = @as(mm_byte, @intCast(ACHN_BACKGROUND));
                need_alloc = true;
            } else {
                act_ch.*.flags = @as(mm_byte, @intCast(@as(c_int, act_ch.*.flags) | MCAF_FADE));
                act_ch.*.type = @as(mm_byte, @intCast(ACHN_BACKGROUND));
                need_alloc = true;
            }
        } else {
            const nna = MCH_BFLAGS_NNA_GET(module_channel.*.bflags);
            if (nna == IT_NNA_CUT) {
                return; // use same channel
            } else if (nna == IT_NNA_CONT) {
                act_ch.*.type = @as(mm_byte, @intCast(ACHN_BACKGROUND));
                need_alloc = true;
            } else if (nna == IT_NNA_OFF) {
                act_ch.*.flags = @as(mm_byte, @intCast(@as(c_int, act_ch.*.flags) & ~MCAF_KEYON));
                act_ch.*.type = @as(mm_byte, @intCast(ACHN_BACKGROUND));
                need_alloc = true;
            } else if (nna == IT_NNA_FADE) {
                act_ch.*.flags = @as(mm_byte, @intCast(@as(c_int, act_ch.*.flags) | MCAF_FADE));
                act_ch.*.type = @as(mm_byte, @intCast(ACHN_BACKGROUND));
                need_alloc = true;
            }
        }
    }

    if (need_alloc) {
        const alloc: mm_word = mmAllocChannel();
        module_channel.*.alloc = @as(mm_byte, @intCast(alloc));
    }
}
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
    // The instrument table contains 32-bit offsets, not raw bytes
    const insttbl_words: [*]const mm_word = @ptrCast(@alignCast(layer.*.insttable));
    const off: mm_word = insttbl_words[instN -% @as(mm_word, @bitCast(@as(c_int, 1)))];
    const ptr: [*]u8 = base + off;
    return @ptrCast(@alignCast(ptr));
}
pub inline fn mpp_PatternPointer(arg_layer: [*c]mpl_layer_information, arg_entry: mm_word) [*c]mm_mas_pattern {
    var layer = arg_layer;
    _ = &layer;
    var entry = arg_entry;
    _ = &entry;
    var base: [*c]mm_byte = @as([*c]mm_byte, @ptrCast(@alignCast(layer.*.songadr)));
    _ = &base;
    const idx: usize = @as(usize, @intCast(entry));
    // The pattern table contains 32-bit offsets, not raw bytes
    const patttbl_words: [*]const mm_word = @ptrCast(@alignCast(layer.*.patttable));
    const offset: mm_word = patttbl_words[idx];
    return @as([*c]mm_mas_pattern, @ptrCast(@alignCast(@as([*]u8, @ptrCast(base)) + @as(usize, @intCast(offset)))));
}
pub extern var mp_solution: [*c]msl_head;
pub extern var mm_mix_channels: [*c]mm_mixer_channel;
pub extern var mm_mixlen: mm_word;
pub extern var mm_bpmdv: mm_word;
pub extern fn mmMixerInit(setup: [*c]mm_gba_system) void;
pub extern fn mmMixerMix(samples_count: mm_word) void;
pub extern fn mmMixerSetRead(channel: c_int, value: mm_word) void;
pub extern fn mmMixerEnd() void;
pub fn mppe_DoVibrato(arg_period: mm_word, arg_channel: [*c]mm_module_channel, arg_layer: [*c]mpl_layer_information) callconv(.c) mm_word {
    var period = arg_period;
    _ = &period;
    var channel = arg_channel;
    _ = &channel;
    var layer = arg_layer;
    _ = &layer;
    var position: mm_byte = undefined;
    _ = &position;
    if ((@as(c_int, @bitCast(@as(c_uint, layer.*.oldeffects))) == @as(c_int, 0)) or (@as(c_int, @bitCast(@as(c_uint, layer.*.tick))) != @as(c_int, 0))) {
        position = @as(mm_byte, @bitCast(@as(i8, @truncate(@as(c_int, @bitCast(@as(c_uint, channel.*.vibspd))) + @as(c_int, @bitCast(@as(c_uint, channel.*.vibpos)))))));
        channel.*.vibpos = position;
    } else {
        position = channel.*.vibpos;
    }
    var value: mm_sword = @as(mm_sword, @bitCast(@as(c_int, mpp_TABLE_FineSineData[position])));
    _ = &value;
    var depth: mm_sword = @as(mm_sword, @bitCast(@as(c_uint, channel.*.vibdep)));
    _ = &depth;
    value = (value * depth) >> @intCast(8);
    if (value < @as(c_int, 0)) return mpph_PitchSlide_Down(period, @as(mm_word, @bitCast(-value)), layer);
    return mpph_PitchSlide_Up(period, @as(mm_word, @bitCast(value)), layer);
}
pub fn mppe_glis_backdoor(arg_param: mm_word, arg_period: mm_word, arg_act_ch: [*c]mm_active_channel, arg_channel: [*c]mm_module_channel, arg_layer: [*c]mpl_layer_information) callconv(.c) mm_word {
    var param = arg_param;
    _ = &param;
    var period = arg_period;
    _ = &period;
    var act_ch = arg_act_ch;
    _ = &act_ch;
    var channel = arg_channel;
    _ = &channel;
    var layer = arg_layer;
    _ = &layer;
    if (act_ch == @as([*c]mm_active_channel, @ptrCast(@alignCast(@as(?*anyopaque, @ptrFromInt(@as(c_int, 0))))))) return period;
    var sample: [*c]mm_mas_sample_info = mpp_SamplePointer(layer, @as(mm_word, @bitCast(@as(c_uint, act_ch.*.sample))));
    _ = &sample;
    var target_period: mm_word = mmGetPeriod(layer, @as(mm_word, @bitCast(@as(c_int, @bitCast(@as(c_uint, sample.*.frequency))) * @as(c_int, 4))), channel.*.note);
    _ = &target_period;
    var new_period: mm_word = undefined;
    _ = &new_period;
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
    var old_period: mm_word = channel.*.period;
    _ = &old_period;
    channel.*.period = new_period;
    var delta: c_int = @as(c_int, @bitCast(new_period -% old_period));
    _ = &delta;
    return period +% @as(mm_word, @bitCast(delta));
}
pub fn mpp_Update_ACHN(arg_layer: [*c]mpl_layer_information, arg_act_ch: [*c]mm_active_channel, arg_period: mm_word, arg_ch: mm_word) callconv(.c) void {
    var layer = arg_layer;
    _ = &layer;
    var act_ch = arg_act_ch;
    _ = &act_ch;
    var period = arg_period;
    _ = &period;
    var ch = arg_ch;
    _ = &ch;
    if ((@as(c_int, @bitCast(@as(c_uint, act_ch.*.flags))) & (@as(c_int, 1) << @intCast(3))) != 0) return;
    _ = mpp_Update_ACHN_notest(layer, act_ch, period, ch);
}
pub var mm_mastertempo: mm_word = @import("std").mem.zeroes(mm_word);
pub export var mm_masterpitch: mm_word = @import("std").mem.zeroes(mm_word);
pub var mmCallback: mm_callback = @import("std").mem.zeroes(mm_callback);
pub fn mpp_setbpm(arg_layer_info: [*c]mpl_layer_information, arg_bpm: mm_word) callconv(.c) void {
    var layer_info = arg_layer_info;
    _ = &layer_info;
    var bpm = arg_bpm;
    _ = &bpm;
    layer_info.*.bpm = @as(mm_byte, @bitCast(@as(u8, @truncate(bpm))));
    if (mpp_clayer == @as(c_uint, @bitCast(MM_MAIN))) {
        var tempo: mm_word = (mm_mastertempo *% bpm) >> @intCast(10);
        _ = &tempo;
        var rate: mm_word = mm_bpmdv / tempo;
        _ = &rate;
        rate &= @as(mm_word, @bitCast(~@as(c_int, 1)));
        layer_info.*.tickrate = @as(mm_hword, @bitCast(@as(c_ushort, @truncate(rate))));
    } else {
        debugPrint("[mpp_setbpm] SUB tickrate={d}\n", .{@as(c_int, @intCast(layer_info.*.tickrate))});
    }
}
pub fn mpp_suspend(arg_layer: mm_layer_type) callconv(.c) void {
    var layer = arg_layer;
    _ = &layer;
    var act_ch: [*c]mm_active_channel = &mm_achannels[@as(c_uint, @intCast(@as(c_int, 0)))];
    _ = &act_ch;
    var mix_ch: [*c]mm_mixer_channel = &mm_mix_channels[@as(c_uint, @intCast(@as(c_int, 0)))];
    _ = &mix_ch;
    {
        var count: mm_word = mm_num_ach;
        _ = &count;
        while (count != @as(mm_word, @bitCast(@as(c_int, 0)))) : (_ = blk: {
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
pub fn mpps_backdoor(arg_id: mm_word, arg_mode: mm_pmode, arg_layer: mm_layer_type) callconv(.c) void {
    var id = arg_id;
    _ = &id;
    var mode = arg_mode;
    _ = &mode;
    var layer = arg_layer;
    _ = &layer;
    var sampleCount: mm_hword = mm_getSampleCount();
    _ = &sampleCount;
    // Use exported module table pointer and read entry as LE32 to avoid alignment issues
    const moduleTable_ptr: [*]const u32 = @ptrCast(mm_getModuleTable());
    const module_table_bytes: [*]const u8 = @ptrCast(moduleTable_ptr);
    const ptr_off: [*]const u8 = module_table_bytes + (@as(usize, @intCast(id)) * 4);
    const entry_off: mm_word = @as(mm_word, @intCast(@as(u32, ptr_off[0]) | (@as(u32, ptr_off[1]) << 8) | (@as(u32, ptr_off[2]) << 16) | (@as(u32, ptr_off[3]) << 24)));
    debugPrint("[mpps_backdoor] id={d} mode={d} layer={d} sampleCount={d}\n", .{ id, mode, layer, sampleCount });
    debugPrint("[mpps_backdoor] moduleTable=0x{x} entry_off={x}\n", .{ @intFromPtr(module_table_bytes), entry_off });
    // Offsets in the module table point to the start of each MAS file,
    // which begins with an 8-byte mm_mas_prefix. Skip it to reach the
    // module header, matching the C reference implementation.
    var moduleAddress: usize = (@as(usize, @intCast(@intFromPtr(mp_solution))) +% entry_off) +% @sizeOf(mm_mas_prefix);
    _ = &moduleAddress;
    debugPrint("[mpps_backdoor] moduleAddress=0x{x}\n", .{moduleAddress});
    mmPlayModule(moduleAddress, @as(mm_word, @bitCast(mode)), @as(mm_word, @bitCast(layer)));
}
pub fn mpp_resetchannels(arg_channels: [*c]mm_module_channel, arg_num_ch: mm_word) callconv(.c) void {
    var channels = arg_channels;
    _ = &channels;
    var num_ch = arg_num_ch;
    _ = &num_ch;
    // No extra reset-channels log in C reference
    _ = memset(@as(?*anyopaque, @ptrCast(channels)), @as(c_int, 0), @sizeOf(mm_module_channel) *% num_ch);
    {
        var i: mm_word = 0;
        _ = &i;
        while (i < num_ch) : (i +%= 1) {
            channels[i].alloc = 255;
        }
    }
    var mix_ch: [*c]mm_mixer_channel = &mm_mix_channels[@as(c_uint, @intCast(@as(c_int, 0)))];
    _ = &mix_ch;
    var act_ch: [*c]mm_active_channel = &mm_achannels[@as(c_uint, @intCast(@as(c_int, 0)))];
    _ = &act_ch;
    {
        var i: mm_word = 0;
        _ = &i;
        while (i < mm_num_ach) : (_ = blk: {
            _ = blk_1: {
                i +%= 1;
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
            if (@as(c_uint, @bitCast((@as(c_int, @bitCast(@as(c_uint, act_ch.*.flags))) & ((@as(c_int, 1) << @intCast(6)) | (@as(c_int, 1) << @intCast(7)))) >> @intCast(6))) != mpp_clayer) continue;
            _ = memset(@as(?*anyopaque, @ptrCast(act_ch)), @as(c_int, 0), @sizeOf(mm_active_channel));
            mix_ch.*.src = MIXCH_GBA_SRC_STOPPED;
        }
    }
}

pub fn mppStop() callconv(.c) void {
    var layer_info: [*c]mpl_layer_information = undefined;
    _ = &layer_info;
    var channels: [*c]mm_module_channel = undefined;
    _ = &channels;
    var num_ch: mm_word = undefined;
    _ = &num_ch;
    if (mpp_clayer == @as(c_uint, @bitCast(MM_JINGLE))) {
        layer_info = &mmLayerSub;
        channels = @as([*c]mm_module_channel, @ptrCast(@alignCast(&mm_schannels[@as(usize, @intCast(0))])));
        num_ch = 4;
    } else {
        layer_info = &mmLayerMain;
        channels = mm_pchannels;
        num_ch = mm_num_mch;
    }
    debugPrint("[mppStop] layer={d} isplaying->0 valid->0\n", .{mpp_clayer});
    layer_info.*.isplaying = 0;
    layer_info.*.valid = 0;
    mpp_resetchannels(channels, num_ch);
}

pub fn mpp_setposition(arg_layer_info: [*c]mpl_layer_information, arg_position: mm_word) callconv(.c) void {
    var layer_info = arg_layer_info;
    _ = &layer_info;
    var position = arg_position;
    _ = &position;
    var header: [*c]mm_mas_head = layer_info.*.songadr;
    _ = &header;
    var entry: mm_byte = undefined;
    _ = &entry;
    while (true) {
        layer_info.*.position = @as(mm_byte, @bitCast(@as(u8, @truncate(position))));
        entry = header.*.sequence[position];
        // C reference does not log per-step position/entry here
        if (@as(c_int, @bitCast(@as(c_uint, entry))) == @as(c_int, 254)) {
            position +%= 1;
            continue;
        }
        if (@as(c_int, @bitCast(@as(c_uint, entry))) != @as(c_int, 255)) break;
        if (@as(c_int, @bitCast(@as(c_uint, layer_info.*.mode))) == MM_PLAY_ONCE) {
            mppStop();
            if (mmCallback != @as(mm_callback, @ptrCast(@alignCast(@as(?*anyopaque, @ptrFromInt(@as(c_int, 0))))))) {
                _ = mmCallback.?(@as(mm_word, @bitCast(@as(c_int, 43))), @as(mm_word, @bitCast(mpp_clayer)));
            }
            return;
        } else {
            position = @as(mm_word, @bitCast(@as(c_uint, header.*.repeat_position)));
        }
    }
    // No C reference logs for table addresses here
    // No C reference logs for patttable dump
    if (@as(c_int, @intCast(header.*.pattn_count)) > @as(c_int, 75)) {
        // No C reference logs here
    }
    // No C reference logs for entry/patt_off
    var patt: [*c]mm_mas_pattern = mpp_PatternPointer(layer_info, @as(mm_word, @bitCast(@as(c_uint, entry))));
    _ = &patt;
    // No C reference logs for patt_ptr/data
    debugPrint("[mpp_setposition] pattern=0x{x} row_count={d}\n", .{ @intFromPtr(patt), @as(c_int, @intCast(patt.*.row_count)) });
    layer_info.*.nrows = patt.*.row_count;
    layer_info.*.tick = 0;
    layer_info.*.row = 0;
    layer_info.*.fpattdelay = 0;
    layer_info.*.pattdelay = 0;
    layer_info.*.pattread = patt.*.pattern_data();
    layer_info.*.ploop_adr = patt.*.pattern_data();
    layer_info.*.ploop_row = 0;
    layer_info.*.ploop_times = 0;
    // No C reference finalization log here
}

pub fn mpp_resetvars(arg_layer_info: [*c]mpl_layer_information) callconv(.c) void {
    var layer_info = arg_layer_info;
    _ = &layer_info;
    layer_info.*.pattjump = 255;
    layer_info.*.pattjump_row = 0;
}

pub fn mpp_Channel_GetACHN(arg_channel: [*c]mm_module_channel) callconv(.c) [*c]mm_active_channel {
    var channel = arg_channel;
    _ = &channel;
    var alloc: mm_word = @as(mm_word, @bitCast(@as(c_uint, channel.*.alloc)));
    _ = &alloc;
    if (alloc == @as(mm_word, @bitCast(@as(c_int, 255)))) return null;
    return &mm_achannels[alloc];
}
pub const mpp_TABLE_LinearSlideUpTable = [_]mm_hword{
    0,
    237,
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 475))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 714))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 953))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 1194))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 1435))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 1677))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 1920))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 2164))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 2409))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 2655))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 2902))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 3149))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 3397))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 3647))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 3897))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 4148))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 4400))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 4653))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 4907))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 5157))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 5417))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 5674))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 5932))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 6190))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 6449))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 6710))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 6971))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 7233))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 7496))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 7761))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 8026))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 8292))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 8559))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 8027))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 9096))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 9366))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 9636))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 9908))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 10181))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 10455))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 10730))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 11006))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 11283))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 11560))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 11839))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 12119))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 12400))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 12682))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 12965))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 13249))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 13533))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 13819))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 14106))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 14394))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 14684))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 14974))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 15265))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 15557))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 15850))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 16145))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 16440))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 16737))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 17034))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 17333))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 17633))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 17933))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 18235))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 18538))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 21315))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 21629))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 21944))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 22260))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 22578))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 22897))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 23216))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 23537))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 23860))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 24183))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 24507))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 24833))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 25160))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 25488))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 25817))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 26148))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 26479))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 26812))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 27146))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 27481))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 27818))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 28155))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 28494))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 28834))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 29175))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 29518))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 29862))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 30207))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 30553))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 30900))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 31248))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 31599))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 31951))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 32303))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 32657))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 33012))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 33369))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 33726))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 34085))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 34446))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 34807))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 35170))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 35534))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 35900))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 36267))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 36635))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 37004))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 37375))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 37747))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 38121))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 38496))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 38872))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 39250))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 39629))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 40009))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 40391))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 40774))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 41158))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 41544))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 41932))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 42320))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 42710))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 43102))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 43495))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 43889))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 44285))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 44682))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 45081))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 45481))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 45882))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 46285))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 46690))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 47095))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 47503))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 47917))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 48322))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 48734))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 49147))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 49562))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 49978))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 50396))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 50815))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 51236))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 51658))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 52082))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 52507))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 52934))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 53363))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 53793))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 54224))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 54658))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 55092))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 55529))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 55966))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 56406))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 56847))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 57289))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 57734))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 58179))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 58627))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 59076))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 59527))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 59979))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 60433))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 60889))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 61346))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 61805))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 62265))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 62727))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 63191))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 63657))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 64124))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 64593))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 65064))))),
    0,
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 474))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 950))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 1427))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 1906))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 2387))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 2870))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 3355))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 3841))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 4327))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 4818))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 5310))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 5803))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 6298))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 6795))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 7294))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 7794))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 8296))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 8800))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 9306))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 9814))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 10323))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 10835))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 11348))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 11863))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 12380))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 12899))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 13419))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 13942))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 14467))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 14993))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 15521))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 16051))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 16583))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 17117))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 17653))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 18191))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 18731))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 19273))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 19817))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 20362))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 20910))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 21460))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 22011))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 22565))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 23121))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 23678))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 24238))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 24800))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 25363))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 25929))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 25497))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 27067))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 27639))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 28213))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 28789))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 29367))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 29947))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 30530))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 31114))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 31701))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 32289))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 32880))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 33473))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 34068))))),
};
pub const mpp_TABLE_LinearSlideDownTable = [_]mm_hword{
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 65535))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 65300))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 65065))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 64830))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 64596))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 64364))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 64132))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 63901))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 63670))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 63441))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 63212))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 62984))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 62757))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 62531))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 62306))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 62081))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 61858))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 61635))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 61413))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 61191))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 60971))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 60751))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 60532))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 60314))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 60097))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 59880))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 59664))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 59449))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 59235))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 59022))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 58809))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 58597))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 58386))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 58176))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 57966))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 57757))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 57549))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 57341))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 57135))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 56929))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 56724))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 56519))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 56316))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 56113))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 55911))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 55709))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 55508))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 55308))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 55109))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 54910))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 54713))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 54515))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 54319))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 54123))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 53928))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 53734))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 53540))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 53347))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 53155))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 52963))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 52773))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 52582))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 52393))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 52204))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 52016))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 51829))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 51642))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 51456))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 51270))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 51085))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 50901))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 50718))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 50535))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 50353))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 50172))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 49991))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 49811))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 49631))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 49452))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 49274))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 49097))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 48920))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 48743))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 48568))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 48393))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 48128))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 48044))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 47871))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 47699))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 47527))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 47356))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 47185))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 47015))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 46846))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 46008))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 45842))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 45677))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 45512))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 45348))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 45185))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 45022))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 44859))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 44698))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 44537))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 44376))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 44216))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 44057))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 43898))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 43740))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 43582))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 43425))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 43269))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 43113))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 42958))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 42803))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 42649))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 42495))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 42342))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 42189))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 42037))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 41886))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 41735))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 41584))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 41434))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 41285))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 41136))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 40988))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 40840))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 40639))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 40566))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 40400))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 40253))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 40110))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 39965))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 39821))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 39678))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 39535))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 39392))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 39250))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 39109))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 38968))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 38828))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 38688))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 38548))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 38409))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 38271))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 38133))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 37996))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 37859))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 37722))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 37586))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 37451))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 37316))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 37181))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 37047))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 36914))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 36781))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 36648))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 36516))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 36385))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 36254))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 36123))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 35993))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 35863))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 35734))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 35605))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 35477))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 35349))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 35221))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 35095))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 34968))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 34842))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 34716))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 34591))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 34467))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 34343))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 34219))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 34095))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 33973))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 33850))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 33728))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 33607))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 33486))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 33365))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 33245))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 33125))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 33005))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 32887))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 32768))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 32650))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 32532))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 32415))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 32298))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 32182))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 32066))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 30157))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 30048))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 29940))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 29832))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 29725))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 29618))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 29511))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 29405))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 29299))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 29193))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 29088))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 28983))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 28879))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 28774))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 28671))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 28567))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 28464))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 28362))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 28260))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 28158))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 28056))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 27955))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 27855))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 27754))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 27654))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 27554))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 27455))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 27356))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 27258))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 27159))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 27062))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 26964))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 26867))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 26770))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 26674))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 26577))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 26482))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 26386))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 26291))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 26196))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 26102))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 26008))))),
};
pub const mpp_TABLE_FineLinearSlideUpTable: [16]mm_hword = [16]mm_hword{
    0,
    59,
    118,
    178,
    237,
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 296))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 356))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 415))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 475))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 535))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 594))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 654))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 714))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 773))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 833))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 893))))),
};
pub const mpp_TABLE_FineLinearSlideDownTable: [16]mm_hword = [16]mm_hword{
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 65535))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 65477))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 65418))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 65359))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 65300))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 65241))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 65182))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 65359))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 65065))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 65006))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 64947))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 64888))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 64830))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 64772))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 64713))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 64645))))),
};
pub fn mpph_psu(arg_period: mm_word, arg_slide_value: mm_word) callconv(.c) mm_word {
    var period = arg_period;
    _ = &period;
    var slide_value = arg_slide_value;
    _ = &slide_value;
    if (slide_value >= @as(mm_word, @bitCast(@as(c_int, 192)))) {
        period *%= @as(mm_word, @bitCast(@as(c_int, 2)));
    }
    var val: mm_word = (period >> @intCast(5)) *% @as(mm_word, @bitCast(@as(c_uint, mpp_TABLE_LinearSlideUpTable[slide_value])));
    _ = &val;
    var ret: mm_word = (val >> @intCast(@as(c_int, 16) - @as(c_int, 5))) +% period;
    _ = &ret;
    if ((ret >> @intCast(@as(c_int, 16) + @as(c_int, 5))) > @as(mm_word, @bitCast(@as(c_int, 0)))) return @as(mm_word, @bitCast(@as(c_int, 1) << @intCast(@as(c_int, 16) + @as(c_int, 5))));
    return ret;
}
pub fn mpph_psd(arg_period: mm_word, arg_slide_value: mm_word) callconv(.c) mm_word {
    var period = arg_period;
    _ = &period;
    var slide_value = arg_slide_value;
    _ = &slide_value;
    var val: mm_word = (period >> @intCast(5)) *% @as(mm_word, @bitCast(@as(c_uint, mpp_TABLE_LinearSlideDownTable[slide_value])));
    _ = &val;
    var ret: mm_word = val >> @intCast(@as(c_int, 16) - @as(c_int, 5));
    _ = &ret;
    return ret;
}
pub fn mpph_PitchSlide_Up(arg_period: mm_word, arg_slide_value: mm_word, arg_layer: [*c]mpl_layer_information) callconv(.c) mm_word {
    var period = arg_period;
    _ = &period;
    var slide_value = arg_slide_value;
    _ = &slide_value;
    var layer = arg_layer;
    _ = &layer;
    if ((@as(c_int, @bitCast(@as(c_uint, layer.*.flags))) & (@as(c_int, 1) << @intCast(2))) != 0) {
        return mpph_psu(period, slide_value);
    } else {
        var delta: mm_word = slide_value << @intCast(4);
        _ = &delta;
        if (delta > period) return 0;
        return period -% delta;
    }
    return @import("std").mem.zeroes(mm_word);
}
pub fn mpph_LinearPitchSlide_Up(arg_period: mm_word, arg_slide_value: mm_word, arg_layer: [*c]mpl_layer_information) callconv(.c) mm_word {
    var period = arg_period;
    _ = &period;
    var slide_value = arg_slide_value;
    _ = &slide_value;
    var layer = arg_layer;
    _ = &layer;
    if ((@as(c_int, @bitCast(@as(c_uint, layer.*.flags))) & (@as(c_int, 1) << @intCast(2))) != 0) return mpph_psu(period, slide_value) else return mpph_psd(period, slide_value);
    return @import("std").mem.zeroes(mm_word);
}
pub fn mpph_FinePitchSlide_Up(arg_period: mm_word, arg_slide_value: mm_word, arg_layer: [*c]mpl_layer_information) callconv(.c) mm_word {
    var period = arg_period;
    _ = &period;
    var slide_value = arg_slide_value;
    _ = &slide_value;
    var layer = arg_layer;
    _ = &layer;
    if ((@as(c_int, @bitCast(@as(c_uint, layer.*.flags))) & (@as(c_int, 1) << @intCast(2))) != 0) {
        var val: mm_word = (period >> @intCast(5)) *% @as(mm_word, @bitCast(@as(c_uint, mpp_TABLE_FineLinearSlideUpTable[slide_value])));
        _ = &val;
        var ret: mm_word = (val >> @intCast(@as(c_int, 16) - @as(c_int, 5))) +% period;
        _ = &ret;
        if ((ret >> @intCast(@as(c_int, 16) + @as(c_int, 5))) > @as(mm_word, @bitCast(@as(c_int, 0)))) return @as(mm_word, @bitCast(@as(c_int, 1) << @intCast(@as(c_int, 16) + @as(c_int, 5))));
        return ret;
    } else {
        var delta: mm_word = slide_value << @intCast(2);
        _ = &delta;
        if (delta > period) return 0;
        return period -% delta;
    }
    return @import("std").mem.zeroes(mm_word);
}
pub fn mpph_PitchSlide_Down(arg_period: mm_word, arg_slide_value: mm_word, arg_layer: [*c]mpl_layer_information) callconv(.c) mm_word {
    var period = arg_period;
    _ = &period;
    var slide_value = arg_slide_value;
    _ = &slide_value;
    var layer = arg_layer;
    _ = &layer;
    if ((@as(c_int, @bitCast(@as(c_uint, layer.*.flags))) & (@as(c_int, 1) << @intCast(2))) != 0) {
        return mpph_psd(period, slide_value);
    } else {
        var delta: mm_word = slide_value << @intCast(4);
        _ = &delta;
        period = period +% delta;
        if ((period >> @intCast(@as(c_int, 16) + @as(c_int, 5))) > @as(mm_word, @bitCast(@as(c_int, 0)))) return @as(mm_word, @bitCast(@as(c_int, 1) << @intCast(@as(c_int, 16) + @as(c_int, 5))));
        return period;
    }
    return @import("std").mem.zeroes(mm_word);
}
pub fn mpph_LinearPitchSlide_Down(arg_period: mm_word, arg_slide_value: mm_word, arg_layer: [*c]mpl_layer_information) callconv(.c) mm_word {
    var period = arg_period;
    _ = &period;
    var slide_value = arg_slide_value;
    _ = &slide_value;
    var layer = arg_layer;
    _ = &layer;
    if ((@as(c_int, @bitCast(@as(c_uint, layer.*.flags))) & (@as(c_int, 1) << @intCast(2))) != 0) return mpph_psd(period, slide_value) else return mpph_psu(period, slide_value);
    return @import("std").mem.zeroes(mm_word);
}
pub fn mpph_FinePitchSlide_Down(arg_period: mm_word, arg_slide_value: mm_word, arg_layer: [*c]mpl_layer_information) callconv(.c) mm_word {
    var period = arg_period;
    _ = &period;
    var slide_value = arg_slide_value;
    _ = &slide_value;
    var layer = arg_layer;
    _ = &layer;
    if ((@as(c_int, @bitCast(@as(c_uint, layer.*.flags))) & (@as(c_int, 1) << @intCast(2))) != 0) {
        var val: mm_word = (period >> @intCast(5)) *% @as(mm_word, @bitCast(@as(c_uint, mpp_TABLE_FineLinearSlideDownTable[slide_value])));
        _ = &val;
        var ret: mm_word = val >> @intCast(@as(c_int, 16) - @as(c_int, 5));
        _ = &ret;
        return ret;
    } else {
        var delta: mm_word = slide_value << @intCast(2);
        _ = &delta;
        period = period +% delta;
        if ((period >> @intCast(@as(c_int, 16) + @as(c_int, 5))) > @as(mm_word, @bitCast(@as(c_int, 0)))) return @as(mm_word, @bitCast(@as(c_int, 1) << @intCast(@as(c_int, 16) + @as(c_int, 5))));
        return period;
    }
    return @import("std").mem.zeroes(mm_word);
}
pub fn mpph_FastForward(arg_layer: [*c]mpl_layer_information, arg_rows_to_skip: mm_word) callconv(.c) void {
    var layer = arg_layer;
    _ = &layer;
    var rows_to_skip = arg_rows_to_skip;
    _ = &rows_to_skip;
    if (rows_to_skip == @as(mm_word, @bitCast(@as(c_int, 0)))) return;
    if (rows_to_skip > @as(mm_word, @bitCast(@as(c_uint, layer.*.nrows)))) return;
    layer.*.row = @as(mm_byte, @bitCast(@as(u8, @truncate(rows_to_skip))));
    while (true) {
        var ok: mm_bool = mmReadPattern(layer);
        _ = &ok;
        if (@as(c_int, @bitCast(@as(c_uint, ok))) == @as(c_int, 0)) {
            mppStop();
            if (mmCallback != @as(mm_callback, @ptrCast(@alignCast(@as(?*anyopaque, @ptrFromInt(@as(c_int, 0))))))) {
                _ = mmCallback.?(@as(mm_word, @bitCast(@as(c_int, 44))), @as(mm_word, @bitCast(mpp_clayer)));
            }
            break;
        }
        rows_to_skip -%= 1;
        if (rows_to_skip == @as(mm_word, @bitCast(@as(c_int, 0)))) break;
    }
}
pub fn mpp_Channel_ExchangeMemory(arg_effect: mm_byte, arg_param: mm_byte, arg_channel: [*c]mm_module_channel, arg_layer: [*c]mpl_layer_information) callconv(.c) mm_word {
    var effect = arg_effect;
    _ = &effect;
    var param = arg_param;
    _ = &param;
    var channel = arg_channel;
    _ = &channel;
    var layer = arg_layer;
    _ = &layer;
    var table_entry: mm_sbyte = undefined;
    _ = &table_entry;
    if ((@as(c_int, @bitCast(@as(c_uint, layer.*.flags))) & (@as(c_int, 1) << @intCast(3))) != 0) {
        const mpp_effect_memmap_xm: [31]mm_sbyte = [31]mm_sbyte{
            @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 1))))),
            @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 1))))),
            @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 1))))),
            @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 1))))),
            1,
            2,
            3,
            @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 1))))),
            @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 1))))),
            4,
            @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 1))))),
            5,
            6,
            @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 1))))),
            @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 1))))),
            7,
            8,
            9,
            10,
            @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 1))))),
            @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 1))))),
            @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 1))))),
            @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 1))))),
            11,
            @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 1))))),
            @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 1))))),
            @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 1))))),
            @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 1))))),
            @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 1))))),
            @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 1))))),
            12,
        };
        _ = &mpp_effect_memmap_xm;
        table_entry = mpp_effect_memmap_xm[effect];
    } else {
        const mpp_effect_memmap_it: [27]mm_sbyte = [27]mm_sbyte{
            @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 1))))),
            @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 1))))),
            @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 1))))),
            @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 1))))),
            1,
            2,
            2,
            @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 1))))),
            @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 1))))),
            3,
            4,
            1,
            1,
            @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 1))))),
            5,
            6,
            7,
            8,
            9,
            10,
            11,
            @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 1))))),
            @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 1))))),
            12,
            @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 1))))),
            13,
            @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 1))))),
        };
        _ = &mpp_effect_memmap_it;
        table_entry = mpp_effect_memmap_it[effect];
    }
    if (@as(c_int, @bitCast(@as(c_int, table_entry))) == -@as(c_int, 1)) return @as(mm_word, @bitCast(@as(c_uint, param)));
    if (@as(c_int, @bitCast(@as(c_uint, param))) == @as(c_int, 0)) {
        channel.*.param = channel.*.memory[@as(u8, @intCast(table_entry))];
        return @as(mm_word, @bitCast(@as(c_uint, channel.*.param)));
    } else {
        channel.*.memory[@as(u8, @intCast(table_entry))] = param;
        return @as(mm_word, @bitCast(@as(c_uint, param)));
    }
    return @import("std").mem.zeroes(mm_word);
}
pub fn mpph_VolumeSlide(arg_volume: c_int, arg_param: mm_word, arg_tick: mm_word, arg_max_volume: c_int, arg_layer: [*c]mpl_layer_information) callconv(.c) mm_word {
    var volume = arg_volume;
    _ = &volume;
    var param = arg_param;
    _ = &param;
    var tick = arg_tick;
    _ = &tick;
    var max_volume = arg_max_volume;
    _ = &max_volume;
    var layer = arg_layer;
    _ = &layer;
    if ((@as(c_int, @bitCast(@as(c_uint, layer.*.flags))) & (@as(c_int, 1) << @intCast(3))) != 0) {
        if (tick != @as(mm_word, @bitCast(@as(c_int, 0)))) {
            var r3: c_int = @as(c_int, @bitCast(param >> @intCast(4)));
            _ = &r3;
            var r1: c_int = @as(c_int, @bitCast(param & @as(mm_word, @bitCast(@as(c_int, 15)))));
            _ = &r1;
            var new_val: c_int = (volume + r3) - r1;
            _ = &new_val;
            if (new_val > max_volume) {
                new_val = max_volume;
            }
            if (new_val < @as(c_int, 0)) {
                new_val = 0;
            }
            volume = new_val;
        }
        return @as(mm_word, @bitCast(volume));
    } else {
        if (param == @as(mm_word, @bitCast(@as(c_int, 15)))) {
            volume -= @as(c_int, 15);
            if (volume < @as(c_int, 0)) return 0;
            return @as(mm_word, @bitCast(volume));
        }
        if (param == @as(mm_word, @bitCast(@as(c_int, 240)))) {
            if (tick != @as(mm_word, @bitCast(@as(c_int, 0)))) return @as(mm_word, @bitCast(volume));
            volume += @as(c_int, 15);
            if (volume > max_volume) return @as(mm_word, @bitCast(max_volume));
            return @as(mm_word, @bitCast(volume));
        }
        if ((param & @as(mm_word, @bitCast(@as(c_int, 15)))) == @as(mm_word, @bitCast(@as(c_int, 0)))) {
            if (tick == @as(mm_word, @bitCast(@as(c_int, 0)))) return @as(mm_word, @bitCast(volume));
            volume += @as(c_int, @bitCast(param >> @intCast(4)));
            if (volume > max_volume) return @as(mm_word, @bitCast(max_volume));
            return @as(mm_word, @bitCast(volume));
        }
        if ((param >> @intCast(4)) == @as(mm_word, @bitCast(@as(c_int, 0)))) {
            if (tick == @as(mm_word, @bitCast(@as(c_int, 0)))) return @as(mm_word, @bitCast(volume));
            volume -= @as(c_int, @bitCast(param & @as(mm_word, @bitCast(@as(c_int, 15)))));
            if (volume < @as(c_int, 0)) return 0;
            return @as(mm_word, @bitCast(volume));
        }
        if (tick != @as(mm_word, @bitCast(@as(c_int, 0)))) return @as(mm_word, @bitCast(volume));
        if ((param & @as(mm_word, @bitCast(@as(c_int, 15)))) == @as(mm_word, @bitCast(@as(c_int, 15)))) {
            volume += @as(c_int, @bitCast(param >> @intCast(4)));
            if (volume > max_volume) return @as(mm_word, @bitCast(max_volume));
            return @as(mm_word, @bitCast(volume));
        }
        if ((param >> @intCast(4)) == @as(mm_word, @bitCast(@as(c_int, 15)))) {
            volume -= @as(c_int, @bitCast(param & @as(mm_word, @bitCast(@as(c_int, 15)))));
            if (volume < @as(c_int, 0)) return 0;
            return @as(mm_word, @bitCast(volume));
        }
        return @as(mm_word, @bitCast(volume));
    }
    return @import("std").mem.zeroes(mm_word);
}
pub fn mpph_VolumeSlide64(arg_volume: c_int, arg_param: mm_word, arg_tick: mm_word, arg_layer: [*c]mpl_layer_information) callconv(.c) mm_word {
    var volume = arg_volume;
    _ = &volume;
    var param = arg_param;
    _ = &param;
    var tick = arg_tick;
    _ = &tick;
    var layer = arg_layer;
    _ = &layer;
    const out = mpph_VolumeSlide(volume, param, tick, @as(c_int, 64), layer);
    if (layer.*.row < 6 and layer.*.tick <= 1) {
        debugPrint("[VOL64] tick={d} param={x} in={d} out={d}\n", .{ @as(c_int, @intCast(tick)), @as(c_int, @intCast(param)), @as(c_int, @intCast(arg_volume)), @as(c_int, @intCast(out)) });
    }
    return out;
}
pub const mpp_TABLE_FineSineData = [_]mm_sbyte{
    0,
    2,
    3,
    5,
    6,
    8,
    9,
    11,
    12,
    14,
    16,
    17,
    19,
    20,
    22,
    23,
    24,
    26,
    27,
    29,
    30,
    32,
    33,
    34,
    36,
    37,
    38,
    39,
    41,
    42,
    43,
    44,
    45,
    46,
    47,
    48,
    49,
    50,
    51,
    52,
    53,
    54,
    55,
    56,
    56,
    57,
    58,
    59,
    59,
    60,
    60,
    61,
    61,
    62,
    62,
    62,
    63,
    63,
    63,
    64,
    64,
    64,
    64,
    64,
    64,
    64,
    64,
    64,
    64,
    64,
    63,
    63,
    63,
    62,
    62,
    62,
    61,
    61,
    60,
    60,
    59,
    59,
    58,
    57,
    56,
    56,
    55,
    54,
    53,
    52,
    51,
    50,
    49,
    48,
    47,
    46,
    45,
    44,
    43,
    42,
    41,
    39,
    38,
    37,
    36,
    34,
    33,
    32,
    30,
    29,
    27,
    26,
    24,
    23,
    22,
    20,
    19,
    17,
    16,
    14,
    12,
    11,
    9,
    8,
    6,
    5,
    3,
    2,
    0,
    @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 2))))),
    @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 3))))),
    @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 5))))),
    @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 6))))),
    @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 8))))),
    @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 9))))),
    @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 11))))),
    @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 12))))),
    @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 14))))),
    @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 16))))),
    @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 17))))),
    @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 19))))),
    @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 20))))),
    @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 22))))),
    @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 23))))),
    @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 24))))),
    @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 26))))),
    @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 27))))),
    @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 29))))),
    @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 30))))),
    @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 32))))),
    @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 33))))),
    @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 34))))),
    @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 36))))),
    @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 37))))),
    @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 38))))),
    @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 39))))),
    @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 41))))),
    @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 42))))),
    @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 43))))),
    @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 44))))),
    @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 45))))),
    @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 46))))),
    @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 47))))),
    @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 48))))),
    @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 49))))),
    @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 50))))),
    @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 51))))),
    @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 52))))),
    @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 53))))),
    @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 54))))),
    @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 55))))),
    @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 56))))),
    @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 56))))),
    @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 57))))),
    @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 58))))),
    @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 59))))),
    @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 59))))),
    @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 60))))),
    @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 60))))),
    @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 61))))),
    @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 61))))),
    @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 62))))),
    @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 62))))),
    @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 62))))),
    @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 63))))),
    @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 63))))),
    @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 63))))),
    @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 64))))),
    @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 64))))),
    @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 64))))),
    @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 64))))),
    @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 64))))),
    @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 64))))),
    @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 64))))),
    @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 64))))),
    @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 64))))),
    @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 64))))),
    @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 64))))),
    @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 61))))),
    @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 61))))),
    @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 60))))),
    @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 60))))),
    @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 59))))),
    @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 59))))),
    @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 58))))),
    @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 57))))),
    @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 56))))),
    @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 56))))),
    @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 55))))),
    @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 54))))),
    @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 53))))),
    @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 52))))),
    @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 51))))),
    @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 50))))),
    @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 49))))),
    @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 48))))),
    @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 47))))),
    @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 46))))),
    @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 45))))),
    @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 44))))),
    @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 43))))),
    @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 42))))),
    @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 41))))),
    @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 39))))),
    @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 38))))),
    @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 37))))),
    @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 36))))),
    @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 34))))),
    @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 33))))),
    @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 32))))),
    @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 30))))),
    @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 29))))),
    @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 27))))),
    @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 26))))),
    @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 24))))),
    @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 23))))),
    @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 22))))),
    @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 20))))),
    @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 19))))),
    @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 17))))),
    @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 16))))),
    @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 14))))),
    @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 12))))),
    @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 11))))),
    @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 9))))),
    @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 8))))),
    @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 6))))),
    @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 5))))),
    @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 3))))),
    @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 2))))),
};
pub fn mppe_SetSpeed(arg_param: mm_word, arg_layer: [*c]mpl_layer_information) callconv(.c) void {
    var param = arg_param;
    _ = &param;
    var layer = arg_layer;
    _ = &layer;
    if (@as(c_int, @bitCast(@as(c_uint, layer.*.tick))) != @as(c_int, 0)) return;
    if (param != @as(mm_word, @bitCast(@as(c_int, 0)))) {
        layer.*.speed = @as(mm_byte, @bitCast(@as(u8, @truncate(param))));
    }
}
pub fn mppe_PositionJump(arg_param: mm_word, arg_layer: [*c]mpl_layer_information) callconv(.c) void {
    var param = arg_param;
    _ = &param;
    var layer = arg_layer;
    _ = &layer;
    if (@as(c_int, @bitCast(@as(c_uint, layer.*.tick))) != @as(c_int, 0)) return;
    layer.*.pattjump = @as(mm_byte, @bitCast(@as(u8, @truncate(param))));
}
pub fn mppe_PatternBreak(arg_param: mm_word, arg_layer: [*c]mpl_layer_information) callconv(.c) void {
    var param = arg_param;
    _ = &param;
    var layer = arg_layer;
    _ = &layer;
    if (@as(c_int, @bitCast(@as(c_uint, layer.*.tick))) != @as(c_int, 0)) return;
    layer.*.pattjump_row = @as(mm_byte, @bitCast(@as(u8, @truncate(param))));
    if (@as(c_int, @bitCast(@as(c_uint, layer.*.pattjump))) == @as(c_int, 255)) {
        layer.*.pattjump = @as(mm_byte, @bitCast(@as(i8, @truncate(@as(c_int, @bitCast(@as(c_uint, layer.*.position))) + @as(c_int, 1)))));
    }
}
pub fn mppe_VolumeSlide(arg_param: mm_word, arg_channel: [*c]mm_module_channel, arg_layer: [*c]mpl_layer_information) callconv(.c) void {
    var param = arg_param;
    _ = &param;
    var channel = arg_channel;
    _ = &channel;
    var layer = arg_layer;
    _ = &layer;
    const ch_idx_dbg: c_int = @as(c_int, @intCast((@intFromPtr(channel) - @intFromPtr(mpp_channels)) / @sizeOf(mm_module_channel)));
    if (ch_idx_dbg >= 0 and ch_idx_dbg < 2 and layer.*.row < 6) {
        debugPrint("[VOLCMD] ch={d} before vol={d} cvol={d} param={x} tick={d}\n", .{ ch_idx_dbg, @as(c_int, @intCast(channel.*.volume)), @as(c_int, @intCast(channel.*.cvolume)), @as(c_int, @intCast(param)), @as(c_int, @intCast(layer.*.tick)) });
    }
    const vol_word = mpph_VolumeSlide64(
        @as(c_int, @intCast(channel.*.volume)),
        param,
        @as(mm_word, @bitCast(@as(c_uint, layer.*.tick))),
        layer,
    );
    channel.*.volume = @as(mm_byte, @intCast(@as(c_int, @intCast(vol_word))));
    if (ch_idx_dbg >= 0 and ch_idx_dbg < 2 and layer.*.row < 6) {
        debugPrint("[VOLCMD] ch={d} after vol={d}\n", .{ ch_idx_dbg, @as(c_int, @intCast(channel.*.volume)) });
    }
}
pub fn mppe_Portamento(arg_param: mm_word, arg_period: mm_word, arg_channel: [*c]mm_module_channel, arg_layer: [*c]mpl_layer_information) callconv(.c) mm_word {
    var param = arg_param;
    _ = &param;
    var period = arg_period;
    _ = &period;
    var channel = arg_channel;
    _ = &channel;
    var layer = arg_layer;
    _ = &layer;
    var is_fine: bool = @as(c_int, 0) != 0;
    _ = &is_fine;
    if ((param >> @intCast(4)) == @as(mm_word, @bitCast(@as(c_int, 14)))) {
        if (@as(c_int, @bitCast(@as(c_uint, layer.*.tick))) != @as(c_int, 0)) return period;
        param &= @as(mm_word, @bitCast(@as(c_int, 15)));
        is_fine = @as(c_int, 1) != 0;
    } else if ((param >> @intCast(4)) == @as(mm_word, @bitCast(@as(c_int, 15)))) {
        if (@as(c_int, @bitCast(@as(c_uint, layer.*.tick))) != @as(c_int, 0)) return period;
        param &= @as(mm_word, @bitCast(@as(c_int, 15)));
    } else {
        if (@as(c_int, @bitCast(@as(c_uint, layer.*.tick))) == @as(c_int, 0)) return period;
    }
    var new_period: mm_word = undefined;
    _ = &new_period;
    if (@as(c_int, @bitCast(@as(c_uint, channel.*.effect))) == @as(c_int, 5)) {
        if (is_fine) {
            new_period = mpph_FinePitchSlide_Down(channel.*.period, param, layer);
        } else {
            new_period = mpph_PitchSlide_Down(channel.*.period, param, layer);
        }
    } else {
        if (is_fine) {
            new_period = mpph_FinePitchSlide_Up(channel.*.period, param, layer);
        } else {
            new_period = mpph_PitchSlide_Up(channel.*.period, param, layer);
        }
    }
    var old_period: c_int = @as(c_int, @bitCast(channel.*.period));
    _ = &old_period;
    channel.*.period = new_period;
    var delta: c_int = @as(c_int, @bitCast(new_period -% @as(mm_word, @bitCast(old_period))));
    _ = &delta;
    return period +% @as(mm_word, @bitCast(delta));
}
pub fn mppe_Glissando(arg_param: mm_word, arg_period: mm_word, arg_act_ch: [*c]mm_active_channel, arg_channel: [*c]mm_module_channel, arg_layer: [*c]mpl_layer_information) callconv(.c) mm_word {
    var param = arg_param;
    _ = &param;
    var period = arg_period;
    _ = &period;
    var act_ch = arg_act_ch;
    _ = &act_ch;
    var channel = arg_channel;
    _ = &channel;
    var layer = arg_layer;
    _ = &layer;
    if (@as(c_int, @bitCast(@as(c_uint, layer.*.tick))) == @as(c_int, 0)) {
        if ((@as(c_int, @bitCast(@as(c_uint, layer.*.flags))) & (@as(c_int, 1) << @intCast(0))) != 0) {
            if (param == @as(mm_word, @bitCast(@as(c_int, 0)))) {
                param = @as(mm_word, @bitCast(@as(c_uint, channel.*.memory[@as(c_uint, @intCast(@as(c_int, 2)))])));
                channel.*.param = @as(mm_byte, @bitCast(@as(u8, @truncate(param))));
            }
            channel.*.memory[@as(c_uint, @intCast(@as(c_int, 2)))] = @as(mm_byte, @bitCast(@as(u8, @truncate(param))));
            channel.*.memory[@as(c_uint, @intCast(@as(c_int, 0)))] = @as(mm_byte, @bitCast(@as(u8, @truncate(param))));
        } else {
            if (param == @as(mm_word, @bitCast(@as(c_int, 0)))) {
                param = @as(mm_word, @bitCast(@as(c_uint, channel.*.memory[@as(c_uint, @intCast(@as(c_int, 0)))])));
                channel.*.param = @as(mm_byte, @bitCast(@as(u8, @truncate(param))));
            }
            channel.*.memory[@as(c_uint, @intCast(@as(c_int, 0)))] = @as(mm_byte, @bitCast(@as(u8, @truncate(param))));
            return period;
        }
    }
    param = @as(mm_word, @bitCast(@as(c_uint, channel.*.memory[@as(c_uint, @intCast(@as(c_int, 0)))])));
    period = mppe_glis_backdoor(param, period, act_ch, channel, layer);
    return period;
}
pub fn mppe_Vibrato(arg_param: mm_word, arg_period: mm_word, arg_channel: [*c]mm_module_channel, arg_layer: [*c]mpl_layer_information) callconv(.c) mm_word {
    var param = arg_param;
    _ = &param;
    var period = arg_period;
    _ = &period;
    var channel = arg_channel;
    _ = &channel;
    var layer = arg_layer;
    _ = &layer;
    if (@as(c_int, @bitCast(@as(c_uint, layer.*.tick))) != @as(c_int, 0)) return mppe_DoVibrato(period, channel, layer);
    var x: mm_word = param >> @intCast(4);
    _ = &x;
    var y: mm_word = param & @as(mm_word, @bitCast(@as(c_int, 15)));
    _ = &y;
    if (x != @as(mm_word, @bitCast(@as(c_int, 0)))) {
        channel.*.vibspd = @as(mm_byte, @bitCast(@as(u8, @truncate(x *% @as(mm_word, @bitCast(@as(c_int, 4)))))));
    }
    if (y != @as(mm_word, @bitCast(@as(c_int, 0)))) {
        var depth: mm_word = y *% @as(mm_word, @bitCast(@as(c_int, 4)));
        _ = &depth;
        channel.*.vibdep = @as(mm_byte, @bitCast(@as(u8, @truncate(depth << @intCast(@as(c_int, @bitCast(@as(c_uint, layer.*.oldeffects))))))));
        return mppe_DoVibrato(period, channel, layer);
    }
    return period;
}
pub fn mppe_Arpeggio(arg_param: mm_word, arg_period: mm_word, arg_act_ch: [*c]mm_active_channel, arg_channel: [*c]mm_module_channel, arg_layer: [*c]mpl_layer_information) callconv(.c) mm_word {
    var param = arg_param;
    _ = &param;
    var period = arg_period;
    _ = &period;
    var act_ch = arg_act_ch;
    _ = &act_ch;
    var channel = arg_channel;
    _ = &channel;
    var layer = arg_layer;
    _ = &layer;
    if (@as(c_int, @bitCast(@as(c_uint, layer.*.tick))) == @as(c_int, 0)) {
        channel.*.fxmem = 0;
    }
    if (act_ch == @as([*c]mm_active_channel, @ptrCast(@alignCast(@as(?*anyopaque, @ptrFromInt(@as(c_int, 0))))))) return period;
    var semitones: mm_word = undefined;
    _ = &semitones;
    if (@as(c_int, @bitCast(@as(c_uint, channel.*.fxmem))) > @as(c_int, 1)) {
        channel.*.fxmem = 0;
        semitones = param & @as(mm_word, @bitCast(@as(c_int, 15)));
    } else if (@as(c_int, @bitCast(@as(c_uint, channel.*.fxmem))) == @as(c_int, 1)) {
        channel.*.fxmem = 2;
        semitones = param >> @intCast(4);
    } else {
        channel.*.fxmem = 1;
        return period;
    }
    semitones *%= @as(mm_word, @bitCast(@as(c_int, 16)));
    period = mpph_LinearPitchSlide_Up(period, semitones, layer);
    return period;
}
pub fn mppe_VibratoVolume(arg_param: mm_word, arg_period: mm_word, arg_channel: [*c]mm_module_channel, arg_layer: [*c]mpl_layer_information) callconv(.c) mm_word {
    var param = arg_param;
    _ = &param;
    var period = arg_period;
    _ = &period;
    var channel = arg_channel;
    _ = &channel;
    var layer = arg_layer;
    _ = &layer;
    var new_period: mm_word = mppe_DoVibrato(period, channel, layer);
    _ = &new_period;
    mppe_VolumeSlide(param, channel, layer);
    return new_period;
}
pub fn mppe_PortaVolume(arg_param: mm_word, arg_period: mm_word, arg_act_ch: [*c]mm_active_channel, arg_channel: [*c]mm_module_channel, arg_layer: [*c]mpl_layer_information) callconv(.c) mm_word {
    var param = arg_param;
    _ = &param;
    var period = arg_period;
    _ = &period;
    var act_ch = arg_act_ch;
    _ = &act_ch;
    var channel = arg_channel;
    _ = &channel;
    var layer = arg_layer;
    _ = &layer;
    var mem: mm_word = @as(mm_word, @bitCast(@as(c_uint, channel.*.memory[@as(c_uint, @intCast(@as(c_int, 0)))])));
    _ = &mem;
    period = mppe_Glissando(mem, period, act_ch, channel, layer);
    mppe_VolumeSlide(param, channel, layer);
    return period;
}
pub fn mppe_ChannelVolume(arg_param: mm_word, arg_channel: [*c]mm_module_channel, arg_layer: [*c]mpl_layer_information) callconv(.c) void {
    var param = arg_param;
    _ = &param;
    var channel = arg_channel;
    _ = &channel;
    var layer = arg_layer;
    _ = &layer;
    if (@as(c_int, @bitCast(@as(c_uint, layer.*.tick))) != @as(c_int, 0)) return;
    if (param > @as(mm_word, @bitCast(@as(c_int, 64)))) return;
    channel.*.cvolume = @as(mm_byte, @bitCast(@as(u8, @truncate(param))));
}
pub fn mppe_ChannelVolumeSlide(arg_param: mm_word, arg_channel: [*c]mm_module_channel, arg_layer: [*c]mpl_layer_information) callconv(.c) void {
    var param = arg_param;
    _ = &param;
    var channel = arg_channel;
    _ = &channel;
    var layer = arg_layer;
    _ = &layer;
    channel.*.cvolume = @as(mm_byte, @bitCast(@as(u8, @truncate(mpph_VolumeSlide64(@as(c_int, @bitCast(@as(c_uint, channel.*.cvolume))), param, @as(mm_word, @bitCast(@as(c_uint, layer.*.tick))), layer)))));
}
pub fn mppe_SampleOffset(arg_param: mm_word, arg_layer: [*c]mpl_layer_information) callconv(.c) void {
    var param = arg_param;
    _ = &param;
    var layer = arg_layer;
    _ = &layer;
    if (@as(c_int, @bitCast(@as(c_uint, layer.*.tick))) != @as(c_int, 0)) return;
    mpp_vars.sampoff = @as(mm_byte, @bitCast(@as(u8, @truncate(param))));
}
pub fn mppe_Retrigger(arg_param: mm_word, arg_act_ch: [*c]mm_active_channel, arg_channel: [*c]mm_module_channel) callconv(.c) void {
    var param = arg_param;
    _ = &param;
    var act_ch = arg_act_ch;
    _ = &act_ch;
    var channel = arg_channel;
    _ = &channel;
    var mem: mm_word = @as(mm_word, @bitCast(@as(c_uint, channel.*.fxmem)));
    _ = &mem;
    if (mem == @as(mm_word, @bitCast(@as(c_int, 0)))) {
        channel.*.fxmem = @as(mm_byte, @bitCast(@as(u8, @truncate((param & @as(mm_word, @bitCast(@as(c_int, 15)))) +% @as(mm_word, @bitCast(@as(c_int, 1)))))));
        return;
    }
    mem -%= 1;
    if (mem != @as(mm_word, @bitCast(@as(c_int, 1)))) {
        channel.*.fxmem = @as(mm_byte, @bitCast(@as(u8, @truncate(mem))));
        return;
    }
    channel.*.fxmem = @as(mm_byte, @bitCast(@as(u8, @truncate((param & @as(mm_word, @bitCast(@as(c_int, 15)))) +% @as(mm_word, @bitCast(@as(c_int, 1)))))));
    var vol: c_int = @as(c_int, @bitCast(@as(c_uint, channel.*.volume)));
    _ = &vol;
    var arg: mm_word = param >> @intCast(4);
    _ = &arg;
    if (arg == @as(mm_word, @bitCast(@as(c_int, 0)))) {} else if (arg <= @as(mm_word, @bitCast(@as(c_int, 5)))) {
        vol -= @as(c_int, 1) << @intCast(arg -% @as(mm_word, @bitCast(@as(c_int, 1))));
        if (vol < @as(c_int, 0)) {
            vol = 0;
        }
    } else if (arg == @as(mm_word, @bitCast(@as(c_int, 6)))) {
        vol = (vol * @as(c_int, 171)) >> @intCast(8);
    } else if (arg == @as(mm_word, @bitCast(@as(c_int, 7)))) {
        vol >>= @intCast(@as(c_int, 1));
    } else if (arg == @as(mm_word, @bitCast(@as(c_int, 8)))) {} else if (arg <= @as(mm_word, @bitCast(@as(c_int, 13)))) {
        vol += @as(c_int, 1) << @intCast(arg -% @as(mm_word, @bitCast(@as(c_int, 9))));
        if (vol > @as(c_int, 64)) {
            vol = 64;
        }
    } else if (arg == @as(mm_word, @bitCast(@as(c_int, 14)))) {
        vol = (vol * @as(c_int, 192)) >> @intCast(7);
    } else {
        vol <<= @intCast(@as(c_int, 1));
        if (vol > @as(c_int, 64)) {
            vol = 64;
        }
    }
    channel.*.volume = @as(mm_byte, @bitCast(@as(i8, @truncate(vol))));
    if (act_ch != @as([*c]mm_active_channel, @ptrCast(@alignCast(@as(?*anyopaque, @ptrFromInt(@as(c_int, 0))))))) {
        act_ch.*.flags |= @as(mm_byte, @bitCast(@as(i8, @truncate(@as(c_int, 1) << @intCast(2)))));
    }
}
pub fn mppe_Tremolo(arg_param: mm_word, arg_channel: [*c]mm_module_channel, arg_layer: [*c]mpl_layer_information) callconv(.c) void {
    var param = arg_param;
    _ = &param;
    var channel = arg_channel;
    _ = &channel;
    var layer = arg_layer;
    _ = &layer;
    if (@as(c_int, @bitCast(@as(c_uint, layer.*.tick))) != @as(c_int, 0)) {
        var position: mm_word = @as(mm_word, @bitCast(@as(c_uint, channel.*.fxmem)));
        _ = &position;
        var speed: mm_word = param >> @intCast(4);
        _ = &speed;
        position +%= speed *% @as(mm_word, @bitCast(@as(c_int, 4)));
        channel.*.fxmem = @as(mm_byte, @bitCast(@as(u8, @truncate(position))));
    }
    var position: mm_word = @as(mm_word, @bitCast(@as(c_uint, channel.*.fxmem)));
    _ = &position;
    var sine: mm_sword = @as(mm_sword, @bitCast(@as(c_int, mpp_TABLE_FineSineData[position])));
    _ = &sine;
    var depth: mm_word = param & @as(mm_word, @bitCast(@as(c_int, 15)));
    _ = &depth;
    var result: mm_sword = @as(mm_sword, @bitCast((@as(mm_word, @bitCast(sine)) *% depth) >> @intCast(6)));
    _ = &result;
    if ((@as(c_int, @bitCast(@as(c_uint, layer.*.flags))) & (@as(c_int, 1) << @intCast(3))) != 0) {
        result >>= @intCast(@as(c_int, 1));
    }
    mpp_vars.volplus = @as(mm_sbyte, @bitCast(@as(i8, @truncate(result))));
}
pub fn mppe_SetTempo(arg_param: mm_word, arg_layer: [*c]mpl_layer_information) callconv(.c) void {
    var param = arg_param;
    _ = &param;
    var layer = arg_layer;
    _ = &layer;
    if (param < @as(mm_word, @bitCast(@as(c_int, 16)))) {
        if (@as(c_int, @bitCast(@as(c_uint, layer.*.tick))) == @as(c_int, 0)) return;
        var bpm: c_int = @as(c_int, @bitCast(@as(mm_word, @bitCast(@as(c_uint, layer.*.bpm))) -% param));
        _ = &bpm;
        if (bpm < @as(c_int, 32)) {
            bpm = 32;
        }
        mpp_setbpm(layer, @as(mm_word, @bitCast(bpm)));
    } else if (param < @as(mm_word, @bitCast(@as(c_int, 32)))) {
        if (@as(c_int, @bitCast(@as(c_uint, layer.*.tick))) == @as(c_int, 0)) return;
        var bpm: c_int = @as(c_int, @bitCast(@as(mm_word, @bitCast(@as(c_uint, layer.*.bpm))) +% (param & @as(mm_word, @bitCast(@as(c_int, 15))))));
        _ = &bpm;
        if (bpm > @as(c_int, 255)) {
            bpm = 255;
        }
        mpp_setbpm(layer, @as(mm_word, @bitCast(bpm)));
    } else {
        if (@as(c_int, @bitCast(@as(c_uint, layer.*.tick))) != @as(c_int, 0)) return;
        mpp_setbpm(layer, param);
    }
}
pub fn mppe_FineVibrato(arg_param: mm_word, arg_period: mm_word, arg_channel: [*c]mm_module_channel, arg_layer: [*c]mpl_layer_information) callconv(.c) mm_word {
    var param = arg_param;
    _ = &param;
    var period = arg_period;
    _ = &period;
    var channel = arg_channel;
    _ = &channel;
    var layer = arg_layer;
    _ = &layer;
    if (@as(c_int, @bitCast(@as(c_uint, layer.*.tick))) == @as(c_int, 0)) {
        var x: mm_word = param >> @intCast(4);
        _ = &x;
        var y: mm_word = param & @as(mm_word, @bitCast(@as(c_int, 15)));
        _ = &y;
        if (x != @as(mm_word, @bitCast(@as(c_int, 0)))) {
            channel.*.vibspd = @as(mm_byte, @bitCast(@as(u8, @truncate(x *% @as(mm_word, @bitCast(@as(c_int, 4)))))));
        }
        if (y != @as(mm_word, @bitCast(@as(c_int, 0)))) {
            var depth: mm_word = y *% @as(mm_word, @bitCast(@as(c_int, 4)));
            _ = &depth;
            channel.*.vibdep = @as(mm_byte, @bitCast(@as(u8, @truncate(depth << @intCast(@as(c_int, @bitCast(@as(c_uint, layer.*.oldeffects))))))));
        }
    }
    return mppe_DoVibrato(period, channel, layer);
}
pub fn mppe_SetGlobalVolume(arg_param: mm_word, arg_layer: [*c]mpl_layer_information) callconv(.c) void {
    var param = arg_param;
    _ = &param;
    var layer = arg_layer;
    _ = &layer;
    if (@as(c_int, @bitCast(@as(c_uint, layer.*.tick))) != @as(c_int, 0)) return;
    var mask: mm_word = @as(mm_word, @bitCast((@as(c_int, 1) << @intCast(3)) | (@as(c_int, 1) << @intCast(5))));
    _ = &mask;
    var maxvol: mm_word = undefined;
    _ = &maxvol;
    if ((@as(mm_word, @bitCast(@as(c_uint, layer.*.flags))) & mask) != 0) {
        maxvol = 64;
    } else {
        maxvol = 128;
    }
    layer.*.global_volume = @as(mm_byte, @bitCast(@as(u8, @truncate(if (param < maxvol) param else maxvol))));
}
pub fn mppe_GlobalVolumeSlide(arg_param: mm_word, arg_layer: [*c]mpl_layer_information) callconv(.c) void {
    var param = arg_param;
    _ = &param;
    var layer = arg_layer;
    _ = &layer;
    var maxvol: mm_word = undefined;
    _ = &maxvol;
    if ((@as(c_int, @bitCast(@as(c_uint, layer.*.flags))) & (@as(c_int, 1) << @intCast(3))) != 0) {
        maxvol = 64;
    } else {
        maxvol = 128;
    }
    layer.*.global_volume = @as(mm_byte, @bitCast(@as(u8, @truncate(mpph_VolumeSlide(@as(c_int, @bitCast(@as(c_uint, layer.*.global_volume))), param, @as(mm_word, @bitCast(@as(c_uint, layer.*.tick))), @as(c_int, @bitCast(maxvol)), layer)))));
}
pub fn mppe_SetPanning(arg_param: mm_word, arg_channel: [*c]mm_module_channel, arg_layer: [*c]mpl_layer_information) callconv(.c) void {
    var param = arg_param;
    _ = &param;
    var channel = arg_channel;
    _ = &channel;
    var layer = arg_layer;
    _ = &layer;
    if (@as(c_int, @bitCast(@as(c_uint, layer.*.tick))) == @as(c_int, 0)) {
        channel.*.panning = @as(mm_byte, @bitCast(@as(u8, @truncate(param))));
    }
}
pub fn mppex_XM_FVolSlideUp(arg_param: mm_word, arg_channel: [*c]mm_module_channel, arg_layer: [*c]mpl_layer_information) callconv(.c) void {
    var param = arg_param;
    _ = &param;
    var channel = arg_channel;
    _ = &channel;
    var layer = arg_layer;
    _ = &layer;
    if (@as(c_int, @bitCast(@as(c_uint, layer.*.tick))) != @as(c_int, 0)) return;
    var volume: c_int = @as(c_int, @bitCast(@as(mm_word, @bitCast(@as(c_uint, channel.*.volume))) +% (param & @as(mm_word, @bitCast(@as(c_int, 15))))));
    _ = &volume;
    if (volume > @as(c_int, 64)) {
        volume = 64;
    }
    channel.*.volume = @as(mm_byte, @bitCast(@as(i8, @truncate(volume))));
}
pub fn mppex_XM_FVolSlideDown(arg_param: mm_word, arg_channel: [*c]mm_module_channel, arg_layer: [*c]mpl_layer_information) callconv(.c) void {
    var param = arg_param;
    _ = &param;
    var channel = arg_channel;
    _ = &channel;
    var layer = arg_layer;
    _ = &layer;
    if (@as(c_int, @bitCast(@as(c_uint, layer.*.tick))) != @as(c_int, 0)) return;
    var volume: c_int = @as(c_int, @bitCast(@as(mm_word, @bitCast(@as(c_uint, channel.*.volume))) -% (param & @as(mm_word, @bitCast(@as(c_int, 15))))));
    _ = &volume;
    if (volume < @as(c_int, 0)) {
        volume = 0;
    }
    channel.*.volume = @as(mm_byte, @bitCast(@as(i8, @truncate(volume))));
}
pub fn mppex_OldRetrig(arg_param: mm_word, arg_act_ch: [*c]mm_active_channel, arg_channel: [*c]mm_module_channel, arg_layer: [*c]mpl_layer_information) callconv(.c) void {
    var param = arg_param;
    _ = &param;
    var act_ch = arg_act_ch;
    _ = &act_ch;
    var channel = arg_channel;
    _ = &channel;
    var layer = arg_layer;
    _ = &layer;
    if (@as(c_int, @bitCast(@as(c_uint, layer.*.tick))) == @as(c_int, 0)) {
        channel.*.fxmem = @as(mm_byte, @bitCast(@as(u8, @truncate(param & @as(mm_word, @bitCast(@as(c_int, 15)))))));
        return;
    }
    channel.*.fxmem -%= 1;
    if (@as(c_int, @bitCast(@as(c_uint, channel.*.fxmem))) == @as(c_int, 0)) {
        channel.*.fxmem = @as(mm_byte, @bitCast(@as(u8, @truncate(param & @as(mm_word, @bitCast(@as(c_int, 15)))))));
        if (act_ch != @as([*c]mm_active_channel, @ptrCast(@alignCast(@as(?*anyopaque, @ptrFromInt(@as(c_int, 0))))))) {
            act_ch.*.flags |= @as(mm_byte, @bitCast(@as(i8, @truncate(@as(c_int, 1) << @intCast(2)))));
        }
    }
}
pub fn mppex_FPattDelay(arg_param: mm_word, arg_layer: [*c]mpl_layer_information) callconv(.c) void {
    var param = arg_param;
    _ = &param;
    var layer = arg_layer;
    _ = &layer;
    if (@as(c_int, @bitCast(@as(c_uint, layer.*.tick))) != @as(c_int, 0)) return;
    layer.*.fpattdelay = @as(mm_byte, @bitCast(@as(u8, @truncate(param & @as(mm_word, @bitCast(@as(c_int, 15)))))));
}
pub fn mppex_InstControl(arg_param: mm_word, arg_act_ch: [*c]mm_active_channel, arg_channel: [*c]mm_module_channel, arg_layer: [*c]mpl_layer_information) callconv(.c) void {
    var param = arg_param;
    _ = &param;
    var act_ch = arg_act_ch;
    _ = &act_ch;
    var channel = arg_channel;
    _ = &channel;
    var layer = arg_layer;
    _ = &layer;
    if (@as(c_int, @bitCast(@as(c_uint, layer.*.tick))) != @as(c_int, 0)) return;
    var subparam: mm_word = param & @as(mm_word, @bitCast(@as(c_int, 15)));
    _ = &subparam;
    if (subparam <= @as(mm_word, @bitCast(@as(c_int, 2)))) {} else if (subparam <= @as(mm_word, @bitCast(@as(c_int, 6)))) {
        channel.*.bflags &= @as(mm_hword, @bitCast(@as(c_short, @truncate(~(@as(c_int, 3) << @intCast(6))))));
        channel.*.bflags |= @as(mm_hword, @bitCast(@as(c_ushort, @truncate(((subparam -% @as(mm_word, @bitCast(@as(c_int, 3)))) << @intCast(6)) & @as(mm_word, @bitCast(@as(c_int, 3) << @intCast(6)))))));
    } else if (subparam <= @as(mm_word, @bitCast(@as(c_int, 8)))) {
        if (act_ch != @as([*c]mm_active_channel, @ptrCast(@alignCast(@as(?*anyopaque, @ptrFromInt(@as(c_int, 0))))))) {
            var val: c_int = @as(c_int, @bitCast(subparam -% @as(mm_word, @bitCast(@as(c_int, 7)))));
            _ = &val;
            if (val != 0) {
                act_ch.*.flags |= @as(mm_byte, @bitCast(@as(i8, @truncate(@as(c_int, 1) << @intCast(5)))));
            } else {
                act_ch.*.flags &= @as(mm_byte, @bitCast(@as(i8, @truncate(~(@as(c_int, 1) << @intCast(5))))));
            }
        }
    }
}
pub fn mppex_SetPanning(arg_param: mm_word, arg_channel: [*c]mm_module_channel) callconv(.c) void {
    var param = arg_param;
    _ = &param;
    var channel = arg_channel;
    _ = &channel;
    channel.*.panning = @as(mm_byte, @bitCast(@as(u8, @truncate(param << @intCast(4)))));
}
pub fn mppex_SoundControl(arg_param: mm_word) callconv(.c) void {
    var param = arg_param;
    _ = &param;
    if (param != @as(mm_word, @bitCast(@as(c_int, 145)))) return;
}
pub fn mppex_PatternLoop(arg_param: mm_word, arg_layer: [*c]mpl_layer_information) callconv(.c) void {
    var param = arg_param;
    _ = &param;
    var layer = arg_layer;
    _ = &layer;
    if (@as(c_int, @bitCast(@as(c_uint, layer.*.tick))) != @as(c_int, 0)) return;
    var subparam: mm_word = param & @as(mm_word, @bitCast(@as(c_int, 15)));
    _ = &subparam;
    if (subparam == @as(mm_word, @bitCast(@as(c_int, 0)))) {
        layer.*.ploop_row = layer.*.row;
        layer.*.ploop_adr = mpp_vars.pattread_p;
        return;
    }
    var counter: mm_word = @as(mm_word, @bitCast(@as(c_uint, layer.*.ploop_times)));
    _ = &counter;
    if (counter == @as(mm_word, @bitCast(@as(c_int, 0)))) {
        layer.*.ploop_times = @as(mm_byte, @bitCast(@as(u8, @truncate(subparam))));
        layer.*.ploop_jump = 1;
    } else {
        layer.*.ploop_times = @as(mm_byte, @bitCast(@as(u8, @truncate(counter -% @as(mm_word, @bitCast(@as(c_int, 1)))))));
        if (@as(c_int, @bitCast(@as(c_uint, layer.*.ploop_times))) != @as(c_int, 0)) {
            layer.*.ploop_jump = 1;
        }
    }
}
pub fn mppex_NoteCut(arg_param: mm_word, arg_channel: [*c]mm_module_channel, arg_layer: [*c]mpl_layer_information) callconv(.c) void {
    var param = arg_param;
    _ = &param;
    var channel = arg_channel;
    _ = &channel;
    var layer = arg_layer;
    _ = &layer;
    var reference: mm_word = param & @as(mm_word, @bitCast(@as(c_int, 15)));
    _ = &reference;
    if (@as(mm_word, @bitCast(@as(c_uint, layer.*.tick))) != reference) return;
    channel.*.volume = 0;
}
pub fn mppex_NoteDelay(arg_param: mm_word, arg_layer: [*c]mpl_layer_information) callconv(.c) void {
    var param = arg_param;
    _ = &param;
    var layer = arg_layer;
    _ = &layer;
    var reference: mm_word = param & @as(mm_word, @bitCast(@as(c_int, 15)));
    _ = &reference;
    if (@as(mm_word, @bitCast(@as(c_uint, layer.*.tick))) >= reference) return;
    mpp_vars.notedelay = @as(mm_byte, @bitCast(@as(u8, @truncate(reference))));
}
pub fn mppex_PatternDelay(arg_param: mm_word, arg_layer: [*c]mpl_layer_information) callconv(.c) void {
    var param = arg_param;
    _ = &param;
    var layer = arg_layer;
    _ = &layer;
    if (@as(c_int, @bitCast(@as(c_uint, layer.*.tick))) != @as(c_int, 0)) return;
    if (@as(c_int, @bitCast(@as(c_uint, layer.*.pattdelay))) == @as(c_int, 0)) {
        layer.*.pattdelay = @as(mm_byte, @bitCast(@as(u8, @truncate((param & @as(mm_word, @bitCast(@as(c_int, 15)))) +% @as(mm_word, @bitCast(@as(c_int, 1)))))));
    }
}
pub fn mppex_SongMessage(arg_param: mm_word, arg_layer: [*c]mpl_layer_information) callconv(.c) void {
    var param = arg_param;
    _ = &param;
    var layer = arg_layer;
    _ = &layer;
    if (@as(c_int, @bitCast(@as(c_uint, layer.*.tick))) != @as(c_int, 0)) return;
    if (mmCallback != @as(mm_callback, @ptrCast(@alignCast(@as(?*anyopaque, @ptrFromInt(@as(c_int, 0))))))) {
        _ = mmCallback.?(@as(mm_word, @bitCast(@as(c_int, 42))), (param & @as(mm_word, @bitCast(@as(c_int, 15)))) | (mpp_clayer << @intCast(4)));
    }
}
pub fn mppe_Extended(arg_param: mm_word, arg_act_ch: [*c]mm_active_channel, arg_channel: [*c]mm_module_channel, arg_layer: [*c]mpl_layer_information) callconv(.c) void {
    var param = arg_param;
    _ = &param;
    var act_ch = arg_act_ch;
    _ = &act_ch;
    var channel = arg_channel;
    _ = &channel;
    var layer = arg_layer;
    _ = &layer;
    var subcmd: mm_word = param >> @intCast(4);
    _ = &subcmd;
    while (true) {
        switch (subcmd) {
            @as(mm_word, @bitCast(@as(c_int, 0))) => {
                mppex_XM_FVolSlideUp(param, channel, layer);
                break;
            },
            @as(mm_word, @bitCast(@as(c_int, 1))) => {
                mppex_XM_FVolSlideDown(param, channel, layer);
                break;
            },
            @as(mm_word, @bitCast(@as(c_int, 2))) => {
                mppex_OldRetrig(param, act_ch, channel, layer);
                break;
            },
            @as(mm_word, @bitCast(@as(c_int, 3))) => break,
            @as(mm_word, @bitCast(@as(c_int, 4))) => break,
            @as(mm_word, @bitCast(@as(c_int, 5))) => break,
            @as(mm_word, @bitCast(@as(c_int, 6))) => {
                mppex_FPattDelay(param, layer);
                break;
            },
            @as(mm_word, @bitCast(@as(c_int, 7))) => {
                mppex_InstControl(param, act_ch, channel, layer);
                break;
            },
            @as(mm_word, @bitCast(@as(c_int, 8))) => {
                mppex_SetPanning(param, channel);
                break;
            },
            @as(mm_word, @bitCast(@as(c_int, 9))) => {
                mppex_SoundControl(param);
                break;
            },
            @as(mm_word, @bitCast(@as(c_int, 10))) => break,
            @as(mm_word, @bitCast(@as(c_int, 11))) => {
                mppex_PatternLoop(param, layer);
                break;
            },
            @as(mm_word, @bitCast(@as(c_int, 12))) => {
                mppex_NoteCut(param, channel, layer);
                break;
            },
            @as(mm_word, @bitCast(@as(c_int, 13))) => {
                mppex_NoteDelay(param, layer);
                break;
            },
            @as(mm_word, @bitCast(@as(c_int, 14))) => {
                mppex_PatternDelay(param, layer);
                break;
            },
            @as(mm_word, @bitCast(@as(c_int, 15))) => {
                mppex_SongMessage(param, layer);
                break;
            },
            else => break,
        }
        break;
    }
}
pub fn mppe_SetVolume(arg_param: mm_word, arg_channel: [*c]mm_module_channel, arg_layer: [*c]mpl_layer_information) callconv(.c) void {
    var param = arg_param;
    _ = &param;
    var channel = arg_channel;
    _ = &channel;
    var layer = arg_layer;
    _ = &layer;
    if (@as(c_int, @bitCast(@as(c_uint, layer.*.tick))) == @as(c_int, 0)) {
        channel.*.volume = @as(mm_byte, @bitCast(@as(u8, @truncate(param))));
    }
}
pub fn mppe_KeyOff(arg_param: mm_word, arg_act_ch: [*c]mm_active_channel, arg_layer: [*c]mpl_layer_information) callconv(.c) void {
    var param = arg_param;
    _ = &param;
    var act_ch = arg_act_ch;
    _ = &act_ch;
    var layer = arg_layer;
    _ = &layer;
    if (@as(mm_word, @bitCast(@as(c_uint, layer.*.tick))) != param) return;
    if (act_ch != @as([*c]mm_active_channel, @ptrCast(@alignCast(@as(?*anyopaque, @ptrFromInt(@as(c_int, 0))))))) {
        act_ch.*.flags &= @as(mm_byte, @bitCast(@as(i8, @truncate(~(@as(c_int, 1) << @intCast(0))))));
    }
}
pub fn mppe_OldTremor(arg_param: mm_word, arg_channel: [*c]mm_module_channel, arg_layer: [*c]mpl_layer_information) callconv(.c) void {
    var param = arg_param;
    _ = &param;
    var channel = arg_channel;
    _ = &channel;
    var layer = arg_layer;
    _ = &layer;
    if (@as(c_int, @bitCast(@as(c_uint, layer.*.tick))) == @as(c_int, 0)) return;
    var mem: c_int = @as(c_int, @bitCast(@as(c_uint, channel.*.fxmem)));
    _ = &mem;
    if (mem == @as(c_int, 0)) {
        channel.*.fxmem = @as(mm_byte, @bitCast(@as(i8, @truncate(mem - @as(c_int, 1)))));
    } else {
        channel.*.bflags ^= @as(mm_hword, @bitCast(@as(c_short, @truncate((@as(c_int, 1) << @intCast(9)) | (@as(c_int, 1) << @intCast(10))))));
        if ((@as(c_int, @bitCast(@as(c_uint, channel.*.bflags))) & (@as(c_int, 1) << @intCast(10))) != 0) {
            channel.*.fxmem = @as(mm_byte, @bitCast(@as(u8, @truncate((param >> @intCast(4)) +% @as(mm_word, @bitCast(@as(c_int, 1)))))));
        } else {
            channel.*.fxmem = @as(mm_byte, @bitCast(@as(u8, @truncate((param & @as(mm_word, @bitCast(@as(c_int, 15)))) +% @as(mm_word, @bitCast(@as(c_int, 1)))))));
        }
    }
    if ((@as(c_int, @bitCast(@as(c_uint, channel.*.bflags))) & (@as(c_int, 1) << @intCast(10))) == @as(c_int, 0)) {
        mpp_vars.volplus = @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 64)))));
    }
}
pub fn mpph_ProcessEnvelope(arg_count_: [*c]mm_hword, arg_node_: [*c]mm_byte, arg_envelope: [*c]mm_mas_envelope, arg_act_ch: [*c]mm_active_channel, arg_value_mul_64: [*c]mm_word) callconv(.c) mm_word {
    var count_ = arg_count_;
    _ = &count_;
    var node_ = arg_node_;
    _ = &node_;
    var envelope = arg_envelope;
    _ = &envelope;
    var act_ch = arg_act_ch;
    _ = &act_ch;
    var value_mul_64 = arg_value_mul_64;
    _ = &value_mul_64;
    var count: mm_hword = count_.*;
    _ = &count;
    var node: mm_byte = node_.*;
    _ = &node;
    // Node array immediately follows the fixed header; compute pointer manually.
    const nodes_base: [*]mm_byte = @as([*]mm_byte, @ptrCast(@alignCast(envelope))) + @sizeOf(mm_mas_envelope);
    const nodes_ptr: [*]mm_mas_envelope_node = @ptrCast(@alignCast(nodes_base));
    const node_info: *mm_mas_envelope_node = &nodes_ptr[@as(usize, @intCast(node))];
    _ = &node_info;
    value_mul_64.* = @as(mm_word, @intCast(@as(c_int, env_node_base(node_info.*)) * @as(c_int, 64)));
    if (@as(c_int, @bitCast(@as(c_uint, count))) == @as(c_int, 0)) {
        if (@as(c_int, @bitCast(@as(c_uint, node))) == @as(c_int, @bitCast(@as(c_uint, envelope.*.loop_end)))) {
            count_.* = count;
            node_.* = envelope.*.loop_start;
            return 2;
        }
        if ((@as(c_int, @bitCast(@as(c_uint, act_ch.*.flags))) & (@as(c_int, 1) << @intCast(0))) != 0) {
            if (@as(c_int, @bitCast(@as(c_uint, node))) == @as(c_int, @bitCast(@as(c_uint, envelope.*.sus_end)))) {
                count_.* = count;
                node_.* = envelope.*.sus_start;
                return 0;
            }
        }
        var last_node: mm_hword = @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, @bitCast(@as(c_uint, @as(mm_hword, @bitCast(@as(c_ushort, envelope.*.node_count)))))) - @as(c_int, 1)))));
        _ = &last_node;
        if (@as(c_int, @bitCast(@as(c_uint, node))) == @as(c_int, @bitCast(@as(c_uint, last_node)))) {
            count_.* = count;
            node_.* = node;
            return 2;
        }
    } else {
        var delta: mm_sword = node_info.delta;
        _ = &delta;
        value_mul_64.* +%= @as(mm_word, @bitCast(@as(mm_sword, @bitCast(delta * @as(c_int, @bitCast(@as(c_uint, count))))) >> @intCast(3)));
    }
    count +%= 1;
    if (@as(c_int, @bitCast(@as(c_uint, count))) == @as(c_int, @bitCast(@as(c_uint, envelope.*.node_count)))) {
        count = 0;
        node = @as(mm_byte, @bitCast(@as(i8, @truncate(@as(c_int, @bitCast(@as(c_uint, node))) + @as(c_int, 1)))));
    }
    count_.* = count;
    node_.* = node;
    return 2;
}

pub fn mpp_Update_ACHN_notest_envelopes(arg_layer: [*c]mpl_layer_information, arg_act_ch: [*c]mm_active_channel, arg_period: mm_word) callconv(.c) mm_word {
    const layer = arg_layer;
    const act_ch = arg_act_ch;
    var period = arg_period;

    const instrument: *mm_mas_instrument = mpp_InstrumentPointer(layer, @as(mm_word, @intCast(act_ch.*.inst))) orelse return period;
    // Instrument envelopes and note map data are stored immediately after the
    // fixed-size instrument header in the MAS blob. The translate-c struct
    // does not expose the trailing union, so compute the pointer manually.
    const INSTR_HDR_SIZE: usize = 12;
    var env_ptr: [*]mm_byte = @as([*]mm_byte, @ptrCast(@alignCast(instrument))) + INSTR_HDR_SIZE;

    // Emit ENVDBG2 like C for first two channels at tick 0 regardless of existence
    if (mpp_layerp.*.tick == 0) {
        const act_addr_dbg2: usize = @intFromPtr(act_ch);
        const base_addr_dbg2: usize = @intFromPtr(&mm_achannels[0]);
        const ch_idx_dbg2: c_int = @as(c_int, @intCast((act_addr_dbg2 - base_addr_dbg2) / @sizeOf(mm_active_channel)));
        if (ch_idx_dbg2 >= 0 and ch_idx_dbg2 < 2) {
            const vol_enabled_dbg: c_int = @as(c_int, @intCast(@intFromBool((@as(c_int, @intCast(instrument.*.env_flags)) & MAS_INSTR_FLAG_VOL_ENV_ENABLED) != 0)));
            debugPrint(
                "[ENVDBG2] ch={d} env_flags=0x{x} vol_enabled={d}\n",
                .{ ch_idx_dbg2, @as(c_int, @intCast(instrument.*.env_flags)), vol_enabled_dbg },
            );
        }
    }

    if ((@as(c_int, @intCast(instrument.*.env_flags)) & MAS_INSTR_FLAG_VOL_ENV_EXISTS) != 0) {
        const vol_enabled: bool = ((@as(c_int, @intCast(instrument.*.env_flags)) & MAS_INSTR_FLAG_VOL_ENV_ENABLED) != 0);
        var value_mul_64: mm_word = 0;
        const env: *mm_mas_envelope = @ptrCast(@alignCast(env_ptr));
        env_ptr += env_ptr[0];
        // No extra ENVDUMP in C reference
        // (ENVDBG2 already printed above once per channel at tick 0)
        if (vol_enabled) {
            const exit_value = mpph_ProcessEnvelope(&act_ch.*.envc_vol, &act_ch.*.envn_vol, env, act_ch, &value_mul_64);
            if (mpp_layerp.*.tick == 0) {
                const act_addr_dbg: usize = @intFromPtr(act_ch);
                const base_addr_dbg: usize = @intFromPtr(&mm_achannels[0]);
                const ch_idx_dbg: c_int = @as(c_int, @intCast((act_addr_dbg - base_addr_dbg) / @sizeOf(mm_active_channel)));
                if (ch_idx_dbg >= 0 and ch_idx_dbg < 2) {
                    debugPrint("[ENVDBG] ch={d} exit={d} flags=0x{x}\n", .{ ch_idx_dbg, @as(c_int, @intCast(exit_value)), @as(c_int, @intCast(act_ch.*.flags)) });
                }
            }
            if (layer.*.tick != 0) {
                if (exit_value == @as(mm_word, @intCast(1))) {
                    if ((@as(c_int, @intCast(layer.*.flags)) & MAS_HEADER_FLAG_XM_MODE) != 0) {
                        act_ch.*.flags |= @as(mm_byte, @intCast(MCAF_ENVEND));
                    } else {
                        act_ch.*.flags |= @as(mm_byte, @intCast(MCAF_ENVEND | MCAF_FADE));
                    }
                } else if (exit_value == @as(mm_word, @intCast(2))) {
                    if ((@as(c_int, @intCast(act_ch.*.flags)) & MCAF_KEYON) == 0) {
                        act_ch.*.flags |= @as(mm_byte, @intCast(MCAF_FADE));
                    }
                }
            }
            // Always scale AFV by envelope factor (parity with C)
            const afv: mm_sword = @as(mm_sword, @intCast(mpp_vars.afvol));
            mpp_vars.afvol = @as(mm_byte, @intCast((@as(c_int, @intCast(afv)) * @as(c_int, @intCast(value_mul_64))) >> (6 + 6)));
            // At tick 0, mark VOLENV only (C does not set UPDATED here)
            if (layer.*.tick == 0) {
                act_ch.*.flags |= @as(mm_byte, @intCast(MCAF_VOLENV));
            }
        }
    }

    if ((@as(c_int, @intCast(act_ch.*.flags)) & MCAF_KEYON) == 0) {
        act_ch.*.flags |= @as(mm_byte, @intCast(MCAF_FADE | MCAF_ENVEND));
        if ((@as(c_int, @intCast(layer.*.flags)) & MAS_HEADER_FLAG_XM_MODE) != 0) {
            act_ch.*.fade = 0;
        }
    }

    if ((@as(c_int, @intCast(instrument.*.env_flags)) & MAS_INSTR_FLAG_PAN_ENV_EXISTS) != 0) {
        var value_mul_64_pan: mm_word = 0;
        const env_pan: *mm_mas_envelope = @ptrCast(@alignCast(env_ptr));
        env_ptr += env_ptr[0];
        _ = mpph_ProcessEnvelope(&act_ch.*.envc_pan, &act_ch.*.envn_pan, env_pan, act_ch, &value_mul_64_pan);
        mpp_vars.panplus += @as(mm_hword, @intCast((@as(c_int, @intCast(value_mul_64_pan)) >> 4) - 128));
    }

    if ((@as(c_int, @intCast(instrument.*.env_flags)) & MAS_INSTR_FLAG_PITCH_ENV_EXISTS) != 0) {
        var value_mul_64_pic: mm_word = 0;
        const env_pic: *mm_mas_envelope = @ptrCast(@alignCast(env_ptr));
        if (env_pic.*.is_filter == 0) {
            _ = mpph_ProcessEnvelope(&act_ch.*.envc_pic, &act_ch.*.envn_pic, env_pic, act_ch, &value_mul_64_pic);
            const value: mm_sword = @as(mm_sword, @intCast((@as(c_int, @intCast(value_mul_64_pic)) >> 3) - 256));
            if (value < 0) {
                period = mpph_LinearPitchSlide_Down(period, @as(mm_word, @intCast(-value)), layer);
            } else {
                period = mpph_LinearPitchSlide_Up(period, @as(mm_word, @intCast(value)), layer);
            }
        }
    }

    if ((@as(c_int, @intCast(act_ch.*.flags)) & MCAF_FADE) != 0) {
        var value: mm_sword = @as(mm_sword, @intCast(act_ch.*.fade)) - @as(mm_sword, @intCast(instrument.*.fadeout));
        if (value < 0) value = 0;
        act_ch.*.fade = @as(mm_hword, @intCast(value));
    }

    return period;
}
pub fn mpp_Update_ACHN_notest_auto_vibrato(arg_layer: [*c]mpl_layer_information, arg_act_ch: [*c]mm_active_channel, arg_period: mm_word) callconv(.c) mm_word {
    var layer = arg_layer;
    _ = &layer;
    var act_ch = arg_act_ch;
    _ = &act_ch;
    var period = arg_period;
    _ = &period;
    var sample: [*c]mm_mas_sample_info = mpp_SamplePointer(layer, @as(mm_word, @bitCast(@as(c_uint, act_ch.*.sample))));
    _ = &sample;
    var av_rate: mm_hword = sample.*.av_rate;
    _ = &av_rate;
    if (@as(c_int, @bitCast(@as(c_uint, av_rate))) != @as(c_int, 0)) {
        var new_rate: mm_word = @as(mm_word, @bitCast(@as(c_int, @bitCast(@as(c_uint, act_ch.*.avib_dep))) + @as(c_int, @bitCast(@as(c_uint, av_rate)))));
        _ = &new_rate;
        if (new_rate > @as(mm_word, @bitCast(@as(c_int, 32768)))) {
            new_rate = @as(mm_word, @bitCast(@as(c_int, 32768)));
        }
        act_ch.*.avib_dep = @as(mm_hword, @bitCast(@as(c_ushort, @truncate(new_rate))));
        var new_depth: mm_sword = @as(mm_sword, @bitCast(@as(mm_word, @bitCast(@as(c_uint, sample.*.av_depth))) *% new_rate));
        _ = &new_depth;
        act_ch.*.avib_pos = @as(mm_hword, @bitCast(@as(c_short, @truncate((@as(c_int, @bitCast(@as(c_uint, act_ch.*.avib_pos))) + @as(c_int, @bitCast(@as(c_uint, sample.*.av_speed)))) & @as(c_int, 255)))));
        var slide_val: mm_sword = @as(mm_sword, @bitCast(@as(c_int, mpp_TABLE_FineSineData[act_ch.*.avib_pos])));
        _ = &slide_val;
        slide_val = (slide_val * new_depth) >> @intCast(23);
        if (slide_val >= @as(c_int, 0)) {
            period = mpph_PitchSlide_Up(period, @as(mm_word, @bitCast(slide_val)), layer);
        } else {
            period = mpph_PitchSlide_Down(period, @as(mm_word, @bitCast(-slide_val)), layer);
        }
    }
    return period;
}

pub fn mpp_Update_ACHN_notest_update_mix(arg_layer: [*c]mpl_layer_information, arg_act_ch: [*c]mm_active_channel, arg_channel: mm_word) callconv(.c) [*c]mm_mixer_channel {
    const layer = arg_layer;
    const act_ch = arg_act_ch;
    const channel = arg_channel;

    const mix_ch: [*c]mm_mixer_channel = &mm_mix_channels[@as(usize, @intCast(channel))];
    // UMIX trace: snapshot before possible (re)bind
    if (umix_allow_log_ch(layer, @as(c_int, @intCast(channel)))) {
        debugPrint("[UMIX] ch={d} flags={x:0>2} sample={d} src0={x:0>8} read0={d}\n", .{
            @as(c_uint, @intCast(channel)),
            @as(c_uint, @intCast(act_ch.*.flags)),
            @as(c_uint, @intCast(act_ch.*.sample)),
            @as(c_uint, @intCast(mix_ch.*.src)),
            @as(c_uint, @intCast(mix_ch.*.read)),
        });
    }
    var should_umix_log: bool = false; // will enable only on bind
    // No pre-bind UMIX dump in C reference

    var umix_len_for_log: u32 = 0;
    var umix_loop_for_log: u32 = 0;
    var did_bind: bool = false;
    if ((@as(c_int, @intCast(act_ch.*.flags)) & MCAF_START) != 0) {
        // Mirror C: clear START immediately on entering start path
        act_ch.*.flags = @as(mm_byte, @intCast(@as(c_int, @intCast(act_ch.*.flags)) & ~MCAF_START));
        // must have a valid sample
        if (act_ch.*.sample != 0) {
            const sample: [*c]mm_mas_sample_info = mpp_SamplePointer(layer, @as(mm_word, @intCast(act_ch.*.sample)));
            // Compute MAS GBA header address without relying on aligned struct loads
            var hdr_addr: usize = 0;
            if (@as(c_uint, @intCast(sample.*.msl_id)) == 0xFFFF) {
                // Embedded sample in module: header starts at sample->data
                hdr_addr = @as(usize, @intCast(@intFromPtr(sample.*.data())));
            } else {
                // External sample in bank: mp_solution base + sampleTable[msl_id] + MAS prefix
                const samp_tbl_words: [*]const mm_word = mm_getSampleTable();
                const samp_tbl_bytes: [*]const u8 = @ptrCast(samp_tbl_words);
                const idx: usize = @as(usize, @intCast(sample.*.msl_id));
                const p: [*]const u8 = samp_tbl_bytes + (idx * 4);
                const off: usize = @as(usize, @intCast(@as(u32, p[0]) | (@as(u32, p[1]) << 8) | (@as(u32, p[2]) << 16) | (@as(u32, p[3]) << 24)));
                hdr_addr = (@as(usize, @intCast(@intFromPtr(mp_solution))) + off) + @sizeOf(mm_mas_prefix);
            }
            const hb: [*]const u8 = @ptrFromInt(hdr_addr);
            // Read header fields as little-endian to avoid unaligned word loads
            const len_le: u32 = @as(u32, hb[0]) | (@as(u32, hb[1]) << 8) | (@as(u32, hb[2]) << 16) | (@as(u32, hb[3]) << 24);
            const loop_le: u32 = @as(u32, hb[4]) | (@as(u32, hb[5]) << 8) | (@as(u32, hb[6]) << 16) | (@as(u32, hb[7]) << 24);
            umix_len_for_log = len_le;
            umix_loop_for_log = loop_le;
            const fmt_b: u8 = hb[8];
            const def_le: u16 = @as(u16, hb[10]) | (@as(u16, hb[11]) << 8);
            // initialize read pointer and source to header+12
            mix_ch.*.src = @as(mm_word, @intCast(hdr_addr + 12));
            did_bind = true;
            // Gate BIND/HDR like C (only on bind and only early channels/first tick)
            should_umix_log = (mpp_layerp.*.tick == 0 and channel < 2);
            if (should_umix_log) {
                debugPrint("[BIND] ch={d} id={d} src={x} def_freq={d} len={d}\n", .{ @as(c_int, @intCast(channel)), @as(c_int, @intCast(sample.*.msl_id)), @as(c_int, @intCast(mix_ch.*.src)), @as(c_int, @intCast(def_le)), @as(c_int, @intCast(len_le)) });
                const w0: u32 = @as(u32, hb[0]) | (@as(u32, hb[1]) << 8) | (@as(u32, hb[2]) << 16) | (@as(u32, hb[3]) << 24);
                const w1: u32 = @as(u32, hb[4]) | (@as(u32, hb[5]) << 8) | (@as(u32, hb[6]) << 16) | (@as(u32, hb[7]) << 24);
                const w2: u32 = @as(u32, hb[8]) | (@as(u32, hb[9]) << 8) | (@as(u32, hb[10]) << 16) | (@as(u32, hb[11]) << 24);
                debugPrint("[HDR] w0={x} w1={x} w2={x} len={d} loop={d} fmt={d} def={d}\n", .{ w0, w1, w2, @as(c_int, @intCast(len_le)), @as(c_int, @intCast(loop_le)), @as(c_int, @intCast(fmt_b)), @as(c_int, @intCast(def_le)) });
            }
            // initialize read pointer
            mix_ch.*.read = @as(mm_word, @intCast(@as(u32, mpp_vars.sampoff))) << (MP_SAMPFRAC + 8);
        }
    }

    if (did_bind and should_umix_log) {
        const umix_idx_for_log: u32 = @as(u32, @intCast(mix_ch.*.read)) >> @intCast(MP_SAMPFRAC + 8);
        debugPrint("[UMIX] -> src={x:0>8} read={d} idx={d} len={d} loop={d}\n", .{ @as(u32, @intCast(mix_ch.*.src)), @as(u32, @intCast(mix_ch.*.read)), umix_idx_for_log, umix_len_for_log, umix_loop_for_log });
    }
    return mix_ch;
}
pub extern var mm_ratescale: mm_word;
pub fn mpp_Update_ACHN_notest_set_pitch_volume(arg_layer: [*c]mpl_layer_information, arg_act_ch: [*c]mm_active_channel, arg_period: mm_word, arg_mix_ch: [*c]mm_mixer_channel) callconv(.c) mm_word {
    var layer = arg_layer;
    _ = &layer;
    var act_ch = arg_act_ch;
    _ = &act_ch;
    var period = arg_period;
    _ = &period;
    var mix_ch = arg_mix_ch;
    _ = &mix_ch;
    if (@as(c_int, @bitCast(@as(c_uint, act_ch.*.sample))) == @as(c_int, 0)) {
        act_ch.*.fvol = 0;
        return 0;
    }
    var sample: [*c]mm_mas_sample_info = mpp_SamplePointer(layer, @as(mm_word, @bitCast(@as(c_uint, act_ch.*.sample))));
    _ = &sample;
    // Debug first: channel index, flags, period, xm flag, ratescale, masterpitch
    // No extra FREQDBG in C reference

    // Match C translate path exactly: compute value based on mode
    var log_freq: mm_word = 0;
    if ((@as(c_int, @bitCast(@as(c_uint, layer.*.flags))) & (@as(c_int, 1) << @intCast(2))) != 0) {
        // XM mode
        // Use sample->frequency as C5 speed (C reference), read as LE bytes to avoid struct packing drift
        const sample_bytes: [*]const u8 = @ptrCast(sample);
        const c5speed: u16 = @as(u16, sample_bytes[2]) | (@as(u16, sample_bytes[3]) << 8);
        var value: mm_word = (((period >> @intCast(8)) *% (@as(mm_word, @intCast(@as(u32, c5speed))) << @intCast(2))) >> @intCast(8));
        if (mpp_clayer == @as(c_uint, @bitCast(MM_MAIN))) {
            value = (value *% mm_masterpitch) >> @intCast(10);
        }
        // Store scaled mixer rate like C: (scale * value) >> 16
        const scale_xm: mm_word = @as(mm_word, @bitCast(@divTrunc(@as(c_int, 4096) * @as(c_int, 65536), @as(c_int, 15768))));
        const rate_xm: mm_word = (scale_xm *% value) >> @intCast(16);
        mix_ch.*.freq = rate_xm;
        log_freq = value; // For logging, use unscaled value to match C
        // Instrument ch2 early rows to verify rate path
        // No extra RATEZ in C reference
        // Defer logging until after fvol is computed
    } else {
        if (period != @as(mm_word, @bitCast(@as(c_int, 0)))) {
            var value: mm_word = @as(mm_word, @bitCast(@as(c_int, 56750314))) / period;
            if (mpp_clayer == @as(c_uint, @bitCast(MM_MAIN))) {
                value = (value *% mm_masterpitch) >> @intCast(10);
            }
            const scale: mm_word = @as(mm_word, @bitCast(@divTrunc(@as(c_int, 4096) * @as(c_int, 65536), @as(c_int, 15768))));
            const rate_out: mm_word = (scale *% value) >> @intCast(16);
            mix_ch.*.freq = rate_out;
            log_freq = value;
            // Defer logging until after fvol is computed
        }
    }
    if (@as(c_int, @bitCast(@as(c_uint, act_ch.*.inst))) == @as(c_int, 0)) {
        act_ch.*.fvol = 0;
        return 0;
    }
    var inst: ?*mm_mas_instrument = mpp_InstrumentPointer(layer, @as(mm_word, @bitCast(@as(c_uint, act_ch.*.inst))));
    _ = &inst;
    if (inst == null) {
        act_ch.*.fvol = 0;
        return 0;
    }
    // Omit SAMP dump for parity with C
    var vol: mm_word = @as(mm_word, @bitCast(@as(c_uint, sample.*.global_volume))); // SV
    _ = &vol;
    const iv: mm_word = @as(mm_word, @bitCast(@as(c_uint, (inst.?).*.global_volume))); // IV
    const afv: mm_word = @as(mm_word, @bitCast(@as(c_uint, mpp_vars.afvol))); // AFVOL
    const gv_pre: mm_word = @as(mm_word, @bitCast(@as(c_uint, layer.*.global_volume))); // GV
    const xm_mode: c_int = (@as(c_int, @bitCast(@as(c_uint, layer.*.flags))) & (@as(c_int, 1) << @intCast(3)));
    vol *%= iv;
    vol *%= afv;
    var global_volume: mm_word = gv_pre;
    _ = &global_volume;
    if (xm_mode != 0) {
        global_volume <<= @intCast(@as(c_int, 1));
    }
    // no VOLDBG: skip retaining this intermediate explicitly
    vol = (vol *% global_volume) >> @intCast(10);
    const fade_word: mm_word = @as(mm_word, @bitCast(@as(c_uint, act_ch.*.fade)));
    // no VOLDBG: skip retaining this intermediate explicitly
    vol = (vol *% fade_word) >> @intCast(10);
    const layer_vol: mm_word = @as(mm_word, @bitCast(@as(c_uint, layer.*.volume)));
    vol *%= layer_vol;
    // Debug the operands and intermediate volume for the first two mixer channels at tick 0
    {
        // No extra VOLDBG in C reference
    }
    const out: mm_word = vol >> @intCast(19);
    var clipped: mm_word = out;
    if (clipped > @as(mm_word, @intCast(255))) clipped = 255;
    act_ch.*.fvol = @as(mm_byte, @intCast(clipped));
    // Ordered per-tick logging after fvol is computed (gate like C)
    {
        const tnow: u8 = mpp_layerp.*.tick;
        // Mixer channel index
        const mix_idx: c_int = @as(c_int, @intCast((@intFromPtr(mix_ch) - @intFromPtr(mm_mix_channels)) / @sizeOf(mm_mixer_channel)));
        // Gate like C: only tick==0 and first two mixer channels
        if (tnow == 0 and mix_idx >= 0 and mix_idx < 2) {
            debugPrint("[UMIX] set_pitch period={d} freq={d} fvol={d}\n", .{ @as(c_int, @intCast(period)), @as(c_int, @intCast(mix_ch.*.freq)), @as(c_int, @intCast(act_ch.*.fvol)) });
        }
    }
    // Do not set mix_ch.vol here; the C path applies panning/disable logic before volume write
    return clipped;
}

pub fn mpp_Update_ACHN_notest_disable_and_panning(arg_volume: mm_word, arg_act_ch: [*c]mm_active_channel, arg_mix_ch: [*c]mm_mixer_channel) callconv(.c) void {
    const volume = arg_volume;
    const act_ch = arg_act_ch;
    const mix_ch = arg_mix_ch;

    if (volume == 0) {
        const env_end = ((@as(c_int, @intCast(act_ch.*.flags)) & MCAF_ENVEND) != 0);
        const key_on = ((@as(c_int, @intCast(act_ch.*.flags)) & MCAF_KEYON) != 0);
        if (env_end and !key_on) {
            mix_ch.*.src = MIXCH_GBA_SRC_STOPPED;
            if (act_ch.*.type == ACHN_FOREGROUND) {
                mpp_channels[act_ch.*.parent].alloc = NO_CHANNEL_AVAILABLE;
            }
            act_ch.*.type = ACHN_DISABLED;
            return;
        }
    }

    // audible path
    mix_ch.*.vol = @as(mm_byte, @intCast(if (volume > @as(mm_word, @intCast(255))) 255 else volume));

    // AUDIO TIMING CRITICAL: The GBA audio hardware requires precise timing between volume updates
    // and subsequent operations. Without this delay, the audio mixer fails to properly process
    // the volume change, resulting in incorrect sample playback (e.g., cymbals repeating when
    // they shouldn't, or samples sounding like "shh-shh" instead of crisp drums). This delay
    // provides the necessary timing gap that was previously provided by debug print formatting
    // operations, ensuring the hardware has time to stabilize between critical audio register
    // writes. The specific delay values (5/6) were determined empirically to match the timing
    // characteristics of the original C code's debug prints.
    artificialDelay(5);

    // If mixer channel ended, disable foreground channel
    if ((mix_ch.*.src & MIXCH_GBA_SRC_STOPPED) != 0) {
        if (act_ch.*.type == ACHN_FOREGROUND) {
            mpp_channels[act_ch.*.parent].alloc = NO_CHANNEL_AVAILABLE;
        }
        act_ch.*.type = ACHN_DISABLED;
        return;
    }

    // Apply panning with panplus
    const panplus: mm_shword = @as(mm_shword, @bitCast(mpp_vars.panplus));
    const old_panning: mm_word = act_ch.*.panning;
    var newpan: c_int = @as(c_int, @intCast(old_panning)) + @as(c_int, @intCast(panplus));
    if (newpan < 0) {
        newpan = 0;
    } else if (newpan > 255) {
        newpan = 255;
    }
    mix_ch.*.pan = @as(mm_byte, @intCast(newpan));
    const stopped: c_int = if ((mix_ch.*.src & MIXCH_GBA_SRC_STOPPED) != 0) 1 else 0;
    if (umix_allow_log_ch(mpp_layerp, umix_channel_index_from_mix(mix_ch))) {
        debugPrint(
            "[UMIX] audible ch={d} vol={d} pan={d} stopped={d}\n",
            .{ @as(c_int, @intCast(act_ch.*.parent)), @as(c_int, @intCast(mix_ch.*.vol)), @as(c_int, @intCast(mix_ch.*.pan)), stopped },
        );
    }
    // AUDIO TIMING CRITICAL: Second delay required after panning updates to ensure proper
    // audio mixer state synchronization. This delay complements the volume delay above,
    // providing the complete timing sequence needed for accurate GBA audio playback.
    artificialDelay(6);
}

// artificialDelay uses string formatting in bufPrint to delay execution. Without these delays, audio regresses.
// I don't understand how to fix it so this hack isn't requied. It's truly disappointing.
var buf: [32]u8 = [_]u8{0} ** 32;
inline fn artificialDelay(delay: usize) void {
    if (delay == 5) {
        _ = std.fmt.bufPrint(
            &buf,
            "delay 5 {d}{d}{d}{d}{d}\n",
            .{ 1, 1, 1, 1, 1 },
        ) catch return;
    } else if (delay == 6) {
        _ = std.fmt.bufPrint(
            &buf,
            "delay 6 {d}{d}{d}{d}{d}{d}\n",
            .{ 0, 1, 1, 1, 1, 1 },
        ) catch return;
    }
}

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
pub const MM_CORE_CHANNEL_TYPES_H__ = "";
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
pub const MIXCH_GBA_SRC_STOPPED = @as(c_uint, 1) << ((@import("std").zig.c_translation.sizeof(usize) * @as(c_int, 8)) - @as(c_int, 1));
pub const MM_CORE_MAS_H__ = "";
pub const MM_CORE_PLAYER_TYPES_H__ = "";
pub const MP_SCHANNELS = @as(c_int, 4);
pub const NO_CHANNEL_AVAILABLE = @as(c_int, 255);
pub const MM_GBA_MAIN_H = "";
pub const MM_GBA_MIXER_H = "";
pub const MP_SAMPFRAC = @as(c_int, 12);
pub const S3M_FREQ_DIVIDER = @import("std").zig.c_translation.promoteIntLiteral(c_int, 57268224, .decimal);
pub const MOD_FREQ_DIVIDER_PAL = @import("std").zig.c_translation.promoteIntLiteral(c_int, 56750314, .decimal);
pub const MOD_FREQ_DIVIDER_NTSC = @import("std").zig.c_translation.promoteIntLiteral(c_int, 57272724, .decimal);
pub const MPP_XM_VOLSLIDE = @as(c_int, 1);
pub const MPP_XM_PORTA_DOWN = @as(c_int, 2);
pub const MPP_XM_PORTA_UP = @as(c_int, 3);
pub const MPP_XM_UNKNOWN = @as(c_int, 4);
pub const MPP_XM_VOLSLIDE_VIBR = @as(c_int, 5);
pub const MPP_XM_VOLSLIDE_GLIS = @as(c_int, 6);
pub const MPP_XM_SAMP_OFFSET = @as(c_int, 7);
pub const MPP_XM_PANSLIDE = @as(c_int, 8);
pub const MPP_XM_RETRIG_NOTE = @as(c_int, 9);
pub const MPP_XM_TREMOLO = @as(c_int, 10);
pub const MPP_XM_GL_VOLSLIDE = @as(c_int, 11);
pub const MPP_XM_TREMOR = @as(c_int, 12);
pub const MPP_XM_VCMD_MEM_PANSL = @as(c_int, 7);
pub const MPP_XM_VCMD_MEM_VS = @as(c_int, 12);
pub const MPP_XM_VCMD_MEM_FVS = @as(c_int, 13);
pub const MPP_XM_VCMD_MEM_GLIS = @as(c_int, 14);
pub const MPP_IT_VOLSLIDE = @as(c_int, 1);
pub const MPP_IT_PORTA = @as(c_int, 2);
pub const MPP_IT_TREMOR = @as(c_int, 3);
pub const MPP_IT_ARPEGGIO = @as(c_int, 4);
pub const MPP_IT_CH_VOLSLIDE = @as(c_int, 5);
pub const MPP_IT_SAMP_OFFSET = @as(c_int, 6);
pub const MPP_IT_PANSLIDE = @as(c_int, 7);
pub const MPP_IT_RETRIG_NOTE = @as(c_int, 8);
pub const MPP_IT_TREMOLO = @as(c_int, 9);
pub const MPP_IT_EXTENDED_FX = @as(c_int, 10);
pub const MPP_IT_TEMPO = @as(c_int, 11);
pub const MPP_IT_GL_VOLSLIDE = @as(c_int, 12);
pub const MPP_IT_PANBRELLO = @as(c_int, 13);
pub const MPP_IT_VCMD_MEM = @as(c_int, 14);
pub const MPP_XM_IT_GLIS = @as(c_int, 0);
pub const PE_FADE_ALLOWED = @as(c_int, 2);
pub const PE_1 = @as(c_int, 1);
pub const PE_FADE_NOT_ALLOWED = @as(c_int, 0);
pub const mmreverbcfg = struct_mmreverbcfg;
pub const t_mmdssample = struct_t_mmdssample;
pub const t_mmsoundeffect = struct_t_mmsoundeffect;
pub const t_mmgbasystem = struct_t_mmgbasystem;
pub const t_mmdssystem = struct_t_mmdssystem;
pub const t_mmstream = struct_t_mmstream;
pub const t_mmstreamdata = struct_t_mmstreamdata;
pub const tmm_voice = struct_tmm_voice;
pub const tmm_mas_head = struct_tmm_mas_head;
pub const tmm_mas_prefix = struct_tmm_mas_prefix;
pub const tmm_mas_instrument = struct_tmm_mas_instrument;
pub const tmm_mas_envelope = struct_tmm_mas_envelope;
pub const tmm_mas_sample_info = struct_tmm_mas_sample_info;
pub const tmm_mas_pattern = struct_tmm_mas_pattern;
pub const tmm_mas_gba_sample = struct_tmm_mas_gba_sample;
pub const tmm_mas_ds_sample = struct_tmm_mas_ds_sample;
pub const tmslheaddata = struct_tmslheaddata;
pub const tmslhead = struct_tmslhead;
