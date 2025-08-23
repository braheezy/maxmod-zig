const std = @import("std");
const gba = @import("gba");
const text = gba.text;
const maxmod = @import("maxmod_gba");
const build_options = @import("build_options");

export var header linksection(".gbaheader") = gba.initHeader("XMDEMO", "XMTZ", "00", 0);

// Embed the soundbank generated from the XM (via mmutil translate-c in build step)
const bank_data: []const u8 = @embedFile("soundbank.bin");

pub export fn main() void {
    // Initialize interrupts and debug output
    gba.interrupt.init();
    _ = gba.interrupt.add(.vblank, maxmod.onVBlank);

    // Basic display setup
    gba.display.ctrl.* = gba.display.Control{ .bg2 = .enable, .mode = .mode3 };
    text.initBmpDefault(3);

    // UI text
    text.write("#{P:72,64}XM Playback Demo");
    text.write("#{P:72,80}XM: ");
    text.write(build_options.xm_name);

    // Initialize Maxmod runtime exactly like MOD demo
    maxmod.init();
    // Use Zig mixer like MOD isolation test
    maxmod.setAsmMixer(false);
    maxmod.enableAsmFrame(false);

    // Load MAS soundbank and play first sample
    if (maxmod.loadMasBank(bank_data)) |_| {
        text.write("#{P:72,96}Soundbank loaded OK");
        if (maxmod.playMasModule(0)) {
            text.write("#{P:72,112}XM module started");
        } else {
            text.write("#{P:72,112}XM module failed");
        }
    } else |_| {
        text.write("#{P:72,96}Soundbank load failed");
    }

    // Main loop: wait for VBlank and tick the audio system
    while (true) {
        gba.display.vSync();
        maxmod.tick();
    }
}
