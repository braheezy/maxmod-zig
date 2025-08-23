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

    // Use translate-c modules instead of older handwritten C-ports for mmutil
    // Auto-translated C (host) – XM load, MAS write, MSL builder (GBA path only)
    const tc_xm = b.createModule(.{ .root_source_file = b.path("src/mmutil/tc/xm_c_raw.zig"), .target = host_target, .optimize = optimize });
    const tc_mas = b.createModule(.{ .root_source_file = b.path("src/mmutil/tc/mas_c_raw_auto.zig"), .target = host_target, .optimize = optimize });
    const tc_files = b.createModule(.{ .root_source_file = b.path("src/mmutil/tc/files_c_raw_auto.zig"), .target = host_target, .optimize = optimize });
    const tc_simple = b.createModule(.{ .root_source_file = b.path("src/mmutil/tc/simple_c_raw_auto.zig"), .target = host_target, .optimize = optimize });
    const tc_samplefix = b.createModule(.{ .root_source_file = b.path("src/mmutil/tc/samplefix_c_raw_auto.zig"), .target = host_target, .optimize = optimize });
    const tc_adpcm = b.createModule(.{ .root_source_file = b.path("src/mmutil/tc/adpcm_c_raw_auto.zig"), .target = host_target, .optimize = optimize });
    const tc_wav = b.createModule(.{ .root_source_file = b.path("src/mmutil/tc/wav_c_raw_auto.zig"), .target = host_target, .optimize = optimize });
    var tc_shim_mod = b.createModule(.{ .root_source_file = b.path("src/mmutil/tc/shim.zig"), .target = host_target, .optimize = optimize });
    // Allow shim to import the translated modules by name
    tc_shim_mod.addImport("tc_mas_c_raw", tc_mas);
    tc_shim_mod.addImport("tc_samplefix_c_raw", tc_samplefix);
    tc_shim_mod.addImport("tc_adpcm_c_raw", tc_adpcm);
    // Attach modules to root
    mmutil_exe.root_module.addImport("tc_xm_c_raw", tc_xm);
    mmutil_exe.root_module.addImport("tc_mas_c_raw", tc_mas);
    mmutil_exe.root_module.addImport("tc_files_c_raw", tc_files);
    mmutil_exe.root_module.addImport("tc_simple_c_raw", tc_simple);
    mmutil_exe.root_module.addImport("tc_samplefix_c_raw", tc_samplefix);
    mmutil_exe.root_module.addImport("tc_adpcm_c_raw", tc_adpcm);
    mmutil_exe.root_module.addImport("tc_wav_c_raw", tc_wav);
    mmutil_exe.root_module.addImport("tc_shim", tc_shim_mod);

    b.installArtifact(mmutil_exe);

    const run_mmutil = b.addRunArtifact(mmutil_exe);
    run_mmutil.step.dependOn(b.getInstallStep());
    if (b.args) |args| run_mmutil.addArgs(args);
    const run_step = b.step("run", "Run mmutil-zig");
    run_step.dependOn(&run_mmutil.step);

    // Parametric SFX conversion: zig build sfx -- <path-to-wav>
    const sfx_step = b.step("sfx", "Convert WAV to .mmraw, build, and run in mGBA");

    // SFX-specific WAV processing (only runs when sfx step is invoked)
    const sfx_convert = b.addRunArtifact(mmutil_exe);
    sfx_convert.addArgs(&.{
        "firered_00A0.wav", // Default WAV file
        "-o",
        "examples/sfx/sample.mmraw",
        "--rate",
        "16000",
        "--bps",
        "8",
    });

    // Provide the default WAV path to the ROM via build options
    const sfx_opts = b.addOptions();
    sfx_opts.addOption([]const u8, "sfx_name", "firered_00A0.wav");

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
    // Options for the runtime library (shared by executables)
    const lib_opts = b.addOptions();
    // Default to Zig mixer for correctness unless explicitly enabled
    lib_opts.addOption(bool, "use_asm_mixer", false);
    gba_mod_runtime.addOptions("lib_options", lib_opts);
    const gba_lib = b.addStaticLibrary(.{
        .name = "maxmod-gba-zig",
        .root_module = gba_mod_runtime,
    });
    // Zig-only build: do not import or link C sources
    b.installArtifact(gba_lib);

    // Build example ROMs using ZigGBA dependency helper
    const ziggba_dep = b.dependency("ziggba", .{});
    const gba_mod = ziggba_dep.module("gba");
    gba_mod_runtime.addImport("gba", gba_mod);

    // Link our maxmod-gba-zig static library into the SFX example
    const sfx_example = ziggba.addGBAExecutable(b, gba_mod, "sfx", "examples/sfx/main.zig");
    sfx_example.step.dependOn(&sfx_convert.step);
    sfx_example.linkLibrary(gba_lib);
    // Allow the example to import the runtime as a Zig module
    sfx_example.root_module.addImport("maxmod_gba", gba_mod_runtime);
    sfx_example.root_module.addOptions("build_options", sfx_opts);
    // Keep object available; we won't call it by default
    sfx_example.addObjectFile(b.path("mixer_asm.o"));

    // The sfx step builds the ROM
    sfx_step.dependOn(&sfx_convert.step);
    sfx_step.dependOn(&sfx_example.step);
    // Also depend on the default step to ensure the ROM gets installed
    sfx_step.dependOn(b.default_step);

    // MOD example: Takes a MOD file as input, creates soundbank.bin, and builds ROM
    const mod_step = b.step("mod", "Build MOD demo ROM from input MOD file");

    // Create the MOD example (always built, but MOD processing is conditional)
    const mod_example = ziggba.addGBAExecutable(b, gba_mod, "mod", "examples/mod/main.zig");
    mod_example.linkLibrary(gba_lib);
    mod_example.root_module.addImport("maxmod_gba", gba_mod_runtime);
    // Keep the prebuilt ASM mixer object linked
    mod_example.addObjectFile(b.path("mixer_asm.o"));

    // The mod step builds the ROM
    mod_step.dependOn(&mod_example.step);
    // Also depend on the default step to ensure the ROM gets installed
    mod_step.dependOn(b.default_step);

    // Create a separate step for MOD processing that can be invoked manually
    const mod_process_step = b.step("mod-process", "Process MOD file and create soundbank");

    // MOD-specific processing (only runs when mod-process step is invoked)
    const mod_args = b.args orelse &[_][]const u8{};
    const selected_mod: []const u8 = if (mod_args.len > 0) mod_args[0] else "casio2.mod";

    // Copy the selected MOD file to examples/mod directory for embedding
    const copy_mod = b.addSystemCommand(&.{ "cp", selected_mod, "examples/mod/mod_file.mod" });

    // Use our Zig mmutil to extract samples from the MOD and create soundbank.bin
    const create_soundbank = b.addRunArtifact(mmutil_exe);
    create_soundbank.addArgs(&.{
        selected_mod,
        "--mod",
        "-o",
        "examples/mod/soundbank.bin",
    });
    create_soundbank.step.dependOn(&copy_mod.step);

    // Build options for the MOD example
    const mod_opts = b.addOptions();
    mod_opts.addOption([]const u8, "mod_name", selected_mod);
    mod_example.root_module.addOptions("build_options", mod_opts);

    // The mod-process step handles the MOD file processing
    mod_process_step.dependOn(&create_soundbank.step);

    // Make mod step depend on mod-process step
    mod_step.dependOn(mod_process_step);

    // XM example: Build XM demo ROM from input XM file
    const xm_step = b.step("xm", "Build XM demo ROM from input XM file");

    // Create the XM example executable
    const xm_example = ziggba.addGBAExecutable(b, gba_mod, "xm", "examples/xm/main.zig");
    xm_example.linkLibrary(gba_lib);
    xm_example.root_module.addImport("maxmod_gba", gba_mod_runtime);
    xm_example.addObjectFile(b.path("mixer_asm.o")); // keep available for future ASM path

    // Handle XM file argument (copy into example directory)
    const xm_args = b.args orelse &[_][]const u8{};
    const selected_xm: []const u8 = if (xm_args.len > 0) xm_args[0] else "bad_apple.xm";
    const copy_xm = b.addSystemCommand(&.{ "cp", selected_xm, "examples/xm/song.xm" });
    xm_example.step.dependOn(&copy_xm.step);

    const xm_opts = b.addOptions();
    xm_opts.addOption([]const u8, "xm_name", selected_xm);
    xm_example.root_module.addOptions("build_options", xm_opts);

    // Generate a MAS file from the XM for upcoming runtime integration
    const create_xm_soundbank = b.addRunArtifact(mmutil_exe);
    create_xm_soundbank.addArgs(&.{
        selected_xm,
        "--xm",
        "-m",
        "-o",
        "examples/xm/soundbank.bin",
    });
    create_xm_soundbank.step.dependOn(&copy_xm.step);

    // Ensure example build waits for the soundbank
    xm_example.step.dependOn(&create_xm_soundbank.step);

    // xm step depends on processing too
    xm_step.dependOn(&copy_xm.step);
    xm_step.dependOn(&create_xm_soundbank.step);
    xm_step.dependOn(&xm_example.step);
    xm_step.dependOn(b.default_step);
}
