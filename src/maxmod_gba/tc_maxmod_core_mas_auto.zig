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
pub const __int8_t = i8;
pub const __uint8_t = u8;
pub const __int16_t = c_short;
pub const __uint16_t = c_ushort;
pub const __int32_t = c_int;
pub const __uint32_t = c_uint;
pub const __int64_t = c_longlong;
pub const __uint64_t = c_ulonglong;
pub const __darwin_intptr_t = c_long;
pub const __darwin_natural_t = c_uint;
pub const __darwin_ct_rune_t = c_int;
pub const __mbstate_t = extern union {
    __mbstate8: [128]u8,
    _mbstateL: c_longlong,
};
pub const __darwin_mbstate_t = __mbstate_t;
pub const __darwin_ptrdiff_t = c_int;
pub const __darwin_size_t = c_uint;
pub const struct___va_list_1 = extern struct {
    __ap: ?*anyopaque = @import("std").mem.zeroes(?*anyopaque),
};
pub const __builtin_va_list = struct___va_list_1;
pub const __darwin_va_list = __builtin_va_list;
pub const __darwin_wchar_t = c_uint;
pub const __darwin_rune_t = __darwin_wchar_t;
pub const __darwin_wint_t = c_int;
pub const __darwin_clock_t = c_ulong;
pub const __darwin_socklen_t = __uint32_t;
pub const __darwin_ssize_t = c_long;
pub const __darwin_time_t = c_long;
pub const __darwin_blkcnt_t = __int64_t;
pub const __darwin_blksize_t = __int32_t;
pub const __darwin_dev_t = __int32_t;
pub const __darwin_fsblkcnt_t = c_uint;
pub const __darwin_fsfilcnt_t = c_uint;
pub const __darwin_gid_t = __uint32_t;
pub const __darwin_id_t = __uint32_t;
pub const __darwin_ino64_t = __uint64_t;
pub const __darwin_ino_t = __darwin_ino64_t;
pub const __darwin_mach_port_name_t = __darwin_natural_t;
pub const __darwin_mach_port_t = __darwin_mach_port_name_t;
pub const __darwin_mode_t = __uint16_t;
pub const __darwin_off_t = __int64_t;
pub const __darwin_pid_t = __int32_t;
pub const __darwin_sigset_t = __uint32_t;
pub const __darwin_suseconds_t = __int32_t;
pub const __darwin_uid_t = __uint32_t;
pub const __darwin_useconds_t = __uint32_t;
pub const __darwin_uuid_t = [16]u8;
pub const __darwin_uuid_string_t = [37]u8;
pub const struct___darwin_pthread_handler_rec = extern struct {
    __routine: ?*const fn (?*anyopaque) callconv(.c) void = @import("std").mem.zeroes(?*const fn (?*anyopaque) callconv(.c) void),
    __arg: ?*anyopaque = @import("std").mem.zeroes(?*anyopaque),
    __next: [*c]struct___darwin_pthread_handler_rec = @import("std").mem.zeroes([*c]struct___darwin_pthread_handler_rec),
};
pub const struct__opaque_pthread_attr_t = extern struct {
    __sig: c_long = @import("std").mem.zeroes(c_long),
    __opaque: [36]u8 = @import("std").mem.zeroes([36]u8),
};
pub const struct__opaque_pthread_cond_t = extern struct {
    __sig: c_long = @import("std").mem.zeroes(c_long),
    __opaque: [24]u8 = @import("std").mem.zeroes([24]u8),
};
pub const struct__opaque_pthread_condattr_t = extern struct {
    __sig: c_long = @import("std").mem.zeroes(c_long),
    __opaque: [4]u8 = @import("std").mem.zeroes([4]u8),
};
pub const struct__opaque_pthread_mutex_t = extern struct {
    __sig: c_long = @import("std").mem.zeroes(c_long),
    __opaque: [40]u8 = @import("std").mem.zeroes([40]u8),
};
pub const struct__opaque_pthread_mutexattr_t = extern struct {
    __sig: c_long = @import("std").mem.zeroes(c_long),
    __opaque: [8]u8 = @import("std").mem.zeroes([8]u8),
};
pub const struct__opaque_pthread_once_t = extern struct {
    __sig: c_long = @import("std").mem.zeroes(c_long),
    __opaque: [4]u8 = @import("std").mem.zeroes([4]u8),
};
pub const struct__opaque_pthread_rwlock_t = extern struct {
    __sig: c_long = @import("std").mem.zeroes(c_long),
    __opaque: [124]u8 = @import("std").mem.zeroes([124]u8),
};
pub const struct__opaque_pthread_rwlockattr_t = extern struct {
    __sig: c_long = @import("std").mem.zeroes(c_long),
    __opaque: [12]u8 = @import("std").mem.zeroes([12]u8),
};
pub const struct__opaque_pthread_t = extern struct {
    __sig: c_long = @import("std").mem.zeroes(c_long),
    __cleanup_stack: [*c]struct___darwin_pthread_handler_rec = @import("std").mem.zeroes([*c]struct___darwin_pthread_handler_rec),
    __opaque: [4088]u8 = @import("std").mem.zeroes([4088]u8),
};
pub const __darwin_pthread_attr_t = struct__opaque_pthread_attr_t;
pub const __darwin_pthread_cond_t = struct__opaque_pthread_cond_t;
pub const __darwin_pthread_condattr_t = struct__opaque_pthread_condattr_t;
pub const __darwin_pthread_key_t = c_ulong;
pub const __darwin_pthread_mutex_t = struct__opaque_pthread_mutex_t;
pub const __darwin_pthread_mutexattr_t = struct__opaque_pthread_mutexattr_t;
pub const __darwin_pthread_once_t = struct__opaque_pthread_once_t;
pub const __darwin_pthread_rwlock_t = struct__opaque_pthread_rwlock_t;
pub const __darwin_pthread_rwlockattr_t = struct__opaque_pthread_rwlockattr_t;
pub const __darwin_pthread_t = [*c]struct__opaque_pthread_t;
pub const __darwin_nl_item = c_int;
pub const __darwin_wctrans_t = c_int;
pub const __darwin_wctype_t = c_ulong;
pub extern fn memchr(__s: ?*const anyopaque, __c: c_int, __n: usize) ?*anyopaque;
pub extern fn memcmp(__s1: ?*const anyopaque, __s2: ?*const anyopaque, __n: usize) c_int;
pub extern fn memcpy(__dst: ?*anyopaque, __src: ?*const anyopaque, __n: usize) ?*anyopaque;
pub extern fn memmove(__dst: ?*anyopaque, __src: ?*const anyopaque, __len: usize) ?*anyopaque;
pub extern fn memset(__b: ?*anyopaque, __c: c_int, __len: usize) ?*anyopaque;
pub extern fn strcat(__s1: [*c]u8, __s2: [*c]const u8) [*c]u8;
pub extern fn strchr(__s: [*c]const u8, __c: c_int) [*c]u8;
pub extern fn strcmp(__s1: [*c]const u8, __s2: [*c]const u8) c_int;
pub extern fn strcoll(__s1: [*c]const u8, __s2: [*c]const u8) c_int;
pub extern fn strcpy(__dst: [*c]u8, __src: [*c]const u8) [*c]u8;
pub extern fn strcspn(__s: [*c]const u8, __charset: [*c]const u8) usize;
pub extern fn strerror(__errnum: c_int) [*c]u8;
pub extern fn strlen(__s: [*c]const u8) usize;
pub extern fn strncat(__s1: [*c]u8, __s2: [*c]const u8, __n: usize) [*c]u8;
pub extern fn strncmp(__s1: [*c]const u8, __s2: [*c]const u8, __n: usize) c_int;
pub extern fn strncpy(__dst: [*c]u8, __src: [*c]const u8, __n: usize) [*c]u8;
pub extern fn strpbrk(__s: [*c]const u8, __charset: [*c]const u8) [*c]u8;
pub extern fn strrchr(__s: [*c]const u8, __c: c_int) [*c]u8;
pub extern fn strspn(__s: [*c]const u8, __charset: [*c]const u8) usize;
pub extern fn strstr(__big: [*c]const u8, __little: [*c]const u8) [*c]u8;
pub extern fn strtok(__str: [*c]u8, __sep: [*c]const u8) [*c]u8;
pub extern fn strxfrm(__s1: [*c]u8, __s2: [*c]const u8, __n: usize) usize;
pub extern fn strtok_r(__str: [*c]u8, __sep: [*c]const u8, __lasts: [*c][*c]u8) [*c]u8;
pub extern fn strerror_r(__errnum: c_int, __strerrbuf: [*c]u8, __buflen: usize) c_int;
pub extern fn strdup(__s1: [*c]const u8) [*c]u8;
pub extern fn memccpy(__dst: ?*anyopaque, __src: ?*const anyopaque, __c: c_int, __n: usize) ?*anyopaque;
pub extern fn stpcpy(__dst: [*c]u8, __src: [*c]const u8) [*c]u8;
pub extern fn stpncpy(__dst: [*c]u8, __src: [*c]const u8, __n: usize) [*c]u8;
pub extern fn strndup(__s1: [*c]const u8, __n: usize) [*c]u8;
pub extern fn strnlen(__s1: [*c]const u8, __n: usize) usize;
pub extern fn strsignal(__sig: c_int) [*c]u8;
pub const u_int8_t = u8;
pub const u_int16_t = c_ushort;
pub const u_int32_t = c_uint;
pub const u_int64_t = c_ulonglong;
pub const register_t = i32;
pub const user_addr_t = u_int32_t;
pub const user_size_t = u_int32_t;
pub const user_ssize_t = i32;
pub const user_long_t = i32;
pub const user_ulong_t = u_int32_t;
pub const user_time_t = i32;
pub const user_off_t = i64;
pub const syscall_arg_t = u_int32_t;
pub const rsize_t = __darwin_size_t;
pub const errno_t = c_int;
pub extern fn memset_s(__s: ?*anyopaque, __smax: rsize_t, __c: c_int, __n: rsize_t) errno_t;
pub extern fn memmem(__big: ?*const anyopaque, __big_len: usize, __little: ?*const anyopaque, __little_len: usize) ?*anyopaque;
pub extern fn memset_pattern4(__b: ?*anyopaque, __pattern4: ?*const anyopaque, __len: usize) void;
pub extern fn memset_pattern8(__b: ?*anyopaque, __pattern8: ?*const anyopaque, __len: usize) void;
pub extern fn memset_pattern16(__b: ?*anyopaque, __pattern16: ?*const anyopaque, __len: usize) void;
pub extern fn strcasestr(__big: [*c]const u8, __little: [*c]const u8) [*c]u8;
pub extern fn strchrnul(__s: [*c]const u8, __c: c_int) [*c]u8;
pub extern fn strnstr(__big: [*c]const u8, __little: [*c]const u8, __len: usize) [*c]u8;
pub extern fn strlcat(__dst: [*c]u8, __source: [*c]const u8, __size: usize) usize;
pub extern fn strlcpy(__dst: [*c]u8, __source: [*c]const u8, __size: usize) usize;
pub extern fn strmode(__mode: c_int, __bp: [*c]u8) void;
pub extern fn strsep(__stringp: [*c][*c]u8, __delim: [*c]const u8) [*c]u8;
pub extern fn swab(noalias ?*const anyopaque, noalias ?*anyopaque, __len: isize) void;
pub extern fn timingsafe_bcmp(__b1: ?*const anyopaque, __b2: ?*const anyopaque, __len: usize) c_int;
pub extern fn strsignal_r(__sig: c_int, __strsignalbuf: [*c]u8, __buflen: usize) c_int;
pub extern fn bcmp(?*const anyopaque, ?*const anyopaque, __n: usize) c_int;
pub extern fn bcopy(?*const anyopaque, ?*anyopaque, __n: usize) void;
pub extern fn bzero(?*anyopaque, __n: usize) void;
pub extern fn index([*c]const u8, c_int) [*c]u8;
pub extern fn rindex([*c]const u8, c_int) [*c]u8;
pub extern fn ffs(c_int) c_int;
pub extern fn strcasecmp([*c]const u8, [*c]const u8) c_int;
pub extern fn strncasecmp([*c]const u8, [*c]const u8, usize) c_int;
pub extern fn ffsl(c_long) c_int;
pub extern fn ffsll(c_longlong) c_int;
pub extern fn fls(c_int) c_int;
pub extern fn flsl(c_long) c_int;
pub extern fn flsll(c_longlong) c_int;
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
const union_unnamed_2 = extern union {
    loop_length: mm_word,
    length: mm_word,
};
pub const struct_t_mmdssample = extern struct {
    loop_start: mm_word = @import("std").mem.zeroes(mm_word),
    unnamed_0: union_unnamed_2 = @import("std").mem.zeroes(union_unnamed_2),
    format: mm_byte = @import("std").mem.zeroes(mm_byte),
    repeat_mode: mm_byte = @import("std").mem.zeroes(mm_byte),
    base_rate: mm_hword = @import("std").mem.zeroes(mm_hword),
    data: mm_addr = @import("std").mem.zeroes(mm_addr),
};
pub const mm_ds_sample = struct_t_mmdssample;
const union_unnamed_3 = extern union {
    id: mm_word,
    sample: [*c]mm_ds_sample,
};
pub const struct_t_mmsoundeffect = extern struct {
    unnamed_0: union_unnamed_3 = @import("std").mem.zeroes(union_unnamed_3),
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
const enum_unnamed_4 = c_uint;
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
    if (id >= mmGetModuleCount()) return;
    mpps_backdoor(id, mode, @as(c_uint, @bitCast(MM_MAIN)));
}
pub export fn mmPause() void {
    if (@as(c_int, @bitCast(@as(c_uint, mmLayerMain.valid))) == @as(c_int, 0)) return;
    mmLayerMain.isplaying = 0;
    mpp_suspend(@as(c_uint, @bitCast(MM_MAIN)));
}
pub export fn mmResume() void {
    if (@as(c_int, @bitCast(@as(c_uint, mmLayerMain.valid))) == @as(c_int, 0)) return;
    mmLayerMain.isplaying = 1;
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
pub const struct_tmm_mas_head = extern struct {
    order_count: mm_byte align(4) = @import("std").mem.zeroes(mm_byte),
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
pub export fn mmPlayModule(arg_address: usize, arg_mode: mm_word, arg_layer: mm_word) void {
    var address = arg_address;
    _ = &address;
    var mode = arg_mode;
    _ = &mode;
    var layer = arg_layer;
    _ = &layer;
    var header: [*c]mm_mas_head = @as([*c]mm_mas_head, @ptrFromInt(address));
    _ = &header;
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
    layer_info.*.mode = @as(mm_byte, @bitCast(@as(u8, @truncate(mode))));
    layer_info.*.songadr = header;
    mpp_resetchannels(channels, num_ch);
    var instn_size: mm_word = @as(mm_word, @bitCast(@as(c_uint, header.*.instr_count)));
    _ = &instn_size;
    var sampn_size: mm_word = @as(mm_word, @bitCast(@as(c_uint, header.*.sampl_count)));
    _ = &sampn_size;
    layer_info.*.insttable = @as([*c]mm_word, @ptrCast(@alignCast(&header.*.tables()[@as(c_uint, @intCast(@as(c_int, 0)))])));
    layer_info.*.samptable = @as([*c]mm_word, @ptrCast(@alignCast(&header.*.tables()[instn_size])));
    layer_info.*.patttable = @as([*c]mm_word, @ptrCast(@alignCast(&header.*.tables()[instn_size +% sampn_size])));
    mpp_setposition(layer_info, @as(mm_word, @bitCast(@as(c_int, 0))));
    mpp_setbpm(layer_info, @as(mm_word, @bitCast(@as(c_uint, header.*.initial_tempo))));
    layer_info.*.global_volume = header.*.global_volume;
    var flags: mm_word = @as(mm_word, @bitCast(@as(c_uint, header.*.flags)));
    _ = &flags;
    layer_info.*.flags = @as(mm_byte, @bitCast(@as(u8, @truncate(flags))));
    layer_info.*.oldeffects = @as(mm_byte, @bitCast(@as(u8, @truncate((flags >> @intCast(1)) & @as(mm_word, @bitCast(@as(c_int, 1)))))));
    layer_info.*.speed = header.*.initial_speed;
    layer_info.*.isplaying = 1;
    layer_info.*.valid = 1;
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
    mpp_suspend(@as(c_uint, @bitCast(MM_JINGLE)));
}
pub export fn mmJingleResume() void {
    if (@as(c_int, @bitCast(@as(c_uint, mmLayerSub.valid))) == @as(c_int, 0)) return;
    mmLayerSub.isplaying = 1;
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
pub extern fn mmSetEffectsVolume(volume: mm_word) void;
pub extern fn mmEffectCancelAll() void;
pub const struct_tmm_mas_prefix = extern struct {
    size: mm_word = @import("std").mem.zeroes(mm_word),
    type: mm_byte = @import("std").mem.zeroes(mm_byte),
    version: mm_byte = @import("std").mem.zeroes(mm_byte),
    reserved: [2]mm_byte = @import("std").mem.zeroes([2]mm_byte),
};
pub const mm_mas_prefix = struct_tmm_mas_prefix;
// maxmod/include/mm_mas.h:82:17: warning: struct demoted to opaque type - has bitfield
pub const struct_tmm_mas_instrument = opaque {};
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
const union_unnamed_5 = extern union {
    loop_length: mm_word,
    length: mm_word,
};
pub const struct_tmm_mas_ds_sample = extern struct {
    loop_start: mm_word align(4) = @import("std").mem.zeroes(mm_word),
    unnamed_0: union_unnamed_5 = @import("std").mem.zeroes(union_unnamed_5),
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
pub const struct_tmslheaddata = extern struct {
    sampleCount: mm_hword = @import("std").mem.zeroes(mm_hword),
    moduleCount: mm_hword = @import("std").mem.zeroes(mm_hword),
    reserved: [2]mm_word = @import("std").mem.zeroes([2]mm_word),
};
pub const msl_head_data = struct_tmslheaddata;
pub const struct_tmslhead = extern struct {
    head_data: msl_head_data align(4) = @import("std").mem.zeroes(msl_head_data),
    pub fn sampleTable(self: anytype) @import("std").zig.c_translation.FlexibleArrayType(@TypeOf(self), ?*anyopaque) {
        const Intermediate = @import("std").zig.c_translation.FlexibleArrayType(@TypeOf(self), u8);
        const ReturnType = @import("std").zig.c_translation.FlexibleArrayType(@TypeOf(self), ?*anyopaque);
        return @as(ReturnType, @ptrCast(@alignCast(@as(Intermediate, @ptrCast(self)) + 12)));
    }
};
pub const msl_head = struct_tmslhead;
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
pub const static_assertion___LINE__ = [1]u8;
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
pub const mm_mixer_channel = extern struct {
    src: usize = @import("std").mem.zeroes(usize),
    read: mm_word = @import("std").mem.zeroes(mm_word),
    vol: mm_byte = @import("std").mem.zeroes(mm_byte),
    pan: mm_byte = @import("std").mem.zeroes(mm_byte),
    unused_0: mm_byte = @import("std").mem.zeroes(mm_byte),
    unused_1: mm_byte = @import("std").mem.zeroes(mm_byte),
    freq: mm_word = @import("std").mem.zeroes(mm_word),
};
const union_unnamed_6 = extern union {
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
    unnamed_0: union_unnamed_6 = @import("std").mem.zeroes(union_unnamed_6),
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
        var ok: mm_bool = mmReadPattern(layer);
        _ = &ok;
        if (@as(c_int, @bitCast(@as(c_uint, ok))) == @as(c_int, 0)) {
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
    if (new_tick < @as(mm_word, @bitCast(@as(c_uint, layer.*.speed)))) {
        layer.*.tick = @as(mm_byte, @bitCast(@as(u8, @truncate(new_tick))));
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
pub extern fn mmReadPattern([*c]mpl_layer_information) mm_bool;
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
                mppe_VolumeSlide(param, channel, layer);
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
// maxmod/source/core/mas.c:3520:9: warning: TODO implement translation of stmt class GotoStmtClass

// maxmod/source/core/mas.c:3508:9: warning: unable to translate function, demoted to extern
pub extern fn mpp_Update_ACHN_notest(arg_layer: [*c]mpl_layer_information, arg_act_ch: [*c]mm_active_channel, arg_period: mm_word, arg_ch: mm_word) mm_word;
// maxmod/source/core/mas.c:667:9: warning: TODO implement translation of stmt class GotoStmtClass

// maxmod/source/core/mas.c:660:17: warning: unable to translate function, demoted to extern
pub extern fn mpp_Channel_NewNote(arg_module_channel: [*c]mm_module_channel, arg_layer: [*c]mpl_layer_information) linksection(".iwram") void;
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
pub extern var mp_solution: [*c]msl_head;
// Rename to avoid symbol collision with our ASM mixer global and make it an internal var
pub var mm_mix_channels_core: [*c]mm_mixer_channel = @ptrFromInt(0);
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
        layer_info.*.tickrate = @as(mm_hword, @bitCast(@as(c_ushort, @truncate((bpm << @intCast(15)) / @as(mm_word, @bitCast(@as(c_int, 149)))))));
    }
}
pub fn mpp_suspend(arg_layer: mm_layer_type) callconv(.c) void {
    var layer = arg_layer;
    _ = &layer;
    var act_ch: [*c]mm_active_channel = &mm_achannels[@as(c_uint, @intCast(@as(c_int, 0)))];
    _ = &act_ch;
    var mix_ch: [*c]mm_mixer_channel = &mm_mix_channels_core[@as(c_uint, @intCast(@as(c_int, 0)))];
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
    var sampleCount: mm_hword = mp_solution.*.head_data.sampleCount;
    _ = &sampleCount;
    var moduleTable: [*c]mm_word = @as([*c]mm_word, @ptrCast(@alignCast(&mp_solution.*.sampleTable()[sampleCount])));
    _ = &moduleTable;
    var moduleAddress: usize = (@as(usize, @intCast(@intFromPtr(mp_solution))) +% @sizeOf(mm_mas_prefix)) +% moduleTable[id];
    _ = &moduleAddress;
    mmPlayModule(moduleAddress, @as(mm_word, @bitCast(mode)), @as(mm_word, @bitCast(layer)));
}
pub fn mpp_resetchannels(arg_channels: [*c]mm_module_channel, arg_num_ch: mm_word) callconv(.c) void {
    var channels = arg_channels;
    _ = &channels;
    var num_ch = arg_num_ch;
    _ = &num_ch;
    _ = __builtin___memset_chk(@as(?*anyopaque, @ptrCast(channels)), @as(c_int, 0), @sizeOf(mm_module_channel) *% num_ch, __builtin_object_size(@as(?*const anyopaque, @ptrCast(channels)), @as(c_int, 0)));
    {
        var i: mm_word = 0;
        _ = &i;
        while (i < num_ch) : (i +%= 1) {
            channels[i].alloc = 255;
        }
    }
    var mix_ch: [*c]mm_mixer_channel = &mm_mix_channels_core[@as(c_uint, @intCast(@as(c_int, 0)))];
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
            _ = __builtin___memset_chk(@as(?*anyopaque, @ptrCast(act_ch)), @as(c_int, 0), @sizeOf(mm_active_channel), __builtin_object_size(@as(?*const anyopaque, @ptrCast(act_ch)), @as(c_int, 0)));
            mix_ch.*.src = @as(c_uint, 1) << @intCast((@sizeOf(usize) *% @as(c_uint, @bitCast(@as(c_int, 8)))) -% @as(c_uint, @bitCast(@as(c_int, 1))));
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
    var patt: [*c]mm_mas_pattern = mpp_PatternPointer(layer_info, @as(mm_word, @bitCast(@as(c_uint, entry))));
    _ = &patt;
    layer_info.*.nrows = patt.*.row_count;
    layer_info.*.tick = 0;
    layer_info.*.row = 0;
    layer_info.*.fpattdelay = 0;
    layer_info.*.pattdelay = 0;
    layer_info.*.pattread = patt.*.pattern_data();
    layer_info.*.ploop_adr = patt.*.pattern_data();
    layer_info.*.ploop_row = 0;
    layer_info.*.ploop_times = 0;
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
pub const mpp_TABLE_LinearSlideUpTable: [257]mm_hword = [257]mm_hword{
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
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 18842))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 19147))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 19454))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 19761))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 20070))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 20379))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 20690))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 21002))))),
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
pub const mpp_TABLE_LinearSlideDownTable: [257]mm_hword = [257]mm_hword{
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
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 46677))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 46509))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 46341))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 46174))))),
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
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 31950))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 31835))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 31720))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 31606))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 31492))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 31379))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 31266))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 31153))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 31041))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 30929))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 30817))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 30706))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 30596))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 30485))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 30376))))),
    @as(mm_hword, @bitCast(@as(c_short, @truncate(@as(c_int, 30226))))),
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
    return mpph_VolumeSlide(volume, param, tick, @as(c_int, 64), layer);
}
pub const mpp_TABLE_FineSineData: [256]mm_sbyte = [256]mm_sbyte{
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
    @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 63))))),
    @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 63))))),
    @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 63))))),
    @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 62))))),
    @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 62))))),
    @as(mm_sbyte, @bitCast(@as(i8, @truncate(-@as(c_int, 62))))),
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
    channel.*.volume = @as(mm_byte, @bitCast(@as(u8, @truncate(mpph_VolumeSlide64(@as(c_int, @bitCast(@as(c_uint, channel.*.volume))), param, @as(mm_word, @bitCast(@as(c_uint, layer.*.tick))), layer)))));
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
    var node_info: ?*mm_mas_envelope_node = &envelope.*.env_nodes()[node];
    _ = &node_info;
    value_mul_64.* = @as(mm_word, @bitCast(@as(c_int, @bitCast(@as(c_uint, node_info.*.base))) * @as(c_int, 64)));
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
        var delta: mm_sword = @as(mm_sword, @bitCast(@as(c_int, node_info.*.delta)));
        _ = &delta;
        value_mul_64.* +%= @as(mm_word, @bitCast(@as(mm_sword, @bitCast(delta * @as(c_int, @bitCast(@as(c_uint, count))))) >> @intCast(3)));
    }
    count +%= 1;
    if (@as(c_int, @bitCast(@as(c_uint, count))) == @as(c_int, @bitCast(@as(c_uint, node_info.*.range)))) {
        count = 0;
        node = @as(mm_byte, @bitCast(@as(i8, @truncate(@as(c_int, @bitCast(@as(c_uint, node))) + @as(c_int, 1)))));
    }
    count_.* = count;
    node_.* = node;
    return 2;
}
// maxmod/source/core/mas.c:3133:13: warning: TODO implement translation of stmt class GotoStmtClass

// maxmod/source/core/mas.c:3086:16: warning: unable to translate function, demoted to extern
pub extern fn mpp_Update_ACHN_notest_envelopes(arg_layer: [*c]mpl_layer_information, arg_act_ch: [*c]mm_active_channel, arg_period: mm_word) callconv(.c) mm_word;
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
// maxmod/source/core/mas.c:3241:9: warning: TODO implement translation of stmt class GotoStmtClass

// maxmod/source/core/mas.c:3232:26: warning: unable to translate function, demoted to extern
pub extern fn mpp_Update_ACHN_notest_update_mix(arg_layer: [*c]mpl_layer_information, arg_act_ch: [*c]mm_active_channel, arg_channel: mm_word) callconv(.c) [*c]mm_mixer_channel;
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
    if ((@as(c_int, @bitCast(@as(c_uint, layer.*.flags))) & (@as(c_int, 1) << @intCast(2))) != 0) {
        var speed: mm_hword = sample.*.frequency;
        _ = &speed;
        var value: mm_word = ((period >> @intCast(8)) *% @as(mm_word, @bitCast(@as(c_int, @bitCast(@as(c_uint, speed))) << @intCast(2)))) >> @intCast(8);
        _ = &value;
        if (mpp_clayer == @as(c_uint, @bitCast(MM_MAIN))) {
            value = (value *% mm_masterpitch) >> @intCast(10);
        }
        const scale: mm_word = @as(mm_word, @bitCast(@divTrunc(@as(c_int, 4096) * @as(c_int, 65536), @as(c_int, 15768))));
        _ = &scale;
        mix_ch.*.freq = (scale *% value) >> @intCast(16);
    } else {
        if (period != @as(mm_word, @bitCast(@as(c_int, 0)))) {
            var value: mm_word = @as(mm_word, @bitCast(@as(c_int, 56750314))) / period;
            _ = &value;
            if (mpp_clayer == @as(c_uint, @bitCast(MM_MAIN))) {
                value = (value *% mm_masterpitch) >> @intCast(10);
            }
            const scale: mm_word = @as(mm_word, @bitCast(@divTrunc(@as(c_int, 4096) * @as(c_int, 65536), @as(c_int, 15768))));
            _ = &scale;
            mix_ch.*.freq = (scale *% value) >> @intCast(16);
        }
    }
    if (@as(c_int, @bitCast(@as(c_uint, act_ch.*.inst))) == @as(c_int, 0)) {
        act_ch.*.fvol = 0;
        return 0;
    }
    var inst: ?*mm_mas_instrument = mpp_InstrumentPointer(layer, @as(mm_word, @bitCast(@as(c_uint, act_ch.*.inst))));
    _ = &inst;
    var vol: mm_word = @as(mm_word, @bitCast(@as(c_uint, sample.*.global_volume)));
    _ = &vol;
    vol *%= @as(mm_word, @bitCast(@as(c_uint, inst.*.global_volume)));
    vol *%= @as(mm_word, @bitCast(@as(c_uint, mpp_vars.afvol)));
    var global_volume: mm_byte = layer.*.global_volume;
    _ = &global_volume;
    if ((@as(c_int, @bitCast(@as(c_uint, layer.*.flags))) & (@as(c_int, 1) << @intCast(3))) != 0) {
        global_volume <<= @intCast(@as(c_int, 1));
    }
    vol = (vol *% @as(mm_word, @bitCast(@as(c_uint, global_volume)))) >> @intCast(10);
    vol = (vol *% @as(mm_word, @bitCast(@as(c_uint, act_ch.*.fade)))) >> @intCast(10);
    vol *%= @as(mm_word, @bitCast(@as(c_uint, layer.*.volume)));
    vol = vol >> @intCast(19);
    if (vol > @as(mm_word, @bitCast(@as(c_int, 255)))) {
        vol = 255;
    }
    act_ch.*.fvol = @as(mm_byte, @bitCast(@as(u8, @truncate(vol))));
    return vol;
}
// maxmod/source/core/mas.c:3410:9: warning: TODO implement translation of stmt class GotoStmtClass

