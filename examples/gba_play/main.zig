const std = @import("std");
const gba = @import("gba");
const mmgba = @import("maxmod_gba");

export var header linksection(".gbaheader") = gba.initHeader("MMRAWDEMO", "MMRW", "00", 0);

// Embed the converted asset
const sample_data: []const u8 = @embedFile("sample.mmraw");

pub export fn main() void {
    // Basic display
    gba.interrupt.init();
    // We do not use Timer1 in DMA-fed path
    _ = gba.interrupt.add(.vblank, null);
    gba.display.ctrl.* = .{ .mode = .mode3, .bg2 = .enable };
    gba.debug.init();

    // Init audio
    mmgba.init();
    // Belt-and-suspenders: ensure all DMA are fully disabled at boot
    mmgba.disableAllDma();

    // Load and play
    if (mmgba.loadMmraw(sample_data)) |_| {
        mmgba.play();
    } else |_| {}

    while (true) {
        gba.display.vSync();
        _ = gba.input.poll();
        if (gba.input.isKeyJustPressed(.A)) {
            mmgba.stop();
            var n: u32 = 5000;
            while (n > 0) : (n -= 1) {}
            mmgba.play();
        }
        mmgba.tick();
    }
}
