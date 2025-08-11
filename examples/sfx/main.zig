const std = @import("std");
const gba = @import("gba");
const mmgba = @import("maxmod_gba");
const build_options = @import("build_options");
const text = gba.text;

export var header linksection(".gbaheader") = gba.initHeader("SFXDEMO", "SFXZ", "00", 0);

// Embed the converted asset
const sample_data: []const u8 = @embedFile("sample.mmraw");

var flash_counter: u32 = 0;
var name_buf: [30]u16 = [_]u16{0} ** 30;
var flash_ticks: u16 = 0; // frames remaining to flash file name after replay

pub export fn main() void {
    // Basic display
    gba.interrupt.init();
    _ = gba.interrupt.add(.vblank, null);
    gba.display.ctrl.* = gba.display.Control{
        .bg2 = .enable,
        .mode = .mode3,
    };
    text.initBmpDefault(3);
    // Show file name and label using text engine
    text.write("#{P:72,64}Press A to replay");
    // File name in white by default
    const white_val: u16 = @as(u16, @bitCast(gba.Color.white));
    const magenta_val: u16 = @as(u16, @bitCast(gba.Color.magenta));
    text.printf("#{{P:72,80;ci:{d}}}", .{white_val});
    text.write(build_options.sfx_name);

    // Init audio
    mmgba.init();
    mmgba.disableAllDma();

    // Load and play
    if (mmgba.loadMmraw(sample_data)) |_| {
        mmgba.play();
    } else |_| {}

    // Colors prepared above

    while (true) {
        gba.display.vSync();
        _ = gba.input.poll();

        if (gba.input.isKeyJustPressed(.A)) {
            flash_counter = 0;
            flash_ticks = 60; // ~1s at 60 FPS
            mmgba.stop();
            var n: u32 = 5000;
            while (n > 0) : (n -= 1) {}
            mmgba.play();
        }
        // If flashing active, toggle file name color between magenta and white
        if (flash_ticks > 0) {
            const color = if ((flash_counter & 8) == 0) magenta_val else white_val;
            text.printf("#{{P:72,80;ci:{d}}}", .{color});
            text.write(build_options.sfx_name);
            flash_ticks -%= 1;
            if (flash_ticks == 0) {
                // Ensure we end on white
                text.printf("#{{P:72,80;ci:{d}}}", .{white_val});
                text.write(build_options.sfx_name);
            }
        }
        flash_counter +%= 1;
        mmgba.tick();
    }
}
