const std = @import("std");
const ziggba = @import("ziggba");
const asset_defs = @import("src/asset_type.zig");
const AssetType = asset_defs.AssetType;

const gba_thumb_target_query = blk: {
    var t = std.Target.Query{
        .cpu_arch = .thumb,
        .cpu_model = .{ .explicit = &std.Target.arm.cpu.arm7tdmi },
        .os_tag = .freestanding,
    };
    t.cpu_features_add.addFeature(@intFromEnum(std.Target.arm.Feature.thumb_mode));
    break :blk t;
};
var gba_target: std.Build.ResolvedTarget = undefined;

pub fn build(b: *std.Build) void {
    const optimize = b.standardOptimizeOption(.{});

    gba_target = b.resolveTargetQuery(gba_thumb_target_query);

    // Get dependencies
    const mmutil_dep = b.dependency("mmutil_zig", .{});

    // Setup maxmod
    const maxmod_zig = b.addModule("maxmod", .{
        .root_source_file = b.path("src/maxmod.zig"),
        .target = gba_target,
        .optimize = optimize,
    });
    maxmod_zig.addObjectFile(b.path("src/mixer_asm.o"));

    // Handle file argument
    const file_args = b.args orelse &[_][]const u8{};
    const selected_asset_file: []const u8 = if (file_args.len > 0) file_args[0] else "bad_apple.xm";

    createPlayExample(
        b,
        mmutil_dep,
        selected_asset_file,
        maxmod_zig,
    );
}

fn createPlayExample(
    b: *std.Build,
    mmutil_dep: *std.Build.Dependency,
    selected_asset_file: []const u8,
    maxmod_zig: *std.Build.Module,
) void {
    const asset_debug = b.option(bool, "assetdebug", "Enable debug instrumentation") orelse false;
    const asset_step = b.step("play", "Build play ROM");

    const asset_type = determineAssetType(selected_asset_file);

    // Path helpers
    const selected_asset_path = b.path(selected_asset_file);

    // Create soundbank generation step using mmutil
    const soundbank_run = b.addRunArtifact(mmutil_dep.artifact("mmutil-zig"));
    soundbank_run.addArgs(&.{
        selected_asset_file,
        "-oexamples/play/soundbank.bin",
    });
    soundbank_run.addFileInput(selected_asset_path);

    const gba_b = ziggba.GbaBuild.create(b);

    const play_exe = gba_b.addExecutable(.{
        .name = "play",
        .root_source_file = b.path("examples/play/main.zig"),
        .build_options = .{ .text_charsets = .all },
    });

    play_exe.step.root_module.addImport("maxmod", maxmod_zig);
    maxmod_zig.addImport("gba", play_exe.gba_module);
    play_exe.step.step.dependOn(&soundbank_run.step);

    const asset_opts = b.addOptions();
    asset_opts.addOption([]const u8, "asset_name", std.fs.path.basename(selected_asset_file));
    asset_opts.addOption(AssetType, "asset_type", asset_type);
    asset_opts.addOption(bool, "asset_debug", asset_debug);
    const build_options_mod = asset_opts.createModule();
    maxmod_zig.addImport("build_options", build_options_mod);

    play_exe.step.root_module.addImport("build_options", build_options_mod);

    asset_step.dependOn(&soundbank_run.step);
    asset_step.dependOn(&play_exe.step.step);
    b.default_step.dependOn(asset_step);

    asset_step.dependOn(&gba_b.addBuildFontsStep().step);
}

fn determineAssetType(path: []const u8) AssetType {
    var extension = std.fs.path.extension(path);
    if (extension.len > 0 and extension[0] == '.') {
        extension = extension[1..];
    }
    if (extension.len != 0) {
        if (matchesIgnoreCase(extension, "xm")) return AssetType.XM;
        if (matchesIgnoreCase(extension, "mod")) return AssetType.MOD;
        if (matchesIgnoreCase(extension, "wav")) return AssetType.SFX;
        if (matchesIgnoreCase(extension, "mmraw")) return AssetType.SFX;
    }
    return AssetType.XM;
}

fn matchesIgnoreCase(value: []const u8, pattern: []const u8) bool {
    if (value.len != pattern.len) return false;
    var i: usize = 0;
    while (i < value.len) : (i += 1) {
        if (std.ascii.toLower(value[i]) != std.ascii.toLower(pattern[i])) return false;
    }
    return true;
}
