const std = @import("std");
const ziggba = @import("ziggba");

pub fn build(b: *std.Build) void {
    const optimize = b.standardOptimizeOption(.{});

    // Get dependencies
    const mmutil_dep = b.dependency("mmutil_zig", .{});
    const ziggba_dep = b.dependency("ziggba", .{});
    const gba_mod = ziggba_dep.module("gba");

    // Setup maxmod
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

    const maxmod_zig = b.addModule("maxmod", .{
        .root_source_file = b.path("src/port/maxmod/maxmod.zig"),
        .target = gba_target,
        .optimize = optimize,
    });
    maxmod_zig.addImport("gba", gba_mod);

    const file_args = b.args orelse &[_][]const u8{};
    const selected_xm_file: []const u8 = if (file_args.len > 0) file_args[0] else "bad_apple.xm";

    const xm_debug = b.option(bool, "xmdebug", "Enable XM debug mode") orelse false;

    const xm_port_step = b.step("xm-port", "Build XM demo ROM using ported Maxmod translate-c files");

    // Create XM soundbank generation step using mmutil
    const xm_create_soundbank = b.addRunArtifact(mmutil_dep.artifact("mmutil-zig"));
    xm_create_soundbank.addArgs(&.{
        selected_xm_file,
        "-oexamples/xm_port/soundbank.bin",
    });

    // XM ROM
    const xm_exe = ziggba.addGBAExecutable(b, gba_mod, "xm-port", "examples/xm_port/main.zig");
    xm_exe.addObjectFile(b.path("mixer_asm.o"));

    xm_exe.root_module.addImport("maxmod", maxmod_zig);

    const xm_opts = b.addOptions();
    xm_opts.addOption([]const u8, "xm_name", selected_xm_file);
    xm_opts.addOption(bool, "xm_debug", xm_debug);
    const build_options_mod = xm_opts.createModule();
    maxmod_zig.addImport("build_options", build_options_mod);

    xm_exe.root_module.addImport("build_options", build_options_mod);

    const mod_maxmod_zig = b.createModule(.{ .root_source_file = b.path("src/port/maxmod/maxmod.zig"), .target = gba_target, .optimize = optimize });
    mod_maxmod_zig.addImport("gba", gba_mod);

    const mod_mm_port_gba_mixer = b.createModule(.{ .root_source_file = b.path("src/port/maxmod/gba/mixer.zig"), .target = gba_target, .optimize = optimize });
    mod_mm_port_gba_mixer.addImport("gba", gba_mod);

    // Hook into top-level steps and install artifacts
    xm_port_step.dependOn(&xm_create_soundbank.step);
    xm_port_step.dependOn(&xm_exe.step);

    xm_port_step.dependOn(b.default_step);
}

// // Parametric SFX conversion: zig build sfx -- <path-to-wav>
// const sfx_step = b.step("sfx", "Convert WAV to .mmraw, build, and run in mGBA");

// // SFX-specific WAV processing (only runs when sfx step is invoked)
// const sfx_convert = b.addRunArtifact(mmutil_exe);
// sfx_convert.addArgs(&.{
//     "firered_00A0.wav", // Default WAV file
//     "-o",
//     "examples/sfx/sample.mmraw",
//     "--rate",
//     "16000",
//     "--bps",
//     "8",
// });

// Provide the default WAV path to the ROM via build options
// const sfx_opts = b.addOptions();
// sfx_opts.addOption([]const u8, "sfx_name", "firered_00A0.wav");

// const gba_mod_runtime = b.createModule(.{
//     // Use Zig runtime API; link translated C mixer for mixing core
//     .root_source_file = b.path("src/maxmod_gba/lib.zig"),
//     .target = gba_target,
//     .optimize = optimize,
// });
// Add translated Maxmod core player and mixer for GBA for linkage and symbols
// const mm_core_mas_c = b.createModule(.{ .root_source_file = b.path("src/translate/maxmod/core/mas_c.zig"), .target = gba_target, .optimize = optimize });
// const mm_gba_mixer_c = b.createModule(.{ .root_source_file = b.path("src/translate/maxmod/gba/mixer_c.zig"), .target = gba_target, .optimize = optimize });
// gba_mod_runtime.addImport("mm_core_mas_c", mm_core_mas_c);
// gba_mod_runtime.addImport("mm_gba_mixer_c", mm_gba_mixer_c);
// Options for the runtime library (shared by executables)
// const lib_opts = b.addOptions();
// // Default to Zig mixer for correctness unless explicitly enabled
// lib_opts.addOption(bool, "use_asm_mixer", false);
// gba_mod_runtime.addOptions("lib_options", lib_opts);
// const gba_lib = b.addStaticLibrary(.{
//     .name = "maxmod-gba-translate",
//     .root_module = gba_mod_runtime,
// });
// b.installArtifact(gba_lib);

// // Build example ROMs using ZigGBA dependency helper

// gba_mod_runtime.addImport("gba", gba_mod);

// // Link our Zig Maxmod static library into the SFX example
// const sfx_example = ziggba.addGBAExecutable(b, gba_mod, "sfx", "examples/sfx/main.zig");
// sfx_example.step.dependOn(&sfx_convert.step);
// sfx_example.linkLibrary(gba_lib);
// // Allow the example to import the runtime as a Zig module (same name)
// sfx_example.root_module.addImport("maxmod_gba", gba_mod_runtime);
// sfx_example.root_module.addOptions("build_options", sfx_opts);
// // Link ASM mixer object to enable ASM path in examples
// sfx_example.addObjectFile(b.path("mixer_asm.o"));

// The sfx step builds the ROM (explicit only; not tied to default install)
// sfx_step.dependOn(&sfx_convert.step);
// sfx_step.dependOn(&sfx_example.step);

