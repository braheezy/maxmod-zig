pub const __builtin_bswap16 = @import("std").zig.c_builtins.__builtin_bswap16;
pub const __builtin_bswap32 = @import("std").zig.c_builtins.__builtin_bswap32;
pub const __builtin_bswap64 = @import("std").zig.c_builtins.__builtin_bswap64;
pub const __builtin_signbit = @import("std").zig.c_builtins.__builtin_signbit;
pub const __builtin_signbitf = @import("std").zig.c_builtins.__builtin_signbitf;
pub const __builtin_popcount = @import("std").zig.c_builtins.__builtin_popcount;
pub const __builtin_ctz = @import("std").zig.c_builtins.__builtin_ctz;
pub const __builtin_clz = @import("std").zig.c_builtins.__builtin_clz;
pub const __builtin_sqrt = @import("std").zig.c_builtins.__builtin_sqrt;
pub const __builtin_sqrtf = @import("std").zig.c_builtins.__builtin_sqrtf;
pub const __builtin_sin = @import("std").zig.c_builtins.__builtin_sin;
pub const __builtin_sinf = @import("std").zig.c_builtins.__builtin_sinf;
pub const __builtin_cos = @import("std").zig.c_builtins.__builtin_cos;
pub const __builtin_cosf = @import("std").zig.c_builtins.__builtin_cosf;
pub const __builtin_exp = @import("std").zig.c_builtins.__builtin_exp;
pub const __builtin_expf = @import("std").zig.c_builtins.__builtin_expf;
pub const __builtin_exp2 = @import("std").zig.c_builtins.__builtin_exp2;
pub const __builtin_exp2f = @import("std").zig.c_builtins.__builtin_exp2f;
pub const __builtin_log = @import("std").zig.c_builtins.__builtin_log;
pub const __builtin_logf = @import("std").zig.c_builtins.__builtin_logf;
pub const __builtin_log2 = @import("std").zig.c_builtins.__builtin_log2;
pub const __builtin_log2f = @import("std").zig.c_builtins.__builtin_log2f;
pub const __builtin_log10 = @import("std").zig.c_builtins.__builtin_log10;
pub const __builtin_log10f = @import("std").zig.c_builtins.__builtin_log10f;
pub const __builtin_abs = @import("std").zig.c_builtins.__builtin_abs;
pub const __builtin_labs = @import("std").zig.c_builtins.__builtin_labs;
pub const __builtin_llabs = @import("std").zig.c_builtins.__builtin_llabs;
pub const __builtin_fabs = @import("std").zig.c_builtins.__builtin_fabs;
pub const __builtin_fabsf = @import("std").zig.c_builtins.__builtin_fabsf;
pub const __builtin_floor = @import("std").zig.c_builtins.__builtin_floor;
pub const __builtin_floorf = @import("std").zig.c_builtins.__builtin_floorf;
pub const __builtin_ceil = @import("std").zig.c_builtins.__builtin_ceil;
pub const __builtin_ceilf = @import("std").zig.c_builtins.__builtin_ceilf;
pub const __builtin_trunc = @import("std").zig.c_builtins.__builtin_trunc;
pub const __builtin_truncf = @import("std").zig.c_builtins.__builtin_truncf;
pub const __builtin_round = @import("std").zig.c_builtins.__builtin_round;
pub const __builtin_roundf = @import("std").zig.c_builtins.__builtin_roundf;
pub const __builtin_strlen = @import("std").zig.c_builtins.__builtin_strlen;
pub const __builtin_strcmp = @import("std").zig.c_builtins.__builtin_strcmp;
pub const __builtin_object_size = @import("std").zig.c_builtins.__builtin_object_size;
pub const __builtin___memset_chk = @import("std").zig.c_builtins.__builtin___memset_chk;
pub const __builtin_memset = @import("std").zig.c_builtins.__builtin_memset;
pub const __builtin___memcpy_chk = @import("std").zig.c_builtins.__builtin___memcpy_chk;
pub const __builtin_memcpy = @import("std").zig.c_builtins.__builtin_memcpy;
pub const __builtin_expect = @import("std").zig.c_builtins.__builtin_expect;
pub const __builtin_nanf = @import("std").zig.c_builtins.__builtin_nanf;
pub const __builtin_huge_valf = @import("std").zig.c_builtins.__builtin_huge_valf;
pub const __builtin_inff = @import("std").zig.c_builtins.__builtin_inff;
pub const __builtin_isnan = @import("std").zig.c_builtins.__builtin_isnan;
pub const __builtin_isinf = @import("std").zig.c_builtins.__builtin_isinf;
pub const __builtin_isinf_sign = @import("std").zig.c_builtins.__builtin_isinf_sign;
pub const __has_builtin = @import("std").zig.c_builtins.__has_builtin;
pub const __builtin_assume = @import("std").zig.c_builtins.__builtin_assume;
pub const __builtin_unreachable = @import("std").zig.c_builtins.__builtin_unreachable;
pub const __builtin_constant_p = @import("std").zig.c_builtins.__builtin_constant_p;
pub const __builtin_mul_overflow = @import("std").zig.c_builtins.__builtin_mul_overflow;
pub const ptrdiff_t = c_int;
pub const wchar_t = c_uint;
pub const max_align_t = extern struct {
    __clang_max_align_nonce1: c_longlong align(8) = @import("std").mem.zeroes(c_longlong),
    __clang_max_align_nonce2: c_longdouble align(8) = @import("std").mem.zeroes(c_longdouble),
};
pub const int_least64_t = i64;
pub const uint_least64_t = u64;
pub const int_fast64_t = i64;
pub const uint_fast64_t = u64;
pub const int_least32_t = i32;
pub const uint_least32_t = u32;
pub const int_fast32_t = i32;
pub const uint_fast32_t = u32;
pub const int_least16_t = i16;
pub const uint_least16_t = u16;
pub const int_fast16_t = i16;
pub const uint_fast16_t = u16;
pub const int_least8_t = i8;
pub const uint_least8_t = u8;
pub const int_fast8_t = i8;
pub const uint_fast8_t = u8;
pub const intmax_t = c_longlong;
pub const uintmax_t = c_ulonglong;
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
const union_unnamed_1 = extern union {
    loop_length: mm_word,
    length: mm_word,
};
pub const struct_t_mmdssample = extern struct {
    loop_start: mm_word = @import("std").mem.zeroes(mm_word),
    unnamed_0: union_unnamed_1 = @import("std").mem.zeroes(union_unnamed_1),
    format: mm_byte = @import("std").mem.zeroes(mm_byte),
    repeat_mode: mm_byte = @import("std").mem.zeroes(mm_byte),
    base_rate: mm_hword = @import("std").mem.zeroes(mm_hword),
    data: mm_addr = @import("std").mem.zeroes(mm_addr),
};
pub const mm_ds_sample = struct_t_mmdssample;
const union_unnamed_2 = extern union {
    id: mm_word,
    sample: [*c]mm_ds_sample,
};
pub const struct_t_mmsoundeffect = extern struct {
    unnamed_0: union_unnamed_2 = @import("std").mem.zeroes(union_unnamed_2),
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
const enum_unnamed_3 = c_uint;
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
pub extern fn mmSetEventHandler(handler: mm_callback) void;
pub extern fn mmFrame() void;
pub extern fn mmGetModuleCount() mm_word;
pub extern fn mmGetSampleCount() mm_word;
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
pub extern fn mmSetEffectsVolume(volume: mm_word) void;
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
    note_map_offset: mm_hword = @import("std").mem.zeroes(mm_hword), // 15-bit in C bitfield
    is_note_map_invalid: mm_hword = @import("std").mem.zeroes(mm_hword), // 1-bit in C bitfield
    reserved: mm_hword = @import("std").mem.zeroes(mm_hword),
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
const union_unnamed_4 = extern union {
    loop_length: mm_word,
    length: mm_word,
};
pub const struct_tmm_mas_ds_sample = extern struct {
    loop_start: mm_word align(4) = @import("std").mem.zeroes(mm_word),
    unnamed_0: union_unnamed_4 = @import("std").mem.zeroes(union_unnamed_4),
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
const union_unnamed_5 = extern union {
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
    unnamed_0: union_unnamed_5 = @import("std").mem.zeroes(union_unnamed_5),
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
pub export fn mmAllocChannel() linksection(".iwram") mm_word {
    @import("gba").debug.print("[mmAllocChannel] mm_ch_mask={x}\n", .{ @as(c_int, @intCast(mm_ch_mask)) }) catch unreachable;
    var act_ch: [*c]mm_active_channel = &mm_achannels[@as(c_uint, @intCast(@as(c_int, 0)))];
    _ = &act_ch;
    var bitmask: mm_word = mm_ch_mask;
    _ = &bitmask;
    var best_channel: mm_word = 255;
    _ = &best_channel;
    var best_volume: mm_word = 2147483648;
    _ = &best_volume;
    {
        var i: mm_word = 0;
        _ = &i;
        while (bitmask != @as(mm_word, @bitCast(@as(c_int, 0)))) : (_ = blk: {
            _ = blk_1: {
                i +%= 1;
                break :blk_1 blk_2: {
                    const ref = &bitmask;
                    ref.* >>= @intCast(@as(c_int, 1));
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
            if ((bitmask & @as(mm_word, @bitCast(@as(c_int, 1)))) == @as(mm_word, @bitCast(@as(c_int, 0)))) continue;
            var fvol: mm_word = @as(mm_word, @bitCast(@as(c_uint, act_ch.*.fvol)));
            _ = &fvol;
            var @"type": mm_word = @as(mm_word, @bitCast(@as(c_uint, act_ch.*.type)));
            _ = &@"type";
            if (@as(mm_word, @bitCast(@as(c_int, 2))) < @"type") continue else if (@as(mm_word, @bitCast(@as(c_int, 2))) > @"type") return i;
            if (best_volume <= (fvol << @intCast(23))) continue;
            best_channel = i;
            best_volume = fvol << @intCast(23);
        }
    }
    @import("gba").debug.print("[mmAllocChannel] return={d}\n", .{ @as(c_int, @intCast(best_channel)) }) catch unreachable;
    return best_channel;
}
// /Users/michaelbraha/personal/gba/maxmod-zig/maxmod/source/core/mas_arm.c:359:9: warning: TODO implement translation of stmt class GotoStmtClass

// /Users/michaelbraha/personal/gba/maxmod-zig/maxmod/source/core/mas_arm.c:352:1: warning: unable to translate function, demoted to extern
pub export fn mmUpdateChannel_T0(arg_module_channel: [*c]mm_module_channel, arg_mpp_layer: [*c]mpl_layer_information, arg_channel_counter: mm_byte) linksection(".iwram") callconv(.c) void {
    const module_channel = arg_module_channel;
    const mpp_layer = arg_mpp_layer;
    const channel_counter = arg_channel_counter;

    @import("gba").debug.print(
        "[UCT0] enter flags={x} alloc={d} vol={d} cvol={d} inst={d} note={d}\n",
        .{
            @as(c_int, @intCast(module_channel.*.flags)),
            @as(c_int, @intCast(module_channel.*.alloc)),
            @as(c_int, @intCast(module_channel.*.volume)),
            @as(c_int, @intCast(module_channel.*.cvolume)),
            @as(c_int, @intCast(module_channel.*.inst)),
            @as(c_int, @intCast(module_channel.*.note)),
        },
    ) catch unreachable;

    // Fast path: if no start flag, ensure TN continues or exits
    if ((@as(c_int, @intCast(module_channel.*.flags)) & MF_START) == 0) {
        const act0: [*c]mm_active_channel = get_active_channel(module_channel);
        if (act0 == @as([*c]mm_active_channel, @ptrFromInt(0))) {
            mmUpdateChannel_TN(module_channel, mpp_layer);
            return;
        }
        // Fallthrough to TN
        mmUpdateChannel_TN(module_channel, mpp_layer);
        return;
    }

    // Start new note
    @import("gba").debug.print(
        "[UCT0] pre-NewNote inst={d} note={d}\n",
        .{ @as(c_int, @intCast(module_channel.*.inst)), @as(c_int, @intCast(module_channel.*.note)) },
    ) catch unreachable;
    mpp_Channel_NewNote(module_channel, mpp_layer);
    const act_ch: [*c]mm_active_channel = get_active_channel(module_channel);
    @import("gba").debug.print(
        "[UCT0] post-NewNote act?={d} sample={d} inst={d}\n",
        .{
            @as(c_int, @intCast(@intFromBool(@intFromPtr(act_ch) != 0))),
            if (@intFromPtr(act_ch) != 0) @as(c_int, @intCast(act_ch.*.sample)) else 0,
            if (@intFromPtr(act_ch) != 0) @as(c_int, @intCast(act_ch.*.inst)) else 0,
        },
    ) catch unreachable;
    var act_ch_mut: [*c]mm_active_channel = act_ch;
    if (act_ch_mut == @as([*c]mm_active_channel, @ptrFromInt(0))) {
        // Fallback: allocate an active channel now if NewNote didn't
        const alloc_idx: mm_word = mmAllocChannel();
        module_channel.*.alloc = @as(mm_byte, @intCast(alloc_idx));
        act_ch_mut = get_active_channel(module_channel);
        @import("gba").debug.print(
            "[UCT0] fallback alloc={d} act?={d}\n",
            .{ @as(c_int, @intCast(module_channel.*.alloc)), @as(c_int, @intCast(@intFromBool(@intFromPtr(act_ch_mut) != 0))) },
        ) catch unreachable;
        if (act_ch_mut == @as([*c]mm_active_channel, @ptrFromInt(0))) {
            mmUpdateChannel_TN(module_channel, mpp_layer);
            return;
        }
    }

    var note: mm_word = mmChannelStartACHN(module_channel, act_ch_mut, mpp_layer, channel_counter);
    if (note == 0 and module_channel.*.pnoter != 0) {
        note = module_channel.*.pnoter;
        module_channel.*.note = @as(mm_byte, @intCast(note));
    }
    // No fallback: rely on mmChannelStartACHN to set sample/note like C
    if (act_ch_mut.*.sample != 0) {
        const sample: [*c]mm_mas_sample_info = mpp_SamplePointer(mpp_layer, @as(mm_word, @intCast(act_ch_mut.*.sample)));
        // tuning: sample->frequency << 2 (C5Speed * 4)
        const tuning: mm_word = @as(mm_word, @intCast(@as(u32, sample.*.frequency) << 2));
        // Compute initial period like C at T0
        module_channel.*.period = mmGetPeriod(mpp_layer, tuning, @as(mm_byte, @intCast(note)));
        // Seed active-channel state so downstream pitch/volume uses correct sample/inst
        act_ch_mut.*.period = module_channel.*.period;
        act_ch_mut.*.inst = module_channel.*.inst;
        // On new note: set KEYON and reset envelope/fade state to active, like C
        act_ch_mut.*.flags |= @as(mm_byte, @intCast(MCAF_KEYON));
        // Clear ENVEND/FADE bits
        act_ch_mut.*.flags = @as(mm_byte, @intCast(@as(c_int, act_ch_mut.*.flags) & ~(@as(c_int, MCAF_ENVEND) | @as(c_int, MCAF_FADE))));
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
        mpp_vars.afvol = @as(mm_byte, @intCast(volume));
        act_ch_mut.*.flags |= @as(mm_byte, @intCast(MCAF_START));
        @import("gba").debug.print(
            "[UCT0] computed period={d} tuning={d} freq={d}\n",
            .{ @as(c_int, @intCast(module_channel.*.period)), @as(c_int, @intCast(tuning)), @as(c_int, @intCast(sample.*.frequency)) },
        ) catch unreachable;
    }

    // Clear start flag and continue normal processing
    module_channel.*.flags = @as(mm_byte, @intCast(@as(c_int, @intCast(module_channel.*.flags)) & ~MF_START));
    @import("gba").debug.print("[UCT0] -> TN\n", .{}) catch unreachable;
    mmUpdateChannel_TN(module_channel, mpp_layer);
}
pub export fn mmUpdateChannel_TN(arg_module_channel: [*c]mm_module_channel, arg_mpp_layer: [*c]mpl_layer_information) linksection(".iwram") void {
    var module_channel = arg_module_channel;
    _ = &module_channel;
    var mpp_layer = arg_mpp_layer;
    _ = &mpp_layer;
    var act_ch: [*c]mm_active_channel = get_active_channel(module_channel);
    _ = &act_ch;
    var period: mm_word = module_channel.*.period;
    _ = &period;
    // Guard: if fade is unset, initialize to full (1024) before volume pipeline
    if (act_ch != @as([*c]mm_active_channel, @ptrCast(@alignCast(@as(?*anyopaque, @ptrFromInt(@as(c_int, 0)))))) and act_ch.*.fade == 0) {
        act_ch.*.fade = 1024;
    }
    mpp_vars.sampoff = 0;
    mpp_vars.volplus = 0;
    mpp_vars.notedelay = 0;
    mpp_vars.panplus = 0;
    if ((@as(c_int, @bitCast(@as(c_uint, module_channel.*.flags))) & @as(c_int, 4)) != 0) {
        period = mpp_Process_VolumeCommand(mpp_layer, act_ch, module_channel, period);
    }
    if ((@as(c_int, @bitCast(@as(c_uint, module_channel.*.flags))) & @as(c_int, 8)) != 0) {
        period = mpp_Process_Effect(mpp_layer, act_ch, module_channel, period);
    }
    if (act_ch == @as([*c]mm_active_channel, @ptrCast(@alignCast(@as(?*anyopaque, @ptrFromInt(@as(c_int, 0))))))) return;
    var volume: c_int = (@as(c_int, @bitCast(@as(c_uint, module_channel.*.volume))) * @as(c_int, @bitCast(@as(c_uint, module_channel.*.cvolume)))) >> @intCast(5);
    _ = &volume;
    act_ch.*.volume = @as(mm_byte, @bitCast(@as(i8, @truncate(volume))));
    var vol_addition: mm_sword = @as(mm_sword, @bitCast(@as(c_int, mpp_vars.volplus)));
    _ = &vol_addition;
    volume += @as(c_int, @bitCast(vol_addition << @intCast(3)));
    if (volume < @as(c_int, 0)) {
        volume = 0;
    }
    if (volume > @as(c_int, 128)) {
        volume = 128;
    }
    mpp_vars.afvol = @as(mm_byte, @bitCast(@as(i8, @truncate(volume))));
    if (mpp_vars.notedelay != 0) {
        act_ch.*.flags |= @as(mm_byte, @bitCast(@as(i8, @truncate(@as(c_int, 1) << @intCast(3)))));
        return;
    }
    act_ch.*.panning = module_channel.*.panning;
    act_ch.*.period = module_channel.*.period;
    mpp_vars.panplus = 0;
    act_ch.*.flags |= @as(mm_byte, @bitCast(@as(i8, @truncate(@as(c_int, 1) << @intCast(3)))));
    @import("gba").debug.print(
        "[UTN] vol={d} afvol={d} panning={d} period={d} tick={d} inst={d} sample={d}\n",
        .{
            @as(c_int, @intCast(volume)),
            @as(c_int, @intCast(mpp_vars.afvol)),
            @as(c_int, @intCast(act_ch.*.panning)),
            @as(c_int, @intCast(period)),
            @as(c_int, @intCast(mpp_layer.*.tick)),
            @as(c_int, @intCast(act_ch.*.inst)),
            @as(c_int, @intCast(act_ch.*.sample)),
        },
    ) catch unreachable;
    period = mpp_Update_ACHN_notest(mpp_layer, act_ch, period, @as(mm_word, @bitCast(@as(c_uint, module_channel.*.alloc))));
}
pub export fn mmGetPeriod(arg_mpp_layer: [*c]mpl_layer_information, arg_tuning: mm_word, arg_note: mm_byte) linksection(".iwram") mm_word {
    var mpp_layer = arg_mpp_layer;
    _ = &mpp_layer;
    var tuning = arg_tuning;
    _ = &tuning;
    var note = arg_note;
    _ = &note;
    if ((@as(c_int, @bitCast(@as(c_uint, mpp_layer.*.flags))) & (@as(c_int, 1) << @intCast(2))) != 0) {
        // XM linear period mode: original C reads as 32-bit words from the 16-bit table
        // return ((mm_word*)IT_PitchTable)[note];
        const table_words: [*]const mm_word = @ptrCast(@alignCast(&IT_PitchTable));
        return table_words[@as(usize, @intCast(note))];
    }
    var r0: mm_word = @as(mm_word, @bitCast(@as(c_uint, note_table_mod[note])));
    _ = &r0;
    var r2: mm_word = @as(mm_word, @bitCast(@as(c_uint, note_table_oct[@as(c_uint, @intCast(@as(c_int, @bitCast(@as(c_uint, note))) >> @intCast(2)))])));
    _ = &r2;
    var ret_val: mm_word = @as(mm_word, @bitCast((@as(c_int, @bitCast(@as(c_uint, ST3_FREQTABLE[r0]))) * @as(c_int, 133808)) >> @intCast(r2)));
    _ = &ret_val;
    if (tuning != 0) {
        ret_val /= tuning;
    }
    return ret_val;
}
pub export fn mmReadPattern(arg_mpp_layer: [*c]mpl_layer_information) linksection(".iwram") mm_bool {
    var mpp_layer = arg_mpp_layer;
    _ = &mpp_layer;
    var instr_count: mm_word = @as(mm_word, @bitCast(@as(c_uint, mpp_layer.*.songadr.*.instr_count)));
    _ = &instr_count;
    var flags: mm_word = @as(mm_word, @bitCast(@as(c_uint, mpp_layer.*.flags)));
    _ = &flags;
    var module_channels: [*c]mm_module_channel = mpp_channels;
    _ = &module_channels;
    mpp_vars.pattread_p = mpp_layer.*.pattread;
    var pattern: [*c]mm_byte = mpp_vars.pattread_p;
    _ = &pattern;
    var update_bits: mm_word = 0;
    _ = &update_bits;
    @import("gba").debug.print("[Z mmReadPattern] start pattread={x} pattread_p={x} nch={d} row={d}\n", .{
        @intFromPtr(mpp_layer.*.pattread),
        @intFromPtr(mpp_vars.pattread_p),
        @as(c_int, @intCast(mpp_nchannels)),
        @as(c_int, @intCast(mpp_layer.*.row)),
    }) catch unreachable;
    var debug_detail: bool = false;
    // Show detailed per-field reads for the first couple of rows
    if (mpp_layer.*.row < 2) debug_detail = true;
    while (true) {
        var read_byte: mm_byte = (blk: {
            const ref = &pattern;
            const tmp = ref.*;
            ref.* += 1;
            break :blk tmp;
        }).*;
        _ = &read_byte;
        if (debug_detail) @import("gba").debug.print("[Z mmReadPattern] read_byte={x} at pos={x}\n", .{ @as(c_int, @intCast(read_byte)), @intFromPtr(pattern - 1) }) catch unreachable;
        // Let the translated C code handle everything (including XM files)
        if ((@as(c_int, @bitCast(@as(c_uint, read_byte))) & @as(c_int, 127)) == @as(c_int, 0)) {
            @import("gba").debug.print("[mmReadPattern] break: read_byte & 127 = 0\n", .{}) catch unreachable;
            break;
        }
        var pattern_flags: mm_word = 0;
        _ = &pattern_flags;
        const chan_calculation = (@as(c_int, @bitCast(@as(c_uint, read_byte))) & @as(c_int, 127)) - @as(c_int, 1);
        if (debug_detail) @import("gba").debug.print("[Z mmReadPattern] chan_calc=(({x} & 127)-1)={d}\n", .{ @as(c_int, @intCast(read_byte)), chan_calculation }) catch unreachable;
        var chan_num: mm_byte = @as(mm_byte, @bitCast(@as(i8, @truncate(chan_calculation))));
        _ = &chan_num;
        if (@as(c_int, @bitCast(@as(c_uint, chan_num))) >= @as(c_int, @bitCast(@as(c_uint, mpp_nchannels)))) {
            @import("gba").debug.print(
                "[mmReadPattern] error: chan {d} >= nch {d} (flags={x} row={d})\n",
                .{
                    @as(c_int, @intCast(chan_num)),
                    @as(c_int, @intCast(mpp_nchannels)),
                    @as(c_int, @intCast(read_byte)),
                    @as(c_int, @intCast(mpp_layer.*.row)),
                },
            ) catch unreachable;
            // Non-XM mode: return error for invalid channels
            return 0;
        }
        update_bits |= @as(mm_word, @bitCast(@as(c_int, 1) << @intCast(@as(c_int, @bitCast(@as(c_uint, chan_num))))));
        var module_channel: [*c]mm_module_channel = &module_channels[chan_num];
        _ = &module_channel;
        if ((@as(c_int, @bitCast(@as(c_uint, read_byte))) & (@as(c_int, 1) << @intCast(7))) != 0) {
            if (debug_detail) @import("gba").debug.print("[Z mmReadPattern] reading cflags (bit7 in {x})\n", .{@as(c_int, @intCast(read_byte))}) catch unreachable;
            module_channel.*.cflags = (blk: {
                const ref = &pattern;
                const tmp = ref.*;
                ref.* += 1;
                break :blk tmp;
            }).*;
            if (debug_detail) @import("gba").debug.print("[Z mmReadPattern] cflags={x} at pos={x}\n", .{ @as(c_int, @intCast(module_channel.*.cflags)), @intFromPtr(pattern - 1) }) catch unreachable;
        }
        var compr_flags: mm_word = @as(mm_word, @bitCast(@as(c_uint, module_channel.*.cflags)));
        _ = &compr_flags;
        if (debug_detail) @import("gba").debug.print("[Z mmReadPattern] compr_flags={x}\n", .{@as(c_int, @intCast(compr_flags))}) catch unreachable;
        if ((compr_flags & @as(mm_word, @bitCast(@as(c_int, 1) << @intCast(0)))) != 0) {
            if (debug_detail) @import("gba").debug.print("[Z mmReadPattern] reading note (bit0 in {x})\n", .{@as(c_int, @intCast(compr_flags))}) catch unreachable;
            var note: mm_byte = (blk: {
                const ref = &pattern;
                const tmp = ref.*;
                ref.* += 1;
                break :blk tmp;
            }).*;
            _ = &note;
            if (debug_detail) @import("gba").debug.print("[Z mmReadPattern] note={x} at pos={x}\n", .{ @as(c_int, @intCast(note)), @intFromPtr(pattern - 1) }) catch unreachable;
            if (@as(c_int, @bitCast(@as(c_uint, note))) == @as(c_int, 254)) {
                pattern_flags |= @as(mm_word, @bitCast(@as(c_int, 128)));
            } else if (@as(c_int, @bitCast(@as(c_uint, note))) == @as(c_int, 255)) {
                pattern_flags |= @as(mm_word, @bitCast(@as(c_int, 64)));
            } else {
                module_channel.*.pnoter = note;
                // Seed note used by T0. This mirrors C's decode state having note ready before T0.
                module_channel.*.note = note;
            }
        }
        if ((compr_flags & @as(mm_word, @bitCast(@as(c_int, 1) << @intCast(1)))) != 0) {
            var instr: mm_byte = (blk: {
                const ref = &pattern;
                const tmp = ref.*;
                ref.* += 1;
                break :blk tmp;
            }).*;
            _ = &instr;
            if ((pattern_flags & @as(mm_word, @bitCast(@as(c_int, 128) | @as(c_int, 64)))) == @as(mm_word, @bitCast(@as(c_int, 0)))) {
                if (@as(mm_word, @bitCast(@as(c_uint, instr))) > instr_count) {
                    instr = 0;
                }
                if (@as(c_int, @bitCast(@as(c_uint, module_channel.*.inst))) != @as(c_int, @bitCast(@as(c_uint, instr)))) {
                    if ((flags & @as(mm_word, @bitCast(@as(c_int, 1) << @intCast(5)))) != 0) {
                        pattern_flags |= @as(mm_word, @bitCast(@as(c_int, 1)));
                    }
                    pattern_flags |= @as(mm_word, @bitCast(@as(c_int, 16)));
                }
                module_channel.*.inst = instr;
                @import("gba").debug.print(
                    "[Z mmReadPattern] ch={d} set inst={d} (row={d})\n",
                    .{ @as(c_int, @intCast(chan_num)), @as(c_int, @intCast(instr)), @as(c_int, @intCast(mpp_layer.*.row)) },
                ) catch unreachable;
            }
        }
        if ((compr_flags & @as(mm_word, @bitCast(@as(c_int, 1) << @intCast(2)))) != 0) {
            module_channel.*.volcmd = (blk: {
                const ref = &pattern;
                const tmp = ref.*;
                ref.* += 1;
                break :blk tmp;
            }).*;
        }
        if ((compr_flags & @as(mm_word, @bitCast(@as(c_int, 1) << @intCast(3)))) != 0) {
            if (debug_detail) @import("gba").debug.print("[Z mmReadPattern] reading eff+param (bit3 in {x})\n", .{@as(c_int, @intCast(compr_flags))}) catch unreachable;
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
            if (debug_detail) @import("gba").debug.print("[Z mmReadPattern] effect={x} param={x} at pos={x}\n", .{ @as(c_int, @intCast(module_channel.*.effect)), @as(c_int, @intCast(module_channel.*.param)), @intFromPtr(pattern - 2) }) catch unreachable;
        }
        module_channel.*.flags = @as(mm_byte, @bitCast(@as(u8, @truncate(pattern_flags | (compr_flags >> @intCast(4))))));
        if (debug_detail) @import("gba").debug.print("[Z mmReadPattern] end chan {d}, pattern now {x}\n", .{ @as(c_int, @intCast(chan_num)), @intFromPtr(pattern) }) catch unreachable;
    }
    mpp_layer.*.pattread = pattern;
    mpp_layer.*.mch_update = update_bits;
    @import("gba").debug.print("[Z mmReadPattern] row end, pattread={x} update_bits={x}\n", .{ @intFromPtr(mpp_layer.*.pattread), @as(c_int, @intCast(update_bits)) }) catch unreachable;
    return 1;
}
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
    const idx: usize = @as(usize, @intCast(sampleN -% @as(mm_word, @bitCast(@as(c_int, 1)))));
    const off_ptr: [*]u8 = @constCast(@ptrCast(@alignCast(&base[@as(usize, 0)])));
    const samptbl_bytes: [*]const u8 = @ptrCast(@alignCast(layer.*.samptable));
    const p: [*]const u8 = samptbl_bytes + (idx * 4);
    const off: usize = @as(usize, @intCast(@as(u32, p[0]) | (@as(u32, p[1]) << 8) | (@as(u32, p[2]) << 16) | (@as(u32, p[3]) << 24)));
    return @as([*c]mm_mas_sample_info, @ptrCast(@alignCast(off_ptr + off)));
}
pub inline fn mpp_InstrumentPointer(arg_layer: [*c]mpl_layer_information, arg_instN: mm_word) ?*mm_mas_instrument {
    var layer = arg_layer;
    _ = &layer;
    var instN = arg_instN;
    _ = &instN;
    var base: [*c]mm_byte = @as([*c]mm_byte, @ptrCast(@alignCast(layer.*.songadr)));
    _ = &base;
    const idx: usize = @as(usize, @intCast(instN -% @as(mm_word, @bitCast(@as(c_int, 1)))));
    const insttbl_bytes: [*]const u8 = @ptrCast(@alignCast(layer.*.insttable));
    const p: [*]const u8 = insttbl_bytes + (idx * 4);
    const off: usize = @as(usize, @intCast(@as(u32, p[0]) | (@as(u32, p[1]) << 8) | (@as(u32, p[2]) << 16) | (@as(u32, p[3]) << 24)));
    const ptr: [*]u8 = @ptrCast(@alignCast(base + off));
    return @ptrCast(@alignCast(ptr));
}
pub inline fn mpp_PatternPointer(arg_layer: [*c]mpl_layer_information, arg_entry: mm_word) [*c]mm_mas_pattern {
    var layer = arg_layer;
    _ = &layer;
    var entry = arg_entry;
    _ = &entry;
    var base: [*c]mm_byte = @as([*c]mm_byte, @ptrCast(@alignCast(layer.*.songadr)));
    _ = &base;
    const idx: usize = @as(usize, @intCast(arg_entry));
    const patttbl_bytes: [*]const u8 = @ptrCast(@alignCast(layer.*.patttable));
    const p: [*]const u8 = patttbl_bytes + (idx * 4);
    const off: usize = @as(usize, @intCast(@as(u32, p[0]) | (@as(u32, p[1]) << 8) | (@as(u32, p[2]) << 16) | (@as(u32, p[3]) << 24)));
    return @as([*c]mm_mas_pattern, @ptrCast(@alignCast(@as([*]u8, @ptrCast(base)) + off)));
}
pub const note_table_oct: [30]mm_byte = [30]mm_byte{
    0,
    0,
    0,
    1,
    1,
    1,
    2,
    2,
    2,
    3,
    3,
    3,
    4,
    4,
    4,
    5,
    5,
    5,
    6,
    6,
    6,
    7,
    7,
    7,
    8,
    8,
    8,
    9,
    9,
    9,
};
pub const note_table_mod: [109]mm_byte = [109]mm_byte{
    0,
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    0,
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    0,
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    0,
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    0,
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    0,
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    0,
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    0,
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    0,
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    0,
};
pub const ST3_FREQTABLE: [12]mm_hword = [12]mm_hword{
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 1712) * @as(c_int, 8))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 1616) * @as(c_int, 8))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 1524) * @as(c_int, 8))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 1440) * @as(c_int, 8))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 1356) * @as(c_int, 8))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 1280) * @as(c_int, 8))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 1208) * @as(c_int, 8))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 1140) * @as(c_int, 8))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 1076) * @as(c_int, 8))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 1016) * @as(c_int, 8))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 960) * @as(c_int, 8))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 907) * @as(c_int, 8))))),
};
pub const IT_PitchTable: [240]mm_hword align(4) = [240]mm_hword{
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 2048))))),
    0,
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 2170))))),
    0,
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 2299))))),
    0,
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 2435))))),
    0,
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 2580))))),
    0,
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 2734))))),
    0,
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 2896))))),
    0,
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 3069))))),
    0,
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 3251))))),
    0,
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 3444))))),
    0,
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 3649))))),
    0,
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 3866))))),
    0,
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 4096))))),
    0,
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 4340))))),
    0,
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 4598))))),
    0,
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 4871))))),
    0,
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 5161))))),
    0,
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 5468))))),
    0,
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 5793))))),
    0,
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 6137))))),
    0,
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 6502))))),
    0,
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 6889))))),
    0,
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 7298))))),
    0,
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 7732))))),
    0,
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 8192))))),
    0,
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 8679))))),
    0,
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 9195))))),
    0,
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 9742))))),
    0,
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 10321))))),
    0,
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 10935))))),
    0,
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 11585))))),
    0,
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 12274))))),
    0,
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 13004))))),
    0,
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 13777))))),
    0,
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 14596))))),
    0,
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 15464))))),
    0,
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 16384))))),
    0,
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 17358))))),
    0,
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 18390))))),
    0,
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 19484))))),
    0,
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 20643))))),
    0,
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 21870))))),
    0,
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 23170))))),
    0,
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 24548))))),
    0,
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 26008))))),
    0,
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 27554))))),
    0,
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 29193))))),
    0,
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 30929))))),
    0,
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 32768))))),
    0,
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 34716))))),
    0,
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 36781))))),
    0,
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 38968))))),
    0,
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 41285))))),
    0,
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 43740))))),
    0,
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 46341))))),
    0,
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 49097))))),
    0,
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 52016))))),
    0,
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 55109))))),
    0,
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 58386))))),
    0,
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 61858))))),
    0,
    0,
    1,
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 3897))))),
    1,
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 8026))))),
    1,
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 12400))))),
    1,
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 17034))))),
    1,
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 21944))))),
    1,
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 27146))))),
    1,
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 32657))))),
    1,
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 38496))))),
    1,
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 44682))))),
    1,
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 51236))))),
    1,
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 58179))))),
    1,
    0,
    2,
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 7794))))),
    2,
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 16051))))),
    2,
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 24800))))),
    2,
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 34068))))),
    2,
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 43888))))),
    2,
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 54292))))),
    2,
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 65314))))),
    2,
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 11456))))),
    3,
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 23828))))),
    3,
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 36936))))),
    3,
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 50823))))),
    3,
    0,
    4,
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 15588))))),
    4,
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 32103))))),
    4,
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 49600))))),
    4,
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 2601))))),
    5,
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 22240))))),
    5,
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 43048))))),
    5,
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 65092))))),
    5,
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 22912))))),
    6,
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 47656))))),
    6,
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 8336))))),
    7,
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 36110))))),
    7,
    0,
    8,
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 31176))))),
    8,
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 64205))))),
    8,
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 33663))))),
    9,
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 5201))))),
    10,
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 44481))))),
    10,
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 20559))))),
    11,
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 64648))))),
    11,
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 45823))))),
    12,
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 29776))))),
    13,
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 16671))))),
    14,
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 6684))))),
    15,
    0,
    16,
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 62352))))),
    16,
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 62875))))),
    17,
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 1790))))),
    19,
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 10403))))),
    20,
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 23425))))),
    21,
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 41118))))),
    22,
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 63761))))),
    23,
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 26111))))),
    25,
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 59552))))),
    26,
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 33342))))),
    28,
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 13368))))),
    30,
};
pub fn mmChannelStartACHN(arg_module_channel: [*c]mm_module_channel, arg_active_channel: [*c]mm_active_channel, arg_mpp_layer: [*c]mpl_layer_information, arg_channel_counter: mm_byte) linksection(".iwram") callconv(.c) mm_byte {
    var module_channel = arg_module_channel;
    _ = &module_channel;
    var active_channel = arg_active_channel;
    _ = &active_channel;
    var mpp_layer = arg_mpp_layer;
    _ = &mpp_layer;
    var channel_counter = arg_channel_counter;
    _ = &channel_counter;
    module_channel.*.bflags &= @as(mm_hword, @bitCast(@as(c_short, @truncate(~((@as(c_int, 1) << @intCast(10)) | (@as(c_int, 1) << @intCast(9)))))));
    if (active_channel != null) {
        active_channel.*.type = 3;
        active_channel.*.flags &= @as(mm_byte, @bitCast(@as(i8, @truncate(~((@as(c_int, 1) << @intCast(6)) | (@as(c_int, 1) << @intCast(7)))))));
        if (mpp_clayer == @as(c_uint, @bitCast(MM_JINGLE))) {
            active_channel.*.flags |= @as(mm_byte, @bitCast(@as(i8, @truncate(@as(c_int, 1) << @intCast(6)))));
        }
        active_channel.*.parent = channel_counter;
        active_channel.*.inst = module_channel.*.inst;
    }
    if (@as(c_int, @bitCast(@as(c_uint, module_channel.*.inst))) == @as(c_int, 0)) return @as(mm_byte, @bitCast(@as(u8, @truncate(module_channel.*.bflags))));
    var instrument: *mm_mas_instrument = mpp_InstrumentPointer(mpp_layer, @as(mm_word, @bitCast(@as(c_uint, module_channel.*.inst)))) orelse unreachable;
    _ = &instrument;
    // Extract packed notemap bitfield: low 15 bits offset, high bit invalid flag
    const packed_nmap: mm_hword = instrument.*.note_map_offset;
    const nm_off: usize = @as(usize, @intCast(packed_nmap & 0x7FFF));
    const invalid_map: bool = ((packed_nmap & 0x8000) != 0);
    // One-time detailed dump for mapping on first two channels at tick 0
    if (mpp_layer.*.tick == 0 and channel_counter < 2) {
        const inst_base_dbg: usize = @intFromPtr(instrument);
        const nm_ptr_dbg: usize = inst_base_dbg + nm_off;
        const idx_dbg: usize = @as(usize, @intCast(module_channel.*.pnoter));
        const map_ptr_dbg: [*]const mm_hword = @ptrFromInt(nm_ptr_dbg);
        const raw_entry_dbg: mm_hword = map_ptr_dbg[idx_dbg];
        @import("gba").debug.print(
            "[MAPDBG] ch={d} inst_ptr={x} nmap_off={x} map_ptr={x} pnoter={d} entry={x} invalid={d}\n",
            .{ @as(c_int, @intCast(channel_counter)), inst_base_dbg, nm_off, nm_ptr_dbg, @as(c_int, @intCast(module_channel.*.pnoter)), @as(c_int, @intCast(raw_entry_dbg)), @as(c_int, @intCast(@intFromBool(invalid_map))) },
        ) catch {};
    }
    if (invalid_map) {
        // No valid note map: use instrument default mapping
        if (active_channel != null) {
            active_channel.*.sample = @as(mm_byte, @intCast(nm_off & 0xFF));
        }
        module_channel.*.note = module_channel.*.pnoter;
    } else {
        // Proper note map: 16-bit entries, low byte is note, high byte is sample index
        const inst_base: usize = @intFromPtr(instrument);
        const map_ptr: [*]const mm_hword = @ptrFromInt(inst_base + nm_off);
        const idx: usize = @as(usize, @intCast(module_channel.*.pnoter));
        const entry: mm_hword = map_ptr[idx];
        module_channel.*.note = @as(mm_byte, @intCast(entry & 0xFF));
        if (active_channel != null) {
            active_channel.*.sample = @as(mm_byte, @intCast((entry >> 8) & 0xFF));
        }
    }
    // Minimal mapping debug on first channels/tick 0 (guarded)
    if (mpp_layer.*.tick == 0 and channel_counter < 2) {
        @import("gba").debug.print(
            "[BINDMAP] ch={d} inst={d} pnoter={d} invalid={d} nmap_off={x} note={d} sample={d}\n",
            .{ @as(c_int, @intCast(channel_counter)), @as(c_int, @intCast(module_channel.*.inst)), @as(c_int, @intCast(module_channel.*.pnoter)), @as(c_int, @intCast(@intFromBool(invalid_map))), @as(c_int, @intCast(nm_off)), @as(c_int, @intCast(module_channel.*.note)), if (active_channel != null) @as(c_int, @intCast(active_channel.*.sample)) else 0 },
        ) catch {};
    }
    return module_channel.*.note;
}
pub fn get_active_channel(arg_module_channel: [*c]mm_module_channel) linksection(".iwram") callconv(.c) [*c]mm_active_channel {
    var module_channel = arg_module_channel;
    _ = &module_channel;
    var act_ch: [*c]mm_active_channel = null;
    _ = &act_ch;
    if (@as(c_int, @bitCast(@as(c_uint, module_channel.*.alloc))) != @as(c_int, 255)) {
        act_ch = &mm_achannels[module_channel.*.alloc];
    }
    return act_ch;
}
pub const __llvm__ = @as(c_int, 1);
pub const __clang__ = @as(c_int, 1);
pub const __clang_major__ = @as(c_int, 19);
pub const __clang_minor__ = @as(c_int, 1);
pub const __clang_patchlevel__ = @as(c_int, 7);
pub const __clang_version__ = "19.1.7 (https://github.com/ziglang/zig-bootstrap de1b01a8c1dddf75a560123ac1c2ab182b4830da)";
pub const __GNUC__ = @as(c_int, 4);
pub const __GNUC_MINOR__ = @as(c_int, 2);
pub const __GNUC_PATCHLEVEL__ = @as(c_int, 1);
pub const __GXX_ABI_VERSION = @as(c_int, 1002);
pub const __ATOMIC_RELAXED = @as(c_int, 0);
pub const __ATOMIC_CONSUME = @as(c_int, 1);
pub const __ATOMIC_ACQUIRE = @as(c_int, 2);
pub const __ATOMIC_RELEASE = @as(c_int, 3);
pub const __ATOMIC_ACQ_REL = @as(c_int, 4);
pub const __ATOMIC_SEQ_CST = @as(c_int, 5);
pub const __MEMORY_SCOPE_SYSTEM = @as(c_int, 0);
pub const __MEMORY_SCOPE_DEVICE = @as(c_int, 1);
pub const __MEMORY_SCOPE_WRKGRP = @as(c_int, 2);
pub const __MEMORY_SCOPE_WVFRNT = @as(c_int, 3);
pub const __MEMORY_SCOPE_SINGLE = @as(c_int, 4);
pub const __OPENCL_MEMORY_SCOPE_WORK_ITEM = @as(c_int, 0);
pub const __OPENCL_MEMORY_SCOPE_WORK_GROUP = @as(c_int, 1);
pub const __OPENCL_MEMORY_SCOPE_DEVICE = @as(c_int, 2);
pub const __OPENCL_MEMORY_SCOPE_ALL_SVM_DEVICES = @as(c_int, 3);
pub const __OPENCL_MEMORY_SCOPE_SUB_GROUP = @as(c_int, 4);
pub const __FPCLASS_SNAN = @as(c_int, 0x0001);
pub const __FPCLASS_QNAN = @as(c_int, 0x0002);
pub const __FPCLASS_NEGINF = @as(c_int, 0x0004);
pub const __FPCLASS_NEGNORMAL = @as(c_int, 0x0008);
pub const __FPCLASS_NEGSUBNORMAL = @as(c_int, 0x0010);
pub const __FPCLASS_NEGZERO = @as(c_int, 0x0020);
pub const __FPCLASS_POSZERO = @as(c_int, 0x0040);
pub const __FPCLASS_POSSUBNORMAL = @as(c_int, 0x0080);
pub const __FPCLASS_POSNORMAL = @as(c_int, 0x0100);
pub const __FPCLASS_POSINF = @as(c_int, 0x0200);
pub const __PRAGMA_REDEFINE_EXTNAME = @as(c_int, 1);
pub const __VERSION__ = "Clang 19.1.7 (https://github.com/ziglang/zig-bootstrap de1b01a8c1dddf75a560123ac1c2ab182b4830da)";
pub const __OBJC_BOOL_IS_BOOL = @as(c_int, 0);
pub const __CONSTANT_CFSTRINGS__ = @as(c_int, 1);
pub const __clang_literal_encoding__ = "UTF-8";
pub const __clang_wide_literal_encoding__ = "UTF-32";
pub const __ORDER_LITTLE_ENDIAN__ = @as(c_int, 1234);
pub const __ORDER_BIG_ENDIAN__ = @as(c_int, 4321);
pub const __ORDER_PDP_ENDIAN__ = @as(c_int, 3412);
pub const __BYTE_ORDER__ = __ORDER_LITTLE_ENDIAN__;
pub const __LITTLE_ENDIAN__ = @as(c_int, 1);
pub const _ILP32 = @as(c_int, 1);
pub const __ILP32__ = @as(c_int, 1);
pub const __CHAR_BIT__ = @as(c_int, 8);
pub const __BOOL_WIDTH__ = @as(c_int, 8);
pub const __SHRT_WIDTH__ = @as(c_int, 16);
pub const __INT_WIDTH__ = @as(c_int, 32);
pub const __LONG_WIDTH__ = @as(c_int, 32);
pub const __LLONG_WIDTH__ = @as(c_int, 64);
pub const __BITINT_MAXWIDTH__ = @as(c_int, 128);
pub const __SCHAR_MAX__ = @as(c_int, 127);
pub const __SHRT_MAX__ = @as(c_int, 32767);
pub const __INT_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_int, 2147483647, .decimal);
pub const __LONG_MAX__ = @as(c_long, 2147483647);
pub const __LONG_LONG_MAX__ = @as(c_longlong, 9223372036854775807);
pub const __WCHAR_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_uint, 4294967295, .decimal);
pub const __WCHAR_WIDTH__ = @as(c_int, 32);
pub const __WINT_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_int, 2147483647, .decimal);
pub const __WINT_WIDTH__ = @as(c_int, 32);
pub const __INTMAX_MAX__ = @as(c_longlong, 9223372036854775807);
pub const __INTMAX_WIDTH__ = @as(c_int, 64);
pub const __SIZE_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_uint, 4294967295, .decimal);
pub const __SIZE_WIDTH__ = @as(c_int, 32);
pub const __UINTMAX_MAX__ = @as(c_ulonglong, 18446744073709551615);
pub const __UINTMAX_WIDTH__ = @as(c_int, 64);
pub const __PTRDIFF_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_int, 2147483647, .decimal);
pub const __PTRDIFF_WIDTH__ = @as(c_int, 32);
pub const __INTPTR_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_int, 2147483647, .decimal);
pub const __INTPTR_WIDTH__ = @as(c_int, 32);
pub const __UINTPTR_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_uint, 4294967295, .decimal);
pub const __UINTPTR_WIDTH__ = @as(c_int, 32);
pub const __SIZEOF_DOUBLE__ = @as(c_int, 8);
pub const __SIZEOF_FLOAT__ = @as(c_int, 4);
pub const __SIZEOF_INT__ = @as(c_int, 4);
pub const __SIZEOF_LONG__ = @as(c_int, 4);
pub const __SIZEOF_LONG_DOUBLE__ = @as(c_int, 8);
pub const __SIZEOF_LONG_LONG__ = @as(c_int, 8);
pub const __SIZEOF_POINTER__ = @as(c_int, 4);
pub const __SIZEOF_SHORT__ = @as(c_int, 2);
pub const __SIZEOF_PTRDIFF_T__ = @as(c_int, 4);
pub const __SIZEOF_SIZE_T__ = @as(c_int, 4);
pub const __SIZEOF_WCHAR_T__ = @as(c_int, 4);
pub const __SIZEOF_WINT_T__ = @as(c_int, 4);
pub const __INTMAX_TYPE__ = c_longlong;
pub const __INTMAX_FMTd__ = "lld";
pub const __INTMAX_FMTi__ = "lli";
pub const __INTMAX_C_SUFFIX__ = @compileError("unable to translate macro: undefined identifier `LL`");
// (no file):94:9
pub const __UINTMAX_TYPE__ = c_ulonglong;
pub const __UINTMAX_FMTo__ = "llo";
pub const __UINTMAX_FMTu__ = "llu";
pub const __UINTMAX_FMTx__ = "llx";
pub const __UINTMAX_FMTX__ = "llX";
pub const __UINTMAX_C_SUFFIX__ = @compileError("unable to translate macro: undefined identifier `ULL`");
// (no file):100:9
pub const __PTRDIFF_TYPE__ = c_int;
pub const __PTRDIFF_FMTd__ = "d";
pub const __PTRDIFF_FMTi__ = "i";
pub const __INTPTR_TYPE__ = c_int;
pub const __INTPTR_FMTd__ = "d";
pub const __INTPTR_FMTi__ = "i";
pub const __SIZE_TYPE__ = c_uint;
pub const __SIZE_FMTo__ = "o";
pub const __SIZE_FMTu__ = "u";
pub const __SIZE_FMTx__ = "x";
pub const __SIZE_FMTX__ = "X";
pub const __WCHAR_TYPE__ = c_uint;
pub const __WINT_TYPE__ = c_int;
pub const __SIG_ATOMIC_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_int, 2147483647, .decimal);
pub const __SIG_ATOMIC_WIDTH__ = @as(c_int, 32);
pub const __CHAR16_TYPE__ = c_ushort;
pub const __CHAR32_TYPE__ = c_uint;
pub const __UINTPTR_TYPE__ = c_uint;
pub const __UINTPTR_FMTo__ = "o";
pub const __UINTPTR_FMTu__ = "u";
pub const __UINTPTR_FMTx__ = "x";
pub const __UINTPTR_FMTX__ = "X";
pub const __FLT16_DENORM_MIN__ = @as(f16, 5.9604644775390625e-8);
pub const __FLT16_NORM_MAX__ = @as(f16, 6.5504e+4);
pub const __FLT16_HAS_DENORM__ = @as(c_int, 1);
pub const __FLT16_DIG__ = @as(c_int, 3);
pub const __FLT16_DECIMAL_DIG__ = @as(c_int, 5);
pub const __FLT16_EPSILON__ = @as(f16, 9.765625e-4);
pub const __FLT16_HAS_INFINITY__ = @as(c_int, 1);
pub const __FLT16_HAS_QUIET_NAN__ = @as(c_int, 1);
pub const __FLT16_MANT_DIG__ = @as(c_int, 11);
pub const __FLT16_MAX_10_EXP__ = @as(c_int, 4);
pub const __FLT16_MAX_EXP__ = @as(c_int, 16);
pub const __FLT16_MAX__ = @as(f16, 6.5504e+4);
pub const __FLT16_MIN_10_EXP__ = -@as(c_int, 4);
pub const __FLT16_MIN_EXP__ = -@as(c_int, 13);
pub const __FLT16_MIN__ = @as(f16, 6.103515625e-5);
pub const __FLT_DENORM_MIN__ = @as(f32, 1.40129846e-45);
pub const __FLT_NORM_MAX__ = @as(f32, 3.40282347e+38);
pub const __FLT_HAS_DENORM__ = @as(c_int, 1);
pub const __FLT_DIG__ = @as(c_int, 6);
pub const __FLT_DECIMAL_DIG__ = @as(c_int, 9);
pub const __FLT_EPSILON__ = @as(f32, 1.19209290e-7);
pub const __FLT_HAS_INFINITY__ = @as(c_int, 1);
pub const __FLT_HAS_QUIET_NAN__ = @as(c_int, 1);
pub const __FLT_MANT_DIG__ = @as(c_int, 24);
pub const __FLT_MAX_10_EXP__ = @as(c_int, 38);
pub const __FLT_MAX_EXP__ = @as(c_int, 128);
pub const __FLT_MAX__ = @as(f32, 3.40282347e+38);
pub const __FLT_MIN_10_EXP__ = -@as(c_int, 37);
pub const __FLT_MIN_EXP__ = -@as(c_int, 125);
pub const __FLT_MIN__ = @as(f32, 1.17549435e-38);
pub const __DBL_DENORM_MIN__ = @as(f64, 4.9406564584124654e-324);
pub const __DBL_NORM_MAX__ = @as(f64, 1.7976931348623157e+308);
pub const __DBL_HAS_DENORM__ = @as(c_int, 1);
pub const __DBL_DIG__ = @as(c_int, 15);
pub const __DBL_DECIMAL_DIG__ = @as(c_int, 17);
pub const __DBL_EPSILON__ = @as(f64, 2.2204460492503131e-16);
pub const __DBL_HAS_INFINITY__ = @as(c_int, 1);
pub const __DBL_HAS_QUIET_NAN__ = @as(c_int, 1);
pub const __DBL_MANT_DIG__ = @as(c_int, 53);
pub const __DBL_MAX_10_EXP__ = @as(c_int, 308);
pub const __DBL_MAX_EXP__ = @as(c_int, 1024);
pub const __DBL_MAX__ = @as(f64, 1.7976931348623157e+308);
pub const __DBL_MIN_10_EXP__ = -@as(c_int, 307);
pub const __DBL_MIN_EXP__ = -@as(c_int, 1021);
pub const __DBL_MIN__ = @as(f64, 2.2250738585072014e-308);
pub const __LDBL_DENORM_MIN__ = @as(c_longdouble, 4.9406564584124654e-324);
pub const __LDBL_NORM_MAX__ = @as(c_longdouble, 1.7976931348623157e+308);
pub const __LDBL_HAS_DENORM__ = @as(c_int, 1);
pub const __LDBL_DIG__ = @as(c_int, 15);
pub const __LDBL_DECIMAL_DIG__ = @as(c_int, 17);
pub const __LDBL_EPSILON__ = @as(c_longdouble, 2.2204460492503131e-16);
pub const __LDBL_HAS_INFINITY__ = @as(c_int, 1);
pub const __LDBL_HAS_QUIET_NAN__ = @as(c_int, 1);
pub const __LDBL_MANT_DIG__ = @as(c_int, 53);
pub const __LDBL_MAX_10_EXP__ = @as(c_int, 308);
pub const __LDBL_MAX_EXP__ = @as(c_int, 1024);
pub const __LDBL_MAX__ = @as(c_longdouble, 1.7976931348623157e+308);
pub const __LDBL_MIN_10_EXP__ = -@as(c_int, 307);
pub const __LDBL_MIN_EXP__ = -@as(c_int, 1021);
pub const __LDBL_MIN__ = @as(c_longdouble, 2.2250738585072014e-308);
pub const __POINTER_WIDTH__ = @as(c_int, 32);
pub const __BIGGEST_ALIGNMENT__ = @as(c_int, 8);
pub const __CHAR_UNSIGNED__ = @as(c_int, 1);
pub const __WCHAR_UNSIGNED__ = @as(c_int, 1);
pub const __INT8_TYPE__ = i8;
pub const __INT8_FMTd__ = "hhd";
pub const __INT8_FMTi__ = "hhi";
pub const __INT8_C_SUFFIX__ = "";
pub const __INT16_TYPE__ = c_short;
pub const __INT16_FMTd__ = "hd";
pub const __INT16_FMTi__ = "hi";
pub const __INT16_C_SUFFIX__ = "";
pub const __INT32_TYPE__ = c_int;
pub const __INT32_FMTd__ = "d";
pub const __INT32_FMTi__ = "i";
pub const __INT32_C_SUFFIX__ = "";
pub const __INT64_TYPE__ = c_longlong;
pub const __INT64_FMTd__ = "lld";
pub const __INT64_FMTi__ = "lli";
pub const __INT64_C_SUFFIX__ = @compileError("unable to translate macro: undefined identifier `LL`");
// (no file):202:9
pub const __UINT8_TYPE__ = u8;
pub const __UINT8_FMTo__ = "hho";
pub const __UINT8_FMTu__ = "hhu";
pub const __UINT8_FMTx__ = "hhx";
pub const __UINT8_FMTX__ = "hhX";
pub const __UINT8_C_SUFFIX__ = "";
pub const __UINT8_MAX__ = @as(c_int, 255);
pub const __INT8_MAX__ = @as(c_int, 127);
pub const __UINT16_TYPE__ = c_ushort;
pub const __UINT16_FMTo__ = "ho";
pub const __UINT16_FMTu__ = "hu";
pub const __UINT16_FMTx__ = "hx";
pub const __UINT16_FMTX__ = "hX";
pub const __UINT16_C_SUFFIX__ = "";
pub const __UINT16_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_int, 65535, .decimal);
pub const __INT16_MAX__ = @as(c_int, 32767);
pub const __UINT32_TYPE__ = c_uint;
pub const __UINT32_FMTo__ = "o";
pub const __UINT32_FMTu__ = "u";
pub const __UINT32_FMTx__ = "x";
pub const __UINT32_FMTX__ = "X";
pub const __UINT32_C_SUFFIX__ = @compileError("unable to translate macro: undefined identifier `U`");
// (no file):224:9
pub const __UINT32_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_uint, 4294967295, .decimal);
pub const __INT32_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_int, 2147483647, .decimal);
pub const __UINT64_TYPE__ = c_ulonglong;
pub const __UINT64_FMTo__ = "llo";
pub const __UINT64_FMTu__ = "llu";
pub const __UINT64_FMTx__ = "llx";
pub const __UINT64_FMTX__ = "llX";
pub const __UINT64_C_SUFFIX__ = @compileError("unable to translate macro: undefined identifier `ULL`");
// (no file):232:9
pub const __UINT64_MAX__ = @as(c_ulonglong, 18446744073709551615);
pub const __INT64_MAX__ = @as(c_longlong, 9223372036854775807);
pub const __INT_LEAST8_TYPE__ = i8;
pub const __INT_LEAST8_MAX__ = @as(c_int, 127);
pub const __INT_LEAST8_WIDTH__ = @as(c_int, 8);
pub const __INT_LEAST8_FMTd__ = "hhd";
pub const __INT_LEAST8_FMTi__ = "hhi";
pub const __UINT_LEAST8_TYPE__ = u8;
pub const __UINT_LEAST8_MAX__ = @as(c_int, 255);
pub const __UINT_LEAST8_FMTo__ = "hho";
pub const __UINT_LEAST8_FMTu__ = "hhu";
pub const __UINT_LEAST8_FMTx__ = "hhx";
pub const __UINT_LEAST8_FMTX__ = "hhX";
pub const __INT_LEAST16_TYPE__ = c_short;
pub const __INT_LEAST16_MAX__ = @as(c_int, 32767);
pub const __INT_LEAST16_WIDTH__ = @as(c_int, 16);
pub const __INT_LEAST16_FMTd__ = "hd";
pub const __INT_LEAST16_FMTi__ = "hi";
pub const __UINT_LEAST16_TYPE__ = c_ushort;
pub const __UINT_LEAST16_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_int, 65535, .decimal);
pub const __UINT_LEAST16_FMTo__ = "ho";
pub const __UINT_LEAST16_FMTu__ = "hu";
pub const __UINT_LEAST16_FMTx__ = "hx";
pub const __UINT_LEAST16_FMTX__ = "hX";
pub const __INT_LEAST32_TYPE__ = c_int;
pub const __INT_LEAST32_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_int, 2147483647, .decimal);
pub const __INT_LEAST32_WIDTH__ = @as(c_int, 32);
pub const __INT_LEAST32_FMTd__ = "d";
pub const __INT_LEAST32_FMTi__ = "i";
pub const __UINT_LEAST32_TYPE__ = c_uint;
pub const __UINT_LEAST32_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_uint, 4294967295, .decimal);
pub const __UINT_LEAST32_FMTo__ = "o";
pub const __UINT_LEAST32_FMTu__ = "u";
pub const __UINT_LEAST32_FMTx__ = "x";
pub const __UINT_LEAST32_FMTX__ = "X";
pub const __INT_LEAST64_TYPE__ = c_longlong;
pub const __INT_LEAST64_MAX__ = @as(c_longlong, 9223372036854775807);
pub const __INT_LEAST64_WIDTH__ = @as(c_int, 64);
pub const __INT_LEAST64_FMTd__ = "lld";
pub const __INT_LEAST64_FMTi__ = "lli";
pub const __UINT_LEAST64_TYPE__ = c_ulonglong;
pub const __UINT_LEAST64_MAX__ = @as(c_ulonglong, 18446744073709551615);
pub const __UINT_LEAST64_FMTo__ = "llo";
pub const __UINT_LEAST64_FMTu__ = "llu";
pub const __UINT_LEAST64_FMTx__ = "llx";
pub const __UINT_LEAST64_FMTX__ = "llX";
pub const __INT_FAST8_TYPE__ = i8;
pub const __INT_FAST8_MAX__ = @as(c_int, 127);
pub const __INT_FAST8_WIDTH__ = @as(c_int, 8);
pub const __INT_FAST8_FMTd__ = "hhd";
pub const __INT_FAST8_FMTi__ = "hhi";
pub const __UINT_FAST8_TYPE__ = u8;
pub const __UINT_FAST8_MAX__ = @as(c_int, 255);
pub const __UINT_FAST8_FMTo__ = "hho";
pub const __UINT_FAST8_FMTu__ = "hhu";
pub const __UINT_FAST8_FMTx__ = "hhx";
pub const __UINT_FAST8_FMTX__ = "hhX";
pub const __INT_FAST16_TYPE__ = c_short;
pub const __INT_FAST16_MAX__ = @as(c_int, 32767);
pub const __INT_FAST16_WIDTH__ = @as(c_int, 16);
pub const __INT_FAST16_FMTd__ = "hd";
pub const __INT_FAST16_FMTi__ = "hi";
pub const __UINT_FAST16_TYPE__ = c_ushort;
pub const __UINT_FAST16_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_int, 65535, .decimal);
pub const __UINT_FAST16_FMTo__ = "ho";
pub const __UINT_FAST16_FMTu__ = "hu";
pub const __UINT_FAST16_FMTx__ = "hx";
pub const __UINT_FAST16_FMTX__ = "hX";
pub const __INT_FAST32_TYPE__ = c_int;
pub const __INT_FAST32_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_int, 2147483647, .decimal);
pub const __INT_FAST32_WIDTH__ = @as(c_int, 32);
pub const __INT_FAST32_FMTd__ = "d";
pub const __INT_FAST32_FMTi__ = "i";
pub const __UINT_FAST32_TYPE__ = c_uint;
pub const __UINT_FAST32_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_uint, 4294967295, .decimal);
pub const __UINT_FAST32_FMTo__ = "o";
pub const __UINT_FAST32_FMTu__ = "u";
pub const __UINT_FAST32_FMTx__ = "x";
pub const __UINT_FAST32_FMTX__ = "X";
pub const __INT_FAST64_TYPE__ = c_longlong;
pub const __INT_FAST64_MAX__ = @as(c_longlong, 9223372036854775807);
pub const __INT_FAST64_WIDTH__ = @as(c_int, 64);
pub const __INT_FAST64_FMTd__ = "lld";
pub const __INT_FAST64_FMTi__ = "lli";
pub const __UINT_FAST64_TYPE__ = c_ulonglong;
pub const __UINT_FAST64_MAX__ = @as(c_ulonglong, 18446744073709551615);
pub const __UINT_FAST64_FMTo__ = "llo";
pub const __UINT_FAST64_FMTu__ = "llu";
pub const __UINT_FAST64_FMTx__ = "llx";
pub const __UINT_FAST64_FMTX__ = "llX";
pub const __USER_LABEL_PREFIX__ = "";
pub const __FINITE_MATH_ONLY__ = @as(c_int, 0);
pub const __GNUC_STDC_INLINE__ = @as(c_int, 1);
pub const __GCC_ATOMIC_TEST_AND_SET_TRUEVAL = @as(c_int, 1);
pub const __GCC_DESTRUCTIVE_SIZE = @as(c_int, 64);
pub const __GCC_CONSTRUCTIVE_SIZE = @as(c_int, 64);
pub const __CLANG_ATOMIC_BOOL_LOCK_FREE = @as(c_int, 1);
pub const __CLANG_ATOMIC_CHAR_LOCK_FREE = @as(c_int, 1);
pub const __CLANG_ATOMIC_CHAR16_T_LOCK_FREE = @as(c_int, 1);
pub const __CLANG_ATOMIC_CHAR32_T_LOCK_FREE = @as(c_int, 1);
pub const __CLANG_ATOMIC_WCHAR_T_LOCK_FREE = @as(c_int, 1);
pub const __CLANG_ATOMIC_SHORT_LOCK_FREE = @as(c_int, 1);
pub const __CLANG_ATOMIC_INT_LOCK_FREE = @as(c_int, 1);
pub const __CLANG_ATOMIC_LONG_LOCK_FREE = @as(c_int, 1);
pub const __CLANG_ATOMIC_LLONG_LOCK_FREE = @as(c_int, 1);
pub const __CLANG_ATOMIC_POINTER_LOCK_FREE = @as(c_int, 1);
pub const __GCC_ATOMIC_BOOL_LOCK_FREE = @as(c_int, 1);
pub const __GCC_ATOMIC_CHAR_LOCK_FREE = @as(c_int, 1);
pub const __GCC_ATOMIC_CHAR16_T_LOCK_FREE = @as(c_int, 1);
pub const __GCC_ATOMIC_CHAR32_T_LOCK_FREE = @as(c_int, 1);
pub const __GCC_ATOMIC_WCHAR_T_LOCK_FREE = @as(c_int, 1);
pub const __GCC_ATOMIC_SHORT_LOCK_FREE = @as(c_int, 1);
pub const __GCC_ATOMIC_INT_LOCK_FREE = @as(c_int, 1);
pub const __GCC_ATOMIC_LONG_LOCK_FREE = @as(c_int, 1);
pub const __GCC_ATOMIC_LLONG_LOCK_FREE = @as(c_int, 1);
pub const __GCC_ATOMIC_POINTER_LOCK_FREE = @as(c_int, 1);
pub const __NO_INLINE__ = @as(c_int, 1);
pub const __FLT_RADIX__ = @as(c_int, 2);
pub const __DECIMAL_DIG__ = __LDBL_DECIMAL_DIG__;
pub const __ELF__ = @as(c_int, 1);
pub const __ARMEL__ = @as(c_int, 1);
pub const __arm = @as(c_int, 1);
pub const __arm__ = @as(c_int, 1);
pub const __REGISTER_PREFIX__ = "";
pub const __ARM_ARCH_4T__ = @as(c_int, 1);
pub const __ARM_ARCH = @as(c_int, 4);
pub const __ARM_ARCH_ISA_ARM = @as(c_int, 1);
pub const __ARM_ARCH_ISA_THUMB = @as(c_int, 1);
pub const __ARM_32BIT_STATE = @as(c_int, 1);
pub const __ARM_ACLE = @as(c_int, 200);
pub const __ARM_FP16_FORMAT_IEEE = @as(c_int, 1);
pub const __ARM_FP16_ARGS = @as(c_int, 1);
pub const __ARM_EABI__ = @as(c_int, 1);
pub const __ARM_PCS = @as(c_int, 1);
pub const __SOFTFP__ = @as(c_int, 1);
pub const __ARM_FEATURE_COPROC = @as(c_int, 0x1);
pub const __APCS_32__ = @as(c_int, 1);
pub const __VFP_FP__ = @as(c_int, 1);
pub const __ARM_SIZEOF_WCHAR_T = @as(c_int, 4);
pub const __ARM_SIZEOF_MINIMAL_ENUM = @as(c_int, 4);
pub const __STDC__ = @as(c_int, 1);
pub const __STDC_HOSTED__ = @as(c_int, 0);
pub const __STDC_VERSION__ = @as(c_long, 201710);
pub const __STDC_UTF_16__ = @as(c_int, 1);
pub const __STDC_UTF_32__ = @as(c_int, 1);
pub const __STDC_EMBED_NOT_FOUND__ = @as(c_int, 0);
pub const __STDC_EMBED_FOUND__ = @as(c_int, 1);
pub const __STDC_EMBED_EMPTY__ = @as(c_int, 2);
pub const _DEBUG = @as(c_int, 1);
pub const __GBA__ = @as(c_int, 1);
pub const IWRAM_CODE = "";
pub const EWRAM_CODE = "";
pub const EWRAM_DATA = "";
pub const IWRAM_DATA = "";
pub const ARM_CODE = "";
pub const THUMB_CODE = "";
pub const __GCC_HAVE_DWARF2_CFI_ASM = @as(c_int, 1);
pub const __need_ptrdiff_t = "";
pub const __need_size_t = "";
pub const __need_wchar_t = "";
pub const __need_NULL = "";
pub const __need_max_align_t = "";
pub const __need_offsetof = "";
pub const __STDDEF_H = "";
pub const _PTRDIFF_T = "";
pub const _SIZE_T = "";
pub const _WCHAR_T = "";
pub const NULL = @import("std").zig.c_translation.cast(?*anyopaque, @as(c_int, 0));
pub const __CLANG_MAX_ALIGN_T_DEFINED = "";
pub const offsetof = @compileError("unable to translate C expr: unexpected token 'an identifier'");
// /Users/michaelbraha/.local/share/zigup/0.14.1/files/lib/include/__stddef_offsetof.h:16:9
pub const MAXMOD_H__ = "";
pub const MM_TYPES_H__ = "";
pub const __STDBOOL_H = "";
pub const __bool_true_false_are_defined = @as(c_int, 1);
pub const @"bool" = bool;
pub const @"true" = @as(c_int, 1);
pub const @"false" = @as(c_int, 0);
pub const __CLANG_STDINT_H = "";
pub const __int_least64_t = i64;
pub const __uint_least64_t = u64;
pub const __int_least32_t = i64;
pub const __uint_least32_t = u64;
pub const __int_least16_t = i64;
pub const __uint_least16_t = u64;
pub const __int_least8_t = i64;
pub const __uint_least8_t = u64;
pub const __uint32_t_defined = "";
pub const __int8_t_defined = "";
pub const __stdint_join3 = @compileError("unable to translate C expr: unexpected token '##'");
// /Users/michaelbraha/.local/share/zigup/0.14.1/files/lib/include/stdint.h:291:9
pub const __intptr_t_defined = "";
pub const _INTPTR_T = "";
pub const _UINTPTR_T = "";
pub const __int_c_join = @compileError("unable to translate C expr: unexpected token '##'");
// /Users/michaelbraha/.local/share/zigup/0.14.1/files/lib/include/stdint.h:328:9
pub inline fn __int_c(v: anytype, suffix: anytype) @TypeOf(__int_c_join(v, suffix)) {
    _ = &v;
    _ = &suffix;
    return __int_c_join(v, suffix);
}
pub const __uint_c = @compileError("unable to translate macro: undefined identifier `U`");
// /Users/michaelbraha/.local/share/zigup/0.14.1/files/lib/include/stdint.h:330:9
pub const __int64_c_suffix = __INT64_C_SUFFIX__;
pub const __int32_c_suffix = __INT64_C_SUFFIX__;
pub const __int16_c_suffix = __INT64_C_SUFFIX__;
pub const __int8_c_suffix = __INT64_C_SUFFIX__;
pub inline fn INT64_C(v: anytype) @TypeOf(__int_c(v, __int64_c_suffix)) {
    _ = &v;
    return __int_c(v, __int64_c_suffix);
}
pub inline fn UINT64_C(v: anytype) @TypeOf(__uint_c(v, __int64_c_suffix)) {
    _ = &v;
    return __uint_c(v, __int64_c_suffix);
}
pub inline fn INT32_C(v: anytype) @TypeOf(__int_c(v, __int32_c_suffix)) {
    _ = &v;
    return __int_c(v, __int32_c_suffix);
}
pub inline fn UINT32_C(v: anytype) @TypeOf(__uint_c(v, __int32_c_suffix)) {
    _ = &v;
    return __uint_c(v, __int32_c_suffix);
}
pub inline fn INT16_C(v: anytype) @TypeOf(__int_c(v, __int16_c_suffix)) {
    _ = &v;
    return __int_c(v, __int16_c_suffix);
}
pub inline fn UINT16_C(v: anytype) @TypeOf(__uint_c(v, __int16_c_suffix)) {
    _ = &v;
    return __uint_c(v, __int16_c_suffix);
}
pub inline fn INT8_C(v: anytype) @TypeOf(__int_c(v, __int8_c_suffix)) {
    _ = &v;
    return __int_c(v, __int8_c_suffix);
}
pub inline fn UINT8_C(v: anytype) @TypeOf(__uint_c(v, __int8_c_suffix)) {
    _ = &v;
    return __uint_c(v, __int8_c_suffix);
}
pub const INT64_MAX = INT64_C(@import("std").zig.c_translation.promoteIntLiteral(c_int, 9223372036854775807, .decimal));
pub const INT64_MIN = -INT64_C(@import("std").zig.c_translation.promoteIntLiteral(c_int, 9223372036854775807, .decimal)) - @as(c_int, 1);
pub const UINT64_MAX = UINT64_C(@import("std").zig.c_translation.promoteIntLiteral(c_int, 18446744073709551615, .decimal));
pub const __INT_LEAST64_MIN = INT64_MIN;
pub const __INT_LEAST64_MAX = INT64_MAX;
pub const __UINT_LEAST64_MAX = UINT64_MAX;
pub const __INT_LEAST32_MIN = INT64_MIN;
pub const __INT_LEAST32_MAX = INT64_MAX;
pub const __UINT_LEAST32_MAX = UINT64_MAX;
pub const __INT_LEAST16_MIN = INT64_MIN;
pub const __INT_LEAST16_MAX = INT64_MAX;
pub const __UINT_LEAST16_MAX = UINT64_MAX;
pub const __INT_LEAST8_MIN = INT64_MIN;
pub const __INT_LEAST8_MAX = INT64_MAX;
pub const __UINT_LEAST8_MAX = UINT64_MAX;
pub const INT_LEAST64_MIN = __INT_LEAST64_MIN;
pub const INT_LEAST64_MAX = __INT_LEAST64_MAX;
pub const UINT_LEAST64_MAX = __UINT_LEAST64_MAX;
pub const INT_FAST64_MIN = __INT_LEAST64_MIN;
pub const INT_FAST64_MAX = __INT_LEAST64_MAX;
pub const UINT_FAST64_MAX = __UINT_LEAST64_MAX;
pub const INT32_MAX = INT32_C(@import("std").zig.c_translation.promoteIntLiteral(c_int, 2147483647, .decimal));
pub const INT32_MIN = -INT32_C(@import("std").zig.c_translation.promoteIntLiteral(c_int, 2147483647, .decimal)) - @as(c_int, 1);
pub const UINT32_MAX = UINT32_C(@import("std").zig.c_translation.promoteIntLiteral(c_int, 4294967295, .decimal));
pub const INT_LEAST32_MIN = __INT_LEAST32_MIN;
pub const INT_LEAST32_MAX = __INT_LEAST32_MAX;
pub const UINT_LEAST32_MAX = __UINT_LEAST32_MAX;
pub const INT_FAST32_MIN = __INT_LEAST32_MIN;
pub const INT_FAST32_MAX = __INT_LEAST32_MAX;
pub const UINT_FAST32_MAX = __UINT_LEAST32_MAX;
pub const INT16_MAX = INT16_C(@as(c_int, 32767));
pub const INT16_MIN = -INT16_C(@as(c_int, 32767)) - @as(c_int, 1);
pub const UINT16_MAX = UINT16_C(@import("std").zig.c_translation.promoteIntLiteral(c_int, 65535, .decimal));
pub const INT_LEAST16_MIN = __INT_LEAST16_MIN;
pub const INT_LEAST16_MAX = __INT_LEAST16_MAX;
pub const UINT_LEAST16_MAX = __UINT_LEAST16_MAX;
pub const INT_FAST16_MIN = __INT_LEAST16_MIN;
pub const INT_FAST16_MAX = __INT_LEAST16_MAX;
pub const UINT_FAST16_MAX = __UINT_LEAST16_MAX;
pub const INT8_MAX = INT8_C(@as(c_int, 127));
pub const INT8_MIN = -INT8_C(@as(c_int, 127)) - @as(c_int, 1);
pub const UINT8_MAX = UINT8_C(@as(c_int, 255));
pub const INT_LEAST8_MIN = __INT_LEAST8_MIN;
pub const INT_LEAST8_MAX = __INT_LEAST8_MAX;
pub const UINT_LEAST8_MAX = __UINT_LEAST8_MAX;
pub const INT_FAST8_MIN = __INT_LEAST8_MIN;
pub const INT_FAST8_MAX = __INT_LEAST8_MAX;
pub const UINT_FAST8_MAX = __UINT_LEAST8_MAX;
pub const __INTN_MIN = @compileError("unable to translate macro: undefined identifier `INT`");
// /Users/michaelbraha/.local/share/zigup/0.14.1/files/lib/include/stdint.h:875:10
pub const __INTN_MAX = @compileError("unable to translate macro: undefined identifier `INT`");
// /Users/michaelbraha/.local/share/zigup/0.14.1/files/lib/include/stdint.h:876:10
pub const __UINTN_MAX = @compileError("unable to translate macro: undefined identifier `UINT`");
// /Users/michaelbraha/.local/share/zigup/0.14.1/files/lib/include/stdint.h:877:9
pub const __INTN_C = @compileError("unable to translate macro: undefined identifier `INT`");
// /Users/michaelbraha/.local/share/zigup/0.14.1/files/lib/include/stdint.h:878:10
pub const __UINTN_C = @compileError("unable to translate macro: undefined identifier `UINT`");
// /Users/michaelbraha/.local/share/zigup/0.14.1/files/lib/include/stdint.h:879:9
pub const INTPTR_MIN = -__INTPTR_MAX__ - @as(c_int, 1);
pub const INTPTR_MAX = __INTPTR_MAX__;
pub const UINTPTR_MAX = __UINTPTR_MAX__;
pub const PTRDIFF_MIN = -__PTRDIFF_MAX__ - @as(c_int, 1);
pub const PTRDIFF_MAX = __PTRDIFF_MAX__;
pub const SIZE_MAX = __SIZE_MAX__;
pub const INTMAX_MIN = -__INTMAX_MAX__ - @as(c_int, 1);
pub const INTMAX_MAX = __INTMAX_MAX__;
pub const UINTMAX_MAX = __UINTMAX_MAX__;
pub const SIG_ATOMIC_MIN = __INTN_MIN(__SIG_ATOMIC_WIDTH__);
pub const SIG_ATOMIC_MAX = __INTN_MAX(__SIG_ATOMIC_WIDTH__);
pub const WINT_MIN = __INTN_MIN(__WINT_WIDTH__);
pub const WINT_MAX = __INTN_MAX(__WINT_WIDTH__);
pub const WCHAR_MAX = __WCHAR_MAX__;
pub const WCHAR_MIN = __UINTN_C(__WCHAR_WIDTH__, @as(c_int, 0));
pub inline fn INTMAX_C(v: anytype) @TypeOf(__int_c(v, __INTMAX_C_SUFFIX__)) {
    _ = &v;
    return __int_c(v, __INTMAX_C_SUFFIX__);
}
pub inline fn UINTMAX_C(v: anytype) @TypeOf(__int_c(v, __UINTMAX_C_SUFFIX__)) {
    _ = &v;
    return __int_c(v, __UINTMAX_C_SUFFIX__);
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
pub const MM_CORE_CHANNEL_TYPES_H__ = "";
pub const _ANSIDECL_H_ = "";
pub const __NEWLIB_H__ = @as(c_int, 1);
pub const _NEWLIB_VERSION_H__ = @as(c_int, 1);
pub const _NEWLIB_VERSION = "4.5.0";
pub const __NEWLIB__ = @as(c_int, 4);
pub const __NEWLIB_MINOR__ = @as(c_int, 5);
pub const __NEWLIB_PATCHLEVEL__ = @as(c_int, 0);
pub const _ATEXIT_DYNAMIC_ALLOC = @as(c_int, 1);
pub const _FSEEK_OPTIMIZATION = @as(c_int, 1);
pub const _FVWRITE_IN_STREAMIO = @as(c_int, 1);
pub const _HAVE_CC_INHIBIT_LOOP_TO_LIBCALL = @as(c_int, 1);
pub const _HAVE_INITFINI_ARRAY = @as(c_int, 1);
pub const _HAVE_LONG_DOUBLE = @as(c_int, 1);
pub const _LDBL_EQ_DBL = @as(c_int, 1);
pub const _MB_CAPABLE = @as(c_int, 1);
pub const _MB_LEN_MAX = @as(c_int, 8);
pub const _REENT_CHECK_VERIFY = @as(c_int, 1);
pub const _UNBUF_STREAM_OPT = @as(c_int, 1);
pub const _WANT_IO_C99_FORMATS = @as(c_int, 1);
pub const _WANT_IO_LONG_LONG = @as(c_int, 1);
pub const _WANT_IO_POS_ARGS = @as(c_int, 1);
pub const _WANT_USE_GDTOA = @as(c_int, 1);
pub const __SYS_CONFIG_H__ = "";
pub const __IEEE_LITTLE_ENDIAN = "";
pub const __DOUBLE_TYPE = f64;
pub const __FLOAT_TYPE = f32;
pub const __OBSOLETE_MATH_DEFAULT = @as(c_int, 1);
pub const __OBSOLETE_MATH = __OBSOLETE_MATH_DEFAULT;
pub const _SYS_FEATURES_H = "";
pub inline fn __GNUC_PREREQ(maj: anytype, min: anytype) @TypeOf(((__GNUC__ << @as(c_int, 16)) + __GNUC_MINOR__) >= ((maj << @as(c_int, 16)) + min)) {
    _ = &maj;
    _ = &min;
    return ((__GNUC__ << @as(c_int, 16)) + __GNUC_MINOR__) >= ((maj << @as(c_int, 16)) + min);
}
pub inline fn __GNUC_PREREQ__(ma: anytype, mi: anytype) @TypeOf(__GNUC_PREREQ(ma, mi)) {
    _ = &ma;
    _ = &mi;
    return __GNUC_PREREQ(ma, mi);
}
pub const _DEFAULT_SOURCE = @as(c_int, 1);
pub const _POSIX_SOURCE = @as(c_int, 1);
pub const _POSIX_C_SOURCE = @as(c_long, 202405);
pub const _ATFILE_SOURCE = @as(c_int, 1);
pub const __ATFILE_VISIBLE = @as(c_int, 1);
pub const __BSD_VISIBLE = @as(c_int, 1);
pub const __GNU_VISIBLE = @as(c_int, 0);
pub const __ISO_C_VISIBLE = @as(c_int, 2011);
pub const __LARGEFILE_VISIBLE = @as(c_int, 0);
pub const __MISC_VISIBLE = @as(c_int, 1);
pub const __POSIX_VISIBLE = @import("std").zig.c_translation.promoteIntLiteral(c_int, 202405, .decimal);
pub const __SVID_VISIBLE = @as(c_int, 1);
pub const __XSI_VISIBLE = @as(c_int, 0);
pub const __SSP_FORTIFY_LEVEL = @as(c_int, 0);
pub const _POSIX_MONOTONIC_CLOCK = @as(c_long, 200112);
pub const _POSIX_TIMERS = @as(c_int, 1);
pub const _POSIX_THREADS = @as(c_int, 1);
pub const _POSIX_SEMAPHORES = @as(c_int, 1);
pub const _POSIX_BARRIERS = @as(c_long, 200112);
pub const _POSIX_READER_WRITER_LOCKS = @as(c_long, 200112);
pub const _UNIX98_THREAD_MUTEX_ATTRIBUTES = @as(c_int, 1);
pub const _POINTER_INT = c_long;
pub const __RAND_MAX = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x7fffffff, .hex);
pub const __EXPORT = "";
pub const __IMPORT = "";
pub const _READ_WRITE_RETURN_TYPE = c_int;
pub const _READ_WRITE_BUFSIZE_TYPE = c_int;
pub const _USE_GDTOA = "";
pub const _BEGIN_STD_C = "";
pub const _END_STD_C = "";
pub const _NOTHROW = "";
pub const _LONG_DOUBLE = @compileError("unable to translate: TODO long double");
// /opt/devkitpro/devkitARM/arm-none-eabi/include/_ansi.h:37:9
pub const _ATTRIBUTE = @compileError("unable to translate C expr: unexpected token '__attribute__'");
// /opt/devkitpro/devkitARM/arm-none-eabi/include/_ansi.h:43:9
pub const _ELIDABLE_INLINE = @compileError("unable to translate C expr: unexpected token 'static'");
// /opt/devkitpro/devkitARM/arm-none-eabi/include/_ansi.h:69:9
pub const _NOINLINE = @compileError("unable to translate macro: undefined identifier `__noinline__`");
// /opt/devkitpro/devkitARM/arm-none-eabi/include/_ansi.h:73:9
pub const _NOINLINE_STATIC = @compileError("unable to translate C expr: unexpected token 'static'");
// /opt/devkitpro/devkitARM/arm-none-eabi/include/_ansi.h:74:9
pub const assert = @compileError("unable to translate macro: undefined identifier `__FILE__`");
// /opt/devkitpro/devkitARM/arm-none-eabi/include/assert.h:16:10
pub const __ASSERT_FUNC = @compileError("unable to translate C expr: unexpected token 'an identifier'");
// /opt/devkitpro/devkitARM/arm-none-eabi/include/assert.h:26:12
pub const static_assert = @compileError("unable to translate C expr: unexpected token '_Static_assert'");
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
pub const MIXCH_GBA_SRC_STOPPED = @as(c_uint, 1) << ((@import("std").zig.c_translation.sizeof(usize) * @as(c_int, 8)) - @as(c_int, 1));
pub const MM_CORE_MAS_H__ = "";
pub const MM_CORE_PLAYER_TYPES_H__ = "";
pub const MP_SCHANNELS = @as(c_int, 4);
pub const NO_CHANNEL_AVAILABLE = @as(c_int, 255);
pub const COMPR_FLAG_NOTE = @as(c_int, 1) << @as(c_int, 0);
pub const COMPR_FLAG_INSTR = @as(c_int, 1) << @as(c_int, 1);
pub const COMPR_FLAG_VOLC = @as(c_int, 1) << @as(c_int, 2);
pub const COMPR_FLAG_EFFC = @as(c_int, 1) << @as(c_int, 3);
pub const GLISSANDO_EFFECT = @as(c_int, 7);
pub const GLISSANDO_IT_VOLCMD_START = @as(c_int, 193);
pub const GLISSANDO_IT_VOLCMD_END = @as(c_int, 202);
pub const GLISSANDO_MX_VOLCMD_START = @as(c_int, 0xF0);
pub const GLISSANDO_MX_VOLCMD_END = @as(c_int, 0xFF);
pub const NOTE_CUT = @as(c_int, 254);
pub const NOTE_OFF = @as(c_int, 255);
pub const MULT_PERIOD = @import("std").zig.c_translation.promoteIntLiteral(c_int, 133808, .decimal);
pub const mmreverbcfg = struct_mmreverbcfg;
pub const t_mmdssample = struct_t_mmdssample;
pub const t_mmsoundeffect = struct_t_mmsoundeffect;
pub const t_mmgbasystem = struct_t_mmgbasystem;
pub const t_mmdssystem = struct_t_mmdssystem;
pub const t_mmstream = struct_t_mmstream;
pub const t_mmstreamdata = struct_t_mmstreamdata;
pub const tmm_voice = struct_tmm_voice;
pub const tmm_mas_prefix = struct_tmm_mas_prefix;
pub const tmm_mas_head = struct_tmm_mas_head;
pub const tmm_mas_instrument = struct_tmm_mas_instrument;
pub const tmm_mas_envelope = struct_tmm_mas_envelope;
pub const tmm_mas_sample_info = struct_tmm_mas_sample_info;
pub const tmm_mas_pattern = struct_tmm_mas_pattern;
pub const tmm_mas_gba_sample = struct_tmm_mas_gba_sample;
pub const tmm_mas_ds_sample = struct_tmm_mas_ds_sample;
