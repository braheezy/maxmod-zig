const gba = @import("gba");
const mm = @import("maxmod");

const mixer = mm.mixer;
const mm_gba = mm.gba;

export var header linksection(".gbaheader") = gba.Header.init("SFXDEMO", "SFXZ", "00", 0);

const bank_data align(4) = @embedFile("soundbank.bin");

const ButtonBinding = struct {
    key: gba.input.Key,
    sample_id: mm.Word,
    label: []const u8,
};

const bindings = [_]ButtonBinding{
    .{ .key = .A, .sample_id = 0, .label = "A      sample 0" },
    .{ .key = .B, .sample_id = 1, .label = "B      sample 1" },
    .{ .key = .L, .sample_id = 2, .label = "L      sample 2" },
    .{ .key = .R, .sample_id = 3, .label = "R      sample 3" },
    .{ .key = .up, .sample_id = 4, .label = "Up     sample 4" },
    .{ .key = .down, .sample_id = 5, .label = "Down   sample 5" },
    .{ .key = .left, .sample_id = 6, .label = "Left   sample 6" },
    .{ .key = .right, .sample_id = 7, .label = "Right  sample 7" },
};

fn vblank_isr(_: gba.interrupt.InterruptFlags) callconv(.c) void {
    mixer.vBlank();
}

fn drawUi(sample_count: mm.Word) void {
    const surface = gba.display.getMode3Surface();
    const draw = surface.draw();
    const title = gba.ColorRgb555.yellow;
    const ready = gba.ColorRgb555.white;
    const disabled = gba.ColorRgb555.rgb(15, 15, 15);

    draw.fill(gba.ColorRgb555.black);
    draw.text("Maxmod SFX Demo", .init(title), .{ .x = 24, .y = 16 });
    draw.print("Samples in bank: {d}", .{sample_count}, .init(ready), .{ .x = 24, .y = 32 });

    inline for (bindings, 0..) |binding, i| {
        const color = if (binding.sample_id < sample_count) ready else disabled;
        const x: u32 = if (i < 4) 24 else 128;
        const y: u32 = 56 + ((i % 4) * 18);
        draw.text(binding.label, .init(color), .{ .x = x, .y = y });
    }
}

fn playSample(sample_id: mm.Word, handle_slot: *mm.Sfxhand) void {
    if (sample_id >= mm_gba.getSampleCount()) return;
    if (handle_slot.* != 0) {
        _ = mm.sfx.effectCancel(handle_slot.*);
    }
    handle_slot.* = mm.sfx.effect(sample_id);
}

export fn main() void {
    gba.debug.init();
    gba.interrupt.init();
    gba.display.ctrl.* = .initMode3(.{});
    gba.interrupt.isr_default_redirect = vblank_isr;

    mm_gba.initDefault(@ptrCast(@constCast(&bank_data[0])), 32) catch |e| {
        gba.debug.print("Failed to initialize Maxmod: {any}\n", .{@errorName(e)}) catch {};
        unreachable;
    };

    drawUi(mm_gba.getSampleCount());

    var input: gba.input.BufferedKeysState = .{};
    var active_handles = [_]mm.Sfxhand{0} ** bindings.len;

    while (true) {
        input.poll();

        inline for (bindings, 0..) |binding, i| {
            if (input.isJustPressed(binding.key)) {
                playSample(binding.sample_id, &active_handles[i]);
            }
        }

        mm_gba.frame();
        gba.bios.vblankIntrWait();
    }
}
