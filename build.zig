const std = @import("std");
const ziggba = @import("my-ZigGBA/src/build/build.zig");

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
    // Avoid executing my-ZigGBA's top-level build (which builds its examples)
    // by wiring the GBA module directly from the local source tree.
    const gba_mod = b.createModule(.{
        .root_source_file = b.path("my-ZigGBA/src/gba/gba.zig"),
        .target = gba_target,
        .optimize = optimize,
    });

    // Setup maxmod
    const maxmod_zig = b.addModule("maxmod", .{
        .root_source_file = b.path("src/maxmod.zig"),
        .target = gba_target,
        .optimize = optimize,
    });
    maxmod_zig.addImport("gba", gba_mod);
    maxmod_zig.addObjectFile(b.path("src/mixer_asm.o"));

    // Handle file argument
    const file_args = b.args orelse &[_][]const u8{};
    const selected_xm_file: []const u8 = if (file_args.len > 0) file_args[0] else "bad_apple.xm";

    createXmExample(
        b,
        optimize,
        gba_mod,
        mmutil_dep,
        selected_xm_file,
        maxmod_zig,
    );
}

fn createXmExample(
    b: *std.Build,
    optimize: std.builtin.OptimizeMode,
    gba_mod: *std.Build.Module,
    mmutil_dep: *std.Build.Dependency,
    selected_xm_file: []const u8,
    maxmod_zig: *std.Build.Module,
) void {
    const xm_debug = b.option(bool, "xmdebug", "Enable XM debug mode") orelse false;
    const xm_step = b.step("xm", "Build XM demo ROM");

    // Create XM soundbank generation step using mmutil
    const xm_create_soundbank = b.addRunArtifact(mmutil_dep.artifact("mmutil-zig"));
    xm_create_soundbank.addArgs(&.{
        selected_xm_file,
        "-oexamples/xm/soundbank.bin",
    });

    // XM ROM
    const xm_exe = ziggba.addGBAExecutable(b, gba_mod, "xm", "examples/xm/main.zig");

    xm_exe.root_module.addImport("maxmod", maxmod_zig);

    const xm_opts = b.addOptions();
    xm_opts.addOption([]const u8, "xm_name", selected_xm_file);
    xm_opts.addOption(bool, "xm_debug", xm_debug);
    const build_options_mod = xm_opts.createModule();
    maxmod_zig.addImport("build_options", build_options_mod);

    xm_exe.root_module.addImport("build_options", build_options_mod);

    const mod_maxmod_zig = b.createModule(.{ .root_source_file = b.path("src/maxmod.zig"), .target = gba_target, .optimize = optimize });
    mod_maxmod_zig.addImport("gba", gba_mod);

    // Add translate-c step for mas_arm.c (using native toolchain to avoid freestanding libc issues)
    const translate_c_step = b.step("c", "Translate mas_arm.c to Zig");
    const host_target = b.resolveTargetQuery(.{});
    const xlate = b.addTranslateC(.{
        .root_source_file = b.path("maxmod/source/core/mas_arm.c"),
        .target = host_target, // translate using host so std headers resolve
        .optimize = optimize,
    });
    // Match include layout expected by the C source
    xlate.addIncludePath(b.path("maxmod/source"));
    xlate.addIncludePath(b.path("maxmod/include"));
    xlate.addIncludePath(b.path("maxmod/source/gba"));
    xlate.addIncludePath(b.path("examples/xm_c_ref/vendor/libmm/include"));
    // Neutralize platform-specific attributes/macros so translation succeeds on host
    xlate.defineCMacro("IWRAM_CODE", "");
    xlate.defineCMacro("ARM_CODE", "");
    // Emit translated Zig into project tree for inspection
    const translated_out = xlate.getOutput();
    const install_translated = b.addInstallFile(translated_out, "src/core/mas_arm_translated.zig");
    translate_c_step.dependOn(&install_translated.step);

    // Hook into top-level steps and install artifacts
    xm_step.dependOn(&xm_create_soundbank.step);
    xm_step.dependOn(&xm_exe.step);

    xm_step.dependOn(b.default_step);
}
