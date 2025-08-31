const gba = @import("gba");
const xm_name = @import("build_options").xm_name;
const mm = @import("maxmod");
const mas = mm.mas;
const mixer = mm.mixer;
const mm_gba = mm.gba;

export var header linksection(".gbaheader") = gba.initHeader("XMPRT", "XMPT", "00", 0);

var bank_data: []const u8 = @embedFile("soundbank.bin");

fn vblank_isr() void {
    mixer.mmVBlank();
}

export fn main() void {
    gba.interrupt.init();

    // Basic display so we know it's alive
    gba.display.ctrl.* = gba.display.Control{ .bg2 = .enable, .mode = .mode3 };
    gba.text.initBmpDefault(3);

    gba.text.write("#{P:32,64}XM Playback Demo");
    gba.text.write("#{P:32,80}Playing: ");
    gba.text.write(xm_name);

    // Register Maxmod VBlank handler and enable VBlank IRQ
    _ = gba.interrupt.add(.vblank, vblank_isr);

    _ = mm_gba.mmInitDefault(@ptrCast(@constCast(&bank_data[0])), 32);

    mas.mmStart(0, 0);

    while (true) {
        // Mix and service VBlank each frame
        mas.mmFrame();

        // Let IRQ call mmVBlank() and wait for VBlank
        gba.display.vSync();
    }
}
