const std = @import("std");
const gba = @import("gba");
const mmcore = @import("mm_core_mas_c");

// Shallow adapter implementing the minimal API used by examples over the translated C core
var g_soundbank_addr: usize = 0;
var g_is_mas_single: bool = false;

pub fn init() void {}

pub fn disableAllDma() void {}

pub fn onVBlank() void { mmcore.mmVBlank(); }

pub fn setAsmMixer(_: bool) void {}
pub fn enableAsmFrame(_: bool) void {}

pub fn loadGbsamp(data: []const u8) !void {
    // Keep address for play(); mmInitDefault will allocate internal buffers and init mixer
    g_soundbank_addr = @intFromPtr(data.ptr);
    // Detect MAS single: file starts with u32 size
    g_is_mas_single = true;
    _ = mmcore.mmInitDefault(@ptrFromInt(g_soundbank_addr), 8);
}

pub fn loadMmraw(_: []const u8) !void { return; }

// Small arena for MOD parsing/runtime allocations
var mod_arena: [32 * 1024]u8 = undefined;
var mod_fba: ?std.heap.FixedBufferAllocator = null;

pub fn loadMod(_: []const u8) !void { return; }

pub fn play() void {
    if (g_soundbank_addr == 0) return;
    // MAS single payload is after 4-byte size
    const mas_head_addr: usize = g_soundbank_addr + 4;
    mmcore.mmPlayModule(mas_head_addr, @as(mmcore.mm_word, @bitCast(@as(c_uint, mmcore.MM_PLAY_LOOP))), @as(mmcore.mm_word, @bitCast(@as(c_uint, mmcore.MM_MAIN))));
}

pub fn stop() void { mmcore.mmStop(); }

pub fn tick() void { mmcore.mmFrame(); }

fn mmFrameStyle() void {}
