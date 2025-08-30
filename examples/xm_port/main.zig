const gba = @import("gba");

const mm_port_core_mas = @import("maxmod").mas;
const mm_port_core_effect = @import("mm_port_core_effect");
const mm_port_core_mas_arm = @import("maxmod").mas_arm;
const mm_port_gba_mixer = @import("mm_port_gba_mixer");
const mm_port_gba_main = @import("maxmod").gba;
const mm_port_shim = @import("maxmod").shim;
const build_options = @import("build_options");

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
    // ALWAYS enable debug for comparison
    gba.debug.init();
    // Extensive logging for comparison

    // Basic display so we know it's alive
    gba.display.ctrl.* = gba.display.Control{ .bg2 = .enable, .mode = .mode3 };
    // Enable BIOS sound bias like C example (REG_SOUNDBIAS)
    const REG_SOUNDBIAS: *volatile u16 = @ptrFromInt(0x04000088);
    REG_SOUNDBIAS.* = 0x200;
    // Register Maxmod VBlank handler and enable VBlank IRQ
    _ = gba.interrupt.add(.vblank, vblank_isr);

    // Initialize Maxmod from bank and start module 0
    // const bank_ptr: usize = @intFromPtr(&bank_data[0]);
    // gba.debug.print("[main] mmInitDefault() starting with bank_ptr=0x{x}\n", .{bank_ptr}) catch unreachable;
    // Match C reference (CHANNELS = 32)
    _ = mm_port_core_mas.mmInitDefault(@ptrCast(@constCast(&bank_data[0])), 32);
    // gba.debug.print("[main] mmInitDefault() done; mm_mixlen={d}\n", .{mm_port_shim.mm_mixlen}) catch unreachable;
    // Hardcode soundbank.h metadata (module ID 0 == MOD_BAD_APPLE)
    mm_port_core_mas.mmSetModuleVolume(0x400);
    mm_port_core_mas.mmSetEffectsVolume(0x400);
    // gba.debug.print("[main] volumes set: module=0x{x} effects=0x{x}\n", .{ 0x400, 0x400 }) catch unreachable;

    // const module_count = mm_port_core_mas.mmGetModuleCount();
    // gba.debug.print("[main] module_count={d}\n", .{module_count}) catch unreachable;
    // Correct start path: resolve MAS from bank via mmStart (MM_PLAY_LOOP = 0)
    // gba.debug.print("[main] mmStart(0, 0) calling\n", .{}) catch unreachable;
    mm_port_core_mas.mmStart(0, 0); // MOD_BAD_APPLE=0, MM_PLAY_LOOP=0
    // gba.debug.print("[main] mmStart() called\n", .{}) catch unreachable;
    // No artificial warm-up in the C example; proceed immediately

    var frame_count: u32 = 0;
    // var prev_pos: u32 = 0xFFFF;
    // var prev_row: u32 = 0xFFFF;
    // var prev_tick: u32 = 0xFFFF;
    // var prev_order: u32 = 0xFFFF;
    while (true) {
        // Mix and service VBlank each frame
        // Frame update
        // gba.debug.print("[FRAME] frame={d} calling mmFrame()\n", .{frame_count}) catch unreachable;
        mm_port_core_mas.mmFrame();
        // gba.debug.print("[FRAME] frame={d} mmFrame() returned\n", .{frame_count}) catch unreachable;

        // ALWAYS log position data for comparison
        // const pos: u32 = mm_port_gba_mixer.mmGetPosition();
        // const row: u32 = mm_port_gba_mixer.mmGetPositionRow();
        // const tick: u32 = mm_port_gba_mixer.mmGetPositionTick();
        // const order: u32 = pos >> 16; // extract order from position

        // gba.debug.print("[POS] frame={d} pos={d} row={d} tick={d} order={d} mixlen={d}\n", .{ frame_count, pos, row, tick, order, mm_port_shim.mm_mixlen }) catch unreachable;

        // Track changes
        // if (pos != prev_pos) {
        //     gba.debug.print("[CHANGE] frame={d} pos: {d} -> {d}\n", .{ frame_count, prev_pos, pos }) catch unreachable;
        //     prev_pos = pos;
        // }
        // if (row != prev_row) {
        //     gba.debug.print("[CHANGE] frame={d} row: {d} -> {d}\n", .{ frame_count, prev_row, row }) catch unreachable;
        //     prev_row = row;
        // }
        // if (tick != prev_tick) {
        //     gba.debug.print("[CHANGE] frame={d} tick: {d} -> {d}\n", .{ frame_count, prev_tick, tick }) catch unreachable;
        //     prev_tick = tick;
        // }
        // if (order != prev_order) {
        //     gba.debug.print("[CHANGE] frame={d} order: {d} -> {d}\n", .{ frame_count, prev_order, order }) catch unreachable;
        //     prev_order = order;
        // }

        // Log every frame for first 100 frames
        // if (frame_count < 100) {
        //     gba.debug.print("[DETAIL] frame={d} pos={d} row={d} tick={d} order={d}\n", .{ frame_count, pos, row, tick, order }) catch unreachable;
        // }

        // Prune per-frame prints
        // Let IRQ call mmVBlank() and wait for VBlank like C reference
        gba.display.vSync();
        frame_count += 1;
    }
}
