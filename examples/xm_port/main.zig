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
    while (true) {
        // Mix and service VBlank each frame
        // Frame update
        mm_port_core_mas.mmFrame();
        // Focused check near suspected static rows: dump first 4 mixer channels at rows 20..22
        {
            const row: u32 = mm_port_gba_mixer.mmGetPositionRow();
            if (row >= 20 and row <= 22) {
                const CDbgMix = extern struct { src: u32, read: u32, freq: u16, vol: u8, pan: u8 };
                const base_ptr: [*]const CDbgMix = @ptrCast(mm_port_gba_mixer.mm_get_mix_channels_ptr());
                var i: usize = 0;
                while (i < 4) : (i += 1) {
                    const c = base_ptr[i];
                    gba.debug.print("[C MIX] i={d} src={x} read={d} freq={d} vol={d} pan={d}\n", .{ i, c.src, c.read, c.freq, c.vol, c.pan }) catch unreachable;
                }
                // Focused RATEC on channel 2
                const c2 = base_ptr[2];
                const rs = mm_port_gba_mixer.mm_ratescale;
                if (rs != 0) {
                    const rate_est: u32 = (@as(u32, c2.freq) << 10) / rs;
                    gba.debug.print("[RATEC] ch=2 freq={d} ratescale={d} rate_est={d}\n", .{ @as(u32, c2.freq), rs, rate_est }) catch unreachable;
                }
            }
        }
        // Mirror C reference: dump first 4 mixer channels after mmFrame()
        // Treat memory as the same faux C layout used by the C demo:
        // struct { u32 src; u32 read; u16 freq; u8 vol; u8 pan; }
        if (false and frame_count < 4) {
            const CDbgMix = extern struct { src: u32, read: u32, freq: u16, vol: u8, pan: u8 };
            const base_ptr: [*]const CDbgMix = @ptrCast(mm_port_gba_mixer.mm_get_mix_channels_ptr());
            var i: usize = 0;
            while (i < 4) : (i += 1) {
                const c = base_ptr[i];
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
        // Prune per-frame prints
        // Let IRQ call mmVBlank() and wait for VBlank like C reference
        gba.display.vSync();
        frame_count += 1;
    }
}