// maxmod/source/core/mas.c:3406:13: warning: unable to translate function, demoted to extern
pub extern fn mpp_Update_ACHN_notest_disable_and_panning(arg_volume: mm_word, arg_act_ch: [*c]mm_active_channel, arg_mix_ch: [*c]mm_mixer_channel) callconv(.c) void;
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
pub const __ARM_FEATURE_COPROC = @as(c_int, 0x0);
pub const __THUMBEL__ = @as(c_int, 1);
pub const __thumb__ = @as(c_int, 1);
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
pub const ARM_CODE = "";
pub const MM_SIZEOF_MIXCH = @as(c_int, 16);
pub const __GCC_HAVE_DWARF2_CFI_ASM = @as(c_int, 1);
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
pub const _STRING_H_ = "";
pub const _LIBC_BOUNDS_H_ = "";
pub const _CDEFS_H_ = "";
pub const __BEGIN_DECLS = "";
pub const __END_DECLS = "";
pub inline fn __has_cpp_attribute(x: anytype) @TypeOf(@as(c_int, 0)) {
    _ = &x;
    return @as(c_int, 0);
}
pub inline fn __P(protos: anytype) @TypeOf(protos) {
    _ = &protos;
    return protos;
}
pub const __CONCAT = @compileError("unable to translate C expr: unexpected token '##'");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/cdefs.h:116:9
pub const __STRING = @compileError("unable to translate C expr: unexpected token '#'");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/cdefs.h:117:9
pub const __const = @compileError("unable to translate C expr: unexpected token 'const'");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/cdefs.h:119:9
pub const __signed = c_int;
pub const __volatile = @compileError("unable to translate C expr: unexpected token 'volatile'");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/cdefs.h:121:9
pub const __dead2 = @compileError("unable to translate macro: undefined identifier `__noreturn__`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/cdefs.h:165:9
pub const __pure2 = @compileError("unable to translate C expr: unexpected token '__attribute__'");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/cdefs.h:166:9
pub const __stateful_pure = @compileError("unable to translate macro: undefined identifier `__pure__`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/cdefs.h:167:9
pub const __unused = @compileError("unable to translate macro: undefined identifier `__unused__`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/cdefs.h:172:9
pub const __used = @compileError("unable to translate macro: undefined identifier `__used__`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/cdefs.h:177:9
pub const __cold = @compileError("unable to translate macro: undefined identifier `__cold__`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/cdefs.h:183:9
pub const __returns_nonnull = @compileError("unable to translate macro: undefined identifier `returns_nonnull`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/cdefs.h:190:9
pub const __exported = @compileError("unable to translate macro: undefined identifier `__visibility__`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/cdefs.h:200:9
pub const __exported_push = @compileError("unable to translate macro: undefined identifier `_Pragma`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/cdefs.h:201:9
pub const __exported_pop = @compileError("unable to translate macro: undefined identifier `_Pragma`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/cdefs.h:202:9
pub const __deprecated = @compileError("unable to translate macro: undefined identifier `__deprecated__`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/cdefs.h:214:9
pub const __deprecated_msg = @compileError("unable to translate macro: undefined identifier `__deprecated__`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/cdefs.h:218:10
pub inline fn __deprecated_enum_msg(_msg: anytype) @TypeOf(__deprecated_msg(_msg)) {
    _ = &_msg;
    return __deprecated_msg(_msg);
}
pub const __kpi_deprecated = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/cdefs.h:229:9
pub const __unavailable = @compileError("unable to translate macro: undefined identifier `__unavailable__`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/cdefs.h:235:9
pub const __kpi_unavailable = "";
pub const __kpi_deprecated_arm64_macos_unavailable = "";
pub const __dead = "";
pub const __pure = "";
pub const __restrict = @compileError("unable to translate C expr: unexpected token 'restrict'");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/cdefs.h:257:9
pub const __disable_tail_calls = @compileError("unable to translate macro: undefined identifier `__disable_tail_calls__`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/cdefs.h:290:9
pub const __not_tail_called = @compileError("unable to translate macro: undefined identifier `__not_tail_called__`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/cdefs.h:302:9
pub const __result_use_check = @compileError("unable to translate macro: undefined identifier `__warn_unused_result__`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/cdefs.h:313:9
pub const __swift_unavailable = @compileError("unable to translate macro: undefined identifier `__availability__`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/cdefs.h:323:9
pub const __swift_unavailable_from_async = @compileError("unable to translate macro: undefined identifier `__swift_attr__`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/cdefs.h:332:9
pub const __swift_nonisolated = @compileError("unable to translate macro: undefined identifier `__swift_attr__`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/cdefs.h:333:9
pub const __swift_nonisolated_unsafe = @compileError("unable to translate macro: undefined identifier `__swift_attr__`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/cdefs.h:334:9
pub const __abortlike = __dead2 ++ __cold ++ __not_tail_called;
pub const __header_inline = @compileError("unable to translate C expr: unexpected token 'inline'");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/cdefs.h:370:10
pub const __header_always_inline = @compileError("unable to translate macro: undefined identifier `__always_inline__`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/cdefs.h:383:10
pub const __unreachable_ok_push = @compileError("unable to translate macro: undefined identifier `_Pragma`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/cdefs.h:396:10
pub const __unreachable_ok_pop = @compileError("unable to translate macro: undefined identifier `_Pragma`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/cdefs.h:399:10
pub const __printflike = @compileError("unable to translate macro: undefined identifier `__format__`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/cdefs.h:420:9
pub const __printf0like = @compileError("unable to translate macro: undefined identifier `__format__`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/cdefs.h:422:9
pub const __scanflike = @compileError("unable to translate macro: undefined identifier `__format__`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/cdefs.h:424:9
pub const __osloglike = @compileError("unable to translate macro: undefined identifier `__format__`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/cdefs.h:426:9
pub const __IDSTRING = @compileError("unable to translate C expr: unexpected token 'static'");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/cdefs.h:429:9
pub const __COPYRIGHT = @compileError("unable to translate macro: undefined identifier `copyright`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/cdefs.h:432:9
pub const __RCSID = @compileError("unable to translate macro: undefined identifier `rcsid`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/cdefs.h:436:9
pub const __SCCSID = @compileError("unable to translate macro: undefined identifier `sccsid`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/cdefs.h:440:9
pub const __PROJECT_VERSION = @compileError("unable to translate macro: undefined identifier `project_version`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/cdefs.h:444:9
pub const __FBSDID = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/cdefs.h:449:9
pub const __DECONST = @compileError("unable to translate C expr: unexpected token 'const'");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/cdefs.h:453:9
pub const __DEVOLATILE = @compileError("unable to translate C expr: unexpected token 'volatile'");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/cdefs.h:457:9
pub const __DEQUALIFY = @compileError("unable to translate C expr: unexpected token 'const'");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/cdefs.h:461:9
pub const __alloc_align = @compileError("unable to translate macro: undefined identifier `alloc_align`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/cdefs.h:470:9
pub const __alloc_size = @compileError("unable to translate C expr: expected ')' instead got '...'");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/cdefs.h:491:9
pub const __has_safe_buffers = @as(c_int, 1);
pub const __unsafe_buffer_usage = @compileError("unable to translate macro: undefined identifier `__unsafe_buffer_usage__`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/cdefs.h:572:9
pub const __unsafe_buffer_usage_begin = @compileError("unable to translate macro: undefined identifier `_Pragma`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/cdefs.h:578:9
pub const __unsafe_buffer_usage_end = @compileError("unable to translate macro: undefined identifier `_Pragma`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/cdefs.h:579:9
pub const __DARWIN_ONLY_64_BIT_INO_T = @as(c_int, 1);
pub const __DARWIN_ONLY_UNIX_CONFORMANCE = @as(c_int, 1);
pub const __DARWIN_ONLY_VERS_1050 = @as(c_int, 1);
pub const __DARWIN_UNIX03 = @as(c_int, 1);
pub const __DARWIN_64_BIT_INO_T = @as(c_int, 1);
pub const __DARWIN_VERS_1050 = @as(c_int, 1);
pub const __DARWIN_NON_CANCELABLE = @as(c_int, 0);
pub const __DARWIN_SUF_UNIX03 = "";
pub const __DARWIN_SUF_64_BIT_INO_T = "";
pub const __DARWIN_SUF_1050 = "";
pub const __DARWIN_SUF_NON_CANCELABLE = "";
pub const __DARWIN_SUF_EXTSN = "$DARWIN_EXTSN";
pub const __DARWIN_ALIAS = @compileError("unable to translate C expr: unexpected token '__asm'");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/cdefs.h:764:9
pub const __DARWIN_ALIAS_C = @compileError("unable to translate C expr: unexpected token '__asm'");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/cdefs.h:765:9
pub const __DARWIN_ALIAS_I = @compileError("unable to translate C expr: unexpected token '__asm'");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/cdefs.h:766:9
pub const __DARWIN_NOCANCEL = @compileError("unable to translate C expr: unexpected token '__asm'");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/cdefs.h:767:9
pub const __DARWIN_INODE64 = @compileError("unable to translate C expr: unexpected token '__asm'");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/cdefs.h:768:9
pub const __DARWIN_1050 = @compileError("unable to translate C expr: unexpected token '__asm'");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/cdefs.h:770:9
pub const __DARWIN_1050ALIAS = @compileError("unable to translate C expr: unexpected token '__asm'");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/cdefs.h:771:9
pub const __DARWIN_1050ALIAS_C = @compileError("unable to translate C expr: unexpected token '__asm'");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/cdefs.h:772:9
pub const __DARWIN_1050ALIAS_I = @compileError("unable to translate C expr: unexpected token '__asm'");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/cdefs.h:773:9
pub const __DARWIN_1050INODE64 = @compileError("unable to translate C expr: unexpected token '__asm'");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/cdefs.h:774:9
pub const __DARWIN_EXTSN = @compileError("unable to translate C expr: unexpected token '__asm'");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/cdefs.h:776:9
pub const __DARWIN_EXTSN_C = @compileError("unable to translate C expr: unexpected token '__asm'");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/cdefs.h:777:9
pub const __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_2_0 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:35:9
pub const __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_2_1 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:41:9
pub const __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_2_2 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:47:9
pub const __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_3_0 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:53:9
pub const __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_3_1 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:59:9
pub const __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_3_2 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:65:9
pub const __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_4_0 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:71:9
pub const __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_4_1 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:77:9
pub const __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_4_2 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:83:9
pub const __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_4_3 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:89:9
pub const __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_5_0 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:95:9
pub const __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_5_1 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:101:9
pub const __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_6_0 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:107:9
pub const __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_6_1 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:113:9
pub const __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_7_0 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:119:9
pub const __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_7_1 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:125:9
pub const __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_8_0 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:131:9
pub const __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_8_1 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:137:9
pub const __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_8_2 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:143:9
pub const __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_8_3 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:149:9
pub const __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_8_4 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:155:9
pub const __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_9_0 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:161:9
pub const __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_9_1 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:167:9
pub const __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_9_2 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:173:9
pub const __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_9_3 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:179:9
pub const __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_10_0 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:185:9
pub const __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_10_1 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:191:9
pub const __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_10_2 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:197:9
pub const __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_10_3 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:203:9
pub const __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_11_0 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:209:9
pub const __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_11_1 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:215:9
pub const __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_11_2 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:221:9
pub const __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_11_3 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:227:9
pub const __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_11_4 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:233:9
pub const __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_12_0 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:239:9
pub const __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_12_1 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:245:9
pub const __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_12_2 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:251:9
pub const __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_12_3 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:257:9
pub const __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_12_4 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:263:9
pub const __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_13_0 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:269:9
pub const __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_13_1 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:275:9
pub const __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_13_2 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:281:9
pub const __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_13_3 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:287:9
pub const __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_13_4 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:293:9
pub const __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_13_5 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:299:9
pub const __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_13_6 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:305:9
pub const __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_13_7 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:311:9
pub const __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_14_0 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:317:9
pub const __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_14_1 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:323:9
pub const __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_14_2 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:329:9
pub const __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_14_3 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:335:9
pub const __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_14_5 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:341:9
pub const __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_14_4 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:347:9
pub const __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_14_6 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:359:9
pub const __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_14_7 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:365:9
pub const __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_14_8 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:371:9
pub const __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_15_0 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:377:9
pub const __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_15_1 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:383:9
pub const __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_15_2 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:389:9
pub const __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_15_3 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:395:9
pub const __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_15_4 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:401:9
pub const __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_15_5 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:407:9
pub const __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_15_6 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:413:9
pub const __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_15_7 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:419:9
pub const __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_15_8 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:425:9
pub const __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_16_0 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:431:9
pub const __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_16_1 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:437:9
pub const __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_16_2 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:443:9
pub const __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_16_3 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:449:9
pub const __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_16_4 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:455:9
pub const __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_16_5 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:461:9
pub const __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_16_6 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:467:9
pub const __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_16_7 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:473:9
pub const __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_17_0 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:479:9
pub const __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_17_1 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:485:9
pub const __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_17_2 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:491:9
pub const __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_17_3 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:497:9
pub const __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_17_4 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:503:9
pub const __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_17_5 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:509:9
pub const __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_17_6 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:515:9
pub const __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_17_7 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:521:9
pub const __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_18_0 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:527:9
pub const __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_18_1 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:533:9
pub const __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_18_2 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:539:9
pub const __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_18_3 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:545:9
pub const __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_18_4 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:551:9
pub const __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_18_5 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:557:9
pub const __DARWIN_ALIAS_STARTING_MAC___MAC_10_0 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:563:9
pub const __DARWIN_ALIAS_STARTING_MAC___MAC_10_1 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:569:9
pub const __DARWIN_ALIAS_STARTING_MAC___MAC_10_2 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:575:9
pub const __DARWIN_ALIAS_STARTING_MAC___MAC_10_3 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:581:9
pub const __DARWIN_ALIAS_STARTING_MAC___MAC_10_4 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:587:9
pub const __DARWIN_ALIAS_STARTING_MAC___MAC_10_5 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:593:9
pub const __DARWIN_ALIAS_STARTING_MAC___MAC_10_6 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:599:9
pub const __DARWIN_ALIAS_STARTING_MAC___MAC_10_7 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:605:9
pub const __DARWIN_ALIAS_STARTING_MAC___MAC_10_8 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:611:9
pub const __DARWIN_ALIAS_STARTING_MAC___MAC_10_9 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:617:9
pub const __DARWIN_ALIAS_STARTING_MAC___MAC_10_10 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:623:9
pub const __DARWIN_ALIAS_STARTING_MAC___MAC_10_10_2 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:629:9
pub const __DARWIN_ALIAS_STARTING_MAC___MAC_10_10_3 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:635:9
pub const __DARWIN_ALIAS_STARTING_MAC___MAC_10_11 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:641:9
pub const __DARWIN_ALIAS_STARTING_MAC___MAC_10_11_2 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:647:9
pub const __DARWIN_ALIAS_STARTING_MAC___MAC_10_11_3 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:653:9
pub const __DARWIN_ALIAS_STARTING_MAC___MAC_10_11_4 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:659:9
pub const __DARWIN_ALIAS_STARTING_MAC___MAC_10_12 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:665:9
pub const __DARWIN_ALIAS_STARTING_MAC___MAC_10_12_1 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:671:9
pub const __DARWIN_ALIAS_STARTING_MAC___MAC_10_12_2 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:677:9
pub const __DARWIN_ALIAS_STARTING_MAC___MAC_10_12_4 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:683:9
pub const __DARWIN_ALIAS_STARTING_MAC___MAC_10_13 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:689:9
pub const __DARWIN_ALIAS_STARTING_MAC___MAC_10_13_1 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:695:9
pub const __DARWIN_ALIAS_STARTING_MAC___MAC_10_13_2 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:701:9
pub const __DARWIN_ALIAS_STARTING_MAC___MAC_10_13_4 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:707:9
pub const __DARWIN_ALIAS_STARTING_MAC___MAC_10_14 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:713:9
pub const __DARWIN_ALIAS_STARTING_MAC___MAC_10_14_1 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:719:9
pub const __DARWIN_ALIAS_STARTING_MAC___MAC_10_14_4 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:725:9
pub const __DARWIN_ALIAS_STARTING_MAC___MAC_10_14_5 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:731:9
pub const __DARWIN_ALIAS_STARTING_MAC___MAC_10_14_6 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:737:9
pub const __DARWIN_ALIAS_STARTING_MAC___MAC_10_15 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:743:9
pub const __DARWIN_ALIAS_STARTING_MAC___MAC_10_15_1 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:749:9
pub const __DARWIN_ALIAS_STARTING_MAC___MAC_10_15_4 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:755:9
pub const __DARWIN_ALIAS_STARTING_MAC___MAC_10_16 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:761:9
pub const __DARWIN_ALIAS_STARTING_MAC___MAC_11_0 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:767:9
pub const __DARWIN_ALIAS_STARTING_MAC___MAC_11_1 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:773:9
pub const __DARWIN_ALIAS_STARTING_MAC___MAC_11_3 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:779:9
pub const __DARWIN_ALIAS_STARTING_MAC___MAC_11_4 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:785:9
pub const __DARWIN_ALIAS_STARTING_MAC___MAC_11_5 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:791:9
pub const __DARWIN_ALIAS_STARTING_MAC___MAC_11_6 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:797:9
pub const __DARWIN_ALIAS_STARTING_MAC___MAC_12_0 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:803:9
pub const __DARWIN_ALIAS_STARTING_MAC___MAC_12_1 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:809:9
pub const __DARWIN_ALIAS_STARTING_MAC___MAC_12_2 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:815:9
pub const __DARWIN_ALIAS_STARTING_MAC___MAC_12_3 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:821:9
pub const __DARWIN_ALIAS_STARTING_MAC___MAC_12_4 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:827:9
pub const __DARWIN_ALIAS_STARTING_MAC___MAC_12_5 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:833:9
pub const __DARWIN_ALIAS_STARTING_MAC___MAC_12_6 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:839:9
pub const __DARWIN_ALIAS_STARTING_MAC___MAC_12_7 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:845:9
pub const __DARWIN_ALIAS_STARTING_MAC___MAC_13_0 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:851:9
pub const __DARWIN_ALIAS_STARTING_MAC___MAC_13_1 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:857:9
pub const __DARWIN_ALIAS_STARTING_MAC___MAC_13_2 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:869:9
pub const __DARWIN_ALIAS_STARTING_MAC___MAC_13_3 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:875:9
pub const __DARWIN_ALIAS_STARTING_MAC___MAC_13_4 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:881:9
pub const __DARWIN_ALIAS_STARTING_MAC___MAC_13_5 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:887:9
pub const __DARWIN_ALIAS_STARTING_MAC___MAC_13_6 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:893:9
pub const __DARWIN_ALIAS_STARTING_MAC___MAC_13_7 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:899:9
pub const __DARWIN_ALIAS_STARTING_MAC___MAC_14_0 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:905:9
pub const __DARWIN_ALIAS_STARTING_MAC___MAC_14_1 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:911:9
pub const __DARWIN_ALIAS_STARTING_MAC___MAC_14_2 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:917:9
pub const __DARWIN_ALIAS_STARTING_MAC___MAC_14_3 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:923:9
pub const __DARWIN_ALIAS_STARTING_MAC___MAC_14_4 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:929:9
pub const __DARWIN_ALIAS_STARTING_MAC___MAC_14_5 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:935:9
pub const __DARWIN_ALIAS_STARTING_MAC___MAC_14_6 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:941:9
pub const __DARWIN_ALIAS_STARTING_MAC___MAC_14_7 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:947:9
pub const __DARWIN_ALIAS_STARTING_MAC___MAC_15_0 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:953:9
pub const __DARWIN_ALIAS_STARTING_MAC___MAC_15_1 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:959:9
pub const __DARWIN_ALIAS_STARTING_MAC___MAC_15_2 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:965:9
pub const __DARWIN_ALIAS_STARTING_MAC___MAC_15_3 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:971:9
pub const __DARWIN_ALIAS_STARTING_MAC___MAC_15_4 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:977:9
pub const __DARWIN_ALIAS_STARTING_MAC___MAC_15_5 = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_symbol_aliasing.h:983:9
pub inline fn __DARWIN_ALIAS_STARTING(_mac: anytype, _iphone: anytype, x: anytype) @TypeOf(x) {
    _ = &_mac;
    _ = &_iphone;
    _ = &x;
    return x;
}
pub const ___POSIX_C_DEPRECATED_STARTING_198808L = "";
pub const ___POSIX_C_DEPRECATED_STARTING_199009L = "";
pub const ___POSIX_C_DEPRECATED_STARTING_199209L = "";
pub const ___POSIX_C_DEPRECATED_STARTING_199309L = "";
pub const ___POSIX_C_DEPRECATED_STARTING_199506L = "";
pub const ___POSIX_C_DEPRECATED_STARTING_200112L = "";
pub const ___POSIX_C_DEPRECATED_STARTING_200809L = "";
pub const __POSIX_C_DEPRECATED = @compileError("unable to translate macro: undefined identifier `___POSIX_C_DEPRECATED_STARTING_`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/cdefs.h:850:9
pub const __DARWIN_C_ANSI = @as(c_long, 0o10000);
pub const __DARWIN_C_FULL = @as(c_long, 900000);
pub const __DARWIN_C_LEVEL = __DARWIN_C_FULL;
pub const __STDC_WANT_LIB_EXT1__ = @as(c_int, 1);
pub const __DARWIN_NO_LONG_LONG = @as(c_int, 0);
pub const _DARWIN_FEATURE_64_BIT_INODE = @as(c_int, 1);
pub const _DARWIN_FEATURE_ONLY_64_BIT_INODE = @as(c_int, 1);
pub const _DARWIN_FEATURE_ONLY_VERS_1050 = @as(c_int, 1);
pub const _DARWIN_FEATURE_ONLY_UNIX_CONFORMANCE = @as(c_int, 1);
pub const _DARWIN_FEATURE_UNIX_CONFORMANCE = @as(c_int, 3);
pub const __CAST_AWAY_QUALIFIER = @compileError("unable to translate macro: undefined identifier `_Pragma`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/cdefs.h:948:9
pub const __XNU_PRIVATE_EXTERN = @compileError("unable to translate macro: undefined identifier `visibility`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/cdefs.h:962:9
pub const __has_ptrcheck = @as(c_int, 0);
pub const __single = "";
pub const __unsafe_indexable = "";
pub const __counted_by = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/cdefs.h:981:9
pub const __counted_by_or_null = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/cdefs.h:982:9
pub const __sized_by = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/cdefs.h:983:9
pub const __sized_by_or_null = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/cdefs.h:984:9
pub const __ended_by = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/cdefs.h:985:9
pub const __terminated_by = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/cdefs.h:986:9
pub const __null_terminated = "";
pub const __ptrcheck_abi_assume_single = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/cdefs.h:996:9
pub const __ptrcheck_abi_assume_unsafe_indexable = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/cdefs.h:997:9
pub inline fn __unsafe_forge_bidi_indexable(T: anytype, P: anytype, S: anytype) @TypeOf(T(P)) {
    _ = &T;
    _ = &P;
    _ = &S;
    return T(P);
}
pub const __unsafe_forge_single = @import("std").zig.c_translation.Macros.CAST_OR_CALL;
pub inline fn __unsafe_forge_terminated_by(T: anytype, P: anytype, E: anytype) @TypeOf(T(P)) {
    _ = &T;
    _ = &P;
    _ = &E;
    return T(P);
}
pub const __unsafe_forge_null_terminated = @import("std").zig.c_translation.Macros.CAST_OR_CALL;
pub inline fn __terminated_by_to_indexable(P: anytype) @TypeOf(P) {
    _ = &P;
    return P;
}
pub inline fn __unsafe_terminated_by_to_indexable(P: anytype) @TypeOf(P) {
    _ = &P;
    return P;
}
pub inline fn __null_terminated_to_indexable(P: anytype) @TypeOf(P) {
    _ = &P;
    return P;
}
pub inline fn __unsafe_null_terminated_to_indexable(P: anytype) @TypeOf(P) {
    _ = &P;
    return P;
}
pub const __unsafe_terminated_by_from_indexable = @compileError("unable to translate C expr: expected ')' instead got '...'");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/cdefs.h:1008:9
pub const __unsafe_null_terminated_from_indexable = @compileError("unable to translate C expr: expected ')' instead got '...'");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/cdefs.h:1009:9
pub const __array_decay_dicards_count_in_parameters = "";
pub const __unsafe_late_const = "";
pub const __ptrcheck_unavailable = "";
pub const __ptrcheck_unavailable_r = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/cdefs.h:1018:9
pub const __ASSUME_PTR_ABI_SINGLE_BEGIN = __ptrcheck_abi_assume_single();
pub const __ASSUME_PTR_ABI_SINGLE_END = __ptrcheck_abi_assume_unsafe_indexable();
pub const __header_indexable = "";
pub const __header_bidi_indexable = "";
pub const __compiler_barrier = @compileError("unable to translate C expr: unexpected token '__asm__'");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/cdefs.h:1047:9
pub const __enum_open = @compileError("unable to translate macro: undefined identifier `__enum_extensibility__`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/cdefs.h:1050:9
pub const __enum_closed = @compileError("unable to translate macro: undefined identifier `__enum_extensibility__`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/cdefs.h:1051:9
pub const __enum_options = @compileError("unable to translate macro: undefined identifier `__flag_enum__`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/cdefs.h:1058:9
pub const __enum_decl = @compileError("unable to translate C expr: expected ')' instead got '...'");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/cdefs.h:1071:9
pub const __enum_closed_decl = @compileError("unable to translate C expr: expected ')' instead got '...'");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/cdefs.h:1073:9
pub const __options_decl = @compileError("unable to translate C expr: expected ')' instead got '...'");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/cdefs.h:1075:9
pub const __options_closed_decl = @compileError("unable to translate C expr: expected ')' instead got '...'");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/cdefs.h:1077:9
pub const __kernel_ptr_semantics = "";
pub const __kernel_data_semantics = "";
pub const __kernel_dual_semantics = "";
pub const __xnu_data_size = "";
pub const __xnu_returns_data_pointer = "";
pub const _LIBC_COUNT = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/_bounds.h:47:9
pub const _LIBC_COUNT_OR_NULL = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/_bounds.h:48:9
pub const _LIBC_SIZE = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/_bounds.h:49:9
pub const _LIBC_SIZE_OR_NULL = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/_bounds.h:50:9
pub const _LIBC_ENDED_BY = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/_bounds.h:51:9
pub const _LIBC_SINGLE = "";
pub const _LIBC_UNSAFE_INDEXABLE = "";
pub const _LIBC_CSTR = "";
pub const _LIBC_NULL_TERMINATED = "";
pub inline fn _LIBC_FLEX_COUNT(FIELD: anytype, INTCOUNT: anytype) @TypeOf(INTCOUNT) {
    _ = &FIELD;
    _ = &INTCOUNT;
    return INTCOUNT;
}
pub const _LIBC_SINGLE_BY_DEFAULT = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/_bounds.h:58:9
pub const _LIBC_PTRCHECK_REPLACED = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/_bounds.h:59:9
pub const __TYPES_H_ = "";
pub const _SYS__TYPES_H_ = "";
pub const _BSD_MACHINE__TYPES_H_ = "";
pub const _BSD_ARM__TYPES_H_ = "";
pub const USE_CLANG_TYPES = @as(c_int, 0);
pub const __DARWIN_NULL = @import("std").zig.c_translation.cast(?*anyopaque, @as(c_int, 0));
pub const _SYS__PTHREAD_TYPES_H_ = "";
pub const __PTHREAD_SIZE__ = @as(c_int, 4088);
pub const __PTHREAD_ATTR_SIZE__ = @as(c_int, 36);
pub const __PTHREAD_MUTEXATTR_SIZE__ = @as(c_int, 8);
pub const __PTHREAD_MUTEX_SIZE__ = @as(c_int, 40);
pub const __PTHREAD_CONDATTR_SIZE__ = @as(c_int, 4);
pub const __PTHREAD_COND_SIZE__ = @as(c_int, 24);
pub const __PTHREAD_ONCE_SIZE__ = @as(c_int, 4);
pub const __PTHREAD_RWLOCK_SIZE__ = @as(c_int, 124);
pub const __PTHREAD_RWLOCKATTR_SIZE__ = @as(c_int, 12);
pub const __offsetof = @compileError("unable to translate C expr: unexpected token 'an identifier'");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_types.h:97:9
pub const __strfmonlike = @compileError("unable to translate macro: undefined identifier `__format__`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/_types.h:34:9
pub const __strftimelike = @compileError("unable to translate macro: undefined identifier `__format__`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/_types.h:36:9
pub const __DARWIN_WCHAR_MAX = __WCHAR_MAX__;
pub const __DARWIN_WCHAR_MIN = -@import("std").zig.c_translation.promoteIntLiteral(c_int, 0x7fffffff, .hex) - @as(c_int, 1);
pub const __DARWIN_WEOF = @import("std").zig.c_translation.cast(__darwin_wint_t, -@as(c_int, 1));
pub const _FORTIFY_SOURCE = @as(c_int, 2);
pub const __AVAILABILITY__ = "";
pub const __API_TO_BE_DEPRECATED = @import("std").zig.c_translation.promoteIntLiteral(c_int, 100000, .decimal);
pub const __API_TO_BE_DEPRECATED_MACOS = @import("std").zig.c_translation.promoteIntLiteral(c_int, 100000, .decimal);
pub const __API_TO_BE_DEPRECATED_MACOSAPPLICATIONEXTENSION = @import("std").zig.c_translation.promoteIntLiteral(c_int, 100000, .decimal);
pub const __API_TO_BE_DEPRECATED_IOS = @import("std").zig.c_translation.promoteIntLiteral(c_int, 100000, .decimal);
pub const __API_TO_BE_DEPRECATED_IOSAPPLICATIONEXTENSION = @import("std").zig.c_translation.promoteIntLiteral(c_int, 100000, .decimal);
pub const __API_TO_BE_DEPRECATED_MACCATALYST = @import("std").zig.c_translation.promoteIntLiteral(c_int, 100000, .decimal);
pub const __API_TO_BE_DEPRECATED_MACCATALYSTAPPLICATIONEXTENSION = @import("std").zig.c_translation.promoteIntLiteral(c_int, 100000, .decimal);
pub const __API_TO_BE_DEPRECATED_WATCHOS = @import("std").zig.c_translation.promoteIntLiteral(c_int, 100000, .decimal);
pub const __API_TO_BE_DEPRECATED_WATCHOSAPPLICATIONEXTENSION = @import("std").zig.c_translation.promoteIntLiteral(c_int, 100000, .decimal);
pub const __API_TO_BE_DEPRECATED_TVOS = @import("std").zig.c_translation.promoteIntLiteral(c_int, 100000, .decimal);
pub const __API_TO_BE_DEPRECATED_TVOSAPPLICATIONEXTENSION = @import("std").zig.c_translation.promoteIntLiteral(c_int, 100000, .decimal);
pub const __API_TO_BE_DEPRECATED_DRIVERKIT = @import("std").zig.c_translation.promoteIntLiteral(c_int, 100000, .decimal);
pub const __API_TO_BE_DEPRECATED_VISIONOS = @import("std").zig.c_translation.promoteIntLiteral(c_int, 100000, .decimal);
pub const __API_TO_BE_DEPRECATED_VISIONOSAPPLICATIONEXTENSION = @import("std").zig.c_translation.promoteIntLiteral(c_int, 100000, .decimal);
pub const __API_TO_BE_DEPRECATED_KERNELKIT = @import("std").zig.c_translation.promoteIntLiteral(c_int, 100000, .decimal);
pub const __AVAILABILITY_VERSIONS__ = "";
pub const __MAC_10_0 = @as(c_int, 1000);
pub const __MAC_10_1 = @as(c_int, 1010);
pub const __MAC_10_2 = @as(c_int, 1020);
pub const __MAC_10_3 = @as(c_int, 1030);
pub const __MAC_10_4 = @as(c_int, 1040);
pub const __MAC_10_5 = @as(c_int, 1050);
pub const __MAC_10_6 = @as(c_int, 1060);
pub const __MAC_10_7 = @as(c_int, 1070);
pub const __MAC_10_8 = @as(c_int, 1080);
pub const __MAC_10_9 = @as(c_int, 1090);
pub const __MAC_10_10 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 101000, .decimal);
pub const __MAC_10_10_2 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 101002, .decimal);
pub const __MAC_10_10_3 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 101003, .decimal);
pub const __MAC_10_11 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 101100, .decimal);
pub const __MAC_10_11_2 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 101102, .decimal);
pub const __MAC_10_11_3 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 101103, .decimal);
pub const __MAC_10_11_4 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 101104, .decimal);
pub const __MAC_10_12 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 101200, .decimal);
pub const __MAC_10_12_1 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 101201, .decimal);
pub const __MAC_10_12_2 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 101202, .decimal);
pub const __MAC_10_12_4 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 101204, .decimal);
pub const __MAC_10_13 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 101300, .decimal);
pub const __MAC_10_13_1 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 101301, .decimal);
pub const __MAC_10_13_2 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 101302, .decimal);
pub const __MAC_10_13_4 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 101304, .decimal);
pub const __MAC_10_14 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 101400, .decimal);
pub const __MAC_10_14_1 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 101401, .decimal);
pub const __MAC_10_14_4 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 101404, .decimal);
pub const __MAC_10_14_5 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 101405, .decimal);
pub const __MAC_10_14_6 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 101406, .decimal);
pub const __MAC_10_15 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 101500, .decimal);
pub const __MAC_10_15_1 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 101501, .decimal);
pub const __MAC_10_15_4 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 101504, .decimal);
pub const __MAC_10_16 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 101600, .decimal);
pub const __MAC_11_0 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 110000, .decimal);
pub const __MAC_11_1 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 110100, .decimal);
pub const __MAC_11_3 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 110300, .decimal);
pub const __MAC_11_4 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 110400, .decimal);
pub const __MAC_11_5 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 110500, .decimal);
pub const __MAC_11_6 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 110600, .decimal);
pub const __MAC_12_0 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 120000, .decimal);
pub const __MAC_12_1 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 120100, .decimal);
pub const __MAC_12_2 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 120200, .decimal);
pub const __MAC_12_3 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 120300, .decimal);
pub const __MAC_12_4 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 120400, .decimal);
pub const __MAC_12_5 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 120500, .decimal);
pub const __MAC_12_6 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 120600, .decimal);
pub const __MAC_12_7 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 120700, .decimal);
pub const __MAC_13_0 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 130000, .decimal);
pub const __MAC_13_1 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 130100, .decimal);
pub const __MAC_13_2 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 130200, .decimal);
pub const __MAC_13_3 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 130300, .decimal);
pub const __MAC_13_4 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 130400, .decimal);
pub const __MAC_13_5 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 130500, .decimal);
pub const __MAC_13_6 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 130600, .decimal);
pub const __MAC_13_7 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 130700, .decimal);
pub const __MAC_14_0 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 140000, .decimal);
pub const __MAC_14_1 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 140100, .decimal);
pub const __MAC_14_2 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 140200, .decimal);
pub const __MAC_14_3 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 140300, .decimal);
pub const __MAC_14_4 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 140400, .decimal);
pub const __MAC_14_5 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 140500, .decimal);
pub const __MAC_14_6 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 140600, .decimal);
pub const __MAC_14_7 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 140700, .decimal);
pub const __MAC_15_0 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 150000, .decimal);
pub const __MAC_15_1 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 150100, .decimal);
pub const __MAC_15_2 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 150200, .decimal);
pub const __MAC_15_3 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 150300, .decimal);
pub const __MAC_15_4 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 150400, .decimal);
pub const __MAC_15_5 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 150500, .decimal);
pub const __IPHONE_2_0 = @as(c_int, 20000);
pub const __IPHONE_2_1 = @as(c_int, 20100);
pub const __IPHONE_2_2 = @as(c_int, 20200);
pub const __IPHONE_3_0 = @as(c_int, 30000);
pub const __IPHONE_3_1 = @as(c_int, 30100);
pub const __IPHONE_3_2 = @as(c_int, 30200);
pub const __IPHONE_4_0 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 40000, .decimal);
pub const __IPHONE_4_1 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 40100, .decimal);
pub const __IPHONE_4_2 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 40200, .decimal);
pub const __IPHONE_4_3 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 40300, .decimal);
pub const __IPHONE_5_0 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 50000, .decimal);
pub const __IPHONE_5_1 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 50100, .decimal);
pub const __IPHONE_6_0 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 60000, .decimal);
pub const __IPHONE_6_1 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 60100, .decimal);
pub const __IPHONE_7_0 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 70000, .decimal);
pub const __IPHONE_7_1 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 70100, .decimal);
pub const __IPHONE_8_0 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 80000, .decimal);
pub const __IPHONE_8_1 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 80100, .decimal);
pub const __IPHONE_8_2 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 80200, .decimal);
pub const __IPHONE_8_3 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 80300, .decimal);
pub const __IPHONE_8_4 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 80400, .decimal);
pub const __IPHONE_9_0 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 90000, .decimal);
pub const __IPHONE_9_1 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 90100, .decimal);
pub const __IPHONE_9_2 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 90200, .decimal);
pub const __IPHONE_9_3 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 90300, .decimal);
pub const __IPHONE_10_0 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 100000, .decimal);
pub const __IPHONE_10_1 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 100100, .decimal);
pub const __IPHONE_10_2 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 100200, .decimal);
pub const __IPHONE_10_3 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 100300, .decimal);
pub const __IPHONE_11_0 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 110000, .decimal);
pub const __IPHONE_11_1 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 110100, .decimal);
pub const __IPHONE_11_2 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 110200, .decimal);
pub const __IPHONE_11_3 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 110300, .decimal);
pub const __IPHONE_11_4 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 110400, .decimal);
pub const __IPHONE_12_0 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 120000, .decimal);
pub const __IPHONE_12_1 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 120100, .decimal);
pub const __IPHONE_12_2 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 120200, .decimal);
pub const __IPHONE_12_3 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 120300, .decimal);
pub const __IPHONE_12_4 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 120400, .decimal);
pub const __IPHONE_13_0 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 130000, .decimal);
pub const __IPHONE_13_1 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 130100, .decimal);
pub const __IPHONE_13_2 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 130200, .decimal);
pub const __IPHONE_13_3 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 130300, .decimal);
pub const __IPHONE_13_4 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 130400, .decimal);
pub const __IPHONE_13_5 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 130500, .decimal);
pub const __IPHONE_13_6 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 130600, .decimal);
pub const __IPHONE_13_7 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 130700, .decimal);
pub const __IPHONE_14_0 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 140000, .decimal);
pub const __IPHONE_14_1 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 140100, .decimal);
pub const __IPHONE_14_2 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 140200, .decimal);
pub const __IPHONE_14_3 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 140300, .decimal);
pub const __IPHONE_14_5 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 140500, .decimal);
pub const __IPHONE_14_4 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 140400, .decimal);
pub const __IPHONE_14_6 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 140600, .decimal);
pub const __IPHONE_14_7 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 140700, .decimal);
pub const __IPHONE_14_8 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 140800, .decimal);
pub const __IPHONE_15_0 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 150000, .decimal);
pub const __IPHONE_15_1 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 150100, .decimal);
pub const __IPHONE_15_2 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 150200, .decimal);
pub const __IPHONE_15_3 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 150300, .decimal);
pub const __IPHONE_15_4 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 150400, .decimal);
pub const __IPHONE_15_5 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 150500, .decimal);
pub const __IPHONE_15_6 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 150600, .decimal);
pub const __IPHONE_15_7 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 150700, .decimal);
pub const __IPHONE_15_8 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 150800, .decimal);
pub const __IPHONE_16_0 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 160000, .decimal);
pub const __IPHONE_16_1 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 160100, .decimal);
pub const __IPHONE_16_2 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 160200, .decimal);
pub const __IPHONE_16_3 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 160300, .decimal);
pub const __IPHONE_16_4 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 160400, .decimal);
pub const __IPHONE_16_5 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 160500, .decimal);
pub const __IPHONE_16_6 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 160600, .decimal);
pub const __IPHONE_16_7 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 160700, .decimal);
pub const __IPHONE_17_0 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 170000, .decimal);
pub const __IPHONE_17_1 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 170100, .decimal);
pub const __IPHONE_17_2 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 170200, .decimal);
pub const __IPHONE_17_3 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 170300, .decimal);
pub const __IPHONE_17_4 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 170400, .decimal);
pub const __IPHONE_17_5 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 170500, .decimal);
pub const __IPHONE_17_6 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 170600, .decimal);
pub const __IPHONE_17_7 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 170700, .decimal);
pub const __IPHONE_18_0 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 180000, .decimal);
pub const __IPHONE_18_1 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 180100, .decimal);
pub const __IPHONE_18_2 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 180200, .decimal);
pub const __IPHONE_18_3 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 180300, .decimal);
pub const __IPHONE_18_4 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 180400, .decimal);
pub const __IPHONE_18_5 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 180500, .decimal);
pub const __WATCHOS_1_0 = @as(c_int, 10000);
pub const __WATCHOS_2_0 = @as(c_int, 20000);
pub const __WATCHOS_2_1 = @as(c_int, 20100);
pub const __WATCHOS_2_2 = @as(c_int, 20200);
pub const __WATCHOS_3_0 = @as(c_int, 30000);
pub const __WATCHOS_3_1 = @as(c_int, 30100);
pub const __WATCHOS_3_1_1 = @as(c_int, 30101);
pub const __WATCHOS_3_2 = @as(c_int, 30200);
pub const __WATCHOS_4_0 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 40000, .decimal);
pub const __WATCHOS_4_1 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 40100, .decimal);
pub const __WATCHOS_4_2 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 40200, .decimal);
pub const __WATCHOS_4_3 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 40300, .decimal);
pub const __WATCHOS_5_0 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 50000, .decimal);
pub const __WATCHOS_5_1 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 50100, .decimal);
pub const __WATCHOS_5_2 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 50200, .decimal);
pub const __WATCHOS_5_3 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 50300, .decimal);
pub const __WATCHOS_6_0 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 60000, .decimal);
pub const __WATCHOS_6_1 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 60100, .decimal);
pub const __WATCHOS_6_2 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 60200, .decimal);
pub const __WATCHOS_7_0 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 70000, .decimal);
pub const __WATCHOS_7_1 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 70100, .decimal);
pub const __WATCHOS_7_2 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 70200, .decimal);
pub const __WATCHOS_7_3 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 70300, .decimal);
pub const __WATCHOS_7_4 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 70400, .decimal);
pub const __WATCHOS_7_5 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 70500, .decimal);
pub const __WATCHOS_7_6 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 70600, .decimal);
pub const __WATCHOS_8_0 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 80000, .decimal);
pub const __WATCHOS_8_1 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 80100, .decimal);
pub const __WATCHOS_8_3 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 80300, .decimal);
pub const __WATCHOS_8_4 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 80400, .decimal);
pub const __WATCHOS_8_5 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 80500, .decimal);
pub const __WATCHOS_8_6 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 80600, .decimal);
pub const __WATCHOS_8_7 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 80700, .decimal);
pub const __WATCHOS_8_8 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 80800, .decimal);
pub const __WATCHOS_9_0 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 90000, .decimal);
pub const __WATCHOS_9_1 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 90100, .decimal);
pub const __WATCHOS_9_2 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 90200, .decimal);
pub const __WATCHOS_9_3 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 90300, .decimal);
pub const __WATCHOS_9_4 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 90400, .decimal);
pub const __WATCHOS_9_5 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 90500, .decimal);
pub const __WATCHOS_9_6 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 90600, .decimal);
pub const __WATCHOS_10_0 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 100000, .decimal);
pub const __WATCHOS_10_1 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 100100, .decimal);
pub const __WATCHOS_10_2 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 100200, .decimal);
pub const __WATCHOS_10_3 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 100300, .decimal);
pub const __WATCHOS_10_4 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 100400, .decimal);
pub const __WATCHOS_10_5 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 100500, .decimal);
pub const __WATCHOS_10_6 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 100600, .decimal);
pub const __WATCHOS_10_7 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 100700, .decimal);
pub const __WATCHOS_11_0 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 110000, .decimal);
pub const __WATCHOS_11_1 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 110100, .decimal);
pub const __WATCHOS_11_2 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 110200, .decimal);
pub const __WATCHOS_11_3 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 110300, .decimal);
pub const __WATCHOS_11_4 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 110400, .decimal);
pub const __WATCHOS_11_5 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 110500, .decimal);
pub const __TVOS_9_0 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 90000, .decimal);
pub const __TVOS_9_1 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 90100, .decimal);
pub const __TVOS_9_2 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 90200, .decimal);
pub const __TVOS_10_0 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 100000, .decimal);
pub const __TVOS_10_0_1 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 100001, .decimal);
pub const __TVOS_10_1 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 100100, .decimal);
pub const __TVOS_10_2 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 100200, .decimal);
pub const __TVOS_11_0 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 110000, .decimal);
pub const __TVOS_11_1 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 110100, .decimal);
pub const __TVOS_11_2 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 110200, .decimal);
pub const __TVOS_11_3 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 110300, .decimal);
pub const __TVOS_11_4 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 110400, .decimal);
pub const __TVOS_12_0 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 120000, .decimal);
pub const __TVOS_12_1 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 120100, .decimal);
pub const __TVOS_12_2 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 120200, .decimal);
pub const __TVOS_12_3 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 120300, .decimal);
pub const __TVOS_12_4 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 120400, .decimal);
pub const __TVOS_13_0 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 130000, .decimal);
pub const __TVOS_13_2 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 130200, .decimal);
pub const __TVOS_13_3 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 130300, .decimal);
pub const __TVOS_13_4 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 130400, .decimal);
pub const __TVOS_14_0 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 140000, .decimal);
pub const __TVOS_14_1 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 140100, .decimal);
pub const __TVOS_14_2 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 140200, .decimal);
pub const __TVOS_14_3 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 140300, .decimal);
pub const __TVOS_14_5 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 140500, .decimal);
pub const __TVOS_14_6 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 140600, .decimal);
pub const __TVOS_14_7 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 140700, .decimal);
pub const __TVOS_15_0 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 150000, .decimal);
pub const __TVOS_15_1 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 150100, .decimal);
pub const __TVOS_15_2 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 150200, .decimal);
pub const __TVOS_15_3 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 150300, .decimal);
pub const __TVOS_15_4 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 150400, .decimal);
pub const __TVOS_15_5 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 150500, .decimal);
pub const __TVOS_15_6 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 150600, .decimal);
pub const __TVOS_16_0 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 160000, .decimal);
pub const __TVOS_16_1 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 160100, .decimal);
pub const __TVOS_16_2 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 160200, .decimal);
pub const __TVOS_16_3 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 160300, .decimal);
pub const __TVOS_16_4 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 160400, .decimal);
pub const __TVOS_16_5 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 160500, .decimal);
pub const __TVOS_16_6 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 160600, .decimal);
pub const __TVOS_17_0 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 170000, .decimal);
pub const __TVOS_17_1 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 170100, .decimal);
pub const __TVOS_17_2 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 170200, .decimal);
pub const __TVOS_17_3 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 170300, .decimal);
pub const __TVOS_17_4 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 170400, .decimal);
pub const __TVOS_17_5 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 170500, .decimal);
pub const __TVOS_17_6 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 170600, .decimal);
pub const __TVOS_18_0 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 180000, .decimal);
pub const __TVOS_18_1 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 180100, .decimal);
pub const __TVOS_18_2 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 180200, .decimal);
pub const __TVOS_18_3 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 180300, .decimal);
pub const __TVOS_18_4 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 180400, .decimal);
pub const __TVOS_18_5 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 180500, .decimal);
pub const __BRIDGEOS_2_0 = @as(c_int, 20000);
pub const __BRIDGEOS_3_0 = @as(c_int, 30000);
pub const __BRIDGEOS_3_1 = @as(c_int, 30100);
pub const __BRIDGEOS_3_4 = @as(c_int, 30400);
pub const __BRIDGEOS_4_0 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 40000, .decimal);
pub const __BRIDGEOS_4_1 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 40100, .decimal);
pub const __BRIDGEOS_5_0 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 50000, .decimal);
pub const __BRIDGEOS_5_1 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 50100, .decimal);
pub const __BRIDGEOS_5_3 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 50300, .decimal);
pub const __BRIDGEOS_6_0 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 60000, .decimal);
pub const __BRIDGEOS_6_2 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 60200, .decimal);
pub const __BRIDGEOS_6_4 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 60400, .decimal);
pub const __BRIDGEOS_6_5 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 60500, .decimal);
pub const __BRIDGEOS_6_6 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 60600, .decimal);
pub const __BRIDGEOS_7_0 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 70000, .decimal);
pub const __BRIDGEOS_7_1 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 70100, .decimal);
pub const __BRIDGEOS_7_2 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 70200, .decimal);
pub const __BRIDGEOS_7_3 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 70300, .decimal);
pub const __BRIDGEOS_7_4 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 70400, .decimal);
pub const __BRIDGEOS_7_6 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 70600, .decimal);
pub const __BRIDGEOS_8_0 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 80000, .decimal);
pub const __BRIDGEOS_8_1 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 80100, .decimal);
pub const __BRIDGEOS_8_2 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 80200, .decimal);
pub const __BRIDGEOS_8_3 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 80300, .decimal);
pub const __BRIDGEOS_8_4 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 80400, .decimal);
pub const __BRIDGEOS_8_5 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 80500, .decimal);
pub const __BRIDGEOS_8_6 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 80600, .decimal);
pub const __BRIDGEOS_9_0 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 90000, .decimal);
pub const __BRIDGEOS_9_1 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 90100, .decimal);
pub const __BRIDGEOS_9_2 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 90200, .decimal);
pub const __BRIDGEOS_9_3 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 90300, .decimal);
pub const __BRIDGEOS_9_4 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 90400, .decimal);
pub const __BRIDGEOS_9_5 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 90500, .decimal);
pub const __DRIVERKIT_19_0 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 190000, .decimal);
pub const __DRIVERKIT_20_0 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 200000, .decimal);
pub const __DRIVERKIT_21_0 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 210000, .decimal);
pub const __DRIVERKIT_22_0 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 220000, .decimal);
pub const __DRIVERKIT_22_4 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 220400, .decimal);
pub const __DRIVERKIT_22_5 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 220500, .decimal);
pub const __DRIVERKIT_22_6 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 220600, .decimal);
pub const __DRIVERKIT_23_0 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 230000, .decimal);
pub const __DRIVERKIT_23_1 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 230100, .decimal);
pub const __DRIVERKIT_23_2 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 230200, .decimal);
pub const __DRIVERKIT_23_3 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 230300, .decimal);
pub const __DRIVERKIT_23_4 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 230400, .decimal);
pub const __DRIVERKIT_23_5 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 230500, .decimal);
pub const __DRIVERKIT_23_6 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 230600, .decimal);
pub const __DRIVERKIT_24_0 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 240000, .decimal);
pub const __DRIVERKIT_24_1 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 240100, .decimal);
pub const __DRIVERKIT_24_2 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 240200, .decimal);
pub const __DRIVERKIT_24_3 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 240300, .decimal);
pub const __DRIVERKIT_24_4 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 240400, .decimal);
pub const __DRIVERKIT_24_5 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 240500, .decimal);
pub const __VISIONOS_1_0 = @as(c_int, 10000);
pub const __VISIONOS_1_1 = @as(c_int, 10100);
pub const __VISIONOS_1_2 = @as(c_int, 10200);
pub const __VISIONOS_1_3 = @as(c_int, 10300);
pub const __VISIONOS_2_0 = @as(c_int, 20000);
pub const __VISIONOS_2_1 = @as(c_int, 20100);
pub const __VISIONOS_2_2 = @as(c_int, 20200);
pub const __VISIONOS_2_3 = @as(c_int, 20300);
pub const __VISIONOS_2_4 = @as(c_int, 20400);
pub const __VISIONOS_2_5 = @as(c_int, 20500);
pub const MAC_OS_X_VERSION_10_0 = __MAC_10_0;
pub const MAC_OS_X_VERSION_10_1 = __MAC_10_1;
pub const MAC_OS_X_VERSION_10_2 = __MAC_10_2;
pub const MAC_OS_X_VERSION_10_3 = __MAC_10_3;
pub const MAC_OS_X_VERSION_10_4 = __MAC_10_4;
pub const MAC_OS_X_VERSION_10_5 = __MAC_10_5;
pub const MAC_OS_X_VERSION_10_6 = __MAC_10_6;
pub const MAC_OS_X_VERSION_10_7 = __MAC_10_7;
pub const MAC_OS_X_VERSION_10_8 = __MAC_10_8;
pub const MAC_OS_X_VERSION_10_9 = __MAC_10_9;
pub const MAC_OS_X_VERSION_10_10 = __MAC_10_10;
pub const MAC_OS_X_VERSION_10_10_2 = __MAC_10_10_2;
pub const MAC_OS_X_VERSION_10_10_3 = __MAC_10_10_3;
pub const MAC_OS_X_VERSION_10_11 = __MAC_10_11;
pub const MAC_OS_X_VERSION_10_11_2 = __MAC_10_11_2;
pub const MAC_OS_X_VERSION_10_11_3 = __MAC_10_11_3;
pub const MAC_OS_X_VERSION_10_11_4 = __MAC_10_11_4;
pub const MAC_OS_X_VERSION_10_12 = __MAC_10_12;
pub const MAC_OS_X_VERSION_10_12_1 = __MAC_10_12_1;
pub const MAC_OS_X_VERSION_10_12_2 = __MAC_10_12_2;
pub const MAC_OS_X_VERSION_10_12_4 = __MAC_10_12_4;
pub const MAC_OS_X_VERSION_10_13 = __MAC_10_13;
pub const MAC_OS_X_VERSION_10_13_1 = __MAC_10_13_1;
pub const MAC_OS_X_VERSION_10_13_2 = __MAC_10_13_2;
pub const MAC_OS_X_VERSION_10_13_4 = __MAC_10_13_4;
pub const MAC_OS_X_VERSION_10_14 = __MAC_10_14;
pub const MAC_OS_X_VERSION_10_14_1 = __MAC_10_14_1;
pub const MAC_OS_X_VERSION_10_14_4 = __MAC_10_14_4;
pub const MAC_OS_X_VERSION_10_14_5 = __MAC_10_14_5;
pub const MAC_OS_X_VERSION_10_14_6 = __MAC_10_14_6;
pub const MAC_OS_X_VERSION_10_15 = __MAC_10_15;
pub const MAC_OS_X_VERSION_10_15_1 = __MAC_10_15_1;
pub const MAC_OS_X_VERSION_10_15_4 = __MAC_10_15_4;
pub const MAC_OS_X_VERSION_10_16 = __MAC_10_16;
pub const MAC_OS_VERSION_11_0 = __MAC_11_0;
pub const MAC_OS_VERSION_11_1 = __MAC_11_1;
pub const MAC_OS_VERSION_11_3 = __MAC_11_3;
pub const MAC_OS_VERSION_11_4 = __MAC_11_4;
pub const MAC_OS_VERSION_11_5 = __MAC_11_5;
pub const MAC_OS_VERSION_11_6 = __MAC_11_6;
pub const MAC_OS_VERSION_12_0 = __MAC_12_0;
pub const MAC_OS_VERSION_12_1 = __MAC_12_1;
pub const MAC_OS_VERSION_12_2 = __MAC_12_2;
pub const MAC_OS_VERSION_12_3 = __MAC_12_3;
pub const MAC_OS_VERSION_12_4 = __MAC_12_4;
pub const MAC_OS_VERSION_12_5 = __MAC_12_5;
pub const MAC_OS_VERSION_12_6 = __MAC_12_6;
pub const MAC_OS_VERSION_12_7 = __MAC_12_7;
pub const MAC_OS_VERSION_13_0 = __MAC_13_0;
pub const MAC_OS_VERSION_13_1 = __MAC_13_1;
pub const MAC_OS_VERSION_13_2 = __MAC_13_2;
pub const MAC_OS_VERSION_13_3 = __MAC_13_3;
pub const MAC_OS_VERSION_13_4 = __MAC_13_4;
pub const MAC_OS_VERSION_13_5 = __MAC_13_5;
pub const MAC_OS_VERSION_13_6 = __MAC_13_6;
pub const MAC_OS_VERSION_13_7 = __MAC_13_7;
pub const MAC_OS_VERSION_14_0 = __MAC_14_0;
pub const MAC_OS_VERSION_14_1 = __MAC_14_1;
pub const MAC_OS_VERSION_14_2 = __MAC_14_2;
pub const MAC_OS_VERSION_14_3 = __MAC_14_3;
pub const MAC_OS_VERSION_14_4 = __MAC_14_4;
pub const MAC_OS_VERSION_14_5 = __MAC_14_5;
pub const MAC_OS_VERSION_14_6 = __MAC_14_6;
pub const MAC_OS_VERSION_14_7 = __MAC_14_7;
pub const MAC_OS_VERSION_15_0 = __MAC_15_0;
pub const MAC_OS_VERSION_15_1 = __MAC_15_1;
pub const MAC_OS_VERSION_15_2 = __MAC_15_2;
pub const MAC_OS_VERSION_15_3 = __MAC_15_3;
pub const MAC_OS_VERSION_15_4 = __MAC_15_4;
pub const MAC_OS_VERSION_15_5 = __MAC_15_5;
pub const __AVAILABILITY_VERSIONS_VERSION_HASH = @import("std").zig.c_translation.promoteIntLiteral(c_uint, 93585900, .decimal);
pub const __AVAILABILITY_VERSIONS_VERSION_STRING = "Local";
pub const __AVAILABILITY_FILE = "AvailabilityVersions.h";
pub const __AVAILABILITY_INTERNAL__ = "";
pub const __AVAILABILITY_INTERNAL_DEPRECATED = @compileError("unable to translate macro: undefined identifier `deprecated`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/AvailabilityInternal.h:130:9
pub const __AVAILABILITY_INTERNAL_DEPRECATED_MSG = @compileError("unable to translate macro: undefined identifier `deprecated`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/AvailabilityInternal.h:133:17
pub const __AVAILABILITY_INTERNAL_UNAVAILABLE = @compileError("unable to translate macro: undefined identifier `unavailable`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/AvailabilityInternal.h:142:9
pub const __AVAILABILITY_INTERNAL_WEAK_IMPORT = @compileError("unable to translate macro: undefined identifier `weak_import`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/AvailabilityInternal.h:143:9
pub const __AVAILABILITY_INTERNAL_REGULAR = "";
pub const __API_AVAILABLE_PLATFORM_macos = @compileError("unable to translate macro: undefined identifier `macos`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/AvailabilityInternal.h:148:12
pub const __API_DEPRECATED_PLATFORM_macos = @compileError("unable to translate macro: undefined identifier `macos`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/AvailabilityInternal.h:149:12
pub const __API_OBSOLETED_PLATFORM_macos = @compileError("unable to translate macro: undefined identifier `macos`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/AvailabilityInternal.h:150:12
pub const __API_UNAVAILABLE_PLATFORM_macos = @compileError("unable to translate macro: undefined identifier `macos`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/AvailabilityInternal.h:151:12
pub const __API_AVAILABLE_PLATFORM_macosx = @compileError("unable to translate macro: undefined identifier `macos`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/AvailabilityInternal.h:152:12
pub const __API_DEPRECATED_PLATFORM_macosx = @compileError("unable to translate macro: undefined identifier `macos`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/AvailabilityInternal.h:153:12
pub const __API_OBSOLETED_PLATFORM_macosx = @compileError("unable to translate macro: undefined identifier `macos`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/AvailabilityInternal.h:154:12
pub const __API_UNAVAILABLE_PLATFORM_macosx = @compileError("unable to translate macro: undefined identifier `macos`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/AvailabilityInternal.h:155:12
pub const __API_AVAILABLE_PLATFORM_macOSApplicationExtension = @compileError("unable to translate macro: undefined identifier `macOSApplicationExtension`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/AvailabilityInternal.h:156:12
pub const __API_DEPRECATED_PLATFORM_macOSApplicationExtension = @compileError("unable to translate macro: undefined identifier `macOSApplicationExtension`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/AvailabilityInternal.h:157:12
pub const __API_OBSOLETED_PLATFORM_macOSApplicationExtension = @compileError("unable to translate macro: undefined identifier `macOSApplicationExtension`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/AvailabilityInternal.h:158:12
pub const __API_UNAVAILABLE_PLATFORM_macOSApplicationExtension = @compileError("unable to translate macro: undefined identifier `macOSApplicationExtension`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/AvailabilityInternal.h:159:12
pub const __API_AVAILABLE_PLATFORM_ios = @compileError("unable to translate macro: undefined identifier `ios`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/AvailabilityInternal.h:160:12
pub const __API_DEPRECATED_PLATFORM_ios = @compileError("unable to translate macro: undefined identifier `ios`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/AvailabilityInternal.h:161:12
pub const __API_OBSOLETED_PLATFORM_ios = @compileError("unable to translate macro: undefined identifier `ios`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/AvailabilityInternal.h:162:12
pub const __API_UNAVAILABLE_PLATFORM_ios = @compileError("unable to translate macro: undefined identifier `ios`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/AvailabilityInternal.h:163:12
pub const __API_AVAILABLE_PLATFORM_iOSApplicationExtension = @compileError("unable to translate macro: undefined identifier `iOSApplicationExtension`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/AvailabilityInternal.h:164:12
pub const __API_DEPRECATED_PLATFORM_iOSApplicationExtension = @compileError("unable to translate macro: undefined identifier `iOSApplicationExtension`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/AvailabilityInternal.h:165:12
pub const __API_OBSOLETED_PLATFORM_iOSApplicationExtension = @compileError("unable to translate macro: undefined identifier `iOSApplicationExtension`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/AvailabilityInternal.h:166:12
pub const __API_UNAVAILABLE_PLATFORM_iOSApplicationExtension = @compileError("unable to translate macro: undefined identifier `iOSApplicationExtension`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/AvailabilityInternal.h:167:12
pub const __API_AVAILABLE_PLATFORM_macCatalyst = @compileError("unable to translate macro: undefined identifier `macCatalyst`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/AvailabilityInternal.h:168:12
pub const __API_DEPRECATED_PLATFORM_macCatalyst = @compileError("unable to translate macro: undefined identifier `macCatalyst`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/AvailabilityInternal.h:169:12
pub const __API_OBSOLETED_PLATFORM_macCatalyst = @compileError("unable to translate macro: undefined identifier `macCatalyst`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/AvailabilityInternal.h:170:12
pub const __API_UNAVAILABLE_PLATFORM_macCatalyst = @compileError("unable to translate macro: undefined identifier `macCatalyst`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/AvailabilityInternal.h:171:12
pub const __API_AVAILABLE_PLATFORM_macCatalystApplicationExtension = @compileError("unable to translate macro: undefined identifier `macCatalystApplicationExtension`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/AvailabilityInternal.h:172:12
pub const __API_DEPRECATED_PLATFORM_macCatalystApplicationExtension = @compileError("unable to translate macro: undefined identifier `macCatalystApplicationExtension`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/AvailabilityInternal.h:173:12
pub const __API_OBSOLETED_PLATFORM_macCatalystApplicationExtension = @compileError("unable to translate macro: undefined identifier `macCatalystApplicationExtension`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/AvailabilityInternal.h:174:12
pub const __API_UNAVAILABLE_PLATFORM_macCatalystApplicationExtension = @compileError("unable to translate macro: undefined identifier `macCatalystApplicationExtension`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/AvailabilityInternal.h:175:12
pub const __API_AVAILABLE_PLATFORM_watchos = @compileError("unable to translate macro: undefined identifier `watchos`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/AvailabilityInternal.h:176:12
pub const __API_DEPRECATED_PLATFORM_watchos = @compileError("unable to translate macro: undefined identifier `watchos`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/AvailabilityInternal.h:177:12
pub const __API_OBSOLETED_PLATFORM_watchos = @compileError("unable to translate macro: undefined identifier `watchos`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/AvailabilityInternal.h:178:12
pub const __API_UNAVAILABLE_PLATFORM_watchos = @compileError("unable to translate macro: undefined identifier `watchos`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/AvailabilityInternal.h:179:12
pub const __API_AVAILABLE_PLATFORM_watchOSApplicationExtension = @compileError("unable to translate macro: undefined identifier `watchOSApplicationExtension`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/AvailabilityInternal.h:180:12
pub const __API_DEPRECATED_PLATFORM_watchOSApplicationExtension = @compileError("unable to translate macro: undefined identifier `watchOSApplicationExtension`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/AvailabilityInternal.h:181:12
pub const __API_OBSOLETED_PLATFORM_watchOSApplicationExtension = @compileError("unable to translate macro: undefined identifier `watchOSApplicationExtension`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/AvailabilityInternal.h:182:12
pub const __API_UNAVAILABLE_PLATFORM_watchOSApplicationExtension = @compileError("unable to translate macro: undefined identifier `watchOSApplicationExtension`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/AvailabilityInternal.h:183:12
pub const __API_AVAILABLE_PLATFORM_tvos = @compileError("unable to translate macro: undefined identifier `tvos`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/AvailabilityInternal.h:184:12
pub const __API_DEPRECATED_PLATFORM_tvos = @compileError("unable to translate macro: undefined identifier `tvos`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/AvailabilityInternal.h:185:12
pub const __API_OBSOLETED_PLATFORM_tvos = @compileError("unable to translate macro: undefined identifier `tvos`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/AvailabilityInternal.h:186:12
pub const __API_UNAVAILABLE_PLATFORM_tvos = @compileError("unable to translate macro: undefined identifier `tvos`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/AvailabilityInternal.h:187:12
pub const __API_AVAILABLE_PLATFORM_tvOSApplicationExtension = @compileError("unable to translate macro: undefined identifier `tvOSApplicationExtension`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/AvailabilityInternal.h:188:12
pub const __API_DEPRECATED_PLATFORM_tvOSApplicationExtension = @compileError("unable to translate macro: undefined identifier `tvOSApplicationExtension`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/AvailabilityInternal.h:189:12
pub const __API_OBSOLETED_PLATFORM_tvOSApplicationExtension = @compileError("unable to translate macro: undefined identifier `tvOSApplicationExtension`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/AvailabilityInternal.h:190:12
pub const __API_UNAVAILABLE_PLATFORM_tvOSApplicationExtension = @compileError("unable to translate macro: undefined identifier `tvOSApplicationExtension`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/AvailabilityInternal.h:191:12
pub const __API_AVAILABLE_PLATFORM_driverkit = @compileError("unable to translate macro: undefined identifier `driverkit`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/AvailabilityInternal.h:193:12
pub const __API_DEPRECATED_PLATFORM_driverkit = @compileError("unable to translate macro: undefined identifier `driverkit`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/AvailabilityInternal.h:194:12
pub const __API_OBSOLETED_PLATFORM_driverkit = @compileError("unable to translate macro: undefined identifier `driverkit`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/AvailabilityInternal.h:195:12
pub const __API_UNAVAILABLE_PLATFORM_driverkit = @compileError("unable to translate macro: undefined identifier `driverkit`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/AvailabilityInternal.h:196:12
pub const __API_AVAILABLE_PLATFORM_visionos = @compileError("unable to translate macro: undefined identifier `visionos`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/AvailabilityInternal.h:197:12
pub const __API_DEPRECATED_PLATFORM_visionos = @compileError("unable to translate macro: undefined identifier `visionos`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/AvailabilityInternal.h:198:12
pub const __API_OBSOLETED_PLATFORM_visionos = @compileError("unable to translate macro: undefined identifier `visionos`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/AvailabilityInternal.h:199:12
pub const __API_UNAVAILABLE_PLATFORM_visionos = @compileError("unable to translate macro: undefined identifier `visionos`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/AvailabilityInternal.h:200:12
pub const __API_AVAILABLE_PLATFORM_visionOSApplicationExtension = @compileError("unable to translate macro: undefined identifier `visionOSApplicationExtension`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/AvailabilityInternal.h:201:12
pub const __API_DEPRECATED_PLATFORM_visionOSApplicationExtension = @compileError("unable to translate macro: undefined identifier `visionOSApplicationExtension`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/AvailabilityInternal.h:202:12
pub const __API_OBSOLETED_PLATFORM_visionOSApplicationExtension = @compileError("unable to translate macro: undefined identifier `visionOSApplicationExtension`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/AvailabilityInternal.h:203:12
pub const __API_UNAVAILABLE_PLATFORM_visionOSApplicationExtension = @compileError("unable to translate macro: undefined identifier `visionOSApplicationExtension`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/AvailabilityInternal.h:204:12
pub const __API_UNAVAILABLE_PLATFORM_kernelkit = @compileError("unable to translate macro: undefined identifier `kernelkit`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/AvailabilityInternal.h:206:12
pub const __API_APPLY_TO = @compileError("unable to translate macro: undefined identifier `any`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/AvailabilityInternal.h:216:11
pub inline fn __API_RANGE_STRINGIFY(x: anytype) @TypeOf(__API_RANGE_STRINGIFY2(x)) {
    _ = &x;
    return __API_RANGE_STRINGIFY2(x);
}
pub const __API_RANGE_STRINGIFY2 = @compileError("unable to translate C expr: unexpected token '#'");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/AvailabilityInternal.h:218:11
pub const __API_A = @compileError("unable to translate macro: undefined identifier `availability`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/AvailabilityInternal.h:232:13
pub inline fn __API_AVAILABLE0(arg0: anytype) @TypeOf(__API_A(arg0)) {
    _ = &arg0;
    return __API_A(arg0);
}
pub inline fn __API_AVAILABLE1(arg0: anytype, arg1: anytype) @TypeOf(__API_A(arg0) ++ __API_A(arg1)) {
    _ = &arg0;
    _ = &arg1;
    return __API_A(arg0) ++ __API_A(arg1);
}
pub inline fn __API_AVAILABLE2(arg0: anytype, arg1: anytype, arg2: anytype) @TypeOf(__API_A(arg0) ++ __API_A(arg1) ++ __API_A(arg2)) {
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    return __API_A(arg0) ++ __API_A(arg1) ++ __API_A(arg2);
}
pub inline fn __API_AVAILABLE3(arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype) @TypeOf(__API_A(arg0) ++ __API_A(arg1) ++ __API_A(arg2) ++ __API_A(arg3)) {
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    return __API_A(arg0) ++ __API_A(arg1) ++ __API_A(arg2) ++ __API_A(arg3);
}
pub inline fn __API_AVAILABLE4(arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype) @TypeOf(__API_A(arg0) ++ __API_A(arg1) ++ __API_A(arg2) ++ __API_A(arg3) ++ __API_A(arg4)) {
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    return __API_A(arg0) ++ __API_A(arg1) ++ __API_A(arg2) ++ __API_A(arg3) ++ __API_A(arg4);
}
pub inline fn __API_AVAILABLE5(arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype) @TypeOf(__API_A(arg0) ++ __API_A(arg1) ++ __API_A(arg2) ++ __API_A(arg3) ++ __API_A(arg4) ++ __API_A(arg5)) {
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    return __API_A(arg0) ++ __API_A(arg1) ++ __API_A(arg2) ++ __API_A(arg3) ++ __API_A(arg4) ++ __API_A(arg5);
}
pub inline fn __API_AVAILABLE6(arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype) @TypeOf(__API_A(arg0) ++ __API_A(arg1) ++ __API_A(arg2) ++ __API_A(arg3) ++ __API_A(arg4) ++ __API_A(arg5) ++ __API_A(arg6)) {
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    return __API_A(arg0) ++ __API_A(arg1) ++ __API_A(arg2) ++ __API_A(arg3) ++ __API_A(arg4) ++ __API_A(arg5) ++ __API_A(arg6);
}
pub inline fn __API_AVAILABLE7(arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype) @TypeOf(__API_A(arg0) ++ __API_A(arg1) ++ __API_A(arg2) ++ __API_A(arg3) ++ __API_A(arg4) ++ __API_A(arg5) ++ __API_A(arg6) ++ __API_A(arg7)) {
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    return __API_A(arg0) ++ __API_A(arg1) ++ __API_A(arg2) ++ __API_A(arg3) ++ __API_A(arg4) ++ __API_A(arg5) ++ __API_A(arg6) ++ __API_A(arg7);
}
pub inline fn __API_AVAILABLE8(arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype) @TypeOf(__API_A(arg0) ++ __API_A(arg1) ++ __API_A(arg2) ++ __API_A(arg3) ++ __API_A(arg4) ++ __API_A(arg5) ++ __API_A(arg6) ++ __API_A(arg7) ++ __API_A(arg8)) {
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    return __API_A(arg0) ++ __API_A(arg1) ++ __API_A(arg2) ++ __API_A(arg3) ++ __API_A(arg4) ++ __API_A(arg5) ++ __API_A(arg6) ++ __API_A(arg7) ++ __API_A(arg8);
}
pub inline fn __API_AVAILABLE9(arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype) @TypeOf(__API_A(arg0) ++ __API_A(arg1) ++ __API_A(arg2) ++ __API_A(arg3) ++ __API_A(arg4) ++ __API_A(arg5) ++ __API_A(arg6) ++ __API_A(arg7) ++ __API_A(arg8) ++ __API_A(arg9)) {
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    return __API_A(arg0) ++ __API_A(arg1) ++ __API_A(arg2) ++ __API_A(arg3) ++ __API_A(arg4) ++ __API_A(arg5) ++ __API_A(arg6) ++ __API_A(arg7) ++ __API_A(arg8) ++ __API_A(arg9);
}
pub inline fn __API_AVAILABLE10(arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype, arg10: anytype) @TypeOf(__API_A(arg0) ++ __API_A(arg1) ++ __API_A(arg2) ++ __API_A(arg3) ++ __API_A(arg4) ++ __API_A(arg5) ++ __API_A(arg6) ++ __API_A(arg7) ++ __API_A(arg8) ++ __API_A(arg9) ++ __API_A(arg10)) {
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    _ = &arg10;
    return __API_A(arg0) ++ __API_A(arg1) ++ __API_A(arg2) ++ __API_A(arg3) ++ __API_A(arg4) ++ __API_A(arg5) ++ __API_A(arg6) ++ __API_A(arg7) ++ __API_A(arg8) ++ __API_A(arg9) ++ __API_A(arg10);
}
pub inline fn __API_AVAILABLE11(arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype, arg10: anytype, arg11: anytype) @TypeOf(__API_A(arg0) ++ __API_A(arg1) ++ __API_A(arg2) ++ __API_A(arg3) ++ __API_A(arg4) ++ __API_A(arg5) ++ __API_A(arg6) ++ __API_A(arg7) ++ __API_A(arg8) ++ __API_A(arg9) ++ __API_A(arg10) ++ __API_A(arg11)) {
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    _ = &arg10;
    _ = &arg11;
    return __API_A(arg0) ++ __API_A(arg1) ++ __API_A(arg2) ++ __API_A(arg3) ++ __API_A(arg4) ++ __API_A(arg5) ++ __API_A(arg6) ++ __API_A(arg7) ++ __API_A(arg8) ++ __API_A(arg9) ++ __API_A(arg10) ++ __API_A(arg11);
}
pub inline fn __API_AVAILABLE12(arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype, arg10: anytype, arg11: anytype, arg12: anytype) @TypeOf(__API_A(arg0) ++ __API_A(arg1) ++ __API_A(arg2) ++ __API_A(arg3) ++ __API_A(arg4) ++ __API_A(arg5) ++ __API_A(arg6) ++ __API_A(arg7) ++ __API_A(arg8) ++ __API_A(arg9) ++ __API_A(arg10) ++ __API_A(arg11) ++ __API_A(arg12)) {
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    _ = &arg10;
    _ = &arg11;
    _ = &arg12;
    return __API_A(arg0) ++ __API_A(arg1) ++ __API_A(arg2) ++ __API_A(arg3) ++ __API_A(arg4) ++ __API_A(arg5) ++ __API_A(arg6) ++ __API_A(arg7) ++ __API_A(arg8) ++ __API_A(arg9) ++ __API_A(arg10) ++ __API_A(arg11) ++ __API_A(arg12);
}
pub inline fn __API_AVAILABLE13(arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype, arg10: anytype, arg11: anytype, arg12: anytype, arg13: anytype) @TypeOf(__API_A(arg0) ++ __API_A(arg1) ++ __API_A(arg2) ++ __API_A(arg3) ++ __API_A(arg4) ++ __API_A(arg5) ++ __API_A(arg6) ++ __API_A(arg7) ++ __API_A(arg8) ++ __API_A(arg9) ++ __API_A(arg10) ++ __API_A(arg11) ++ __API_A(arg12) ++ __API_A(arg13)) {
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    _ = &arg10;
    _ = &arg11;
    _ = &arg12;
    _ = &arg13;
    return __API_A(arg0) ++ __API_A(arg1) ++ __API_A(arg2) ++ __API_A(arg3) ++ __API_A(arg4) ++ __API_A(arg5) ++ __API_A(arg6) ++ __API_A(arg7) ++ __API_A(arg8) ++ __API_A(arg9) ++ __API_A(arg10) ++ __API_A(arg11) ++ __API_A(arg12) ++ __API_A(arg13);
}
pub inline fn __API_AVAILABLE14(arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype, arg10: anytype, arg11: anytype, arg12: anytype, arg13: anytype, arg14: anytype) @TypeOf(__API_A(arg0) ++ __API_A(arg1) ++ __API_A(arg2) ++ __API_A(arg3) ++ __API_A(arg4) ++ __API_A(arg5) ++ __API_A(arg6) ++ __API_A(arg7) ++ __API_A(arg8) ++ __API_A(arg9) ++ __API_A(arg10) ++ __API_A(arg11) ++ __API_A(arg12) ++ __API_A(arg13) ++ __API_A(arg14)) {
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    _ = &arg10;
    _ = &arg11;
    _ = &arg12;
    _ = &arg13;
    _ = &arg14;
    return __API_A(arg0) ++ __API_A(arg1) ++ __API_A(arg2) ++ __API_A(arg3) ++ __API_A(arg4) ++ __API_A(arg5) ++ __API_A(arg6) ++ __API_A(arg7) ++ __API_A(arg8) ++ __API_A(arg9) ++ __API_A(arg10) ++ __API_A(arg11) ++ __API_A(arg12) ++ __API_A(arg13) ++ __API_A(arg14);
}
pub inline fn __API_AVAILABLE15(arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype, arg10: anytype, arg11: anytype, arg12: anytype, arg13: anytype, arg14: anytype, arg15: anytype) @TypeOf(__API_A(arg0) ++ __API_A(arg1) ++ __API_A(arg2) ++ __API_A(arg3) ++ __API_A(arg4) ++ __API_A(arg5) ++ __API_A(arg6) ++ __API_A(arg7) ++ __API_A(arg8) ++ __API_A(arg9) ++ __API_A(arg10) ++ __API_A(arg11) ++ __API_A(arg12) ++ __API_A(arg13) ++ __API_A(arg14) ++ __API_A(arg15)) {
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    _ = &arg10;
    _ = &arg11;
    _ = &arg12;
    _ = &arg13;
    _ = &arg14;
    _ = &arg15;
    return __API_A(arg0) ++ __API_A(arg1) ++ __API_A(arg2) ++ __API_A(arg3) ++ __API_A(arg4) ++ __API_A(arg5) ++ __API_A(arg6) ++ __API_A(arg7) ++ __API_A(arg8) ++ __API_A(arg9) ++ __API_A(arg10) ++ __API_A(arg11) ++ __API_A(arg12) ++ __API_A(arg13) ++ __API_A(arg14) ++ __API_A(arg15);
}
pub const __API_AVAILABLE_GET_MACRO_93585900 = @compileError("unable to translate C expr: expected ')' instead got '...'");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/AvailabilityInternal.h:250:13
pub const __API_A_BEGIN = @compileError("unable to translate macro: undefined identifier `_Pragma`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/AvailabilityInternal.h:252:13
pub inline fn __API_AVAILABLE_BEGIN0(arg0: anytype) @TypeOf(__API_A_BEGIN(arg0)) {
    _ = &arg0;
    return __API_A_BEGIN(arg0);
}
pub inline fn __API_AVAILABLE_BEGIN1(arg0: anytype, arg1: anytype) @TypeOf(__API_A_BEGIN(arg0) ++ __API_A_BEGIN(arg1)) {
    _ = &arg0;
    _ = &arg1;
    return __API_A_BEGIN(arg0) ++ __API_A_BEGIN(arg1);
}
pub inline fn __API_AVAILABLE_BEGIN2(arg0: anytype, arg1: anytype, arg2: anytype) @TypeOf(__API_A_BEGIN(arg0) ++ __API_A_BEGIN(arg1) ++ __API_A_BEGIN(arg2)) {
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    return __API_A_BEGIN(arg0) ++ __API_A_BEGIN(arg1) ++ __API_A_BEGIN(arg2);
}
pub inline fn __API_AVAILABLE_BEGIN3(arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype) @TypeOf(__API_A_BEGIN(arg0) ++ __API_A_BEGIN(arg1) ++ __API_A_BEGIN(arg2) ++ __API_A_BEGIN(arg3)) {
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    return __API_A_BEGIN(arg0) ++ __API_A_BEGIN(arg1) ++ __API_A_BEGIN(arg2) ++ __API_A_BEGIN(arg3);
}
pub inline fn __API_AVAILABLE_BEGIN4(arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype) @TypeOf(__API_A_BEGIN(arg0) ++ __API_A_BEGIN(arg1) ++ __API_A_BEGIN(arg2) ++ __API_A_BEGIN(arg3) ++ __API_A_BEGIN(arg4)) {
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    return __API_A_BEGIN(arg0) ++ __API_A_BEGIN(arg1) ++ __API_A_BEGIN(arg2) ++ __API_A_BEGIN(arg3) ++ __API_A_BEGIN(arg4);
}
pub inline fn __API_AVAILABLE_BEGIN5(arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype) @TypeOf(__API_A_BEGIN(arg0) ++ __API_A_BEGIN(arg1) ++ __API_A_BEGIN(arg2) ++ __API_A_BEGIN(arg3) ++ __API_A_BEGIN(arg4) ++ __API_A_BEGIN(arg5)) {
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    return __API_A_BEGIN(arg0) ++ __API_A_BEGIN(arg1) ++ __API_A_BEGIN(arg2) ++ __API_A_BEGIN(arg3) ++ __API_A_BEGIN(arg4) ++ __API_A_BEGIN(arg5);
}
pub inline fn __API_AVAILABLE_BEGIN6(arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype) @TypeOf(__API_A_BEGIN(arg0) ++ __API_A_BEGIN(arg1) ++ __API_A_BEGIN(arg2) ++ __API_A_BEGIN(arg3) ++ __API_A_BEGIN(arg4) ++ __API_A_BEGIN(arg5) ++ __API_A_BEGIN(arg6)) {
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    return __API_A_BEGIN(arg0) ++ __API_A_BEGIN(arg1) ++ __API_A_BEGIN(arg2) ++ __API_A_BEGIN(arg3) ++ __API_A_BEGIN(arg4) ++ __API_A_BEGIN(arg5) ++ __API_A_BEGIN(arg6);
}
pub inline fn __API_AVAILABLE_BEGIN7(arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype) @TypeOf(__API_A_BEGIN(arg0) ++ __API_A_BEGIN(arg1) ++ __API_A_BEGIN(arg2) ++ __API_A_BEGIN(arg3) ++ __API_A_BEGIN(arg4) ++ __API_A_BEGIN(arg5) ++ __API_A_BEGIN(arg6) ++ __API_A_BEGIN(arg7)) {
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    return __API_A_BEGIN(arg0) ++ __API_A_BEGIN(arg1) ++ __API_A_BEGIN(arg2) ++ __API_A_BEGIN(arg3) ++ __API_A_BEGIN(arg4) ++ __API_A_BEGIN(arg5) ++ __API_A_BEGIN(arg6) ++ __API_A_BEGIN(arg7);
}
pub inline fn __API_AVAILABLE_BEGIN8(arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype) @TypeOf(__API_A_BEGIN(arg0) ++ __API_A_BEGIN(arg1) ++ __API_A_BEGIN(arg2) ++ __API_A_BEGIN(arg3) ++ __API_A_BEGIN(arg4) ++ __API_A_BEGIN(arg5) ++ __API_A_BEGIN(arg6) ++ __API_A_BEGIN(arg7) ++ __API_A_BEGIN(arg8)) {
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    return __API_A_BEGIN(arg0) ++ __API_A_BEGIN(arg1) ++ __API_A_BEGIN(arg2) ++ __API_A_BEGIN(arg3) ++ __API_A_BEGIN(arg4) ++ __API_A_BEGIN(arg5) ++ __API_A_BEGIN(arg6) ++ __API_A_BEGIN(arg7) ++ __API_A_BEGIN(arg8);
}
pub inline fn __API_AVAILABLE_BEGIN9(arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype) @TypeOf(__API_A_BEGIN(arg0) ++ __API_A_BEGIN(arg1) ++ __API_A_BEGIN(arg2) ++ __API_A_BEGIN(arg3) ++ __API_A_BEGIN(arg4) ++ __API_A_BEGIN(arg5) ++ __API_A_BEGIN(arg6) ++ __API_A_BEGIN(arg7) ++ __API_A_BEGIN(arg8) ++ __API_A_BEGIN(arg9)) {
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    return __API_A_BEGIN(arg0) ++ __API_A_BEGIN(arg1) ++ __API_A_BEGIN(arg2) ++ __API_A_BEGIN(arg3) ++ __API_A_BEGIN(arg4) ++ __API_A_BEGIN(arg5) ++ __API_A_BEGIN(arg6) ++ __API_A_BEGIN(arg7) ++ __API_A_BEGIN(arg8) ++ __API_A_BEGIN(arg9);
}
pub inline fn __API_AVAILABLE_BEGIN10(arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype, arg10: anytype) @TypeOf(__API_A_BEGIN(arg0) ++ __API_A_BEGIN(arg1) ++ __API_A_BEGIN(arg2) ++ __API_A_BEGIN(arg3) ++ __API_A_BEGIN(arg4) ++ __API_A_BEGIN(arg5) ++ __API_A_BEGIN(arg6) ++ __API_A_BEGIN(arg7) ++ __API_A_BEGIN(arg8) ++ __API_A_BEGIN(arg9) ++ __API_A_BEGIN(arg10)) {
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    _ = &arg10;
    return __API_A_BEGIN(arg0) ++ __API_A_BEGIN(arg1) ++ __API_A_BEGIN(arg2) ++ __API_A_BEGIN(arg3) ++ __API_A_BEGIN(arg4) ++ __API_A_BEGIN(arg5) ++ __API_A_BEGIN(arg6) ++ __API_A_BEGIN(arg7) ++ __API_A_BEGIN(arg8) ++ __API_A_BEGIN(arg9) ++ __API_A_BEGIN(arg10);
}
pub inline fn __API_AVAILABLE_BEGIN11(arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype, arg10: anytype, arg11: anytype) @TypeOf(__API_A_BEGIN(arg0) ++ __API_A_BEGIN(arg1) ++ __API_A_BEGIN(arg2) ++ __API_A_BEGIN(arg3) ++ __API_A_BEGIN(arg4) ++ __API_A_BEGIN(arg5) ++ __API_A_BEGIN(arg6) ++ __API_A_BEGIN(arg7) ++ __API_A_BEGIN(arg8) ++ __API_A_BEGIN(arg9) ++ __API_A_BEGIN(arg10) ++ __API_A_BEGIN(arg11)) {
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    _ = &arg10;
    _ = &arg11;
    return __API_A_BEGIN(arg0) ++ __API_A_BEGIN(arg1) ++ __API_A_BEGIN(arg2) ++ __API_A_BEGIN(arg3) ++ __API_A_BEGIN(arg4) ++ __API_A_BEGIN(arg5) ++ __API_A_BEGIN(arg6) ++ __API_A_BEGIN(arg7) ++ __API_A_BEGIN(arg8) ++ __API_A_BEGIN(arg9) ++ __API_A_BEGIN(arg10) ++ __API_A_BEGIN(arg11);
}
pub inline fn __API_AVAILABLE_BEGIN12(arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype, arg10: anytype, arg11: anytype, arg12: anytype) @TypeOf(__API_A_BEGIN(arg0) ++ __API_A_BEGIN(arg1) ++ __API_A_BEGIN(arg2) ++ __API_A_BEGIN(arg3) ++ __API_A_BEGIN(arg4) ++ __API_A_BEGIN(arg5) ++ __API_A_BEGIN(arg6) ++ __API_A_BEGIN(arg7) ++ __API_A_BEGIN(arg8) ++ __API_A_BEGIN(arg9) ++ __API_A_BEGIN(arg10) ++ __API_A_BEGIN(arg11) ++ __API_A_BEGIN(arg12)) {
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    _ = &arg10;
    _ = &arg11;
    _ = &arg12;
    return __API_A_BEGIN(arg0) ++ __API_A_BEGIN(arg1) ++ __API_A_BEGIN(arg2) ++ __API_A_BEGIN(arg3) ++ __API_A_BEGIN(arg4) ++ __API_A_BEGIN(arg5) ++ __API_A_BEGIN(arg6) ++ __API_A_BEGIN(arg7) ++ __API_A_BEGIN(arg8) ++ __API_A_BEGIN(arg9) ++ __API_A_BEGIN(arg10) ++ __API_A_BEGIN(arg11) ++ __API_A_BEGIN(arg12);
}
pub inline fn __API_AVAILABLE_BEGIN13(arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype, arg10: anytype, arg11: anytype, arg12: anytype, arg13: anytype) @TypeOf(__API_A_BEGIN(arg0) ++ __API_A_BEGIN(arg1) ++ __API_A_BEGIN(arg2) ++ __API_A_BEGIN(arg3) ++ __API_A_BEGIN(arg4) ++ __API_A_BEGIN(arg5) ++ __API_A_BEGIN(arg6) ++ __API_A_BEGIN(arg7) ++ __API_A_BEGIN(arg8) ++ __API_A_BEGIN(arg9) ++ __API_A_BEGIN(arg10) ++ __API_A_BEGIN(arg11) ++ __API_A_BEGIN(arg12) ++ __API_A_BEGIN(arg13)) {
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    _ = &arg10;
    _ = &arg11;
    _ = &arg12;
    _ = &arg13;
    return __API_A_BEGIN(arg0) ++ __API_A_BEGIN(arg1) ++ __API_A_BEGIN(arg2) ++ __API_A_BEGIN(arg3) ++ __API_A_BEGIN(arg4) ++ __API_A_BEGIN(arg5) ++ __API_A_BEGIN(arg6) ++ __API_A_BEGIN(arg7) ++ __API_A_BEGIN(arg8) ++ __API_A_BEGIN(arg9) ++ __API_A_BEGIN(arg10) ++ __API_A_BEGIN(arg11) ++ __API_A_BEGIN(arg12) ++ __API_A_BEGIN(arg13);
}
pub inline fn __API_AVAILABLE_BEGIN14(arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype, arg10: anytype, arg11: anytype, arg12: anytype, arg13: anytype, arg14: anytype) @TypeOf(__API_A_BEGIN(arg0) ++ __API_A_BEGIN(arg1) ++ __API_A_BEGIN(arg2) ++ __API_A_BEGIN(arg3) ++ __API_A_BEGIN(arg4) ++ __API_A_BEGIN(arg5) ++ __API_A_BEGIN(arg6) ++ __API_A_BEGIN(arg7) ++ __API_A_BEGIN(arg8) ++ __API_A_BEGIN(arg9) ++ __API_A_BEGIN(arg10) ++ __API_A_BEGIN(arg11) ++ __API_A_BEGIN(arg12) ++ __API_A_BEGIN(arg13) ++ __API_A_BEGIN(arg14)) {
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    _ = &arg10;
    _ = &arg11;
    _ = &arg12;
    _ = &arg13;
    _ = &arg14;
    return __API_A_BEGIN(arg0) ++ __API_A_BEGIN(arg1) ++ __API_A_BEGIN(arg2) ++ __API_A_BEGIN(arg3) ++ __API_A_BEGIN(arg4) ++ __API_A_BEGIN(arg5) ++ __API_A_BEGIN(arg6) ++ __API_A_BEGIN(arg7) ++ __API_A_BEGIN(arg8) ++ __API_A_BEGIN(arg9) ++ __API_A_BEGIN(arg10) ++ __API_A_BEGIN(arg11) ++ __API_A_BEGIN(arg12) ++ __API_A_BEGIN(arg13) ++ __API_A_BEGIN(arg14);
}
pub inline fn __API_AVAILABLE_BEGIN15(arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype, arg10: anytype, arg11: anytype, arg12: anytype, arg13: anytype, arg14: anytype, arg15: anytype) @TypeOf(__API_A_BEGIN(arg0) ++ __API_A_BEGIN(arg1) ++ __API_A_BEGIN(arg2) ++ __API_A_BEGIN(arg3) ++ __API_A_BEGIN(arg4) ++ __API_A_BEGIN(arg5) ++ __API_A_BEGIN(arg6) ++ __API_A_BEGIN(arg7) ++ __API_A_BEGIN(arg8) ++ __API_A_BEGIN(arg9) ++ __API_A_BEGIN(arg10) ++ __API_A_BEGIN(arg11) ++ __API_A_BEGIN(arg12) ++ __API_A_BEGIN(arg13) ++ __API_A_BEGIN(arg14) ++ __API_A_BEGIN(arg15)) {
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    _ = &arg10;
    _ = &arg11;
    _ = &arg12;
    _ = &arg13;
    _ = &arg14;
    _ = &arg15;
    return __API_A_BEGIN(arg0) ++ __API_A_BEGIN(arg1) ++ __API_A_BEGIN(arg2) ++ __API_A_BEGIN(arg3) ++ __API_A_BEGIN(arg4) ++ __API_A_BEGIN(arg5) ++ __API_A_BEGIN(arg6) ++ __API_A_BEGIN(arg7) ++ __API_A_BEGIN(arg8) ++ __API_A_BEGIN(arg9) ++ __API_A_BEGIN(arg10) ++ __API_A_BEGIN(arg11) ++ __API_A_BEGIN(arg12) ++ __API_A_BEGIN(arg13) ++ __API_A_BEGIN(arg14) ++ __API_A_BEGIN(arg15);
}
pub const __API_AVAILABLE_BEGIN_GET_MACRO_93585900 = @compileError("unable to translate C expr: expected ')' instead got '...'");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/AvailabilityInternal.h:270:13
pub const __API_D = @compileError("unable to translate macro: undefined identifier `availability`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/AvailabilityInternal.h:274:13
pub inline fn __API_DEPRECATED_MSG0(msg: anytype, arg0: anytype) @TypeOf(__API_D(msg, arg0)) {
    _ = &msg;
    _ = &arg0;
    return __API_D(msg, arg0);
}
pub inline fn __API_DEPRECATED_MSG1(msg: anytype, arg0: anytype, arg1: anytype) @TypeOf(__API_D(msg, arg0) ++ __API_D(msg, arg1)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    return __API_D(msg, arg0) ++ __API_D(msg, arg1);
}
pub inline fn __API_DEPRECATED_MSG2(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype) @TypeOf(__API_D(msg, arg0) ++ __API_D(msg, arg1) ++ __API_D(msg, arg2)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    return __API_D(msg, arg0) ++ __API_D(msg, arg1) ++ __API_D(msg, arg2);
}
pub inline fn __API_DEPRECATED_MSG3(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype) @TypeOf(__API_D(msg, arg0) ++ __API_D(msg, arg1) ++ __API_D(msg, arg2) ++ __API_D(msg, arg3)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    return __API_D(msg, arg0) ++ __API_D(msg, arg1) ++ __API_D(msg, arg2) ++ __API_D(msg, arg3);
}
pub inline fn __API_DEPRECATED_MSG4(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype) @TypeOf(__API_D(msg, arg0) ++ __API_D(msg, arg1) ++ __API_D(msg, arg2) ++ __API_D(msg, arg3) ++ __API_D(msg, arg4)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    return __API_D(msg, arg0) ++ __API_D(msg, arg1) ++ __API_D(msg, arg2) ++ __API_D(msg, arg3) ++ __API_D(msg, arg4);
}
pub inline fn __API_DEPRECATED_MSG5(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype) @TypeOf(__API_D(msg, arg0) ++ __API_D(msg, arg1) ++ __API_D(msg, arg2) ++ __API_D(msg, arg3) ++ __API_D(msg, arg4) ++ __API_D(msg, arg5)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    return __API_D(msg, arg0) ++ __API_D(msg, arg1) ++ __API_D(msg, arg2) ++ __API_D(msg, arg3) ++ __API_D(msg, arg4) ++ __API_D(msg, arg5);
}
pub inline fn __API_DEPRECATED_MSG6(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype) @TypeOf(__API_D(msg, arg0) ++ __API_D(msg, arg1) ++ __API_D(msg, arg2) ++ __API_D(msg, arg3) ++ __API_D(msg, arg4) ++ __API_D(msg, arg5) ++ __API_D(msg, arg6)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    return __API_D(msg, arg0) ++ __API_D(msg, arg1) ++ __API_D(msg, arg2) ++ __API_D(msg, arg3) ++ __API_D(msg, arg4) ++ __API_D(msg, arg5) ++ __API_D(msg, arg6);
}
pub inline fn __API_DEPRECATED_MSG7(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype) @TypeOf(__API_D(msg, arg0) ++ __API_D(msg, arg1) ++ __API_D(msg, arg2) ++ __API_D(msg, arg3) ++ __API_D(msg, arg4) ++ __API_D(msg, arg5) ++ __API_D(msg, arg6) ++ __API_D(msg, arg7)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    return __API_D(msg, arg0) ++ __API_D(msg, arg1) ++ __API_D(msg, arg2) ++ __API_D(msg, arg3) ++ __API_D(msg, arg4) ++ __API_D(msg, arg5) ++ __API_D(msg, arg6) ++ __API_D(msg, arg7);
}
pub inline fn __API_DEPRECATED_MSG8(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype) @TypeOf(__API_D(msg, arg0) ++ __API_D(msg, arg1) ++ __API_D(msg, arg2) ++ __API_D(msg, arg3) ++ __API_D(msg, arg4) ++ __API_D(msg, arg5) ++ __API_D(msg, arg6) ++ __API_D(msg, arg7) ++ __API_D(msg, arg8)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    return __API_D(msg, arg0) ++ __API_D(msg, arg1) ++ __API_D(msg, arg2) ++ __API_D(msg, arg3) ++ __API_D(msg, arg4) ++ __API_D(msg, arg5) ++ __API_D(msg, arg6) ++ __API_D(msg, arg7) ++ __API_D(msg, arg8);
}
pub inline fn __API_DEPRECATED_MSG9(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype) @TypeOf(__API_D(msg, arg0) ++ __API_D(msg, arg1) ++ __API_D(msg, arg2) ++ __API_D(msg, arg3) ++ __API_D(msg, arg4) ++ __API_D(msg, arg5) ++ __API_D(msg, arg6) ++ __API_D(msg, arg7) ++ __API_D(msg, arg8) ++ __API_D(msg, arg9)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    return __API_D(msg, arg0) ++ __API_D(msg, arg1) ++ __API_D(msg, arg2) ++ __API_D(msg, arg3) ++ __API_D(msg, arg4) ++ __API_D(msg, arg5) ++ __API_D(msg, arg6) ++ __API_D(msg, arg7) ++ __API_D(msg, arg8) ++ __API_D(msg, arg9);
}
pub inline fn __API_DEPRECATED_MSG10(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype, arg10: anytype) @TypeOf(__API_D(msg, arg0) ++ __API_D(msg, arg1) ++ __API_D(msg, arg2) ++ __API_D(msg, arg3) ++ __API_D(msg, arg4) ++ __API_D(msg, arg5) ++ __API_D(msg, arg6) ++ __API_D(msg, arg7) ++ __API_D(msg, arg8) ++ __API_D(msg, arg9) ++ __API_D(msg, arg10)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    _ = &arg10;
    return __API_D(msg, arg0) ++ __API_D(msg, arg1) ++ __API_D(msg, arg2) ++ __API_D(msg, arg3) ++ __API_D(msg, arg4) ++ __API_D(msg, arg5) ++ __API_D(msg, arg6) ++ __API_D(msg, arg7) ++ __API_D(msg, arg8) ++ __API_D(msg, arg9) ++ __API_D(msg, arg10);
}
pub inline fn __API_DEPRECATED_MSG11(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype, arg10: anytype, arg11: anytype) @TypeOf(__API_D(msg, arg0) ++ __API_D(msg, arg1) ++ __API_D(msg, arg2) ++ __API_D(msg, arg3) ++ __API_D(msg, arg4) ++ __API_D(msg, arg5) ++ __API_D(msg, arg6) ++ __API_D(msg, arg7) ++ __API_D(msg, arg8) ++ __API_D(msg, arg9) ++ __API_D(msg, arg10) ++ __API_D(msg, arg11)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    _ = &arg10;
    _ = &arg11;
    return __API_D(msg, arg0) ++ __API_D(msg, arg1) ++ __API_D(msg, arg2) ++ __API_D(msg, arg3) ++ __API_D(msg, arg4) ++ __API_D(msg, arg5) ++ __API_D(msg, arg6) ++ __API_D(msg, arg7) ++ __API_D(msg, arg8) ++ __API_D(msg, arg9) ++ __API_D(msg, arg10) ++ __API_D(msg, arg11);
}
pub inline fn __API_DEPRECATED_MSG12(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype, arg10: anytype, arg11: anytype, arg12: anytype) @TypeOf(__API_D(msg, arg0) ++ __API_D(msg, arg1) ++ __API_D(msg, arg2) ++ __API_D(msg, arg3) ++ __API_D(msg, arg4) ++ __API_D(msg, arg5) ++ __API_D(msg, arg6) ++ __API_D(msg, arg7) ++ __API_D(msg, arg8) ++ __API_D(msg, arg9) ++ __API_D(msg, arg10) ++ __API_D(msg, arg11) ++ __API_D(msg, arg12)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    _ = &arg10;
    _ = &arg11;
    _ = &arg12;
    return __API_D(msg, arg0) ++ __API_D(msg, arg1) ++ __API_D(msg, arg2) ++ __API_D(msg, arg3) ++ __API_D(msg, arg4) ++ __API_D(msg, arg5) ++ __API_D(msg, arg6) ++ __API_D(msg, arg7) ++ __API_D(msg, arg8) ++ __API_D(msg, arg9) ++ __API_D(msg, arg10) ++ __API_D(msg, arg11) ++ __API_D(msg, arg12);
}
pub inline fn __API_DEPRECATED_MSG13(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype, arg10: anytype, arg11: anytype, arg12: anytype, arg13: anytype) @TypeOf(__API_D(msg, arg0) ++ __API_D(msg, arg1) ++ __API_D(msg, arg2) ++ __API_D(msg, arg3) ++ __API_D(msg, arg4) ++ __API_D(msg, arg5) ++ __API_D(msg, arg6) ++ __API_D(msg, arg7) ++ __API_D(msg, arg8) ++ __API_D(msg, arg9) ++ __API_D(msg, arg10) ++ __API_D(msg, arg11) ++ __API_D(msg, arg12) ++ __API_D(msg, arg13)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    _ = &arg10;
    _ = &arg11;
    _ = &arg12;
    _ = &arg13;
    return __API_D(msg, arg0) ++ __API_D(msg, arg1) ++ __API_D(msg, arg2) ++ __API_D(msg, arg3) ++ __API_D(msg, arg4) ++ __API_D(msg, arg5) ++ __API_D(msg, arg6) ++ __API_D(msg, arg7) ++ __API_D(msg, arg8) ++ __API_D(msg, arg9) ++ __API_D(msg, arg10) ++ __API_D(msg, arg11) ++ __API_D(msg, arg12) ++ __API_D(msg, arg13);
}
pub inline fn __API_DEPRECATED_MSG14(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype, arg10: anytype, arg11: anytype, arg12: anytype, arg13: anytype, arg14: anytype) @TypeOf(__API_D(msg, arg0) ++ __API_D(msg, arg1) ++ __API_D(msg, arg2) ++ __API_D(msg, arg3) ++ __API_D(msg, arg4) ++ __API_D(msg, arg5) ++ __API_D(msg, arg6) ++ __API_D(msg, arg7) ++ __API_D(msg, arg8) ++ __API_D(msg, arg9) ++ __API_D(msg, arg10) ++ __API_D(msg, arg11) ++ __API_D(msg, arg12) ++ __API_D(msg, arg13) ++ __API_D(msg, arg14)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    _ = &arg10;
    _ = &arg11;
    _ = &arg12;
    _ = &arg13;
    _ = &arg14;
    return __API_D(msg, arg0) ++ __API_D(msg, arg1) ++ __API_D(msg, arg2) ++ __API_D(msg, arg3) ++ __API_D(msg, arg4) ++ __API_D(msg, arg5) ++ __API_D(msg, arg6) ++ __API_D(msg, arg7) ++ __API_D(msg, arg8) ++ __API_D(msg, arg9) ++ __API_D(msg, arg10) ++ __API_D(msg, arg11) ++ __API_D(msg, arg12) ++ __API_D(msg, arg13) ++ __API_D(msg, arg14);
}
pub inline fn __API_DEPRECATED_MSG15(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype, arg10: anytype, arg11: anytype, arg12: anytype, arg13: anytype, arg14: anytype, arg15: anytype) @TypeOf(__API_D(msg, arg0) ++ __API_D(msg, arg1) ++ __API_D(msg, arg2) ++ __API_D(msg, arg3) ++ __API_D(msg, arg4) ++ __API_D(msg, arg5) ++ __API_D(msg, arg6) ++ __API_D(msg, arg7) ++ __API_D(msg, arg8) ++ __API_D(msg, arg9) ++ __API_D(msg, arg10) ++ __API_D(msg, arg11) ++ __API_D(msg, arg12) ++ __API_D(msg, arg13) ++ __API_D(msg, arg14) ++ __API_D(msg, arg15)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    _ = &arg10;
    _ = &arg11;
    _ = &arg12;
    _ = &arg13;
    _ = &arg14;
    _ = &arg15;
    return __API_D(msg, arg0) ++ __API_D(msg, arg1) ++ __API_D(msg, arg2) ++ __API_D(msg, arg3) ++ __API_D(msg, arg4) ++ __API_D(msg, arg5) ++ __API_D(msg, arg6) ++ __API_D(msg, arg7) ++ __API_D(msg, arg8) ++ __API_D(msg, arg9) ++ __API_D(msg, arg10) ++ __API_D(msg, arg11) ++ __API_D(msg, arg12) ++ __API_D(msg, arg13) ++ __API_D(msg, arg14) ++ __API_D(msg, arg15);
}
pub const __API_DEPRECATED_MSG_GET_MACRO_93585900 = @compileError("unable to translate C expr: expected ')' instead got '...'");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/AvailabilityInternal.h:292:13
pub const __API_D_BEGIN = @compileError("unable to translate macro: undefined identifier `_Pragma`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/AvailabilityInternal.h:294:13
pub inline fn __API_DEPRECATED_BEGIN0(msg: anytype, arg0: anytype) @TypeOf(__API_D_BEGIN(msg, arg0)) {
    _ = &msg;
    _ = &arg0;
    return __API_D_BEGIN(msg, arg0);
}
pub inline fn __API_DEPRECATED_BEGIN1(msg: anytype, arg0: anytype, arg1: anytype) @TypeOf(__API_D_BEGIN(msg, arg0) ++ __API_D_BEGIN(msg, arg1)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    return __API_D_BEGIN(msg, arg0) ++ __API_D_BEGIN(msg, arg1);
}
pub inline fn __API_DEPRECATED_BEGIN2(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype) @TypeOf(__API_D_BEGIN(msg, arg0) ++ __API_D_BEGIN(msg, arg1) ++ __API_D_BEGIN(msg, arg2)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    return __API_D_BEGIN(msg, arg0) ++ __API_D_BEGIN(msg, arg1) ++ __API_D_BEGIN(msg, arg2);
}
pub inline fn __API_DEPRECATED_BEGIN3(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype) @TypeOf(__API_D_BEGIN(msg, arg0) ++ __API_D_BEGIN(msg, arg1) ++ __API_D_BEGIN(msg, arg2) ++ __API_D_BEGIN(msg, arg3)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    return __API_D_BEGIN(msg, arg0) ++ __API_D_BEGIN(msg, arg1) ++ __API_D_BEGIN(msg, arg2) ++ __API_D_BEGIN(msg, arg3);
}
pub inline fn __API_DEPRECATED_BEGIN4(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype) @TypeOf(__API_D_BEGIN(msg, arg0) ++ __API_D_BEGIN(msg, arg1) ++ __API_D_BEGIN(msg, arg2) ++ __API_D_BEGIN(msg, arg3) ++ __API_D_BEGIN(msg, arg4)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    return __API_D_BEGIN(msg, arg0) ++ __API_D_BEGIN(msg, arg1) ++ __API_D_BEGIN(msg, arg2) ++ __API_D_BEGIN(msg, arg3) ++ __API_D_BEGIN(msg, arg4);
}
pub inline fn __API_DEPRECATED_BEGIN5(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype) @TypeOf(__API_D_BEGIN(msg, arg0) ++ __API_D_BEGIN(msg, arg1) ++ __API_D_BEGIN(msg, arg2) ++ __API_D_BEGIN(msg, arg3) ++ __API_D_BEGIN(msg, arg4) ++ __API_D_BEGIN(msg, arg5)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    return __API_D_BEGIN(msg, arg0) ++ __API_D_BEGIN(msg, arg1) ++ __API_D_BEGIN(msg, arg2) ++ __API_D_BEGIN(msg, arg3) ++ __API_D_BEGIN(msg, arg4) ++ __API_D_BEGIN(msg, arg5);
}
pub inline fn __API_DEPRECATED_BEGIN6(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype) @TypeOf(__API_D_BEGIN(msg, arg0) ++ __API_D_BEGIN(msg, arg1) ++ __API_D_BEGIN(msg, arg2) ++ __API_D_BEGIN(msg, arg3) ++ __API_D_BEGIN(msg, arg4) ++ __API_D_BEGIN(msg, arg5) ++ __API_D_BEGIN(msg, arg6)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    return __API_D_BEGIN(msg, arg0) ++ __API_D_BEGIN(msg, arg1) ++ __API_D_BEGIN(msg, arg2) ++ __API_D_BEGIN(msg, arg3) ++ __API_D_BEGIN(msg, arg4) ++ __API_D_BEGIN(msg, arg5) ++ __API_D_BEGIN(msg, arg6);
}
pub inline fn __API_DEPRECATED_BEGIN7(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype) @TypeOf(__API_D_BEGIN(msg, arg0) ++ __API_D_BEGIN(msg, arg1) ++ __API_D_BEGIN(msg, arg2) ++ __API_D_BEGIN(msg, arg3) ++ __API_D_BEGIN(msg, arg4) ++ __API_D_BEGIN(msg, arg5) ++ __API_D_BEGIN(msg, arg6) ++ __API_D_BEGIN(msg, arg7)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    return __API_D_BEGIN(msg, arg0) ++ __API_D_BEGIN(msg, arg1) ++ __API_D_BEGIN(msg, arg2) ++ __API_D_BEGIN(msg, arg3) ++ __API_D_BEGIN(msg, arg4) ++ __API_D_BEGIN(msg, arg5) ++ __API_D_BEGIN(msg, arg6) ++ __API_D_BEGIN(msg, arg7);
}
pub inline fn __API_DEPRECATED_BEGIN8(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype) @TypeOf(__API_D_BEGIN(msg, arg0) ++ __API_D_BEGIN(msg, arg1) ++ __API_D_BEGIN(msg, arg2) ++ __API_D_BEGIN(msg, arg3) ++ __API_D_BEGIN(msg, arg4) ++ __API_D_BEGIN(msg, arg5) ++ __API_D_BEGIN(msg, arg6) ++ __API_D_BEGIN(msg, arg7) ++ __API_D_BEGIN(msg, arg8)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    return __API_D_BEGIN(msg, arg0) ++ __API_D_BEGIN(msg, arg1) ++ __API_D_BEGIN(msg, arg2) ++ __API_D_BEGIN(msg, arg3) ++ __API_D_BEGIN(msg, arg4) ++ __API_D_BEGIN(msg, arg5) ++ __API_D_BEGIN(msg, arg6) ++ __API_D_BEGIN(msg, arg7) ++ __API_D_BEGIN(msg, arg8);
}
pub inline fn __API_DEPRECATED_BEGIN9(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype) @TypeOf(__API_D_BEGIN(msg, arg0) ++ __API_D_BEGIN(msg, arg1) ++ __API_D_BEGIN(msg, arg2) ++ __API_D_BEGIN(msg, arg3) ++ __API_D_BEGIN(msg, arg4) ++ __API_D_BEGIN(msg, arg5) ++ __API_D_BEGIN(msg, arg6) ++ __API_D_BEGIN(msg, arg7) ++ __API_D_BEGIN(msg, arg8) ++ __API_D_BEGIN(msg, arg9)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    return __API_D_BEGIN(msg, arg0) ++ __API_D_BEGIN(msg, arg1) ++ __API_D_BEGIN(msg, arg2) ++ __API_D_BEGIN(msg, arg3) ++ __API_D_BEGIN(msg, arg4) ++ __API_D_BEGIN(msg, arg5) ++ __API_D_BEGIN(msg, arg6) ++ __API_D_BEGIN(msg, arg7) ++ __API_D_BEGIN(msg, arg8) ++ __API_D_BEGIN(msg, arg9);
}
pub inline fn __API_DEPRECATED_BEGIN10(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype, arg10: anytype) @TypeOf(__API_D_BEGIN(msg, arg0) ++ __API_D_BEGIN(msg, arg1) ++ __API_D_BEGIN(msg, arg2) ++ __API_D_BEGIN(msg, arg3) ++ __API_D_BEGIN(msg, arg4) ++ __API_D_BEGIN(msg, arg5) ++ __API_D_BEGIN(msg, arg6) ++ __API_D_BEGIN(msg, arg7) ++ __API_D_BEGIN(msg, arg8) ++ __API_D_BEGIN(msg, arg9) ++ __API_D_BEGIN(msg, arg10)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    _ = &arg10;
    return __API_D_BEGIN(msg, arg0) ++ __API_D_BEGIN(msg, arg1) ++ __API_D_BEGIN(msg, arg2) ++ __API_D_BEGIN(msg, arg3) ++ __API_D_BEGIN(msg, arg4) ++ __API_D_BEGIN(msg, arg5) ++ __API_D_BEGIN(msg, arg6) ++ __API_D_BEGIN(msg, arg7) ++ __API_D_BEGIN(msg, arg8) ++ __API_D_BEGIN(msg, arg9) ++ __API_D_BEGIN(msg, arg10);
}
pub inline fn __API_DEPRECATED_BEGIN11(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype, arg10: anytype, arg11: anytype) @TypeOf(__API_D_BEGIN(msg, arg0) ++ __API_D_BEGIN(msg, arg1) ++ __API_D_BEGIN(msg, arg2) ++ __API_D_BEGIN(msg, arg3) ++ __API_D_BEGIN(msg, arg4) ++ __API_D_BEGIN(msg, arg5) ++ __API_D_BEGIN(msg, arg6) ++ __API_D_BEGIN(msg, arg7) ++ __API_D_BEGIN(msg, arg8) ++ __API_D_BEGIN(msg, arg9) ++ __API_D_BEGIN(msg, arg10) ++ __API_D_BEGIN(msg, arg11)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    _ = &arg10;
    _ = &arg11;
    return __API_D_BEGIN(msg, arg0) ++ __API_D_BEGIN(msg, arg1) ++ __API_D_BEGIN(msg, arg2) ++ __API_D_BEGIN(msg, arg3) ++ __API_D_BEGIN(msg, arg4) ++ __API_D_BEGIN(msg, arg5) ++ __API_D_BEGIN(msg, arg6) ++ __API_D_BEGIN(msg, arg7) ++ __API_D_BEGIN(msg, arg8) ++ __API_D_BEGIN(msg, arg9) ++ __API_D_BEGIN(msg, arg10) ++ __API_D_BEGIN(msg, arg11);
}
pub inline fn __API_DEPRECATED_BEGIN12(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype, arg10: anytype, arg11: anytype, arg12: anytype) @TypeOf(__API_D_BEGIN(msg, arg0) ++ __API_D_BEGIN(msg, arg1) ++ __API_D_BEGIN(msg, arg2) ++ __API_D_BEGIN(msg, arg3) ++ __API_D_BEGIN(msg, arg4) ++ __API_D_BEGIN(msg, arg5) ++ __API_D_BEGIN(msg, arg6) ++ __API_D_BEGIN(msg, arg7) ++ __API_D_BEGIN(msg, arg8) ++ __API_D_BEGIN(msg, arg9) ++ __API_D_BEGIN(msg, arg10) ++ __API_D_BEGIN(msg, arg11) ++ __API_D_BEGIN(msg, arg12)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    _ = &arg10;
    _ = &arg11;
    _ = &arg12;
    return __API_D_BEGIN(msg, arg0) ++ __API_D_BEGIN(msg, arg1) ++ __API_D_BEGIN(msg, arg2) ++ __API_D_BEGIN(msg, arg3) ++ __API_D_BEGIN(msg, arg4) ++ __API_D_BEGIN(msg, arg5) ++ __API_D_BEGIN(msg, arg6) ++ __API_D_BEGIN(msg, arg7) ++ __API_D_BEGIN(msg, arg8) ++ __API_D_BEGIN(msg, arg9) ++ __API_D_BEGIN(msg, arg10) ++ __API_D_BEGIN(msg, arg11) ++ __API_D_BEGIN(msg, arg12);
}
pub inline fn __API_DEPRECATED_BEGIN13(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype, arg10: anytype, arg11: anytype, arg12: anytype, arg13: anytype) @TypeOf(__API_D_BEGIN(msg, arg0) ++ __API_D_BEGIN(msg, arg1) ++ __API_D_BEGIN(msg, arg2) ++ __API_D_BEGIN(msg, arg3) ++ __API_D_BEGIN(msg, arg4) ++ __API_D_BEGIN(msg, arg5) ++ __API_D_BEGIN(msg, arg6) ++ __API_D_BEGIN(msg, arg7) ++ __API_D_BEGIN(msg, arg8) ++ __API_D_BEGIN(msg, arg9) ++ __API_D_BEGIN(msg, arg10) ++ __API_D_BEGIN(msg, arg11) ++ __API_D_BEGIN(msg, arg12) ++ __API_D_BEGIN(msg, arg13)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    _ = &arg10;
    _ = &arg11;
    _ = &arg12;
    _ = &arg13;
    return __API_D_BEGIN(msg, arg0) ++ __API_D_BEGIN(msg, arg1) ++ __API_D_BEGIN(msg, arg2) ++ __API_D_BEGIN(msg, arg3) ++ __API_D_BEGIN(msg, arg4) ++ __API_D_BEGIN(msg, arg5) ++ __API_D_BEGIN(msg, arg6) ++ __API_D_BEGIN(msg, arg7) ++ __API_D_BEGIN(msg, arg8) ++ __API_D_BEGIN(msg, arg9) ++ __API_D_BEGIN(msg, arg10) ++ __API_D_BEGIN(msg, arg11) ++ __API_D_BEGIN(msg, arg12) ++ __API_D_BEGIN(msg, arg13);
}
pub inline fn __API_DEPRECATED_BEGIN14(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype, arg10: anytype, arg11: anytype, arg12: anytype, arg13: anytype, arg14: anytype) @TypeOf(__API_D_BEGIN(msg, arg0) ++ __API_D_BEGIN(msg, arg1) ++ __API_D_BEGIN(msg, arg2) ++ __API_D_BEGIN(msg, arg3) ++ __API_D_BEGIN(msg, arg4) ++ __API_D_BEGIN(msg, arg5) ++ __API_D_BEGIN(msg, arg6) ++ __API_D_BEGIN(msg, arg7) ++ __API_D_BEGIN(msg, arg8) ++ __API_D_BEGIN(msg, arg9) ++ __API_D_BEGIN(msg, arg10) ++ __API_D_BEGIN(msg, arg11) ++ __API_D_BEGIN(msg, arg12) ++ __API_D_BEGIN(msg, arg13) ++ __API_D_BEGIN(msg, arg14)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    _ = &arg10;
    _ = &arg11;
    _ = &arg12;
    _ = &arg13;
    _ = &arg14;
    return __API_D_BEGIN(msg, arg0) ++ __API_D_BEGIN(msg, arg1) ++ __API_D_BEGIN(msg, arg2) ++ __API_D_BEGIN(msg, arg3) ++ __API_D_BEGIN(msg, arg4) ++ __API_D_BEGIN(msg, arg5) ++ __API_D_BEGIN(msg, arg6) ++ __API_D_BEGIN(msg, arg7) ++ __API_D_BEGIN(msg, arg8) ++ __API_D_BEGIN(msg, arg9) ++ __API_D_BEGIN(msg, arg10) ++ __API_D_BEGIN(msg, arg11) ++ __API_D_BEGIN(msg, arg12) ++ __API_D_BEGIN(msg, arg13) ++ __API_D_BEGIN(msg, arg14);
}
pub inline fn __API_DEPRECATED_BEGIN15(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype, arg10: anytype, arg11: anytype, arg12: anytype, arg13: anytype, arg14: anytype, arg15: anytype) @TypeOf(__API_D_BEGIN(msg, arg0) ++ __API_D_BEGIN(msg, arg1) ++ __API_D_BEGIN(msg, arg2) ++ __API_D_BEGIN(msg, arg3) ++ __API_D_BEGIN(msg, arg4) ++ __API_D_BEGIN(msg, arg5) ++ __API_D_BEGIN(msg, arg6) ++ __API_D_BEGIN(msg, arg7) ++ __API_D_BEGIN(msg, arg8) ++ __API_D_BEGIN(msg, arg9) ++ __API_D_BEGIN(msg, arg10) ++ __API_D_BEGIN(msg, arg11) ++ __API_D_BEGIN(msg, arg12) ++ __API_D_BEGIN(msg, arg13) ++ __API_D_BEGIN(msg, arg14) ++ __API_D_BEGIN(msg, arg15)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    _ = &arg10;
    _ = &arg11;
    _ = &arg12;
    _ = &arg13;
    _ = &arg14;
    _ = &arg15;
    return __API_D_BEGIN(msg, arg0) ++ __API_D_BEGIN(msg, arg1) ++ __API_D_BEGIN(msg, arg2) ++ __API_D_BEGIN(msg, arg3) ++ __API_D_BEGIN(msg, arg4) ++ __API_D_BEGIN(msg, arg5) ++ __API_D_BEGIN(msg, arg6) ++ __API_D_BEGIN(msg, arg7) ++ __API_D_BEGIN(msg, arg8) ++ __API_D_BEGIN(msg, arg9) ++ __API_D_BEGIN(msg, arg10) ++ __API_D_BEGIN(msg, arg11) ++ __API_D_BEGIN(msg, arg12) ++ __API_D_BEGIN(msg, arg13) ++ __API_D_BEGIN(msg, arg14) ++ __API_D_BEGIN(msg, arg15);
}
pub const __API_DEPRECATED_BEGIN_GET_MACRO_93585900 = @compileError("unable to translate C expr: expected ')' instead got '...'");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/AvailabilityInternal.h:312:13
pub const __API_DR = @compileError("unable to translate macro: undefined identifier `availability`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/AvailabilityInternal.h:315:17
pub inline fn __API_DEPRECATED_REP0(msg: anytype, arg0: anytype) @TypeOf(__API_DR(msg, arg0)) {
    _ = &msg;
    _ = &arg0;
    return __API_DR(msg, arg0);
}
pub inline fn __API_DEPRECATED_REP1(msg: anytype, arg0: anytype, arg1: anytype) @TypeOf(__API_DR(msg, arg0) ++ __API_DR(msg, arg1)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    return __API_DR(msg, arg0) ++ __API_DR(msg, arg1);
}
pub inline fn __API_DEPRECATED_REP2(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype) @TypeOf(__API_DR(msg, arg0) ++ __API_DR(msg, arg1) ++ __API_DR(msg, arg2)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    return __API_DR(msg, arg0) ++ __API_DR(msg, arg1) ++ __API_DR(msg, arg2);
}
pub inline fn __API_DEPRECATED_REP3(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype) @TypeOf(__API_DR(msg, arg0) ++ __API_DR(msg, arg1) ++ __API_DR(msg, arg2) ++ __API_DR(msg, arg3)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    return __API_DR(msg, arg0) ++ __API_DR(msg, arg1) ++ __API_DR(msg, arg2) ++ __API_DR(msg, arg3);
}
pub inline fn __API_DEPRECATED_REP4(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype) @TypeOf(__API_DR(msg, arg0) ++ __API_DR(msg, arg1) ++ __API_DR(msg, arg2) ++ __API_DR(msg, arg3) ++ __API_DR(msg, arg4)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    return __API_DR(msg, arg0) ++ __API_DR(msg, arg1) ++ __API_DR(msg, arg2) ++ __API_DR(msg, arg3) ++ __API_DR(msg, arg4);
}
pub inline fn __API_DEPRECATED_REP5(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype) @TypeOf(__API_DR(msg, arg0) ++ __API_DR(msg, arg1) ++ __API_DR(msg, arg2) ++ __API_DR(msg, arg3) ++ __API_DR(msg, arg4) ++ __API_DR(msg, arg5)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    return __API_DR(msg, arg0) ++ __API_DR(msg, arg1) ++ __API_DR(msg, arg2) ++ __API_DR(msg, arg3) ++ __API_DR(msg, arg4) ++ __API_DR(msg, arg5);
}
pub inline fn __API_DEPRECATED_REP6(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype) @TypeOf(__API_DR(msg, arg0) ++ __API_DR(msg, arg1) ++ __API_DR(msg, arg2) ++ __API_DR(msg, arg3) ++ __API_DR(msg, arg4) ++ __API_DR(msg, arg5) ++ __API_DR(msg, arg6)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    return __API_DR(msg, arg0) ++ __API_DR(msg, arg1) ++ __API_DR(msg, arg2) ++ __API_DR(msg, arg3) ++ __API_DR(msg, arg4) ++ __API_DR(msg, arg5) ++ __API_DR(msg, arg6);
}
pub inline fn __API_DEPRECATED_REP7(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype) @TypeOf(__API_DR(msg, arg0) ++ __API_DR(msg, arg1) ++ __API_DR(msg, arg2) ++ __API_DR(msg, arg3) ++ __API_DR(msg, arg4) ++ __API_DR(msg, arg5) ++ __API_DR(msg, arg6) ++ __API_DR(msg, arg7)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    return __API_DR(msg, arg0) ++ __API_DR(msg, arg1) ++ __API_DR(msg, arg2) ++ __API_DR(msg, arg3) ++ __API_DR(msg, arg4) ++ __API_DR(msg, arg5) ++ __API_DR(msg, arg6) ++ __API_DR(msg, arg7);
}
pub inline fn __API_DEPRECATED_REP8(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype) @TypeOf(__API_DR(msg, arg0) ++ __API_DR(msg, arg1) ++ __API_DR(msg, arg2) ++ __API_DR(msg, arg3) ++ __API_DR(msg, arg4) ++ __API_DR(msg, arg5) ++ __API_DR(msg, arg6) ++ __API_DR(msg, arg7) ++ __API_DR(msg, arg8)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    return __API_DR(msg, arg0) ++ __API_DR(msg, arg1) ++ __API_DR(msg, arg2) ++ __API_DR(msg, arg3) ++ __API_DR(msg, arg4) ++ __API_DR(msg, arg5) ++ __API_DR(msg, arg6) ++ __API_DR(msg, arg7) ++ __API_DR(msg, arg8);
}
pub inline fn __API_DEPRECATED_REP9(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype) @TypeOf(__API_DR(msg, arg0) ++ __API_DR(msg, arg1) ++ __API_DR(msg, arg2) ++ __API_DR(msg, arg3) ++ __API_DR(msg, arg4) ++ __API_DR(msg, arg5) ++ __API_DR(msg, arg6) ++ __API_DR(msg, arg7) ++ __API_DR(msg, arg8) ++ __API_DR(msg, arg9)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    return __API_DR(msg, arg0) ++ __API_DR(msg, arg1) ++ __API_DR(msg, arg2) ++ __API_DR(msg, arg3) ++ __API_DR(msg, arg4) ++ __API_DR(msg, arg5) ++ __API_DR(msg, arg6) ++ __API_DR(msg, arg7) ++ __API_DR(msg, arg8) ++ __API_DR(msg, arg9);
}
pub inline fn __API_DEPRECATED_REP10(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype, arg10: anytype) @TypeOf(__API_DR(msg, arg0) ++ __API_DR(msg, arg1) ++ __API_DR(msg, arg2) ++ __API_DR(msg, arg3) ++ __API_DR(msg, arg4) ++ __API_DR(msg, arg5) ++ __API_DR(msg, arg6) ++ __API_DR(msg, arg7) ++ __API_DR(msg, arg8) ++ __API_DR(msg, arg9) ++ __API_DR(msg, arg10)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    _ = &arg10;
    return __API_DR(msg, arg0) ++ __API_DR(msg, arg1) ++ __API_DR(msg, arg2) ++ __API_DR(msg, arg3) ++ __API_DR(msg, arg4) ++ __API_DR(msg, arg5) ++ __API_DR(msg, arg6) ++ __API_DR(msg, arg7) ++ __API_DR(msg, arg8) ++ __API_DR(msg, arg9) ++ __API_DR(msg, arg10);
}
pub inline fn __API_DEPRECATED_REP11(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype, arg10: anytype, arg11: anytype) @TypeOf(__API_DR(msg, arg0) ++ __API_DR(msg, arg1) ++ __API_DR(msg, arg2) ++ __API_DR(msg, arg3) ++ __API_DR(msg, arg4) ++ __API_DR(msg, arg5) ++ __API_DR(msg, arg6) ++ __API_DR(msg, arg7) ++ __API_DR(msg, arg8) ++ __API_DR(msg, arg9) ++ __API_DR(msg, arg10) ++ __API_DR(msg, arg11)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    _ = &arg10;
    _ = &arg11;
    return __API_DR(msg, arg0) ++ __API_DR(msg, arg1) ++ __API_DR(msg, arg2) ++ __API_DR(msg, arg3) ++ __API_DR(msg, arg4) ++ __API_DR(msg, arg5) ++ __API_DR(msg, arg6) ++ __API_DR(msg, arg7) ++ __API_DR(msg, arg8) ++ __API_DR(msg, arg9) ++ __API_DR(msg, arg10) ++ __API_DR(msg, arg11);
}
pub inline fn __API_DEPRECATED_REP12(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype, arg10: anytype, arg11: anytype, arg12: anytype) @TypeOf(__API_DR(msg, arg0) ++ __API_DR(msg, arg1) ++ __API_DR(msg, arg2) ++ __API_DR(msg, arg3) ++ __API_DR(msg, arg4) ++ __API_DR(msg, arg5) ++ __API_DR(msg, arg6) ++ __API_DR(msg, arg7) ++ __API_DR(msg, arg8) ++ __API_DR(msg, arg9) ++ __API_DR(msg, arg10) ++ __API_DR(msg, arg11) ++ __API_DR(msg, arg12)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    _ = &arg10;
    _ = &arg11;
    _ = &arg12;
    return __API_DR(msg, arg0) ++ __API_DR(msg, arg1) ++ __API_DR(msg, arg2) ++ __API_DR(msg, arg3) ++ __API_DR(msg, arg4) ++ __API_DR(msg, arg5) ++ __API_DR(msg, arg6) ++ __API_DR(msg, arg7) ++ __API_DR(msg, arg8) ++ __API_DR(msg, arg9) ++ __API_DR(msg, arg10) ++ __API_DR(msg, arg11) ++ __API_DR(msg, arg12);
}
pub inline fn __API_DEPRECATED_REP13(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype, arg10: anytype, arg11: anytype, arg12: anytype, arg13: anytype) @TypeOf(__API_DR(msg, arg0) ++ __API_DR(msg, arg1) ++ __API_DR(msg, arg2) ++ __API_DR(msg, arg3) ++ __API_DR(msg, arg4) ++ __API_DR(msg, arg5) ++ __API_DR(msg, arg6) ++ __API_DR(msg, arg7) ++ __API_DR(msg, arg8) ++ __API_DR(msg, arg9) ++ __API_DR(msg, arg10) ++ __API_DR(msg, arg11) ++ __API_DR(msg, arg12) ++ __API_DR(msg, arg13)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    _ = &arg10;
    _ = &arg11;
    _ = &arg12;
    _ = &arg13;
    return __API_DR(msg, arg0) ++ __API_DR(msg, arg1) ++ __API_DR(msg, arg2) ++ __API_DR(msg, arg3) ++ __API_DR(msg, arg4) ++ __API_DR(msg, arg5) ++ __API_DR(msg, arg6) ++ __API_DR(msg, arg7) ++ __API_DR(msg, arg8) ++ __API_DR(msg, arg9) ++ __API_DR(msg, arg10) ++ __API_DR(msg, arg11) ++ __API_DR(msg, arg12) ++ __API_DR(msg, arg13);
}
pub inline fn __API_DEPRECATED_REP14(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype, arg10: anytype, arg11: anytype, arg12: anytype, arg13: anytype, arg14: anytype) @TypeOf(__API_DR(msg, arg0) ++ __API_DR(msg, arg1) ++ __API_DR(msg, arg2) ++ __API_DR(msg, arg3) ++ __API_DR(msg, arg4) ++ __API_DR(msg, arg5) ++ __API_DR(msg, arg6) ++ __API_DR(msg, arg7) ++ __API_DR(msg, arg8) ++ __API_DR(msg, arg9) ++ __API_DR(msg, arg10) ++ __API_DR(msg, arg11) ++ __API_DR(msg, arg12) ++ __API_DR(msg, arg13) ++ __API_DR(msg, arg14)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    _ = &arg10;
    _ = &arg11;
    _ = &arg12;
    _ = &arg13;
    _ = &arg14;
    return __API_DR(msg, arg0) ++ __API_DR(msg, arg1) ++ __API_DR(msg, arg2) ++ __API_DR(msg, arg3) ++ __API_DR(msg, arg4) ++ __API_DR(msg, arg5) ++ __API_DR(msg, arg6) ++ __API_DR(msg, arg7) ++ __API_DR(msg, arg8) ++ __API_DR(msg, arg9) ++ __API_DR(msg, arg10) ++ __API_DR(msg, arg11) ++ __API_DR(msg, arg12) ++ __API_DR(msg, arg13) ++ __API_DR(msg, arg14);
}
pub inline fn __API_DEPRECATED_REP15(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype, arg10: anytype, arg11: anytype, arg12: anytype, arg13: anytype, arg14: anytype, arg15: anytype) @TypeOf(__API_DR(msg, arg0) ++ __API_DR(msg, arg1) ++ __API_DR(msg, arg2) ++ __API_DR(msg, arg3) ++ __API_DR(msg, arg4) ++ __API_DR(msg, arg5) ++ __API_DR(msg, arg6) ++ __API_DR(msg, arg7) ++ __API_DR(msg, arg8) ++ __API_DR(msg, arg9) ++ __API_DR(msg, arg10) ++ __API_DR(msg, arg11) ++ __API_DR(msg, arg12) ++ __API_DR(msg, arg13) ++ __API_DR(msg, arg14) ++ __API_DR(msg, arg15)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    _ = &arg10;
    _ = &arg11;
    _ = &arg12;
    _ = &arg13;
    _ = &arg14;
    _ = &arg15;
    return __API_DR(msg, arg0) ++ __API_DR(msg, arg1) ++ __API_DR(msg, arg2) ++ __API_DR(msg, arg3) ++ __API_DR(msg, arg4) ++ __API_DR(msg, arg5) ++ __API_DR(msg, arg6) ++ __API_DR(msg, arg7) ++ __API_DR(msg, arg8) ++ __API_DR(msg, arg9) ++ __API_DR(msg, arg10) ++ __API_DR(msg, arg11) ++ __API_DR(msg, arg12) ++ __API_DR(msg, arg13) ++ __API_DR(msg, arg14) ++ __API_DR(msg, arg15);
}
pub const __API_DEPRECATED_REP_GET_MACRO_93585900 = @compileError("unable to translate C expr: expected ')' instead got '...'");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/AvailabilityInternal.h:336:13
pub const __API_DR_BEGIN = @compileError("unable to translate macro: undefined identifier `_Pragma`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/AvailabilityInternal.h:339:17
pub inline fn __API_DEPRECATED_WITH_REPLACEMENT_BEGIN0(msg: anytype, arg0: anytype) @TypeOf(__API_DR_BEGIN(msg, arg0)) {
    _ = &msg;
    _ = &arg0;
    return __API_DR_BEGIN(msg, arg0);
}
pub inline fn __API_DEPRECATED_WITH_REPLACEMENT_BEGIN1(msg: anytype, arg0: anytype, arg1: anytype) @TypeOf(__API_DR_BEGIN(msg, arg0) ++ __API_DR_BEGIN(msg, arg1)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    return __API_DR_BEGIN(msg, arg0) ++ __API_DR_BEGIN(msg, arg1);
}
pub inline fn __API_DEPRECATED_WITH_REPLACEMENT_BEGIN2(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype) @TypeOf(__API_DR_BEGIN(msg, arg0) ++ __API_DR_BEGIN(msg, arg1) ++ __API_DR_BEGIN(msg, arg2)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    return __API_DR_BEGIN(msg, arg0) ++ __API_DR_BEGIN(msg, arg1) ++ __API_DR_BEGIN(msg, arg2);
}
pub inline fn __API_DEPRECATED_WITH_REPLACEMENT_BEGIN3(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype) @TypeOf(__API_DR_BEGIN(msg, arg0) ++ __API_DR_BEGIN(msg, arg1) ++ __API_DR_BEGIN(msg, arg2) ++ __API_DR_BEGIN(msg, arg3)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    return __API_DR_BEGIN(msg, arg0) ++ __API_DR_BEGIN(msg, arg1) ++ __API_DR_BEGIN(msg, arg2) ++ __API_DR_BEGIN(msg, arg3);
}
pub inline fn __API_DEPRECATED_WITH_REPLACEMENT_BEGIN4(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype) @TypeOf(__API_DR_BEGIN(msg, arg0) ++ __API_DR_BEGIN(msg, arg1) ++ __API_DR_BEGIN(msg, arg2) ++ __API_DR_BEGIN(msg, arg3) ++ __API_DR_BEGIN(msg, arg4)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    return __API_DR_BEGIN(msg, arg0) ++ __API_DR_BEGIN(msg, arg1) ++ __API_DR_BEGIN(msg, arg2) ++ __API_DR_BEGIN(msg, arg3) ++ __API_DR_BEGIN(msg, arg4);
}
pub inline fn __API_DEPRECATED_WITH_REPLACEMENT_BEGIN5(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype) @TypeOf(__API_DR_BEGIN(msg, arg0) ++ __API_DR_BEGIN(msg, arg1) ++ __API_DR_BEGIN(msg, arg2) ++ __API_DR_BEGIN(msg, arg3) ++ __API_DR_BEGIN(msg, arg4) ++ __API_DR_BEGIN(msg, arg5)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    return __API_DR_BEGIN(msg, arg0) ++ __API_DR_BEGIN(msg, arg1) ++ __API_DR_BEGIN(msg, arg2) ++ __API_DR_BEGIN(msg, arg3) ++ __API_DR_BEGIN(msg, arg4) ++ __API_DR_BEGIN(msg, arg5);
}
pub inline fn __API_DEPRECATED_WITH_REPLACEMENT_BEGIN6(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype) @TypeOf(__API_DR_BEGIN(msg, arg0) ++ __API_DR_BEGIN(msg, arg1) ++ __API_DR_BEGIN(msg, arg2) ++ __API_DR_BEGIN(msg, arg3) ++ __API_DR_BEGIN(msg, arg4) ++ __API_DR_BEGIN(msg, arg5) ++ __API_DR_BEGIN(msg, arg6)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    return __API_DR_BEGIN(msg, arg0) ++ __API_DR_BEGIN(msg, arg1) ++ __API_DR_BEGIN(msg, arg2) ++ __API_DR_BEGIN(msg, arg3) ++ __API_DR_BEGIN(msg, arg4) ++ __API_DR_BEGIN(msg, arg5) ++ __API_DR_BEGIN(msg, arg6);
}
pub inline fn __API_DEPRECATED_WITH_REPLACEMENT_BEGIN7(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype) @TypeOf(__API_DR_BEGIN(msg, arg0) ++ __API_DR_BEGIN(msg, arg1) ++ __API_DR_BEGIN(msg, arg2) ++ __API_DR_BEGIN(msg, arg3) ++ __API_DR_BEGIN(msg, arg4) ++ __API_DR_BEGIN(msg, arg5) ++ __API_DR_BEGIN(msg, arg6) ++ __API_DR_BEGIN(msg, arg7)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    return __API_DR_BEGIN(msg, arg0) ++ __API_DR_BEGIN(msg, arg1) ++ __API_DR_BEGIN(msg, arg2) ++ __API_DR_BEGIN(msg, arg3) ++ __API_DR_BEGIN(msg, arg4) ++ __API_DR_BEGIN(msg, arg5) ++ __API_DR_BEGIN(msg, arg6) ++ __API_DR_BEGIN(msg, arg7);
}
pub inline fn __API_DEPRECATED_WITH_REPLACEMENT_BEGIN8(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype) @TypeOf(__API_DR_BEGIN(msg, arg0) ++ __API_DR_BEGIN(msg, arg1) ++ __API_DR_BEGIN(msg, arg2) ++ __API_DR_BEGIN(msg, arg3) ++ __API_DR_BEGIN(msg, arg4) ++ __API_DR_BEGIN(msg, arg5) ++ __API_DR_BEGIN(msg, arg6) ++ __API_DR_BEGIN(msg, arg7) ++ __API_DR_BEGIN(msg, arg8)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    return __API_DR_BEGIN(msg, arg0) ++ __API_DR_BEGIN(msg, arg1) ++ __API_DR_BEGIN(msg, arg2) ++ __API_DR_BEGIN(msg, arg3) ++ __API_DR_BEGIN(msg, arg4) ++ __API_DR_BEGIN(msg, arg5) ++ __API_DR_BEGIN(msg, arg6) ++ __API_DR_BEGIN(msg, arg7) ++ __API_DR_BEGIN(msg, arg8);
}
pub inline fn __API_DEPRECATED_WITH_REPLACEMENT_BEGIN9(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype) @TypeOf(__API_DR_BEGIN(msg, arg0) ++ __API_DR_BEGIN(msg, arg1) ++ __API_DR_BEGIN(msg, arg2) ++ __API_DR_BEGIN(msg, arg3) ++ __API_DR_BEGIN(msg, arg4) ++ __API_DR_BEGIN(msg, arg5) ++ __API_DR_BEGIN(msg, arg6) ++ __API_DR_BEGIN(msg, arg7) ++ __API_DR_BEGIN(msg, arg8) ++ __API_DR_BEGIN(msg, arg9)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    return __API_DR_BEGIN(msg, arg0) ++ __API_DR_BEGIN(msg, arg1) ++ __API_DR_BEGIN(msg, arg2) ++ __API_DR_BEGIN(msg, arg3) ++ __API_DR_BEGIN(msg, arg4) ++ __API_DR_BEGIN(msg, arg5) ++ __API_DR_BEGIN(msg, arg6) ++ __API_DR_BEGIN(msg, arg7) ++ __API_DR_BEGIN(msg, arg8) ++ __API_DR_BEGIN(msg, arg9);
}
pub inline fn __API_DEPRECATED_WITH_REPLACEMENT_BEGIN10(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype, arg10: anytype) @TypeOf(__API_DR_BEGIN(msg, arg0) ++ __API_DR_BEGIN(msg, arg1) ++ __API_DR_BEGIN(msg, arg2) ++ __API_DR_BEGIN(msg, arg3) ++ __API_DR_BEGIN(msg, arg4) ++ __API_DR_BEGIN(msg, arg5) ++ __API_DR_BEGIN(msg, arg6) ++ __API_DR_BEGIN(msg, arg7) ++ __API_DR_BEGIN(msg, arg8) ++ __API_DR_BEGIN(msg, arg9) ++ __API_DR_BEGIN(msg, arg10)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    _ = &arg10;
    return __API_DR_BEGIN(msg, arg0) ++ __API_DR_BEGIN(msg, arg1) ++ __API_DR_BEGIN(msg, arg2) ++ __API_DR_BEGIN(msg, arg3) ++ __API_DR_BEGIN(msg, arg4) ++ __API_DR_BEGIN(msg, arg5) ++ __API_DR_BEGIN(msg, arg6) ++ __API_DR_BEGIN(msg, arg7) ++ __API_DR_BEGIN(msg, arg8) ++ __API_DR_BEGIN(msg, arg9) ++ __API_DR_BEGIN(msg, arg10);
}
pub inline fn __API_DEPRECATED_WITH_REPLACEMENT_BEGIN11(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype, arg10: anytype, arg11: anytype) @TypeOf(__API_DR_BEGIN(msg, arg0) ++ __API_DR_BEGIN(msg, arg1) ++ __API_DR_BEGIN(msg, arg2) ++ __API_DR_BEGIN(msg, arg3) ++ __API_DR_BEGIN(msg, arg4) ++ __API_DR_BEGIN(msg, arg5) ++ __API_DR_BEGIN(msg, arg6) ++ __API_DR_BEGIN(msg, arg7) ++ __API_DR_BEGIN(msg, arg8) ++ __API_DR_BEGIN(msg, arg9) ++ __API_DR_BEGIN(msg, arg10) ++ __API_DR_BEGIN(msg, arg11)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    _ = &arg10;
    _ = &arg11;
    return __API_DR_BEGIN(msg, arg0) ++ __API_DR_BEGIN(msg, arg1) ++ __API_DR_BEGIN(msg, arg2) ++ __API_DR_BEGIN(msg, arg3) ++ __API_DR_BEGIN(msg, arg4) ++ __API_DR_BEGIN(msg, arg5) ++ __API_DR_BEGIN(msg, arg6) ++ __API_DR_BEGIN(msg, arg7) ++ __API_DR_BEGIN(msg, arg8) ++ __API_DR_BEGIN(msg, arg9) ++ __API_DR_BEGIN(msg, arg10) ++ __API_DR_BEGIN(msg, arg11);
}
pub inline fn __API_DEPRECATED_WITH_REPLACEMENT_BEGIN12(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype, arg10: anytype, arg11: anytype, arg12: anytype) @TypeOf(__API_DR_BEGIN(msg, arg0) ++ __API_DR_BEGIN(msg, arg1) ++ __API_DR_BEGIN(msg, arg2) ++ __API_DR_BEGIN(msg, arg3) ++ __API_DR_BEGIN(msg, arg4) ++ __API_DR_BEGIN(msg, arg5) ++ __API_DR_BEGIN(msg, arg6) ++ __API_DR_BEGIN(msg, arg7) ++ __API_DR_BEGIN(msg, arg8) ++ __API_DR_BEGIN(msg, arg9) ++ __API_DR_BEGIN(msg, arg10) ++ __API_DR_BEGIN(msg, arg11) ++ __API_DR_BEGIN(msg, arg12)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    _ = &arg10;
    _ = &arg11;
    _ = &arg12;
    return __API_DR_BEGIN(msg, arg0) ++ __API_DR_BEGIN(msg, arg1) ++ __API_DR_BEGIN(msg, arg2) ++ __API_DR_BEGIN(msg, arg3) ++ __API_DR_BEGIN(msg, arg4) ++ __API_DR_BEGIN(msg, arg5) ++ __API_DR_BEGIN(msg, arg6) ++ __API_DR_BEGIN(msg, arg7) ++ __API_DR_BEGIN(msg, arg8) ++ __API_DR_BEGIN(msg, arg9) ++ __API_DR_BEGIN(msg, arg10) ++ __API_DR_BEGIN(msg, arg11) ++ __API_DR_BEGIN(msg, arg12);
}
pub inline fn __API_DEPRECATED_WITH_REPLACEMENT_BEGIN13(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype, arg10: anytype, arg11: anytype, arg12: anytype, arg13: anytype) @TypeOf(__API_DR_BEGIN(msg, arg0) ++ __API_DR_BEGIN(msg, arg1) ++ __API_DR_BEGIN(msg, arg2) ++ __API_DR_BEGIN(msg, arg3) ++ __API_DR_BEGIN(msg, arg4) ++ __API_DR_BEGIN(msg, arg5) ++ __API_DR_BEGIN(msg, arg6) ++ __API_DR_BEGIN(msg, arg7) ++ __API_DR_BEGIN(msg, arg8) ++ __API_DR_BEGIN(msg, arg9) ++ __API_DR_BEGIN(msg, arg10) ++ __API_DR_BEGIN(msg, arg11) ++ __API_DR_BEGIN(msg, arg12) ++ __API_DR_BEGIN(msg, arg13)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    _ = &arg10;
    _ = &arg11;
    _ = &arg12;
    _ = &arg13;
    return __API_DR_BEGIN(msg, arg0) ++ __API_DR_BEGIN(msg, arg1) ++ __API_DR_BEGIN(msg, arg2) ++ __API_DR_BEGIN(msg, arg3) ++ __API_DR_BEGIN(msg, arg4) ++ __API_DR_BEGIN(msg, arg5) ++ __API_DR_BEGIN(msg, arg6) ++ __API_DR_BEGIN(msg, arg7) ++ __API_DR_BEGIN(msg, arg8) ++ __API_DR_BEGIN(msg, arg9) ++ __API_DR_BEGIN(msg, arg10) ++ __API_DR_BEGIN(msg, arg11) ++ __API_DR_BEGIN(msg, arg12) ++ __API_DR_BEGIN(msg, arg13);
}
pub inline fn __API_DEPRECATED_WITH_REPLACEMENT_BEGIN14(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype, arg10: anytype, arg11: anytype, arg12: anytype, arg13: anytype, arg14: anytype) @TypeOf(__API_DR_BEGIN(msg, arg0) ++ __API_DR_BEGIN(msg, arg1) ++ __API_DR_BEGIN(msg, arg2) ++ __API_DR_BEGIN(msg, arg3) ++ __API_DR_BEGIN(msg, arg4) ++ __API_DR_BEGIN(msg, arg5) ++ __API_DR_BEGIN(msg, arg6) ++ __API_DR_BEGIN(msg, arg7) ++ __API_DR_BEGIN(msg, arg8) ++ __API_DR_BEGIN(msg, arg9) ++ __API_DR_BEGIN(msg, arg10) ++ __API_DR_BEGIN(msg, arg11) ++ __API_DR_BEGIN(msg, arg12) ++ __API_DR_BEGIN(msg, arg13) ++ __API_DR_BEGIN(msg, arg14)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    _ = &arg10;
    _ = &arg11;
    _ = &arg12;
    _ = &arg13;
    _ = &arg14;
    return __API_DR_BEGIN(msg, arg0) ++ __API_DR_BEGIN(msg, arg1) ++ __API_DR_BEGIN(msg, arg2) ++ __API_DR_BEGIN(msg, arg3) ++ __API_DR_BEGIN(msg, arg4) ++ __API_DR_BEGIN(msg, arg5) ++ __API_DR_BEGIN(msg, arg6) ++ __API_DR_BEGIN(msg, arg7) ++ __API_DR_BEGIN(msg, arg8) ++ __API_DR_BEGIN(msg, arg9) ++ __API_DR_BEGIN(msg, arg10) ++ __API_DR_BEGIN(msg, arg11) ++ __API_DR_BEGIN(msg, arg12) ++ __API_DR_BEGIN(msg, arg13) ++ __API_DR_BEGIN(msg, arg14);
}
pub inline fn __API_DEPRECATED_WITH_REPLACEMENT_BEGIN15(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype, arg10: anytype, arg11: anytype, arg12: anytype, arg13: anytype, arg14: anytype, arg15: anytype) @TypeOf(__API_DR_BEGIN(msg, arg0) ++ __API_DR_BEGIN(msg, arg1) ++ __API_DR_BEGIN(msg, arg2) ++ __API_DR_BEGIN(msg, arg3) ++ __API_DR_BEGIN(msg, arg4) ++ __API_DR_BEGIN(msg, arg5) ++ __API_DR_BEGIN(msg, arg6) ++ __API_DR_BEGIN(msg, arg7) ++ __API_DR_BEGIN(msg, arg8) ++ __API_DR_BEGIN(msg, arg9) ++ __API_DR_BEGIN(msg, arg10) ++ __API_DR_BEGIN(msg, arg11) ++ __API_DR_BEGIN(msg, arg12) ++ __API_DR_BEGIN(msg, arg13) ++ __API_DR_BEGIN(msg, arg14) ++ __API_DR_BEGIN(msg, arg15)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    _ = &arg10;
    _ = &arg11;
    _ = &arg12;
    _ = &arg13;
    _ = &arg14;
    _ = &arg15;
    return __API_DR_BEGIN(msg, arg0) ++ __API_DR_BEGIN(msg, arg1) ++ __API_DR_BEGIN(msg, arg2) ++ __API_DR_BEGIN(msg, arg3) ++ __API_DR_BEGIN(msg, arg4) ++ __API_DR_BEGIN(msg, arg5) ++ __API_DR_BEGIN(msg, arg6) ++ __API_DR_BEGIN(msg, arg7) ++ __API_DR_BEGIN(msg, arg8) ++ __API_DR_BEGIN(msg, arg9) ++ __API_DR_BEGIN(msg, arg10) ++ __API_DR_BEGIN(msg, arg11) ++ __API_DR_BEGIN(msg, arg12) ++ __API_DR_BEGIN(msg, arg13) ++ __API_DR_BEGIN(msg, arg14) ++ __API_DR_BEGIN(msg, arg15);
}
pub const __API_DEPRECATED_WITH_REPLACEMENT_BEGIN_GET_MACRO_93585900 = @compileError("unable to translate C expr: expected ')' instead got '...'");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/AvailabilityInternal.h:360:13
pub const __API_O = @compileError("unable to translate macro: undefined identifier `availability`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/AvailabilityInternal.h:364:9
pub inline fn __API_OBSOLETED_MSG0(msg: anytype, arg0: anytype) @TypeOf(__API_O(msg, arg0)) {
    _ = &msg;
    _ = &arg0;
    return __API_O(msg, arg0);
}
pub inline fn __API_OBSOLETED_MSG1(msg: anytype, arg0: anytype, arg1: anytype) @TypeOf(__API_O(msg, arg0) ++ __API_O(msg, arg1)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    return __API_O(msg, arg0) ++ __API_O(msg, arg1);
}
pub inline fn __API_OBSOLETED_MSG2(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype) @TypeOf(__API_O(msg, arg0) ++ __API_O(msg, arg1) ++ __API_O(msg, arg2)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    return __API_O(msg, arg0) ++ __API_O(msg, arg1) ++ __API_O(msg, arg2);
}
pub inline fn __API_OBSOLETED_MSG3(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype) @TypeOf(__API_O(msg, arg0) ++ __API_O(msg, arg1) ++ __API_O(msg, arg2) ++ __API_O(msg, arg3)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    return __API_O(msg, arg0) ++ __API_O(msg, arg1) ++ __API_O(msg, arg2) ++ __API_O(msg, arg3);
}
pub inline fn __API_OBSOLETED_MSG4(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype) @TypeOf(__API_O(msg, arg0) ++ __API_O(msg, arg1) ++ __API_O(msg, arg2) ++ __API_O(msg, arg3) ++ __API_O(msg, arg4)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    return __API_O(msg, arg0) ++ __API_O(msg, arg1) ++ __API_O(msg, arg2) ++ __API_O(msg, arg3) ++ __API_O(msg, arg4);
}
pub inline fn __API_OBSOLETED_MSG5(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype) @TypeOf(__API_O(msg, arg0) ++ __API_O(msg, arg1) ++ __API_O(msg, arg2) ++ __API_O(msg, arg3) ++ __API_O(msg, arg4) ++ __API_O(msg, arg5)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    return __API_O(msg, arg0) ++ __API_O(msg, arg1) ++ __API_O(msg, arg2) ++ __API_O(msg, arg3) ++ __API_O(msg, arg4) ++ __API_O(msg, arg5);
}
pub inline fn __API_OBSOLETED_MSG6(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype) @TypeOf(__API_O(msg, arg0) ++ __API_O(msg, arg1) ++ __API_O(msg, arg2) ++ __API_O(msg, arg3) ++ __API_O(msg, arg4) ++ __API_O(msg, arg5) ++ __API_O(msg, arg6)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    return __API_O(msg, arg0) ++ __API_O(msg, arg1) ++ __API_O(msg, arg2) ++ __API_O(msg, arg3) ++ __API_O(msg, arg4) ++ __API_O(msg, arg5) ++ __API_O(msg, arg6);
}
pub inline fn __API_OBSOLETED_MSG7(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype) @TypeOf(__API_O(msg, arg0) ++ __API_O(msg, arg1) ++ __API_O(msg, arg2) ++ __API_O(msg, arg3) ++ __API_O(msg, arg4) ++ __API_O(msg, arg5) ++ __API_O(msg, arg6) ++ __API_O(msg, arg7)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    return __API_O(msg, arg0) ++ __API_O(msg, arg1) ++ __API_O(msg, arg2) ++ __API_O(msg, arg3) ++ __API_O(msg, arg4) ++ __API_O(msg, arg5) ++ __API_O(msg, arg6) ++ __API_O(msg, arg7);
}
pub inline fn __API_OBSOLETED_MSG8(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype) @TypeOf(__API_O(msg, arg0) ++ __API_O(msg, arg1) ++ __API_O(msg, arg2) ++ __API_O(msg, arg3) ++ __API_O(msg, arg4) ++ __API_O(msg, arg5) ++ __API_O(msg, arg6) ++ __API_O(msg, arg7) ++ __API_O(msg, arg8)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    return __API_O(msg, arg0) ++ __API_O(msg, arg1) ++ __API_O(msg, arg2) ++ __API_O(msg, arg3) ++ __API_O(msg, arg4) ++ __API_O(msg, arg5) ++ __API_O(msg, arg6) ++ __API_O(msg, arg7) ++ __API_O(msg, arg8);
}
pub inline fn __API_OBSOLETED_MSG9(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype) @TypeOf(__API_O(msg, arg0) ++ __API_O(msg, arg1) ++ __API_O(msg, arg2) ++ __API_O(msg, arg3) ++ __API_O(msg, arg4) ++ __API_O(msg, arg5) ++ __API_O(msg, arg6) ++ __API_O(msg, arg7) ++ __API_O(msg, arg8) ++ __API_O(msg, arg9)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    return __API_O(msg, arg0) ++ __API_O(msg, arg1) ++ __API_O(msg, arg2) ++ __API_O(msg, arg3) ++ __API_O(msg, arg4) ++ __API_O(msg, arg5) ++ __API_O(msg, arg6) ++ __API_O(msg, arg7) ++ __API_O(msg, arg8) ++ __API_O(msg, arg9);
}
pub inline fn __API_OBSOLETED_MSG10(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype, arg10: anytype) @TypeOf(__API_O(msg, arg0) ++ __API_O(msg, arg1) ++ __API_O(msg, arg2) ++ __API_O(msg, arg3) ++ __API_O(msg, arg4) ++ __API_O(msg, arg5) ++ __API_O(msg, arg6) ++ __API_O(msg, arg7) ++ __API_O(msg, arg8) ++ __API_O(msg, arg9) ++ __API_O(msg, arg10)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    _ = &arg10;
    return __API_O(msg, arg0) ++ __API_O(msg, arg1) ++ __API_O(msg, arg2) ++ __API_O(msg, arg3) ++ __API_O(msg, arg4) ++ __API_O(msg, arg5) ++ __API_O(msg, arg6) ++ __API_O(msg, arg7) ++ __API_O(msg, arg8) ++ __API_O(msg, arg9) ++ __API_O(msg, arg10);
}
pub inline fn __API_OBSOLETED_MSG11(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype, arg10: anytype, arg11: anytype) @TypeOf(__API_O(msg, arg0) ++ __API_O(msg, arg1) ++ __API_O(msg, arg2) ++ __API_O(msg, arg3) ++ __API_O(msg, arg4) ++ __API_O(msg, arg5) ++ __API_O(msg, arg6) ++ __API_O(msg, arg7) ++ __API_O(msg, arg8) ++ __API_O(msg, arg9) ++ __API_O(msg, arg10) ++ __API_O(msg, arg11)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    _ = &arg10;
    _ = &arg11;
    return __API_O(msg, arg0) ++ __API_O(msg, arg1) ++ __API_O(msg, arg2) ++ __API_O(msg, arg3) ++ __API_O(msg, arg4) ++ __API_O(msg, arg5) ++ __API_O(msg, arg6) ++ __API_O(msg, arg7) ++ __API_O(msg, arg8) ++ __API_O(msg, arg9) ++ __API_O(msg, arg10) ++ __API_O(msg, arg11);
}
pub inline fn __API_OBSOLETED_MSG12(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype, arg10: anytype, arg11: anytype, arg12: anytype) @TypeOf(__API_O(msg, arg0) ++ __API_O(msg, arg1) ++ __API_O(msg, arg2) ++ __API_O(msg, arg3) ++ __API_O(msg, arg4) ++ __API_O(msg, arg5) ++ __API_O(msg, arg6) ++ __API_O(msg, arg7) ++ __API_O(msg, arg8) ++ __API_O(msg, arg9) ++ __API_O(msg, arg10) ++ __API_O(msg, arg11) ++ __API_O(msg, arg12)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    _ = &arg10;
    _ = &arg11;
    _ = &arg12;
    return __API_O(msg, arg0) ++ __API_O(msg, arg1) ++ __API_O(msg, arg2) ++ __API_O(msg, arg3) ++ __API_O(msg, arg4) ++ __API_O(msg, arg5) ++ __API_O(msg, arg6) ++ __API_O(msg, arg7) ++ __API_O(msg, arg8) ++ __API_O(msg, arg9) ++ __API_O(msg, arg10) ++ __API_O(msg, arg11) ++ __API_O(msg, arg12);
}
pub inline fn __API_OBSOLETED_MSG13(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype, arg10: anytype, arg11: anytype, arg12: anytype, arg13: anytype) @TypeOf(__API_O(msg, arg0) ++ __API_O(msg, arg1) ++ __API_O(msg, arg2) ++ __API_O(msg, arg3) ++ __API_O(msg, arg4) ++ __API_O(msg, arg5) ++ __API_O(msg, arg6) ++ __API_O(msg, arg7) ++ __API_O(msg, arg8) ++ __API_O(msg, arg9) ++ __API_O(msg, arg10) ++ __API_O(msg, arg11) ++ __API_O(msg, arg12) ++ __API_O(msg, arg13)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    _ = &arg10;
    _ = &arg11;
    _ = &arg12;
    _ = &arg13;
    return __API_O(msg, arg0) ++ __API_O(msg, arg1) ++ __API_O(msg, arg2) ++ __API_O(msg, arg3) ++ __API_O(msg, arg4) ++ __API_O(msg, arg5) ++ __API_O(msg, arg6) ++ __API_O(msg, arg7) ++ __API_O(msg, arg8) ++ __API_O(msg, arg9) ++ __API_O(msg, arg10) ++ __API_O(msg, arg11) ++ __API_O(msg, arg12) ++ __API_O(msg, arg13);
}
pub inline fn __API_OBSOLETED_MSG14(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype, arg10: anytype, arg11: anytype, arg12: anytype, arg13: anytype, arg14: anytype) @TypeOf(__API_O(msg, arg0) ++ __API_O(msg, arg1) ++ __API_O(msg, arg2) ++ __API_O(msg, arg3) ++ __API_O(msg, arg4) ++ __API_O(msg, arg5) ++ __API_O(msg, arg6) ++ __API_O(msg, arg7) ++ __API_O(msg, arg8) ++ __API_O(msg, arg9) ++ __API_O(msg, arg10) ++ __API_O(msg, arg11) ++ __API_O(msg, arg12) ++ __API_O(msg, arg13) ++ __API_O(msg, arg14)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    _ = &arg10;
    _ = &arg11;
    _ = &arg12;
    _ = &arg13;
    _ = &arg14;
    return __API_O(msg, arg0) ++ __API_O(msg, arg1) ++ __API_O(msg, arg2) ++ __API_O(msg, arg3) ++ __API_O(msg, arg4) ++ __API_O(msg, arg5) ++ __API_O(msg, arg6) ++ __API_O(msg, arg7) ++ __API_O(msg, arg8) ++ __API_O(msg, arg9) ++ __API_O(msg, arg10) ++ __API_O(msg, arg11) ++ __API_O(msg, arg12) ++ __API_O(msg, arg13) ++ __API_O(msg, arg14);
}
pub inline fn __API_OBSOLETED_MSG15(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype, arg10: anytype, arg11: anytype, arg12: anytype, arg13: anytype, arg14: anytype, arg15: anytype) @TypeOf(__API_O(msg, arg0) ++ __API_O(msg, arg1) ++ __API_O(msg, arg2) ++ __API_O(msg, arg3) ++ __API_O(msg, arg4) ++ __API_O(msg, arg5) ++ __API_O(msg, arg6) ++ __API_O(msg, arg7) ++ __API_O(msg, arg8) ++ __API_O(msg, arg9) ++ __API_O(msg, arg10) ++ __API_O(msg, arg11) ++ __API_O(msg, arg12) ++ __API_O(msg, arg13) ++ __API_O(msg, arg14) ++ __API_O(msg, arg15)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    _ = &arg10;
    _ = &arg11;
    _ = &arg12;
    _ = &arg13;
    _ = &arg14;
    _ = &arg15;
    return __API_O(msg, arg0) ++ __API_O(msg, arg1) ++ __API_O(msg, arg2) ++ __API_O(msg, arg3) ++ __API_O(msg, arg4) ++ __API_O(msg, arg5) ++ __API_O(msg, arg6) ++ __API_O(msg, arg7) ++ __API_O(msg, arg8) ++ __API_O(msg, arg9) ++ __API_O(msg, arg10) ++ __API_O(msg, arg11) ++ __API_O(msg, arg12) ++ __API_O(msg, arg13) ++ __API_O(msg, arg14) ++ __API_O(msg, arg15);
}
pub const __API_OBSOLETED_MSG_GET_MACRO_93585900 = @compileError("unable to translate C expr: expected ')' instead got '...'");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/AvailabilityInternal.h:382:13
pub const __API_O_BEGIN = @compileError("unable to translate macro: undefined identifier `_Pragma`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/AvailabilityInternal.h:384:9
pub inline fn __API_OBSOLETED_BEGIN0(msg: anytype, arg0: anytype) @TypeOf(__API_O_BEGIN(msg, arg0)) {
    _ = &msg;
    _ = &arg0;
    return __API_O_BEGIN(msg, arg0);
}
pub inline fn __API_OBSOLETED_BEGIN1(msg: anytype, arg0: anytype, arg1: anytype) @TypeOf(__API_O_BEGIN(msg, arg0) ++ __API_O_BEGIN(msg, arg1)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    return __API_O_BEGIN(msg, arg0) ++ __API_O_BEGIN(msg, arg1);
}
pub inline fn __API_OBSOLETED_BEGIN2(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype) @TypeOf(__API_O_BEGIN(msg, arg0) ++ __API_O_BEGIN(msg, arg1) ++ __API_O_BEGIN(msg, arg2)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    return __API_O_BEGIN(msg, arg0) ++ __API_O_BEGIN(msg, arg1) ++ __API_O_BEGIN(msg, arg2);
}
pub inline fn __API_OBSOLETED_BEGIN3(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype) @TypeOf(__API_O_BEGIN(msg, arg0) ++ __API_O_BEGIN(msg, arg1) ++ __API_O_BEGIN(msg, arg2) ++ __API_O_BEGIN(msg, arg3)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    return __API_O_BEGIN(msg, arg0) ++ __API_O_BEGIN(msg, arg1) ++ __API_O_BEGIN(msg, arg2) ++ __API_O_BEGIN(msg, arg3);
}
pub inline fn __API_OBSOLETED_BEGIN4(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype) @TypeOf(__API_O_BEGIN(msg, arg0) ++ __API_O_BEGIN(msg, arg1) ++ __API_O_BEGIN(msg, arg2) ++ __API_O_BEGIN(msg, arg3) ++ __API_O_BEGIN(msg, arg4)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    return __API_O_BEGIN(msg, arg0) ++ __API_O_BEGIN(msg, arg1) ++ __API_O_BEGIN(msg, arg2) ++ __API_O_BEGIN(msg, arg3) ++ __API_O_BEGIN(msg, arg4);
}
pub inline fn __API_OBSOLETED_BEGIN5(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype) @TypeOf(__API_O_BEGIN(msg, arg0) ++ __API_O_BEGIN(msg, arg1) ++ __API_O_BEGIN(msg, arg2) ++ __API_O_BEGIN(msg, arg3) ++ __API_O_BEGIN(msg, arg4) ++ __API_O_BEGIN(msg, arg5)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    return __API_O_BEGIN(msg, arg0) ++ __API_O_BEGIN(msg, arg1) ++ __API_O_BEGIN(msg, arg2) ++ __API_O_BEGIN(msg, arg3) ++ __API_O_BEGIN(msg, arg4) ++ __API_O_BEGIN(msg, arg5);
}
pub inline fn __API_OBSOLETED_BEGIN6(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype) @TypeOf(__API_O_BEGIN(msg, arg0) ++ __API_O_BEGIN(msg, arg1) ++ __API_O_BEGIN(msg, arg2) ++ __API_O_BEGIN(msg, arg3) ++ __API_O_BEGIN(msg, arg4) ++ __API_O_BEGIN(msg, arg5) ++ __API_O_BEGIN(msg, arg6)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    return __API_O_BEGIN(msg, arg0) ++ __API_O_BEGIN(msg, arg1) ++ __API_O_BEGIN(msg, arg2) ++ __API_O_BEGIN(msg, arg3) ++ __API_O_BEGIN(msg, arg4) ++ __API_O_BEGIN(msg, arg5) ++ __API_O_BEGIN(msg, arg6);
}
pub inline fn __API_OBSOLETED_BEGIN7(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype) @TypeOf(__API_O_BEGIN(msg, arg0) ++ __API_O_BEGIN(msg, arg1) ++ __API_O_BEGIN(msg, arg2) ++ __API_O_BEGIN(msg, arg3) ++ __API_O_BEGIN(msg, arg4) ++ __API_O_BEGIN(msg, arg5) ++ __API_O_BEGIN(msg, arg6) ++ __API_O_BEGIN(msg, arg7)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    return __API_O_BEGIN(msg, arg0) ++ __API_O_BEGIN(msg, arg1) ++ __API_O_BEGIN(msg, arg2) ++ __API_O_BEGIN(msg, arg3) ++ __API_O_BEGIN(msg, arg4) ++ __API_O_BEGIN(msg, arg5) ++ __API_O_BEGIN(msg, arg6) ++ __API_O_BEGIN(msg, arg7);
}
pub inline fn __API_OBSOLETED_BEGIN8(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype) @TypeOf(__API_O_BEGIN(msg, arg0) ++ __API_O_BEGIN(msg, arg1) ++ __API_O_BEGIN(msg, arg2) ++ __API_O_BEGIN(msg, arg3) ++ __API_O_BEGIN(msg, arg4) ++ __API_O_BEGIN(msg, arg5) ++ __API_O_BEGIN(msg, arg6) ++ __API_O_BEGIN(msg, arg7) ++ __API_O_BEGIN(msg, arg8)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    return __API_O_BEGIN(msg, arg0) ++ __API_O_BEGIN(msg, arg1) ++ __API_O_BEGIN(msg, arg2) ++ __API_O_BEGIN(msg, arg3) ++ __API_O_BEGIN(msg, arg4) ++ __API_O_BEGIN(msg, arg5) ++ __API_O_BEGIN(msg, arg6) ++ __API_O_BEGIN(msg, arg7) ++ __API_O_BEGIN(msg, arg8);
}
pub inline fn __API_OBSOLETED_BEGIN9(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype) @TypeOf(__API_O_BEGIN(msg, arg0) ++ __API_O_BEGIN(msg, arg1) ++ __API_O_BEGIN(msg, arg2) ++ __API_O_BEGIN(msg, arg3) ++ __API_O_BEGIN(msg, arg4) ++ __API_O_BEGIN(msg, arg5) ++ __API_O_BEGIN(msg, arg6) ++ __API_O_BEGIN(msg, arg7) ++ __API_O_BEGIN(msg, arg8) ++ __API_O_BEGIN(msg, arg9)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    return __API_O_BEGIN(msg, arg0) ++ __API_O_BEGIN(msg, arg1) ++ __API_O_BEGIN(msg, arg2) ++ __API_O_BEGIN(msg, arg3) ++ __API_O_BEGIN(msg, arg4) ++ __API_O_BEGIN(msg, arg5) ++ __API_O_BEGIN(msg, arg6) ++ __API_O_BEGIN(msg, arg7) ++ __API_O_BEGIN(msg, arg8) ++ __API_O_BEGIN(msg, arg9);
}
pub inline fn __API_OBSOLETED_BEGIN10(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype, arg10: anytype) @TypeOf(__API_O_BEGIN(msg, arg0) ++ __API_O_BEGIN(msg, arg1) ++ __API_O_BEGIN(msg, arg2) ++ __API_O_BEGIN(msg, arg3) ++ __API_O_BEGIN(msg, arg4) ++ __API_O_BEGIN(msg, arg5) ++ __API_O_BEGIN(msg, arg6) ++ __API_O_BEGIN(msg, arg7) ++ __API_O_BEGIN(msg, arg8) ++ __API_O_BEGIN(msg, arg9) ++ __API_O_BEGIN(msg, arg10)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    _ = &arg10;
    return __API_O_BEGIN(msg, arg0) ++ __API_O_BEGIN(msg, arg1) ++ __API_O_BEGIN(msg, arg2) ++ __API_O_BEGIN(msg, arg3) ++ __API_O_BEGIN(msg, arg4) ++ __API_O_BEGIN(msg, arg5) ++ __API_O_BEGIN(msg, arg6) ++ __API_O_BEGIN(msg, arg7) ++ __API_O_BEGIN(msg, arg8) ++ __API_O_BEGIN(msg, arg9) ++ __API_O_BEGIN(msg, arg10);
}
pub inline fn __API_OBSOLETED_BEGIN11(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype, arg10: anytype, arg11: anytype) @TypeOf(__API_O_BEGIN(msg, arg0) ++ __API_O_BEGIN(msg, arg1) ++ __API_O_BEGIN(msg, arg2) ++ __API_O_BEGIN(msg, arg3) ++ __API_O_BEGIN(msg, arg4) ++ __API_O_BEGIN(msg, arg5) ++ __API_O_BEGIN(msg, arg6) ++ __API_O_BEGIN(msg, arg7) ++ __API_O_BEGIN(msg, arg8) ++ __API_O_BEGIN(msg, arg9) ++ __API_O_BEGIN(msg, arg10) ++ __API_O_BEGIN(msg, arg11)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    _ = &arg10;
    _ = &arg11;
    return __API_O_BEGIN(msg, arg0) ++ __API_O_BEGIN(msg, arg1) ++ __API_O_BEGIN(msg, arg2) ++ __API_O_BEGIN(msg, arg3) ++ __API_O_BEGIN(msg, arg4) ++ __API_O_BEGIN(msg, arg5) ++ __API_O_BEGIN(msg, arg6) ++ __API_O_BEGIN(msg, arg7) ++ __API_O_BEGIN(msg, arg8) ++ __API_O_BEGIN(msg, arg9) ++ __API_O_BEGIN(msg, arg10) ++ __API_O_BEGIN(msg, arg11);
}
pub inline fn __API_OBSOLETED_BEGIN12(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype, arg10: anytype, arg11: anytype, arg12: anytype) @TypeOf(__API_O_BEGIN(msg, arg0) ++ __API_O_BEGIN(msg, arg1) ++ __API_O_BEGIN(msg, arg2) ++ __API_O_BEGIN(msg, arg3) ++ __API_O_BEGIN(msg, arg4) ++ __API_O_BEGIN(msg, arg5) ++ __API_O_BEGIN(msg, arg6) ++ __API_O_BEGIN(msg, arg7) ++ __API_O_BEGIN(msg, arg8) ++ __API_O_BEGIN(msg, arg9) ++ __API_O_BEGIN(msg, arg10) ++ __API_O_BEGIN(msg, arg11) ++ __API_O_BEGIN(msg, arg12)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    _ = &arg10;
    _ = &arg11;
    _ = &arg12;
    return __API_O_BEGIN(msg, arg0) ++ __API_O_BEGIN(msg, arg1) ++ __API_O_BEGIN(msg, arg2) ++ __API_O_BEGIN(msg, arg3) ++ __API_O_BEGIN(msg, arg4) ++ __API_O_BEGIN(msg, arg5) ++ __API_O_BEGIN(msg, arg6) ++ __API_O_BEGIN(msg, arg7) ++ __API_O_BEGIN(msg, arg8) ++ __API_O_BEGIN(msg, arg9) ++ __API_O_BEGIN(msg, arg10) ++ __API_O_BEGIN(msg, arg11) ++ __API_O_BEGIN(msg, arg12);
}
pub inline fn __API_OBSOLETED_BEGIN13(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype, arg10: anytype, arg11: anytype, arg12: anytype, arg13: anytype) @TypeOf(__API_O_BEGIN(msg, arg0) ++ __API_O_BEGIN(msg, arg1) ++ __API_O_BEGIN(msg, arg2) ++ __API_O_BEGIN(msg, arg3) ++ __API_O_BEGIN(msg, arg4) ++ __API_O_BEGIN(msg, arg5) ++ __API_O_BEGIN(msg, arg6) ++ __API_O_BEGIN(msg, arg7) ++ __API_O_BEGIN(msg, arg8) ++ __API_O_BEGIN(msg, arg9) ++ __API_O_BEGIN(msg, arg10) ++ __API_O_BEGIN(msg, arg11) ++ __API_O_BEGIN(msg, arg12) ++ __API_O_BEGIN(msg, arg13)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    _ = &arg10;
    _ = &arg11;
    _ = &arg12;
    _ = &arg13;
    return __API_O_BEGIN(msg, arg0) ++ __API_O_BEGIN(msg, arg1) ++ __API_O_BEGIN(msg, arg2) ++ __API_O_BEGIN(msg, arg3) ++ __API_O_BEGIN(msg, arg4) ++ __API_O_BEGIN(msg, arg5) ++ __API_O_BEGIN(msg, arg6) ++ __API_O_BEGIN(msg, arg7) ++ __API_O_BEGIN(msg, arg8) ++ __API_O_BEGIN(msg, arg9) ++ __API_O_BEGIN(msg, arg10) ++ __API_O_BEGIN(msg, arg11) ++ __API_O_BEGIN(msg, arg12) ++ __API_O_BEGIN(msg, arg13);
}
pub inline fn __API_OBSOLETED_BEGIN14(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype, arg10: anytype, arg11: anytype, arg12: anytype, arg13: anytype, arg14: anytype) @TypeOf(__API_O_BEGIN(msg, arg0) ++ __API_O_BEGIN(msg, arg1) ++ __API_O_BEGIN(msg, arg2) ++ __API_O_BEGIN(msg, arg3) ++ __API_O_BEGIN(msg, arg4) ++ __API_O_BEGIN(msg, arg5) ++ __API_O_BEGIN(msg, arg6) ++ __API_O_BEGIN(msg, arg7) ++ __API_O_BEGIN(msg, arg8) ++ __API_O_BEGIN(msg, arg9) ++ __API_O_BEGIN(msg, arg10) ++ __API_O_BEGIN(msg, arg11) ++ __API_O_BEGIN(msg, arg12) ++ __API_O_BEGIN(msg, arg13) ++ __API_O_BEGIN(msg, arg14)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    _ = &arg10;
    _ = &arg11;
    _ = &arg12;
    _ = &arg13;
    _ = &arg14;
    return __API_O_BEGIN(msg, arg0) ++ __API_O_BEGIN(msg, arg1) ++ __API_O_BEGIN(msg, arg2) ++ __API_O_BEGIN(msg, arg3) ++ __API_O_BEGIN(msg, arg4) ++ __API_O_BEGIN(msg, arg5) ++ __API_O_BEGIN(msg, arg6) ++ __API_O_BEGIN(msg, arg7) ++ __API_O_BEGIN(msg, arg8) ++ __API_O_BEGIN(msg, arg9) ++ __API_O_BEGIN(msg, arg10) ++ __API_O_BEGIN(msg, arg11) ++ __API_O_BEGIN(msg, arg12) ++ __API_O_BEGIN(msg, arg13) ++ __API_O_BEGIN(msg, arg14);
}
pub inline fn __API_OBSOLETED_BEGIN15(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype, arg10: anytype, arg11: anytype, arg12: anytype, arg13: anytype, arg14: anytype, arg15: anytype) @TypeOf(__API_O_BEGIN(msg, arg0) ++ __API_O_BEGIN(msg, arg1) ++ __API_O_BEGIN(msg, arg2) ++ __API_O_BEGIN(msg, arg3) ++ __API_O_BEGIN(msg, arg4) ++ __API_O_BEGIN(msg, arg5) ++ __API_O_BEGIN(msg, arg6) ++ __API_O_BEGIN(msg, arg7) ++ __API_O_BEGIN(msg, arg8) ++ __API_O_BEGIN(msg, arg9) ++ __API_O_BEGIN(msg, arg10) ++ __API_O_BEGIN(msg, arg11) ++ __API_O_BEGIN(msg, arg12) ++ __API_O_BEGIN(msg, arg13) ++ __API_O_BEGIN(msg, arg14) ++ __API_O_BEGIN(msg, arg15)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    _ = &arg10;
    _ = &arg11;
    _ = &arg12;
    _ = &arg13;
    _ = &arg14;
    _ = &arg15;
    return __API_O_BEGIN(msg, arg0) ++ __API_O_BEGIN(msg, arg1) ++ __API_O_BEGIN(msg, arg2) ++ __API_O_BEGIN(msg, arg3) ++ __API_O_BEGIN(msg, arg4) ++ __API_O_BEGIN(msg, arg5) ++ __API_O_BEGIN(msg, arg6) ++ __API_O_BEGIN(msg, arg7) ++ __API_O_BEGIN(msg, arg8) ++ __API_O_BEGIN(msg, arg9) ++ __API_O_BEGIN(msg, arg10) ++ __API_O_BEGIN(msg, arg11) ++ __API_O_BEGIN(msg, arg12) ++ __API_O_BEGIN(msg, arg13) ++ __API_O_BEGIN(msg, arg14) ++ __API_O_BEGIN(msg, arg15);
}
pub const __API_OBSOLETED_BEGIN_GET_MACRO_93585900 = @compileError("unable to translate C expr: expected ')' instead got '...'");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/AvailabilityInternal.h:402:13
pub const __API_OR = @compileError("unable to translate macro: undefined identifier `availability`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/AvailabilityInternal.h:405:13
pub inline fn __API_OBSOLETED_REP0(msg: anytype, arg0: anytype) @TypeOf(__API_OR(msg, arg0)) {
    _ = &msg;
    _ = &arg0;
    return __API_OR(msg, arg0);
}
pub inline fn __API_OBSOLETED_REP1(msg: anytype, arg0: anytype, arg1: anytype) @TypeOf(__API_OR(msg, arg0) ++ __API_OR(msg, arg1)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    return __API_OR(msg, arg0) ++ __API_OR(msg, arg1);
}
pub inline fn __API_OBSOLETED_REP2(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype) @TypeOf(__API_OR(msg, arg0) ++ __API_OR(msg, arg1) ++ __API_OR(msg, arg2)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    return __API_OR(msg, arg0) ++ __API_OR(msg, arg1) ++ __API_OR(msg, arg2);
}
pub inline fn __API_OBSOLETED_REP3(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype) @TypeOf(__API_OR(msg, arg0) ++ __API_OR(msg, arg1) ++ __API_OR(msg, arg2) ++ __API_OR(msg, arg3)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    return __API_OR(msg, arg0) ++ __API_OR(msg, arg1) ++ __API_OR(msg, arg2) ++ __API_OR(msg, arg3);
}
pub inline fn __API_OBSOLETED_REP4(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype) @TypeOf(__API_OR(msg, arg0) ++ __API_OR(msg, arg1) ++ __API_OR(msg, arg2) ++ __API_OR(msg, arg3) ++ __API_OR(msg, arg4)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    return __API_OR(msg, arg0) ++ __API_OR(msg, arg1) ++ __API_OR(msg, arg2) ++ __API_OR(msg, arg3) ++ __API_OR(msg, arg4);
}
pub inline fn __API_OBSOLETED_REP5(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype) @TypeOf(__API_OR(msg, arg0) ++ __API_OR(msg, arg1) ++ __API_OR(msg, arg2) ++ __API_OR(msg, arg3) ++ __API_OR(msg, arg4) ++ __API_OR(msg, arg5)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    return __API_OR(msg, arg0) ++ __API_OR(msg, arg1) ++ __API_OR(msg, arg2) ++ __API_OR(msg, arg3) ++ __API_OR(msg, arg4) ++ __API_OR(msg, arg5);
}
pub inline fn __API_OBSOLETED_REP6(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype) @TypeOf(__API_OR(msg, arg0) ++ __API_OR(msg, arg1) ++ __API_OR(msg, arg2) ++ __API_OR(msg, arg3) ++ __API_OR(msg, arg4) ++ __API_OR(msg, arg5) ++ __API_OR(msg, arg6)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    return __API_OR(msg, arg0) ++ __API_OR(msg, arg1) ++ __API_OR(msg, arg2) ++ __API_OR(msg, arg3) ++ __API_OR(msg, arg4) ++ __API_OR(msg, arg5) ++ __API_OR(msg, arg6);
}
pub inline fn __API_OBSOLETED_REP7(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype) @TypeOf(__API_OR(msg, arg0) ++ __API_OR(msg, arg1) ++ __API_OR(msg, arg2) ++ __API_OR(msg, arg3) ++ __API_OR(msg, arg4) ++ __API_OR(msg, arg5) ++ __API_OR(msg, arg6) ++ __API_OR(msg, arg7)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    return __API_OR(msg, arg0) ++ __API_OR(msg, arg1) ++ __API_OR(msg, arg2) ++ __API_OR(msg, arg3) ++ __API_OR(msg, arg4) ++ __API_OR(msg, arg5) ++ __API_OR(msg, arg6) ++ __API_OR(msg, arg7);
}
pub inline fn __API_OBSOLETED_REP8(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype) @TypeOf(__API_OR(msg, arg0) ++ __API_OR(msg, arg1) ++ __API_OR(msg, arg2) ++ __API_OR(msg, arg3) ++ __API_OR(msg, arg4) ++ __API_OR(msg, arg5) ++ __API_OR(msg, arg6) ++ __API_OR(msg, arg7) ++ __API_OR(msg, arg8)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    return __API_OR(msg, arg0) ++ __API_OR(msg, arg1) ++ __API_OR(msg, arg2) ++ __API_OR(msg, arg3) ++ __API_OR(msg, arg4) ++ __API_OR(msg, arg5) ++ __API_OR(msg, arg6) ++ __API_OR(msg, arg7) ++ __API_OR(msg, arg8);
}
pub inline fn __API_OBSOLETED_REP9(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype) @TypeOf(__API_OR(msg, arg0) ++ __API_OR(msg, arg1) ++ __API_OR(msg, arg2) ++ __API_OR(msg, arg3) ++ __API_OR(msg, arg4) ++ __API_OR(msg, arg5) ++ __API_OR(msg, arg6) ++ __API_OR(msg, arg7) ++ __API_OR(msg, arg8) ++ __API_OR(msg, arg9)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    return __API_OR(msg, arg0) ++ __API_OR(msg, arg1) ++ __API_OR(msg, arg2) ++ __API_OR(msg, arg3) ++ __API_OR(msg, arg4) ++ __API_OR(msg, arg5) ++ __API_OR(msg, arg6) ++ __API_OR(msg, arg7) ++ __API_OR(msg, arg8) ++ __API_OR(msg, arg9);
}
pub inline fn __API_OBSOLETED_REP10(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype, arg10: anytype) @TypeOf(__API_OR(msg, arg0) ++ __API_OR(msg, arg1) ++ __API_OR(msg, arg2) ++ __API_OR(msg, arg3) ++ __API_OR(msg, arg4) ++ __API_OR(msg, arg5) ++ __API_OR(msg, arg6) ++ __API_OR(msg, arg7) ++ __API_OR(msg, arg8) ++ __API_OR(msg, arg9) ++ __API_OR(msg, arg10)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    _ = &arg10;
    return __API_OR(msg, arg0) ++ __API_OR(msg, arg1) ++ __API_OR(msg, arg2) ++ __API_OR(msg, arg3) ++ __API_OR(msg, arg4) ++ __API_OR(msg, arg5) ++ __API_OR(msg, arg6) ++ __API_OR(msg, arg7) ++ __API_OR(msg, arg8) ++ __API_OR(msg, arg9) ++ __API_OR(msg, arg10);
}
pub inline fn __API_OBSOLETED_REP11(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype, arg10: anytype, arg11: anytype) @TypeOf(__API_OR(msg, arg0) ++ __API_OR(msg, arg1) ++ __API_OR(msg, arg2) ++ __API_OR(msg, arg3) ++ __API_OR(msg, arg4) ++ __API_OR(msg, arg5) ++ __API_OR(msg, arg6) ++ __API_OR(msg, arg7) ++ __API_OR(msg, arg8) ++ __API_OR(msg, arg9) ++ __API_OR(msg, arg10) ++ __API_OR(msg, arg11)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    _ = &arg10;
    _ = &arg11;
    return __API_OR(msg, arg0) ++ __API_OR(msg, arg1) ++ __API_OR(msg, arg2) ++ __API_OR(msg, arg3) ++ __API_OR(msg, arg4) ++ __API_OR(msg, arg5) ++ __API_OR(msg, arg6) ++ __API_OR(msg, arg7) ++ __API_OR(msg, arg8) ++ __API_OR(msg, arg9) ++ __API_OR(msg, arg10) ++ __API_OR(msg, arg11);
}
pub inline fn __API_OBSOLETED_REP12(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype, arg10: anytype, arg11: anytype, arg12: anytype) @TypeOf(__API_OR(msg, arg0) ++ __API_OR(msg, arg1) ++ __API_OR(msg, arg2) ++ __API_OR(msg, arg3) ++ __API_OR(msg, arg4) ++ __API_OR(msg, arg5) ++ __API_OR(msg, arg6) ++ __API_OR(msg, arg7) ++ __API_OR(msg, arg8) ++ __API_OR(msg, arg9) ++ __API_OR(msg, arg10) ++ __API_OR(msg, arg11) ++ __API_OR(msg, arg12)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    _ = &arg10;
    _ = &arg11;
    _ = &arg12;
    return __API_OR(msg, arg0) ++ __API_OR(msg, arg1) ++ __API_OR(msg, arg2) ++ __API_OR(msg, arg3) ++ __API_OR(msg, arg4) ++ __API_OR(msg, arg5) ++ __API_OR(msg, arg6) ++ __API_OR(msg, arg7) ++ __API_OR(msg, arg8) ++ __API_OR(msg, arg9) ++ __API_OR(msg, arg10) ++ __API_OR(msg, arg11) ++ __API_OR(msg, arg12);
}
pub inline fn __API_OBSOLETED_REP13(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype, arg10: anytype, arg11: anytype, arg12: anytype, arg13: anytype) @TypeOf(__API_OR(msg, arg0) ++ __API_OR(msg, arg1) ++ __API_OR(msg, arg2) ++ __API_OR(msg, arg3) ++ __API_OR(msg, arg4) ++ __API_OR(msg, arg5) ++ __API_OR(msg, arg6) ++ __API_OR(msg, arg7) ++ __API_OR(msg, arg8) ++ __API_OR(msg, arg9) ++ __API_OR(msg, arg10) ++ __API_OR(msg, arg11) ++ __API_OR(msg, arg12) ++ __API_OR(msg, arg13)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    _ = &arg10;
    _ = &arg11;
    _ = &arg12;
    _ = &arg13;
    return __API_OR(msg, arg0) ++ __API_OR(msg, arg1) ++ __API_OR(msg, arg2) ++ __API_OR(msg, arg3) ++ __API_OR(msg, arg4) ++ __API_OR(msg, arg5) ++ __API_OR(msg, arg6) ++ __API_OR(msg, arg7) ++ __API_OR(msg, arg8) ++ __API_OR(msg, arg9) ++ __API_OR(msg, arg10) ++ __API_OR(msg, arg11) ++ __API_OR(msg, arg12) ++ __API_OR(msg, arg13);
}
pub inline fn __API_OBSOLETED_REP14(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype, arg10: anytype, arg11: anytype, arg12: anytype, arg13: anytype, arg14: anytype) @TypeOf(__API_OR(msg, arg0) ++ __API_OR(msg, arg1) ++ __API_OR(msg, arg2) ++ __API_OR(msg, arg3) ++ __API_OR(msg, arg4) ++ __API_OR(msg, arg5) ++ __API_OR(msg, arg6) ++ __API_OR(msg, arg7) ++ __API_OR(msg, arg8) ++ __API_OR(msg, arg9) ++ __API_OR(msg, arg10) ++ __API_OR(msg, arg11) ++ __API_OR(msg, arg12) ++ __API_OR(msg, arg13) ++ __API_OR(msg, arg14)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    _ = &arg10;
    _ = &arg11;
    _ = &arg12;
    _ = &arg13;
    _ = &arg14;
    return __API_OR(msg, arg0) ++ __API_OR(msg, arg1) ++ __API_OR(msg, arg2) ++ __API_OR(msg, arg3) ++ __API_OR(msg, arg4) ++ __API_OR(msg, arg5) ++ __API_OR(msg, arg6) ++ __API_OR(msg, arg7) ++ __API_OR(msg, arg8) ++ __API_OR(msg, arg9) ++ __API_OR(msg, arg10) ++ __API_OR(msg, arg11) ++ __API_OR(msg, arg12) ++ __API_OR(msg, arg13) ++ __API_OR(msg, arg14);
}
pub inline fn __API_OBSOLETED_REP15(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype, arg10: anytype, arg11: anytype, arg12: anytype, arg13: anytype, arg14: anytype, arg15: anytype) @TypeOf(__API_OR(msg, arg0) ++ __API_OR(msg, arg1) ++ __API_OR(msg, arg2) ++ __API_OR(msg, arg3) ++ __API_OR(msg, arg4) ++ __API_OR(msg, arg5) ++ __API_OR(msg, arg6) ++ __API_OR(msg, arg7) ++ __API_OR(msg, arg8) ++ __API_OR(msg, arg9) ++ __API_OR(msg, arg10) ++ __API_OR(msg, arg11) ++ __API_OR(msg, arg12) ++ __API_OR(msg, arg13) ++ __API_OR(msg, arg14) ++ __API_OR(msg, arg15)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    _ = &arg10;
    _ = &arg11;
    _ = &arg12;
    _ = &arg13;
    _ = &arg14;
    _ = &arg15;
    return __API_OR(msg, arg0) ++ __API_OR(msg, arg1) ++ __API_OR(msg, arg2) ++ __API_OR(msg, arg3) ++ __API_OR(msg, arg4) ++ __API_OR(msg, arg5) ++ __API_OR(msg, arg6) ++ __API_OR(msg, arg7) ++ __API_OR(msg, arg8) ++ __API_OR(msg, arg9) ++ __API_OR(msg, arg10) ++ __API_OR(msg, arg11) ++ __API_OR(msg, arg12) ++ __API_OR(msg, arg13) ++ __API_OR(msg, arg14) ++ __API_OR(msg, arg15);
}
pub const __API_OBSOLETED_REP_GET_MACRO_93585900 = @compileError("unable to translate C expr: expected ')' instead got '...'");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/AvailabilityInternal.h:426:13
pub const __API_OR_BEGIN = @compileError("unable to translate macro: undefined identifier `_Pragma`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/AvailabilityInternal.h:429:13
pub const __API_OBSOLETED_WITH_REPLACEMENT_BEGIN0 = @compileError("unable to translate macro: undefined identifier `__API_R_BEGIN`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/AvailabilityInternal.h:434:13
pub const __API_OBSOLETED_WITH_REPLACEMENT_BEGIN1 = @compileError("unable to translate macro: undefined identifier `__API_R_BEGIN`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/AvailabilityInternal.h:435:13
pub const __API_OBSOLETED_WITH_REPLACEMENT_BEGIN2 = @compileError("unable to translate macro: undefined identifier `__API_R_BEGIN`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/AvailabilityInternal.h:436:13
pub const __API_OBSOLETED_WITH_REPLACEMENT_BEGIN3 = @compileError("unable to translate macro: undefined identifier `__API_R_BEGIN`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/AvailabilityInternal.h:437:13
pub const __API_OBSOLETED_WITH_REPLACEMENT_BEGIN4 = @compileError("unable to translate macro: undefined identifier `__API_R_BEGIN`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/AvailabilityInternal.h:438:13
pub const __API_OBSOLETED_WITH_REPLACEMENT_BEGIN5 = @compileError("unable to translate macro: undefined identifier `__API_R_BEGIN`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/AvailabilityInternal.h:439:13
pub const __API_OBSOLETED_WITH_REPLACEMENT_BEGIN6 = @compileError("unable to translate macro: undefined identifier `__API_R_BEGIN`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/AvailabilityInternal.h:440:13
pub const __API_OBSOLETED_WITH_REPLACEMENT_BEGIN7 = @compileError("unable to translate macro: undefined identifier `__API_R_BEGIN`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/AvailabilityInternal.h:441:13
pub const __API_OBSOLETED_WITH_REPLACEMENT_BEGIN8 = @compileError("unable to translate macro: undefined identifier `__API_R_BEGIN`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/AvailabilityInternal.h:442:13
pub const __API_OBSOLETED_WITH_REPLACEMENT_BEGIN9 = @compileError("unable to translate macro: undefined identifier `__API_R_BEGIN`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/AvailabilityInternal.h:443:13
pub const __API_OBSOLETED_WITH_REPLACEMENT_BEGIN10 = @compileError("unable to translate macro: undefined identifier `__API_R_BEGIN`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/AvailabilityInternal.h:444:13
pub const __API_OBSOLETED_WITH_REPLACEMENT_BEGIN11 = @compileError("unable to translate macro: undefined identifier `__API_R_BEGIN`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/AvailabilityInternal.h:445:13
pub const __API_OBSOLETED_WITH_REPLACEMENT_BEGIN12 = @compileError("unable to translate macro: undefined identifier `__API_R_BEGIN`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/AvailabilityInternal.h:446:13
pub const __API_OBSOLETED_WITH_REPLACEMENT_BEGIN13 = @compileError("unable to translate macro: undefined identifier `__API_R_BEGIN`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/AvailabilityInternal.h:447:13
pub const __API_OBSOLETED_WITH_REPLACEMENT_BEGIN14 = @compileError("unable to translate macro: undefined identifier `__API_R_BEGIN`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/AvailabilityInternal.h:448:13
pub const __API_OBSOLETED_WITH_REPLACEMENT_BEGIN15 = @compileError("unable to translate macro: undefined identifier `__API_R_BEGIN`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/AvailabilityInternal.h:449:13
pub const __API_OBSOLETED_WITH_REPLACEMENT_BEGIN_GET_MACRO_93585900 = @compileError("unable to translate C expr: expected ')' instead got '...'");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/AvailabilityInternal.h:450:13
pub const __API_U = @compileError("unable to translate macro: undefined identifier `availability`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/AvailabilityInternal.h:461:13
pub inline fn __API_UNAVAILABLE0(arg0: anytype) @TypeOf(__API_U(arg0)) {
    _ = &arg0;
    return __API_U(arg0);
}
pub inline fn __API_UNAVAILABLE1(arg0: anytype, arg1: anytype) @TypeOf(__API_U(arg0) ++ __API_U(arg1)) {
    _ = &arg0;
    _ = &arg1;
    return __API_U(arg0) ++ __API_U(arg1);
}
pub inline fn __API_UNAVAILABLE2(arg0: anytype, arg1: anytype, arg2: anytype) @TypeOf(__API_U(arg0) ++ __API_U(arg1) ++ __API_U(arg2)) {
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    return __API_U(arg0) ++ __API_U(arg1) ++ __API_U(arg2);
}
pub inline fn __API_UNAVAILABLE3(arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype) @TypeOf(__API_U(arg0) ++ __API_U(arg1) ++ __API_U(arg2) ++ __API_U(arg3)) {
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    return __API_U(arg0) ++ __API_U(arg1) ++ __API_U(arg2) ++ __API_U(arg3);
}
pub inline fn __API_UNAVAILABLE4(arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype) @TypeOf(__API_U(arg0) ++ __API_U(arg1) ++ __API_U(arg2) ++ __API_U(arg3) ++ __API_U(arg4)) {
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    return __API_U(arg0) ++ __API_U(arg1) ++ __API_U(arg2) ++ __API_U(arg3) ++ __API_U(arg4);
}
pub inline fn __API_UNAVAILABLE5(arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype) @TypeOf(__API_U(arg0) ++ __API_U(arg1) ++ __API_U(arg2) ++ __API_U(arg3) ++ __API_U(arg4) ++ __API_U(arg5)) {
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    return __API_U(arg0) ++ __API_U(arg1) ++ __API_U(arg2) ++ __API_U(arg3) ++ __API_U(arg4) ++ __API_U(arg5);
}
pub inline fn __API_UNAVAILABLE6(arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype) @TypeOf(__API_U(arg0) ++ __API_U(arg1) ++ __API_U(arg2) ++ __API_U(arg3) ++ __API_U(arg4) ++ __API_U(arg5) ++ __API_U(arg6)) {
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    return __API_U(arg0) ++ __API_U(arg1) ++ __API_U(arg2) ++ __API_U(arg3) ++ __API_U(arg4) ++ __API_U(arg5) ++ __API_U(arg6);
}
pub inline fn __API_UNAVAILABLE7(arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype) @TypeOf(__API_U(arg0) ++ __API_U(arg1) ++ __API_U(arg2) ++ __API_U(arg3) ++ __API_U(arg4) ++ __API_U(arg5) ++ __API_U(arg6) ++ __API_U(arg7)) {
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    return __API_U(arg0) ++ __API_U(arg1) ++ __API_U(arg2) ++ __API_U(arg3) ++ __API_U(arg4) ++ __API_U(arg5) ++ __API_U(arg6) ++ __API_U(arg7);
}
pub inline fn __API_UNAVAILABLE8(arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype) @TypeOf(__API_U(arg0) ++ __API_U(arg1) ++ __API_U(arg2) ++ __API_U(arg3) ++ __API_U(arg4) ++ __API_U(arg5) ++ __API_U(arg6) ++ __API_U(arg7) ++ __API_U(arg8)) {
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    return __API_U(arg0) ++ __API_U(arg1) ++ __API_U(arg2) ++ __API_U(arg3) ++ __API_U(arg4) ++ __API_U(arg5) ++ __API_U(arg6) ++ __API_U(arg7) ++ __API_U(arg8);
}
pub inline fn __API_UNAVAILABLE9(arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype) @TypeOf(__API_U(arg0) ++ __API_U(arg1) ++ __API_U(arg2) ++ __API_U(arg3) ++ __API_U(arg4) ++ __API_U(arg5) ++ __API_U(arg6) ++ __API_U(arg7) ++ __API_U(arg8) ++ __API_U(arg9)) {
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    return __API_U(arg0) ++ __API_U(arg1) ++ __API_U(arg2) ++ __API_U(arg3) ++ __API_U(arg4) ++ __API_U(arg5) ++ __API_U(arg6) ++ __API_U(arg7) ++ __API_U(arg8) ++ __API_U(arg9);
}
pub inline fn __API_UNAVAILABLE10(arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype, arg10: anytype) @TypeOf(__API_U(arg0) ++ __API_U(arg1) ++ __API_U(arg2) ++ __API_U(arg3) ++ __API_U(arg4) ++ __API_U(arg5) ++ __API_U(arg6) ++ __API_U(arg7) ++ __API_U(arg8) ++ __API_U(arg9) ++ __API_U(arg10)) {
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    _ = &arg10;
    return __API_U(arg0) ++ __API_U(arg1) ++ __API_U(arg2) ++ __API_U(arg3) ++ __API_U(arg4) ++ __API_U(arg5) ++ __API_U(arg6) ++ __API_U(arg7) ++ __API_U(arg8) ++ __API_U(arg9) ++ __API_U(arg10);
}
pub inline fn __API_UNAVAILABLE11(arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype, arg10: anytype, arg11: anytype) @TypeOf(__API_U(arg0) ++ __API_U(arg1) ++ __API_U(arg2) ++ __API_U(arg3) ++ __API_U(arg4) ++ __API_U(arg5) ++ __API_U(arg6) ++ __API_U(arg7) ++ __API_U(arg8) ++ __API_U(arg9) ++ __API_U(arg10) ++ __API_U(arg11)) {
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    _ = &arg10;
    _ = &arg11;
    return __API_U(arg0) ++ __API_U(arg1) ++ __API_U(arg2) ++ __API_U(arg3) ++ __API_U(arg4) ++ __API_U(arg5) ++ __API_U(arg6) ++ __API_U(arg7) ++ __API_U(arg8) ++ __API_U(arg9) ++ __API_U(arg10) ++ __API_U(arg11);
}
pub inline fn __API_UNAVAILABLE12(arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype, arg10: anytype, arg11: anytype, arg12: anytype) @TypeOf(__API_U(arg0) ++ __API_U(arg1) ++ __API_U(arg2) ++ __API_U(arg3) ++ __API_U(arg4) ++ __API_U(arg5) ++ __API_U(arg6) ++ __API_U(arg7) ++ __API_U(arg8) ++ __API_U(arg9) ++ __API_U(arg10) ++ __API_U(arg11) ++ __API_U(arg12)) {
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    _ = &arg10;
    _ = &arg11;
    _ = &arg12;
    return __API_U(arg0) ++ __API_U(arg1) ++ __API_U(arg2) ++ __API_U(arg3) ++ __API_U(arg4) ++ __API_U(arg5) ++ __API_U(arg6) ++ __API_U(arg7) ++ __API_U(arg8) ++ __API_U(arg9) ++ __API_U(arg10) ++ __API_U(arg11) ++ __API_U(arg12);
}
pub inline fn __API_UNAVAILABLE13(arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype, arg10: anytype, arg11: anytype, arg12: anytype, arg13: anytype) @TypeOf(__API_U(arg0) ++ __API_U(arg1) ++ __API_U(arg2) ++ __API_U(arg3) ++ __API_U(arg4) ++ __API_U(arg5) ++ __API_U(arg6) ++ __API_U(arg7) ++ __API_U(arg8) ++ __API_U(arg9) ++ __API_U(arg10) ++ __API_U(arg11) ++ __API_U(arg12) ++ __API_U(arg13)) {
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    _ = &arg10;
    _ = &arg11;
    _ = &arg12;
    _ = &arg13;
    return __API_U(arg0) ++ __API_U(arg1) ++ __API_U(arg2) ++ __API_U(arg3) ++ __API_U(arg4) ++ __API_U(arg5) ++ __API_U(arg6) ++ __API_U(arg7) ++ __API_U(arg8) ++ __API_U(arg9) ++ __API_U(arg10) ++ __API_U(arg11) ++ __API_U(arg12) ++ __API_U(arg13);
}
pub inline fn __API_UNAVAILABLE14(arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype, arg10: anytype, arg11: anytype, arg12: anytype, arg13: anytype, arg14: anytype) @TypeOf(__API_U(arg0) ++ __API_U(arg1) ++ __API_U(arg2) ++ __API_U(arg3) ++ __API_U(arg4) ++ __API_U(arg5) ++ __API_U(arg6) ++ __API_U(arg7) ++ __API_U(arg8) ++ __API_U(arg9) ++ __API_U(arg10) ++ __API_U(arg11) ++ __API_U(arg12) ++ __API_U(arg13) ++ __API_U(arg14)) {
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    _ = &arg10;
    _ = &arg11;
    _ = &arg12;
    _ = &arg13;
    _ = &arg14;
    return __API_U(arg0) ++ __API_U(arg1) ++ __API_U(arg2) ++ __API_U(arg3) ++ __API_U(arg4) ++ __API_U(arg5) ++ __API_U(arg6) ++ __API_U(arg7) ++ __API_U(arg8) ++ __API_U(arg9) ++ __API_U(arg10) ++ __API_U(arg11) ++ __API_U(arg12) ++ __API_U(arg13) ++ __API_U(arg14);
}
pub inline fn __API_UNAVAILABLE15(arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype, arg10: anytype, arg11: anytype, arg12: anytype, arg13: anytype, arg14: anytype, arg15: anytype) @TypeOf(__API_U(arg0) ++ __API_U(arg1) ++ __API_U(arg2) ++ __API_U(arg3) ++ __API_U(arg4) ++ __API_U(arg5) ++ __API_U(arg6) ++ __API_U(arg7) ++ __API_U(arg8) ++ __API_U(arg9) ++ __API_U(arg10) ++ __API_U(arg11) ++ __API_U(arg12) ++ __API_U(arg13) ++ __API_U(arg14) ++ __API_U(arg15)) {
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    _ = &arg10;
    _ = &arg11;
    _ = &arg12;
    _ = &arg13;
    _ = &arg14;
    _ = &arg15;
    return __API_U(arg0) ++ __API_U(arg1) ++ __API_U(arg2) ++ __API_U(arg3) ++ __API_U(arg4) ++ __API_U(arg5) ++ __API_U(arg6) ++ __API_U(arg7) ++ __API_U(arg8) ++ __API_U(arg9) ++ __API_U(arg10) ++ __API_U(arg11) ++ __API_U(arg12) ++ __API_U(arg13) ++ __API_U(arg14) ++ __API_U(arg15);
}
pub const __API_UNAVAILABLE_GET_MACRO_93585900 = @compileError("unable to translate C expr: expected ')' instead got '...'");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/AvailabilityInternal.h:479:13
pub const __API_U_BEGIN = @compileError("unable to translate macro: undefined identifier `_Pragma`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/AvailabilityInternal.h:481:13
pub inline fn __API_UNAVAILABLE_BEGIN0(arg0: anytype) @TypeOf(__API_U_BEGIN(arg0)) {
    _ = &arg0;
    return __API_U_BEGIN(arg0);
}
pub inline fn __API_UNAVAILABLE_BEGIN1(arg0: anytype, arg1: anytype) @TypeOf(__API_U_BEGIN(arg0) ++ __API_U_BEGIN(arg1)) {
    _ = &arg0;
    _ = &arg1;
    return __API_U_BEGIN(arg0) ++ __API_U_BEGIN(arg1);
}
pub inline fn __API_UNAVAILABLE_BEGIN2(arg0: anytype, arg1: anytype, arg2: anytype) @TypeOf(__API_U_BEGIN(arg0) ++ __API_U_BEGIN(arg1) ++ __API_U_BEGIN(arg2)) {
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    return __API_U_BEGIN(arg0) ++ __API_U_BEGIN(arg1) ++ __API_U_BEGIN(arg2);
}
pub inline fn __API_UNAVAILABLE_BEGIN3(arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype) @TypeOf(__API_U_BEGIN(arg0) ++ __API_U_BEGIN(arg1) ++ __API_U_BEGIN(arg2) ++ __API_U_BEGIN(arg3)) {
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    return __API_U_BEGIN(arg0) ++ __API_U_BEGIN(arg1) ++ __API_U_BEGIN(arg2) ++ __API_U_BEGIN(arg3);
}
pub inline fn __API_UNAVAILABLE_BEGIN4(arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype) @TypeOf(__API_U_BEGIN(arg0) ++ __API_U_BEGIN(arg1) ++ __API_U_BEGIN(arg2) ++ __API_U_BEGIN(arg3) ++ __API_U_BEGIN(arg4)) {
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    return __API_U_BEGIN(arg0) ++ __API_U_BEGIN(arg1) ++ __API_U_BEGIN(arg2) ++ __API_U_BEGIN(arg3) ++ __API_U_BEGIN(arg4);
}
pub inline fn __API_UNAVAILABLE_BEGIN5(arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype) @TypeOf(__API_U_BEGIN(arg0) ++ __API_U_BEGIN(arg1) ++ __API_U_BEGIN(arg2) ++ __API_U_BEGIN(arg3) ++ __API_U_BEGIN(arg4) ++ __API_U_BEGIN(arg5)) {
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    return __API_U_BEGIN(arg0) ++ __API_U_BEGIN(arg1) ++ __API_U_BEGIN(arg2) ++ __API_U_BEGIN(arg3) ++ __API_U_BEGIN(arg4) ++ __API_U_BEGIN(arg5);
}
pub inline fn __API_UNAVAILABLE_BEGIN6(arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype) @TypeOf(__API_U_BEGIN(arg0) ++ __API_U_BEGIN(arg1) ++ __API_U_BEGIN(arg2) ++ __API_U_BEGIN(arg3) ++ __API_U_BEGIN(arg4) ++ __API_U_BEGIN(arg5) ++ __API_U_BEGIN(arg6)) {
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    return __API_U_BEGIN(arg0) ++ __API_U_BEGIN(arg1) ++ __API_U_BEGIN(arg2) ++ __API_U_BEGIN(arg3) ++ __API_U_BEGIN(arg4) ++ __API_U_BEGIN(arg5) ++ __API_U_BEGIN(arg6);
}
pub inline fn __API_UNAVAILABLE_BEGIN7(arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype) @TypeOf(__API_U_BEGIN(arg0) ++ __API_U_BEGIN(arg1) ++ __API_U_BEGIN(arg2) ++ __API_U_BEGIN(arg3) ++ __API_U_BEGIN(arg4) ++ __API_U_BEGIN(arg5) ++ __API_U_BEGIN(arg6) ++ __API_U_BEGIN(arg7)) {
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    return __API_U_BEGIN(arg0) ++ __API_U_BEGIN(arg1) ++ __API_U_BEGIN(arg2) ++ __API_U_BEGIN(arg3) ++ __API_U_BEGIN(arg4) ++ __API_U_BEGIN(arg5) ++ __API_U_BEGIN(arg6) ++ __API_U_BEGIN(arg7);
}
pub inline fn __API_UNAVAILABLE_BEGIN8(arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype) @TypeOf(__API_U_BEGIN(arg0) ++ __API_U_BEGIN(arg1) ++ __API_U_BEGIN(arg2) ++ __API_U_BEGIN(arg3) ++ __API_U_BEGIN(arg4) ++ __API_U_BEGIN(arg5) ++ __API_U_BEGIN(arg6) ++ __API_U_BEGIN(arg7) ++ __API_U_BEGIN(arg8)) {
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    return __API_U_BEGIN(arg0) ++ __API_U_BEGIN(arg1) ++ __API_U_BEGIN(arg2) ++ __API_U_BEGIN(arg3) ++ __API_U_BEGIN(arg4) ++ __API_U_BEGIN(arg5) ++ __API_U_BEGIN(arg6) ++ __API_U_BEGIN(arg7) ++ __API_U_BEGIN(arg8);
}
pub inline fn __API_UNAVAILABLE_BEGIN9(arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype) @TypeOf(__API_U_BEGIN(arg0) ++ __API_U_BEGIN(arg1) ++ __API_U_BEGIN(arg2) ++ __API_U_BEGIN(arg3) ++ __API_U_BEGIN(arg4) ++ __API_U_BEGIN(arg5) ++ __API_U_BEGIN(arg6) ++ __API_U_BEGIN(arg7) ++ __API_U_BEGIN(arg8) ++ __API_U_BEGIN(arg9)) {
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    return __API_U_BEGIN(arg0) ++ __API_U_BEGIN(arg1) ++ __API_U_BEGIN(arg2) ++ __API_U_BEGIN(arg3) ++ __API_U_BEGIN(arg4) ++ __API_U_BEGIN(arg5) ++ __API_U_BEGIN(arg6) ++ __API_U_BEGIN(arg7) ++ __API_U_BEGIN(arg8) ++ __API_U_BEGIN(arg9);
}
pub inline fn __API_UNAVAILABLE_BEGIN10(arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype, arg10: anytype) @TypeOf(__API_U_BEGIN(arg0) ++ __API_U_BEGIN(arg1) ++ __API_U_BEGIN(arg2) ++ __API_U_BEGIN(arg3) ++ __API_U_BEGIN(arg4) ++ __API_U_BEGIN(arg5) ++ __API_U_BEGIN(arg6) ++ __API_U_BEGIN(arg7) ++ __API_U_BEGIN(arg8) ++ __API_U_BEGIN(arg9) ++ __API_U_BEGIN(arg10)) {
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    _ = &arg10;
    return __API_U_BEGIN(arg0) ++ __API_U_BEGIN(arg1) ++ __API_U_BEGIN(arg2) ++ __API_U_BEGIN(arg3) ++ __API_U_BEGIN(arg4) ++ __API_U_BEGIN(arg5) ++ __API_U_BEGIN(arg6) ++ __API_U_BEGIN(arg7) ++ __API_U_BEGIN(arg8) ++ __API_U_BEGIN(arg9) ++ __API_U_BEGIN(arg10);
}
pub inline fn __API_UNAVAILABLE_BEGIN11(arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype, arg10: anytype, arg11: anytype) @TypeOf(__API_U_BEGIN(arg0) ++ __API_U_BEGIN(arg1) ++ __API_U_BEGIN(arg2) ++ __API_U_BEGIN(arg3) ++ __API_U_BEGIN(arg4) ++ __API_U_BEGIN(arg5) ++ __API_U_BEGIN(arg6) ++ __API_U_BEGIN(arg7) ++ __API_U_BEGIN(arg8) ++ __API_U_BEGIN(arg9) ++ __API_U_BEGIN(arg10) ++ __API_U_BEGIN(arg11)) {
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    _ = &arg10;
    _ = &arg11;
    return __API_U_BEGIN(arg0) ++ __API_U_BEGIN(arg1) ++ __API_U_BEGIN(arg2) ++ __API_U_BEGIN(arg3) ++ __API_U_BEGIN(arg4) ++ __API_U_BEGIN(arg5) ++ __API_U_BEGIN(arg6) ++ __API_U_BEGIN(arg7) ++ __API_U_BEGIN(arg8) ++ __API_U_BEGIN(arg9) ++ __API_U_BEGIN(arg10) ++ __API_U_BEGIN(arg11);
}
pub inline fn __API_UNAVAILABLE_BEGIN12(arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype, arg10: anytype, arg11: anytype, arg12: anytype) @TypeOf(__API_U_BEGIN(arg0) ++ __API_U_BEGIN(arg1) ++ __API_U_BEGIN(arg2) ++ __API_U_BEGIN(arg3) ++ __API_U_BEGIN(arg4) ++ __API_U_BEGIN(arg5) ++ __API_U_BEGIN(arg6) ++ __API_U_BEGIN(arg7) ++ __API_U_BEGIN(arg8) ++ __API_U_BEGIN(arg9) ++ __API_U_BEGIN(arg10) ++ __API_U_BEGIN(arg11) ++ __API_U_BEGIN(arg12)) {
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    _ = &arg10;
    _ = &arg11;
    _ = &arg12;
    return __API_U_BEGIN(arg0) ++ __API_U_BEGIN(arg1) ++ __API_U_BEGIN(arg2) ++ __API_U_BEGIN(arg3) ++ __API_U_BEGIN(arg4) ++ __API_U_BEGIN(arg5) ++ __API_U_BEGIN(arg6) ++ __API_U_BEGIN(arg7) ++ __API_U_BEGIN(arg8) ++ __API_U_BEGIN(arg9) ++ __API_U_BEGIN(arg10) ++ __API_U_BEGIN(arg11) ++ __API_U_BEGIN(arg12);
}
pub inline fn __API_UNAVAILABLE_BEGIN13(arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype, arg10: anytype, arg11: anytype, arg12: anytype, arg13: anytype) @TypeOf(__API_U_BEGIN(arg0) ++ __API_U_BEGIN(arg1) ++ __API_U_BEGIN(arg2) ++ __API_U_BEGIN(arg3) ++ __API_U_BEGIN(arg4) ++ __API_U_BEGIN(arg5) ++ __API_U_BEGIN(arg6) ++ __API_U_BEGIN(arg7) ++ __API_U_BEGIN(arg8) ++ __API_U_BEGIN(arg9) ++ __API_U_BEGIN(arg10) ++ __API_U_BEGIN(arg11) ++ __API_U_BEGIN(arg12) ++ __API_U_BEGIN(arg13)) {
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    _ = &arg10;
    _ = &arg11;
    _ = &arg12;
    _ = &arg13;
    return __API_U_BEGIN(arg0) ++ __API_U_BEGIN(arg1) ++ __API_U_BEGIN(arg2) ++ __API_U_BEGIN(arg3) ++ __API_U_BEGIN(arg4) ++ __API_U_BEGIN(arg5) ++ __API_U_BEGIN(arg6) ++ __API_U_BEGIN(arg7) ++ __API_U_BEGIN(arg8) ++ __API_U_BEGIN(arg9) ++ __API_U_BEGIN(arg10) ++ __API_U_BEGIN(arg11) ++ __API_U_BEGIN(arg12) ++ __API_U_BEGIN(arg13);
}
pub inline fn __API_UNAVAILABLE_BEGIN14(arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype, arg10: anytype, arg11: anytype, arg12: anytype, arg13: anytype, arg14: anytype) @TypeOf(__API_U_BEGIN(arg0) ++ __API_U_BEGIN(arg1) ++ __API_U_BEGIN(arg2) ++ __API_U_BEGIN(arg3) ++ __API_U_BEGIN(arg4) ++ __API_U_BEGIN(arg5) ++ __API_U_BEGIN(arg6) ++ __API_U_BEGIN(arg7) ++ __API_U_BEGIN(arg8) ++ __API_U_BEGIN(arg9) ++ __API_U_BEGIN(arg10) ++ __API_U_BEGIN(arg11) ++ __API_U_BEGIN(arg12) ++ __API_U_BEGIN(arg13) ++ __API_U_BEGIN(arg14)) {
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    _ = &arg10;
    _ = &arg11;
    _ = &arg12;
    _ = &arg13;
    _ = &arg14;
    return __API_U_BEGIN(arg0) ++ __API_U_BEGIN(arg1) ++ __API_U_BEGIN(arg2) ++ __API_U_BEGIN(arg3) ++ __API_U_BEGIN(arg4) ++ __API_U_BEGIN(arg5) ++ __API_U_BEGIN(arg6) ++ __API_U_BEGIN(arg7) ++ __API_U_BEGIN(arg8) ++ __API_U_BEGIN(arg9) ++ __API_U_BEGIN(arg10) ++ __API_U_BEGIN(arg11) ++ __API_U_BEGIN(arg12) ++ __API_U_BEGIN(arg13) ++ __API_U_BEGIN(arg14);
}
pub inline fn __API_UNAVAILABLE_BEGIN15(arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype, arg10: anytype, arg11: anytype, arg12: anytype, arg13: anytype, arg14: anytype, arg15: anytype) @TypeOf(__API_U_BEGIN(arg0) ++ __API_U_BEGIN(arg1) ++ __API_U_BEGIN(arg2) ++ __API_U_BEGIN(arg3) ++ __API_U_BEGIN(arg4) ++ __API_U_BEGIN(arg5) ++ __API_U_BEGIN(arg6) ++ __API_U_BEGIN(arg7) ++ __API_U_BEGIN(arg8) ++ __API_U_BEGIN(arg9) ++ __API_U_BEGIN(arg10) ++ __API_U_BEGIN(arg11) ++ __API_U_BEGIN(arg12) ++ __API_U_BEGIN(arg13) ++ __API_U_BEGIN(arg14) ++ __API_U_BEGIN(arg15)) {
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    _ = &arg10;
    _ = &arg11;
    _ = &arg12;
    _ = &arg13;
    _ = &arg14;
    _ = &arg15;
    return __API_U_BEGIN(arg0) ++ __API_U_BEGIN(arg1) ++ __API_U_BEGIN(arg2) ++ __API_U_BEGIN(arg3) ++ __API_U_BEGIN(arg4) ++ __API_U_BEGIN(arg5) ++ __API_U_BEGIN(arg6) ++ __API_U_BEGIN(arg7) ++ __API_U_BEGIN(arg8) ++ __API_U_BEGIN(arg9) ++ __API_U_BEGIN(arg10) ++ __API_U_BEGIN(arg11) ++ __API_U_BEGIN(arg12) ++ __API_U_BEGIN(arg13) ++ __API_U_BEGIN(arg14) ++ __API_U_BEGIN(arg15);
}
pub const __API_UNAVAILABLE_BEGIN_GET_MACRO_93585900 = @compileError("unable to translate C expr: expected ')' instead got '...'");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/AvailabilityInternal.h:499:13
pub const __swift_compiler_version_at_least = @compileError("unable to translate C expr: expected ')' instead got '...'");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/AvailabilityInternal.h:521:13
pub const __AVAILABILITY_INTERNAL_LEGACY__ = "";
pub const __OSX_AVAILABLE_STARTING = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/Availability.h:255:13
pub const __OSX_AVAILABLE_BUT_DEPRECATED = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/Availability.h:256:13
pub const __OSX_AVAILABLE_BUT_DEPRECATED_MSG = @compileError("unable to translate C expr: unexpected token ''");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/Availability.h:257:13
pub const __OS_AVAILABILITY = @compileError("unable to translate macro: undefined identifier `availability`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/Availability.h:263:13
pub const __OS_AVAILABILITY_MSG = @compileError("unable to translate macro: undefined identifier `availability`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/Availability.h:264:13
pub const __OSX_EXTENSION_UNAVAILABLE = @compileError("unable to translate macro: undefined identifier `macosx_app_extension`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/Availability.h:281:13
pub const __IOS_EXTENSION_UNAVAILABLE = @compileError("unable to translate macro: undefined identifier `ios_app_extension`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/Availability.h:282:13
pub inline fn __OS_EXTENSION_UNAVAILABLE(_msg: anytype) @TypeOf(__OSX_EXTENSION_UNAVAILABLE(_msg) ++ __IOS_EXTENSION_UNAVAILABLE(_msg)) {
    _ = &_msg;
    return __OSX_EXTENSION_UNAVAILABLE(_msg) ++ __IOS_EXTENSION_UNAVAILABLE(_msg);
}
pub const __OSX_UNAVAILABLE = @compileError("unable to translate macro: undefined identifier `macosx`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/Availability.h:299:13
pub const __OSX_AVAILABLE = @compileError("unable to translate macro: undefined identifier `macosx`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/Availability.h:300:13
pub const __OSX_DEPRECATED = @compileError("unable to translate macro: undefined identifier `macosx`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/Availability.h:301:13
pub const __IOS_UNAVAILABLE = @compileError("unable to translate macro: undefined identifier `ios`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/Availability.h:325:13
pub const __IOS_PROHIBITED = @compileError("unable to translate macro: undefined identifier `ios`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/Availability.h:327:15
pub const __IOS_AVAILABLE = @compileError("unable to translate macro: undefined identifier `ios`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/Availability.h:329:13
pub const __IOS_DEPRECATED = @compileError("unable to translate macro: undefined identifier `ios`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/Availability.h:330:13
pub const __TVOS_UNAVAILABLE = @compileError("unable to translate macro: undefined identifier `tvos`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/Availability.h:354:13
pub const __TVOS_PROHIBITED = @compileError("unable to translate macro: undefined identifier `tvos`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/Availability.h:356:15
pub const __TVOS_AVAILABLE = @compileError("unable to translate macro: undefined identifier `tvos`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/Availability.h:358:13
pub const __TVOS_DEPRECATED = @compileError("unable to translate macro: undefined identifier `tvos`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/Availability.h:359:13
pub const __WATCHOS_UNAVAILABLE = @compileError("unable to translate macro: undefined identifier `watchos`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/Availability.h:383:13
pub const __WATCHOS_PROHIBITED = @compileError("unable to translate macro: undefined identifier `watchos`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/Availability.h:385:15
pub const __WATCHOS_AVAILABLE = @compileError("unable to translate macro: undefined identifier `watchos`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/Availability.h:387:13
pub const __WATCHOS_DEPRECATED = @compileError("unable to translate macro: undefined identifier `watchos`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/Availability.h:388:13
pub const __SWIFT_UNAVAILABLE = @compileError("unable to translate macro: undefined identifier `swift`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/Availability.h:411:13
pub const __SWIFT_UNAVAILABLE_MSG = @compileError("unable to translate macro: undefined identifier `swift`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/Availability.h:412:13
pub const __API_AVAILABLE = @compileError("unable to translate C expr: expected ')' instead got '...'");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/Availability.h:457:13
pub const __API_AVAILABLE_BEGIN = @compileError("unable to translate C expr: expected ')' instead got '...'");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/Availability.h:459:13
pub const __API_AVAILABLE_END = @compileError("unable to translate macro: undefined identifier `_Pragma`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/Availability.h:460:13
pub const __API_DEPRECATED = @compileError("unable to translate C expr: expected ')' instead got '...'");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/Availability.h:480:13
pub const __API_DEPRECATED_WITH_REPLACEMENT = @compileError("unable to translate C expr: expected ')' instead got '...'");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/Availability.h:481:13
pub const __API_DEPRECATED_BEGIN = @compileError("unable to translate C expr: expected ')' instead got '...'");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/Availability.h:483:13
pub const __API_DEPRECATED_END = @compileError("unable to translate macro: undefined identifier `_Pragma`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/Availability.h:484:13
pub const __API_DEPRECATED_WITH_REPLACEMENT_BEGIN = @compileError("unable to translate C expr: expected ')' instead got '...'");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/Availability.h:486:13
pub const __API_DEPRECATED_WITH_REPLACEMENT_END = @compileError("unable to translate macro: undefined identifier `_Pragma`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/Availability.h:487:13
pub const __API_OBSOLETED = @compileError("unable to translate C expr: expected ')' instead got '...'");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/Availability.h:490:13
pub const __API_OBSOLETED_WITH_REPLACEMENT = @compileError("unable to translate C expr: expected ')' instead got '...'");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/Availability.h:491:13
pub const __API_OBSOLETED_BEGIN = @compileError("unable to translate C expr: expected ')' instead got '...'");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/Availability.h:493:13
pub const __API_OBSOLETED_END = @compileError("unable to translate macro: undefined identifier `_Pragma`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/Availability.h:494:13
pub const __API_OBSOLETED_WITH_REPLACEMENT_BEGIN = @compileError("unable to translate C expr: expected ')' instead got '...'");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/Availability.h:496:13
pub const __API_OBSOLETED_WITH_REPLACEMENT_END = @compileError("unable to translate macro: undefined identifier `_Pragma`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/Availability.h:497:13
pub const __API_UNAVAILABLE = @compileError("unable to translate C expr: expected ')' instead got '...'");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/Availability.h:507:13
pub const __API_UNAVAILABLE_BEGIN = @compileError("unable to translate C expr: expected ')' instead got '...'");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/Availability.h:509:13
pub const __API_UNAVAILABLE_END = @compileError("unable to translate macro: undefined identifier `_Pragma`");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/Availability.h:510:13
pub const __SPI_AVAILABLE = @compileError("unable to translate C expr: expected ')' instead got '...'");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/Availability.h:595:11
pub const __SPI_AVAILABLE_BEGIN = @compileError("unable to translate C expr: expected ')' instead got '...'");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/Availability.h:599:11
pub const __SPI_AVAILABLE_END = @compileError("unable to translate C expr: expected ')' instead got '...'");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/Availability.h:603:11
pub const __SPI_DEPRECATED = @compileError("unable to translate C expr: expected ')' instead got '...'");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/Availability.h:607:11
pub const __SPI_DEPRECATED_WITH_REPLACEMENT = @compileError("unable to translate C expr: expected ')' instead got '...'");
// /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/Availability.h:611:11
pub const USE_CLANG_STDDEF = @as(c_int, 0);
pub const _SIZE_T = "";
pub const NULL = __DARWIN_NULL;
pub const _RSIZE_T = "";
pub const _BSD_MACHINE_TYPES_H_ = "";
pub const _ARM_MACHTYPES_H_ = "";
pub const _MACHTYPES_H_ = "";
pub const _INT8_T = "";
pub const _INT16_T = "";
pub const _INT32_T = "";
pub const _INT64_T = "";
pub const _U_INT8_T = "";
pub const _U_INT16_T = "";
pub const _U_INT32_T = "";
pub const _U_INT64_T = "";
pub const USER_ADDR_NULL = @import("std").zig.c_translation.cast(user_addr_t, @as(c_int, 0));
pub inline fn CAST_USER_ADDR_T(a_ptr: anytype) user_addr_t {
    _ = &a_ptr;
    return @import("std").zig.c_translation.cast(user_addr_t, @import("std").zig.c_translation.cast(usize, a_ptr));
}
pub const _ERRNO_T = "";
pub const _SSIZE_T = "";
pub const __STRINGS_H_ = "";
pub const _SECURE__STRINGS_H_ = "";
pub const _SECURE__COMMON_H_ = "";
pub const _USE_FORTIFY_LEVEL = @as(c_int, 2);
pub inline fn __darwin_obsz0(object: anytype) @TypeOf(__builtin_object_size(object, @as(c_int, 0))) {
    _ = &object;
    return __builtin_object_size(object, @as(c_int, 0));
}
pub inline fn __darwin_obsz(object: anytype) @TypeOf(__builtin_object_size(object, if (_USE_FORTIFY_LEVEL > @as(c_int, 1)) @as(c_int, 1) else @as(c_int, 0))) {
    _ = &object;
    return __builtin_object_size(object, if (_USE_FORTIFY_LEVEL > @as(c_int, 1)) @as(c_int, 1) else @as(c_int, 0));
}
pub const _SECURE__STRING_H_ = "";
pub const __HAS_FIXED_CHK_PROTOTYPES = @as(c_int, 1);
pub const MAXMOD_H__ = "";
pub const MM_TYPES_H__ = "";
pub const MMCB_SONGMESSAGE = @as(c_int, 0x2A);
pub const MMCB_SONGFINISHED = @as(c_int, 0x2B);
pub const MMCB_SONGERROR = @as(c_int, 0x2C);
pub const MM_SIZEOF_MODCH = @as(c_int, 40);
pub const MM_SIZEOF_ACTCH = @as(c_int, 28);
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
pub const MMZ_STUB_ASSERT_H = "";
pub const static_assert = @compileError("unable to translate C expr: expected ')' instead got '...'");
// src/maxmod_gba/tc_shims/assert.h:6:9
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
pub const REG_SOUNDCNT_L = @compileError("unable to translate C expr: unexpected token 'volatile'");
// maxmod/source/gba/mixer.h:13:9
pub const REG_SOUNDCNT_H = @compileError("unable to translate C expr: unexpected token 'volatile'");
// maxmod/source/gba/mixer.h:14:9
pub const REG_SOUNDCNT_X = @compileError("unable to translate C expr: unexpected token 'volatile'");
// maxmod/source/gba/mixer.h:15:9
pub const REG_TM0CNT = @compileError("unable to translate C expr: unexpected token 'volatile'");
// maxmod/source/gba/mixer.h:17:9
pub const REG_DMA1SAD = @compileError("unable to translate C expr: unexpected token 'volatile'");
// maxmod/source/gba/mixer.h:19:9
pub const REG_DMA1DAD = @compileError("unable to translate C expr: unexpected token 'volatile'");
// maxmod/source/gba/mixer.h:20:9
pub const REG_DMA1CNT = @compileError("unable to translate C expr: unexpected token 'volatile'");
// maxmod/source/gba/mixer.h:21:9
pub const REG_DMA1CNT_H = @compileError("unable to translate C expr: unexpected token 'volatile'");
// maxmod/source/gba/mixer.h:22:9
pub const REG_DMA2SAD = @compileError("unable to translate C expr: unexpected token 'volatile'");
// maxmod/source/gba/mixer.h:24:9
pub const REG_DMA2DAD = @compileError("unable to translate C expr: unexpected token 'volatile'");
// maxmod/source/gba/mixer.h:25:9
pub const REG_DMA2CNT = @compileError("unable to translate C expr: unexpected token 'volatile'");
// maxmod/source/gba/mixer.h:26:9
pub const REG_DMA2CNT_H = @compileError("unable to translate C expr: unexpected token 'volatile'");
// maxmod/source/gba/mixer.h:27:9
pub const REG_DMA3SAD = @compileError("unable to translate C expr: unexpected token 'volatile'");
// maxmod/source/gba/mixer.h:29:9
pub const REG_DMA3DAD = @compileError("unable to translate C expr: unexpected token 'volatile'");
// maxmod/source/gba/mixer.h:30:9
pub const REG_DMA3CNT = @compileError("unable to translate C expr: unexpected token 'volatile'");
// maxmod/source/gba/mixer.h:31:9
pub const REG_SGFIFOA = @compileError("unable to translate C expr: unexpected token 'volatile'");
// maxmod/source/gba/mixer.h:33:9
pub const REG_SGFIFOB = @compileError("unable to translate C expr: unexpected token 'volatile'");
// maxmod/source/gba/mixer.h:34:9
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
pub const __darwin_pthread_handler_rec = struct___darwin_pthread_handler_rec;
pub const _opaque_pthread_attr_t = struct__opaque_pthread_attr_t;
pub const _opaque_pthread_cond_t = struct__opaque_pthread_cond_t;
pub const _opaque_pthread_condattr_t = struct__opaque_pthread_condattr_t;
pub const _opaque_pthread_mutex_t = struct__opaque_pthread_mutex_t;
pub const _opaque_pthread_mutexattr_t = struct__opaque_pthread_mutexattr_t;
pub const _opaque_pthread_once_t = struct__opaque_pthread_once_t;
pub const _opaque_pthread_rwlock_t = struct__opaque_pthread_rwlock_t;
pub const _opaque_pthread_rwlockattr_t = struct__opaque_pthread_rwlockattr_t;
pub const _opaque_pthread_t = struct__opaque_pthread_t;
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
