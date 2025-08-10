const std = @import("std");
const ziggba = @import("ziggba");

pub fn build(b: *std.Build) void {
    const optimize = b.standardOptimizeOption(.{});

    // Host tool: mmutil-zig (WAV -> .mmraw)
    const host_target = b.standardTargetOptions(.{});
    const mmutil_mod = b.createModule(.{
        .root_source_file = b.path("src/mmutil/main.zig"),
        .target = host_target,
        .optimize = optimize,
    });
    const mmutil_exe = b.addExecutable(.{
        .name = "mmutil-zig",
        .root_module = mmutil_mod,
    });
    b.installArtifact(mmutil_exe);

    const run_mmutil = b.addRunArtifact(mmutil_exe);
    run_mmutil.step.dependOn(b.getInstallStep());
    if (b.args) |args| run_mmutil.addArgs(args);
    const run_step = b.step("run", "Run mmutil-zig");
    run_step.dependOn(&run_mmutil.step);

    // Convert root Ambulance.wav into an embedded asset for the GBA example
    const convert_sfx = b.addRunArtifact(mmutil_exe);
    convert_sfx.addArgs(&.{
        "Ambulance.wav",
        "-o",
        "examples/gba_play/sample.mmraw",
        // Use a common GBA SFX rate
        "--rate", "11025",
        "--bps", "8",
    });

    // GBA runtime static library (freestanding ARM ARM7TDMI Thumb)
    const gba_thumb_target_query = blk: {
        var t = std.Target.Query{
            .cpu_arch = .thumb,
            .cpu_model = .{ .explicit = &std.Target.arm.cpu.arm7tdmi },
            .os_tag = .freestanding,
        };
        t.cpu_features_add.addFeature(@intFromEnum(std.Target.arm.Feature.thumb_mode));
        break :blk t;
    };
    const gba_target = b.resolveTargetQuery(gba_thumb_target_query);
    const gba_mod_runtime = b.createModule(.{
        .root_source_file = b.path("src/maxmod_gba/lib.zig"),
        .target = gba_target,
        .optimize = optimize,
    });
    const gba_lib = b.addStaticLibrary(.{
        .name = "maxmod-gba-zig",
        .root_module = gba_mod_runtime,
    });
    b.installArtifact(gba_lib);

    // Build example ROM using ZigGBA dependency helper
    const ziggba_dep = b.dependency("ziggba", .{});
    const gba_mod = ziggba_dep.module("gba");

    // Link our maxmod-gba-zig static library into the example
    const example = ziggba.addGBAExecutable(b, gba_mod, "gba_play", "examples/gba_play/main.zig");
    example.step.dependOn(&convert_sfx.step);
    example.linkLibrary(gba_lib);
    // Allow the example to import the runtime as a Zig module
    example.root_module.addImport("maxmod_gba", gba_mod_runtime);
    const gba_step = b.step("gba", "Build the GBA runtime library and example ROM");
    gba_step.dependOn(&example.step);
}
