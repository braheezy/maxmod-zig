// Minimal Zig wrapper for Maxmod C library (libmm.a)
// This provides the function declarations that Zig needs to call the C library

const gba = @import("gba");

// Maxmod types (minimal definitions needed)
pub const mm_addr = usize;
pub const mm_word = u32;
pub const mm_hword = u16;
pub const mm_byte = u8;
pub const mm_bool = u8;
pub const mm_pmode = u8;
pub const mm_callback = ?*const fn (mm_word, mm_word) callconv(.C) void;

// Maxmod constants
pub const MM_PLAY_ONCE: mm_pmode = 0;
pub const MM_PLAY_LOOP: mm_pmode = 1;
pub const MM_PLAY_FORWARD: mm_pmode = 2;
pub const MM_PLAY_BACKWARD: mm_pmode = 3;
pub const MM_PLAY_BIDIRECTIONAL: mm_pmode = 4;

// Maxmod system structure
pub const mm_gba_system = extern struct {
    mode: mm_word,
    n_channels: mm_word,
    mix_length: mm_word,
    mix_rate: mm_word,
    timer: mm_word,
    irq: mm_word,
};

// Export Maxmod functions from libmm.a (only the ones that actually exist)
pub extern fn mmInitDefault(soundbank: mm_addr, number_of_channels: mm_word) void;
pub extern fn mmVBlank() void;
pub extern fn mmFrame() void;
pub extern fn mmStart(module_ID: mm_word, mode: mm_pmode) void;
pub extern fn mmSetModuleVolume(volume: mm_word) void;
pub extern fn mmSetEffectsVolume(volume: mm_word) void;

// Constants from soundbank.h
pub const MOD_BAD_APPLE: mm_word = 0;
pub const MSL_NSONGS: mm_word = 1;
pub const MSL_NSAMPS: mm_word = 12;
pub const MSL_BANKSIZE: mm_word = 13;
