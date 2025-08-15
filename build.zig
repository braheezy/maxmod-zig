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

    // Parametric SFX conversion: zig build sfx -- <path-to-wav>
    const sfx_step = b.step("sfx", "Convert WAV to .mmraw, build, and run in mGBA");
    const sfx_args = b.args orelse &[_][]const u8{};
    const selected_wav: []const u8 = if (sfx_args.len > 0) sfx_args[0] else "firered_00A0.wav";

    const convert_sfx = b.addRunArtifact(mmutil_exe);
    convert_sfx.addArgs(&.{
        selected_wav,
        "-o",
        "examples/sfx/sample.mmraw",
        // Use a common GBA SFX rate for cleaner playback
        "--rate",
        "16000",
        "--bps",
        "8",
    });
    // Provide the selected WAV path to the ROM via build options
    const opts = b.addOptions();
    opts.addOption([]const u8, "sfx_name", selected_wav);

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
    // Zig-only build: do not import or link C sources
    b.installArtifact(gba_lib);

    // Build example ROMs using ZigGBA dependency helper
    const ziggba_dep = b.dependency("ziggba", .{});
    const gba_mod = ziggba_dep.module("gba");

    // Link our maxmod-gba-zig static library into the SFX example
    const example = ziggba.addGBAExecutable(b, gba_mod, "sfx", "examples/sfx/main.zig");
    example.step.dependOn(&convert_sfx.step);
    example.linkLibrary(gba_lib);
    // Allow the example to import the runtime as a Zig module
    example.root_module.addImport("maxmod_gba", gba_mod_runtime);
    example.root_module.addOptions("build_options", opts);

    // The sfx step builds the ROM
    sfx_step.dependOn(&convert_sfx.step);
    sfx_step.dependOn(&example.step);
    // Also depend on the default step to ensure the ROM gets installed
    sfx_step.dependOn(b.default_step);

    // MOD example: Zig-only. We embed tracker assets directly (to be ported in Zig).
    const example_mod = ziggba.addGBAExecutable(b, gba_mod, "mod", "examples/mod/main.zig");
    example_mod.linkLibrary(gba_lib);
    example_mod.root_module.addImport("maxmod_gba", gba_mod_runtime);

    // TODO: Integrate ASM mixer when supported by toolchain (GAS). Clang IAS chokes on macros.

    const mod_step = b.step("mod", "Build MOD demo ROM (Zig-only)");
    mod_step.dependOn(&example_mod.step);
}
