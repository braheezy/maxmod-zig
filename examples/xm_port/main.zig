const gba = @import("gba");

const mm_port_core_mas = @import("mm_port_core_mas");
const mm_port_core_effect = @import("mm_port_core_effect");
const mm_port_core_mas_arm = @import("mm_port_core_mas_arm");
const mm_port_gba_mixer = @import("mm_port_gba_mixer");
const mm_port_gba_main = @import("mm_port_gba_main");
const mm_port_shim = @import("mm_port_shim");

// Functions imported from port modules

export var header linksection(".gbaheader") = gba.initHeader("XMPRT", "XMPT", "00", 0);

var bank_data: []const u8 = @embedFile("soundbank.bin");

fn vblank_isr() void {
    mm_port_gba_mixer.mmVBlank();
}

export fn main() void {
    // Touch imported modules to prevent dead stripping
    comptime {
        _ = mm_port_core_mas;
        _ = mm_port_core_effect;
        _ = mm_port_core_mas_arm;
        _ = mm_port_gba_mixer;
        _ = mm_port_gba_main;
        _ = mm_port_shim;
    }
    gba.interrupt.init();
    gba.debug.init();
    // Prune noisy prints to keep emulation fast

    // Basic display so we know it's alive
    gba.display.ctrl.* = gba.display.Control{ .bg2 = .enable, .mode = .mode3 };
    // Enable BIOS sound bias like C example (REG_SOUNDBIAS)
    const REG_SOUNDBIAS: *volatile u16 = @ptrFromInt(0x04000088);
    REG_SOUNDBIAS.* = 0x200;
    // Register Maxmod VBlank handler and enable VBlank IRQ
    _ = gba.interrupt.add(.vblank, vblank_isr);

    // Initialize Maxmod from bank and start module 0
    const bank_ptr: usize = @intFromPtr(&bank_data[0]);
    _ = bank_ptr; // silence unused after print pruning
    // Match C reference (CHANNELS = 32)
    _ = mm_port_core_mas.mmInitDefault(@ptrCast(@constCast(&bank_data[0])), 32);
    // Hardcode soundbank.h metadata (module ID 0 == MOD_BAD_APPLE)
    mm_port_core_mas.mmSetModuleVolume(0x400);
    mm_port_core_mas.mmSetEffectsVolume(0x400);
    // gba.debug.print("[main] mmInitDefault() done; mm_mixlen={d}\n", .{mm_port_shim.mm_mixlen}) catch unreachable;

    const module_count = mm_port_core_mas.mmGetModuleCount();
    _ = module_count; // silence unused after print pruning
    // Correct start path: resolve MAS from bank via mmStart (MM_PLAY_LOOP = 0)
    mm_port_core_mas.mmStart(0, 0); // MOD_BAD_APPLE=0, MM_PLAY_LOOP=0
    // No artificial warm-up in the C example; proceed immediately

    var frame_count: u32 = 0;
    var prev_pos: u32 = 0xFFFF;
    var prev_row: u32 = 0xFFFF;
    var prev_tick: u32 = 0xFFFF;
    var prev_order: u32 = 0xFFFF;
    var row_log_budget: u32 = 24; // bump budget to see first two patterns
    var order_log_budget: u32 = 20; // track order changes
    var early_mix_budget: u32 = 50; // early mixer state
    while (true) {
        // Mix and service VBlank each frame
        // Frame update
        mm_port_core_mas.mmFrame();

        // Comprehensive telemetry: position, order, and early mixer state
        if (row_log_budget > 0 or order_log_budget > 0 or early_mix_budget > 0) {
            const pos: u32 = mm_port_gba_mixer.mmGetPosition();
            const row: u32 = mm_port_gba_mixer.mmGetPositionRow();
            const tick: u32 = mm_port_gba_mixer.mmGetPositionTick();
            const order: u32 = pos >> 16; // extract order from position

            // Position logging at tick==0
            if (tick == 0 and row != prev_row and row_log_budget > 0) {
                gba.debug.print("[POS] pos={d} row={d} tick={d} mixlen={d}\n", .{ pos, row, tick, mm_port_shim.mm_mixlen }) catch unreachable;
                prev_pos = pos;
                prev_row = row;
                prev_tick = tick;
                row_log_budget -= 1;
            } else {
                prev_pos = pos;
                prev_row = row;
                prev_tick = tick;
            }

            // Order change logging
            if (order != prev_order and order_log_budget > 0) {
                gba.debug.print("[ORDER] order={d} pos={d} row={d} tick={d}\n", .{ order, pos, row, tick }) catch unreachable;
                prev_order = order;
                order_log_budget -= 1;
            }

            // Early mixer state logging (first few frames)
            if (early_mix_budget > 0 and frame_count < 10) {
                gba.debug.print("[EARLY] frame={d} pos={d} row={d} tick={d} order={d}\n", .{ frame_count, pos, row, tick, order }) catch unreachable;
                early_mix_budget -= 1;
            }
        }

        // Prune per-frame prints
        // Let IRQ call mmVBlank() and wait for VBlank like C reference
        gba.display.vSync();
        frame_count += 1;
    }
}
