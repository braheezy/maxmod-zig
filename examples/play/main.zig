const std = @import("std");
const gba = @import("gba");
const build_options = @import("build_options");
const AssetOptions = @TypeOf(build_options.asset_type);
const mm = @import("maxmod");
const mas = mm.mas;
const mixer = mm.mixer;
const mm_gba = mm.gba;
const text = gba.text;

const bank_data align(4) = @embedFile("soundbank.bin");

export var header linksection(".gbaheader") = gba.Header.init("ASPL", "MMPT", "00", 0);

fn assetLabel(asset_type: AssetOptions) []const u8 {
    return switch (asset_type) {
        .XM => "XM",
        .MOD => "MOD",
        .SFX => "SFX",
    };
}

fn isModuleType(asset_type: AssetOptions) bool {
    return asset_type != .SFX;
}

fn drawInfo(mode3: gba.display.Mode3Surface, title: []const u8, name: []const u8) void {
    const draw = mode3.draw();
    draw.text(title, .init(gba.ColorRgb555.yellow), .{ .x = 32, .y = 64 });
    draw.print("File: {s}", .{name}, .init(gba.ColorRgb555.green), .{ .x = 32, .y = 80 });
}

fn vblank_isr(_: gba.interrupt.InterruptFlags) callconv(.c) void {
    mixer.vBlank();
}

export fn main() void {
    gba.debug.init();
    gba.interrupt.init();

    const asset_type = build_options.asset_type;
    const asset_name = build_options.asset_name;
    const title = "maxmod-zig player";
    const type_label = assetLabel(asset_type);
    const is_module = isModuleType(asset_type);

    const bank_ptr = @intFromPtr(&bank_data[0]);
    const bank_len = bank_data.len;

    if (build_options.asset_debug) {
        gba.debug.print("[MAIN] asset={s} type={s}\n", .{ asset_name, type_label }) catch {};
        gba.debug.print("[MAIN] soundbank=0x{x} len={d}\n", .{ bank_ptr, bank_len }) catch {};
    }

    gba.display.ctrl.* = .initMode3(.{});
    const mode3 = gba.display.getMode3Surface();
    drawInfo(mode3, title, asset_name);

    gba.interrupt.isr_default_redirect = vblank_isr;

    if (build_options.asset_debug) {
        gba.debug.print("[MAXMOD] initDefault called\n", .{}) catch {};
    }

    mm_gba.initDefault(@ptrCast(@constCast(&bank_data[0])), 32) catch |e| {
        gba.debug.print("Failed to initialize Maxmod: {any}\n", .{@errorName(e)}) catch {};
        unreachable;
    };

    if (build_options.asset_debug) {
        gba.debug.print("[MAXMOD] initDefault finished; mm_mixlen={d}\n", .{mm_gba.mm_mixlen}) catch {};
    }

    if (is_module) {
        mas.mmStart(0, 0);
    } else {
        _ = mm.sfx.effect(0);
    }

    while (true) {
        mm_gba.frame();

        gba.bios.vblankIntrWait();
    }
}