// // MOD example: Takes a MOD file as input, creates soundbank.bin, and builds ROM
// const mod_step = b.step("mod", "Build MOD demo ROM from input MOD file");

// // Create the MOD example (always built, but MOD processing is conditional)
// const mod_example = ziggba.addGBAExecutable(b, gba_mod, "mod", "examples/mod/main.zig");
// mod_example.linkLibrary(gba_lib);
// mod_example.root_module.addImport("maxmod_gba", gba_mod_runtime);
// // Link ASM mixer object to enable ASM path in examples
// mod_example.addObjectFile(b.path("mixer_asm.o"));

// // The mod step builds the ROM
// mod_step.dependOn(&mod_example.step);
// b.installArtifact(mod_example);
// mod_step.dependOn(b.default_step);

// // Create a separate step for MOD processing that can be invoked manually
// const mod_process_step = b.step("mod-process", "Process MOD file and create soundbank");

// // MOD-specific processing (only runs when mod-process step is invoked)
// const mod_args = b.args orelse &[_][]const u8{};
// const selected_mod: []const u8 = if (mod_args.len > 0) mod_args[0] else "casio2.mod";

// Copy the selected MOD file to examples/mod directory for embedding
// const copy_mod = b.addSystemCommand(&.{ "cp", selected_mod, "examples/mod/mod_file.mod" });

// // Use our Zig mmutil to extract samples from the MOD and create soundbank.bin
// const create_soundbank = b.addRunArtifact(mmutil_exe);
// create_soundbank.addArgs(&.{
//     selected_mod,
//     "--mod",
//     "-m",
//     "-o",
//     "examples/mod/soundbank.bin",
// });
// create_soundbank.step.dependOn(&copy_mod.step);

// // Build options for the MOD example
// const mod_opts = b.addOptions();
// mod_opts.addOption([]const u8, "mod_name", selected_mod);
// mod_example.root_module.addOptions("build_options", mod_opts);

// // The mod-process step handles the MOD file processing
// mod_process_step.dependOn(&create_soundbank.step);

// // If MOD args are provided, also run the processing step in the main mod step
// if (mod_args.len > 0) {
//     mod_step.dependOn(&create_soundbank.step);
// }

// Optional: allow separate preprocessing step. MOD step does not require it.

// XM example: Build XM demo ROM from input XM file
// const xm_step = b.step("xm", "Build XM demo ROM from input XM file");

// Create the XM example executable
// const xm_example = ziggba.addGBAExecutable(b, gba_mod, "xm", "examples/xm/main.zig");
// xm_example.linkLibrary(gba_lib);
// xm_example.root_module.addImport("maxmod_gba", gba_mod_runtime);
// xm_example.addObjectFile(b.path("mixer_asm.o")); // optional ASM path if available
// Translated Maxmod MAS runtime (player) modules for XM demo only
// const tc_mm_channel_types = b.createModule(.{ .root_source_file = b.path("src/maxmod_gba/tc_maxmod_channel_types_auto.zig"), .target = gba_target, .optimize = optimize });
// const tc_mm_mixer_h = b.createModule(.{ .root_source_file = b.path("src/maxmod_gba/tc_maxmod_mixer_header_auto.zig"), .target = gba_target, .optimize = optimize });
// const tc_mm_mas_arm = b.createModule(.{ .root_source_file = b.path("src/maxmod_gba/tc_maxmod_core_mas_arm_auto.zig"), .target = gba_target, .optimize = optimize });
// const tc_mm_mas = b.createModule(.{ .root_source_file = b.path("src/maxmod_gba/tc_maxmod_core_mas_auto.zig"), .target = gba_target, .optimize = optimize });
// tc_mm_mas.addImport("tc_maxmod_channel_types_auto", tc_mm_channel_types);
// tc_mm_mas.addImport("tc_maxmod_mixer_header_auto", tc_mm_mixer_h);
// tc_mm_mas.addImport("tc_maxmod_core_mas_arm_auto", tc_mm_mas_arm);
// Shim and XM adapter for demo only
// const mmcore_shim = b.createModule(.{ .root_source_file = b.path("src/maxmod_gba/maxmod_core_shim.zig"), .target = gba_target, .optimize = optimize });
// // mmcore_shim.addImport("tc_maxmod_core_mas_auto", tc_mm_mas);
// // mmcore_shim.addImport("tc_maxmod_channel_types_auto", tc_mm_channel_types);
// // mmcore_shim.addImport("tc_maxmod_core_mas_arm_auto", tc_mm_mas_arm);
// mmcore_shim.addImport("maxmod_gba", gba_mod_runtime);
// const xm_adapter = b.createModule(.{ .root_source_file = b.path("src/maxmod_gba/xm_core_adapter.zig"), .target = gba_target, .optimize = optimize });
// xm_adapter.addImport("maxmod_gba", gba_mod_runtime);
// xm_adapter.addImport("tc_maxmod_core_mas_auto", tc_mm_mas);
// xm_adapter.addImport("tc_maxmod_channel_types_auto", tc_mm_channel_types);
// xm_adapter.addImport("tc_maxmod_core_mas_arm_auto", tc_mm_mas_arm);
// xm_adapter.addImport("mmcore_shim", mmcore_shim);
// xm_example.root_module.addImport("tc_maxmod_core_mas_auto", tc_mm_mas);
// xm_example.root_module.addImport("tc_maxmod_channel_types_auto", tc_mm_channel_types);
// xm_example.root_module.addImport("tc_maxmod_core_mas_arm_auto", tc_mm_mas_arm);
// xm_example.root_module.addImport("mmcore_shim", mmcore_shim);
// xm_example.root_module.addImport("xm_core_adapter", xm_adapter);

// Handle XM file argument (copy into example directory)
