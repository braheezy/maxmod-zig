const gba = @import("gba");
const xm_name = @import("build_options").xm_name;
const xm_debug = @import("build_options").xm_debug;
const mm = @import("maxmod");
const mas = mm.mas;
const mixer = mm.mixer;
const mm_gba = mm.gba;

export var header linksection(".gbaheader") = gba.initHeader("XMPRT", "XMPT", "00", 0);

var bank_data: []const u8 = @embedFile("soundbank.bin");

fn vblank_isr() void {
    mixer.vBlank();
    mm.shim.debug_state.print();
}

export fn main() void {
    gba.debug.init();

    // Basic display so we know it's alive
    gba.display.ctrl.* = gba.display.Control{ .bg2 = .enable, .mode = .mode3 };
    gba.text.initBmpDefault(3);

    gba.text.write("#{P:32,64}XM Playback Demo");
    gba.text.write("#{P:32,80}Playing: ");
    gba.text.write(xm_name);

    // Register Maxmod VBlank handler and enable VBlank IRQ
    // _ = gba.interrupt.add(.vblank, vblank_isr);

    mm_gba.initDefault(@ptrCast(@constCast(&bank_data[0])), 32) catch |e| {
        gba.debug.print("Failed to initialize Maxmod: {any}\n", .{@errorName(e)}) catch {};
        unreachable;
    };

    mas.mmStart(0, 0);

    var frame_count: u32 = 0;
    const max_frames: u32 = 2;

    while (true) {
        // Mix and service VBlank each frame
        mm_gba.frame();

        mixer.vBlank();

        if (xm_debug) {
            mm.shim.print();
            frame_count += 1;

            if (frame_count == max_frames) {
                break;
            }
        }
    }
}
