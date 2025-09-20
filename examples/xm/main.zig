const gba = @import("gba");
const xm_name = @import("build_options").xm_name;
const xm_debug = @import("build_options").xm_debug;
const mm = @import("maxmod");
const mas = mm.mas;
const mixer = mm.mixer;
const mm_gba = mm.gba;

export var header linksection(".gbaheader") = gba.initHeader("XMPRT", "XMPT", "00", 0);

const bank_data align(4) = @embedFile("soundbank.bin");

fn vblank_isr() void {
    mixer.vBlank();
    mm.shim.debug_state.print();
}

export fn main() void {
    gba.debug.init();
    if (xm_debug) {
        gba.debug.print("[STOP] value=0x{x}\n", .{mm.shim.MIXCH_GBA_SRC_STOPPED}) catch {};
    }

    const bank_ptr = @intFromPtr(&bank_data[0]);
    const bank_len = bank_data.len;
    if (xm_debug) {
        gba.debug.print("[main] soundbank=0x{x} len={d}\n", .{ bank_ptr, bank_len }) catch {};
        gba.debug.print("[main] mmInitDefault() starting with bank_len={d}\n", .{bank_len}) catch {};
        gba.debug.print("[MAXMOD] mmInitDefault called!\n", .{}) catch {};
    }

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
    if (xm_debug) {
        gba.debug.print("[main] mmInitDefault() done; mm_mixlen={d}\n", .{mm_gba.mm_mixlen}) catch {};
    }

    mas.mmStart(0, 0);

    var frame_count: u32 = 0;
    const max_frames: u32 = 90;

    while (true) {
        // Mix and service VBlank each frame
        mm_gba.frame();

        if (xm_debug) {
            mm.shim.logMixHash(frame_count);
            mm.shim.logMixChannels(frame_count);
        }

        mixer.vBlank();

        gba.display.naiveVSync();

        if (xm_debug) {
            frame_count += 1;
            if (frame_count == max_frames) {
                mm.shim.print();
                while (true) {}
            }
        }
    }
}
