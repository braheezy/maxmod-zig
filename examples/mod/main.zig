const std = @import("std");
const gba = @import("gba");
const text = gba.text;
const maxmod = @import("maxmod_gba");
const debug = gba.debug;
const ISOLATE_CH3 = false; // set true to run lane-3 isolation test (targets mixer lane index 2)

export var header linksection(".gbaheader") = gba.initHeader("MODDEMO", "MODZ", "00", 0);

// Embed a MOD module placed next to this example
const mod_data: []const u8 = @embedFile("casio2.mod");
// Embed sample bank. Prefer official Maxmod MSL soundbank.
const gbsamp_data: []const u8 = @embedFile("soundbank.bin");

pub export fn main() void {
    gba.interrupt.init();
    _ = gba.interrupt.add(.vblank, @import("maxmod_gba").onVBlank);
    debug.init();
    debug.write("[MOD] Debug init\n") catch {};

    gba.display.ctrl.* = gba.display.Control{ .bg2 = .enable, .mode = .mode3 };
    text.initBmpDefault(3);

    text.write("#{P:72,64}MOD Playback Demo");
    text.write("#{P:72,80}Playing: casio2.mod");
    debug.write("[MOD] UI ready\n") catch {};

    maxmod.init();
    // Use fast ASM mixer + mmFrame by default (disabled in isolate mode)
    maxmod.setAsmMixer(true);
    maxmod.enableAsmFrame(true);

    debug.write("[TEST] isolate check\n") catch {};
    if (ISOLATE_CH3) {
        // Isolation uses the Zig mixer (ASM expects MAS headers). Disable ASM path here.
        maxmod.setAsmMixer(false);
        maxmod.enableAsmFrame(false);

        // Target the problematic lane: logical channel index 2 (often referred to as CH3 in logs)
        // Build a small audible looping square wave centered at 128 (unsigned 8-bit)
        var testbuf: [512]u8 = undefined;
        var i: usize = 0;
        while (i < testbuf.len) : (i += 1) {
            // 50% duty square: 64 samples high, 64 low
            const phase = (i / 64) % 2;
            testbuf[i] = if (phase == 0) 192 else 64; // centered around 128
        }

        // Set a moderate step so pitch is clearly audible; also set a loop length to keep it running
        const pan: u8 = 255; // lane 2 is right in Amiga panning (0,1,2,3 = L,R,R,L)
        const step_20_12: u32 = 0x1200; // ~1.125 samples per output sample
        const loop_len_bytes: u32 = @as(u32, @intCast(testbuf.len)); // loop whole buffer
        maxmod.mixerTestSetChannelFromPcm8(2, &testbuf, loop_len_bytes, 255, pan, step_20_12);
        debug.write("[TEST] Lane 2 isolated with looping square\n") catch {};
    } else {
        debug.write("[TEST] isolate=false path\n") catch {};
        // Load soundbank for ASM mixer (MAS headers in ROM)
        _ = maxmod.loadGbsamp(gbsamp_data) catch {};
        debug.write("[MOD] GBSAMP loaded\n") catch {};
        // Parse MOD and play using ASM mixer with GBSAMP samples
        _ = maxmod.loadMod(mod_data) catch {};
        debug.write("[MOD] Module parsed\n") catch {};
        // The player will mix a small looping buffer on play
        maxmod.play();
        debug.write("[MOD] Playback started\n") catch {};
    }

    while (true) {
        gba.display.vSync();
        maxmod.tick();
    }
}
