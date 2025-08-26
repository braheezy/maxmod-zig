const gba = @import("gba");

const mm_port_core_mas = @import("mm_port_core_mas");
const mm_port_core_effect = @import("mm_port_core_effect");
const mm_port_core_mas_arm = @import("mm_port_core_mas_arm");
const mm_port_gba_mixer = @import("mm_port_gba_mixer");
const mm_port_gba_main = @import("mm_port_gba_main");
const mm_port_shim = @import("mm_port_shim");

// Functions imported from port modules

export var header linksection(".gbaheader") = gba.initHeader("XMPRT", "XMPT", "00", 0);

const bank_data: []const u8 = @embedFile("soundbank.bin");

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
    gba.debug.print("[main] start xm-port demo\n", .{}) catch unreachable;

    // Basic display so we know it's alive
    gba.display.ctrl.* = gba.display.Control{ .bg2 = .enable, .mode = .mode3 };
    // Enable BIOS sound bias like C example (REG_SOUNDBIAS)
    const REG_SOUNDBIAS: *volatile u16 = @ptrFromInt(0x04000088);
    REG_SOUNDBIAS.* = 0x200;
    // Register Maxmod VBlank handler and enable VBlank IRQ
    _ = gba.interrupt.add(.vblank, vblank_isr);
    gba.debug.print("[main] registered VBlank IRQ handler mmVBlank()\n", .{}) catch unreachable;

    // Initialize Maxmod from bank and start module 0
    gba.debug.print("[main] bank_data.len={d}\n", .{bank_data.len}) catch unreachable;
    const bank_ptr: usize = @intFromPtr(&bank_data[0]);
    gba.debug.print("[main] bank_ptr={x}\n", .{bank_ptr}) catch unreachable;
    // Match C reference (CHANNELS = 32)
    _ = mm_port_core_mas.mmInitDefault(@ptrFromInt(bank_ptr), 32);
    // Hardcode soundbank.h metadata (module ID 0 == MOD_BAD_APPLE)
    mm_port_core_mas.mmSetModuleVolume(0x400);
    mm_port_core_mas.mmSetEffectsVolume(0x400);
    gba.debug.print("[main] mmInitDefault() done; mm_mixlen={d}\n", .{mm_port_shim.mm_mixlen}) catch unreachable;

    const module_count = mm_port_core_mas.mmGetModuleCount();
    gba.debug.print("[main] module_count={d}\n", .{module_count}) catch unreachable;
    // Correct start path: resolve MAS from bank via mmStart (MM_PLAY_LOOP = 0)
    gba.debug.print("[main] mmStart(0, MM_PLAY_LOOP)\n", .{}) catch unreachable;
    mm_port_core_mas.mmStart(0, 0); // MOD_BAD_APPLE=0, MM_PLAY_LOOP=0
    // No artificial warm-up in the C example; proceed immediately

    var frame_count: u32 = 0;
    while (true) {
        // Mix and service VBlank each frame
        if (frame_count < 10 or (frame_count % 300) == 0) {
            gba.debug.print("[main] frame {d} mmFrame()\n", .{frame_count}) catch unreachable;
        }
        // no-op at frame 5; rely on mmStart path
        // Do not force flags; match C reference behavior exactly
        mm_port_core_mas.mmFrame();
        // Mirror C reference: dump first 4 mixer channels after mmFrame()
        // C example uses a different (wrong) struct layout: {src,u32; read,u32; freq,u16; vol,u8; pan,u8}
        // Use the same layout here so numbers match exactly.
        if (frame_count < 4) {
            const WrongCMix = extern struct { src: u32, read: u32, freq: u16, vol: u8, pan: u8 };
            const ch_wrong: [*]const WrongCMix = @ptrCast(mm_port_gba_mixer.mm_get_mix_channels_ptr());
            var i: usize = 0;
            while (i < 4) : (i += 1) {
                const c = ch_wrong[i];
                gba.debug.print(
                    "[C MIX] i={d} src={x} read={d} freq={d} vol={d} pan={d}\n",
                    .{ i, c.src, c.read, c.freq, c.vol, c.pan },
                ) catch unreachable;
                const rs = mm_port_gba_mixer.mm_ratescale;
                if (rs != 0) {
                    const rate_est: u32 = (@as(u32, c.freq) << 10) / rs;
                    gba.debug.print("[C RATE] i={d} rate_est={d} ratescale={d}\n", .{ i, rate_est, rs }) catch unreachable;
                }
            }
        }
        if (frame_count < 10 or (frame_count % 300) == 0) {
            gba.debug.print("[main] frame {d} mmVBlank()\n", .{frame_count}) catch unreachable;
        }
        // Let IRQ call mmVBlank() and wait for VBlank like C reference
        gba.display.vSync();
        frame_count += 1;
    }
}
