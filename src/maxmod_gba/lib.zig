const std = @import("std");
const audio = @import("audio.zig");
const player = @import("player.zig");
const mixer = @import("mixer_asm.zig");

pub fn init() void {
    audio.init();
    // Initialize mixer ASM path at 16 kHz (mode index 3)
    mixer.init(3);
}

pub fn disableAllDma() void {
    audio.silenceAllDma();
}

pub fn loadMmraw(data: []const u8) !void { try player.loadMmrawSlice(data); }

pub fn play() void {
    // If a MOD is active, the mixer path already configured DMA and Direct Sound.
    if (@import("player.zig").isModActive()) {
        return;
    } else {
        player.play();
    }
}

pub fn stop() void {
    player.stop();
}

pub fn tick() void {
    // Drive mixer once per tick to advance the stereo buffers
    const seg: u32 = mixer.getMixLen();
    mixer.mixOneSegment();
    // Inform mod player about how many samples were mixed (segment length)
    if (@import("player.zig").isModActive()) {
        if (@import("player.zig").mod_player) |*mp| mp.onMixed(seg);
    }
    player.frame();
}

// Expose vblank hook to examples
pub fn onVBlank() void {
    mixer.onVBlank();
}

// --- MOD (tracker) helpers ---
var mod_arena: [64 * 1024]u8 = undefined;
var mod_fba: ?std.heap.FixedBufferAllocator = null;

pub fn loadMod(data: []const u8) !void {
    if (mod_fba == null) {
        const fba = std.heap.FixedBufferAllocator.init(mod_arena[0..]);
        mod_fba = fba;
    }
    // Safe to unwrap because we just initialized if null
    var fba_ptr: *std.heap.FixedBufferAllocator = &mod_fba.?;
    try player.loadModSlice(fba_ptr.allocator(), data);
}
