const std = @import("std");
const gba = @import("gba");
const text = gba.text;
const maxmod = @import("maxmod_gba");

export var header linksection(".gbaheader") = gba.initHeader("MODDEMO", "MODZ", "00", 0);

// Embed a MOD module placed next to this example
const mod_data: []const u8 = @embedFile("casio2.mod");

pub export fn main() void {
    gba.interrupt.init();
    _ = gba.interrupt.add(.vblank, @import("maxmod_gba").onVBlank);

    gba.display.ctrl.* = gba.display.Control{ .bg2 = .enable, .mode = .mode3 };
    text.initBmpDefault(3);

    text.write("#{P:72,64}MOD Playback Demo");
    text.write("#{P:72,80}Playing: casio2.mod");

    maxmod.init();
    // Minimal path: use library helper to parse and stage a preview
    _ = maxmod.loadMod(mod_data) catch {};
    // The player will mix a small looping buffer on play
    maxmod.play();

    while (true) {
        gba.display.vSync();
        maxmod.tick();
    }
}
