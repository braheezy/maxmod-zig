const std = @import("std");
// Import translated modules by name (configured in build.zig)
const mas = @import("tc_mas_c_raw");
const sfix = @import("tc_samplefix_c_raw");
const adpcm = @import("tc_adpcm_c_raw");

pub export var MAS_FILESIZE: u32 = 0;
pub export var target_system: c_int = 0; // 0 = GBA path
pub export var ignore_sflags: c_int = 0; // match C main.c default
// Provide PANNING_SEP default like C code expects
pub export var PANNING_SEP: c_int = 64;

// FixSample wrapper bound to the translated implementation (renamed via -D FixSample=MM_FixSampleImpl)
pub export fn FixSample(samp: *mas.Sample) void {
    sfix.MM_FixSampleImpl(@ptrCast(samp));
}

// Export original adpcm symbol bound to renamed translated implementation
pub export fn adpcm_compress_sample(s: *mas.Sample) void {
    adpcm.MM_adpcm_compress_sampleImpl(@ptrCast(s));
}

// Provide clamp helpers expected by translated loaders
pub export fn clamp_s8(value: c_int) callconv(.C) c_int {
    var v = value;
    if (v < -128) v = -128;
    if (v > 127) v = 127;
    return v;
}

pub export fn clamp_u8(value: c_int) callconv(.C) c_int {
    var v = value;
    if (v < 0) v = 0;
    if (v > 255) v = 255;
    return v;
}

// Unused on GBA path (used for DS); keep simple constants to satisfy linkage
// DS-only helpers are provided by translated simple.c when that path is used.
// Provide stub implementations to satisfy linkage for GBA builds (DS path unused).
pub export fn sample_dsformat(samp: *anyopaque) u8 {
    _ = samp;
    return 0;
}

pub export fn sample_dsreptype(samp: *anyopaque) u8 {
    _ = samp;
    return 0;
}
