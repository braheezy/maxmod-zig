const std = @import("std");
const ziggba = @import("ziggba");

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
    const xm_debug = b.option(bool, "xmdebug", "Enable XM debug mode") orelse false;

    gba_target = b.resolveTargetQuery(gba_thumb_target_query);

    const maxmod_opts = b.addOptions();
    maxmod_opts.addOption(bool, "xm_debug", xm_debug);
    _ = createMaxmodModule(b, "maxmod", maxmod_opts.createModule(), null);
    const gba_b = ziggba.GbaBuild.create(b);

    // Handle file argument
    const file_args = b.args orelse &[_][]const u8{};
    const sfx_arg_list = isSfxArgList(file_args);
    const selected_xm_file: []const u8 = if (file_args.len > 0 and !sfx_arg_list) file_args[0] else "bad_apple.xm";
    const default_sfx_files = [_][]const u8{
        "assets/Ambulance.wav",
        "assets/firered_00A0.wav",
    };
    const selected_sfx_files: []const []const u8 = if (sfx_arg_list) file_args else default_sfx_files[0..];

    const xm_opts = b.addOptions();
    xm_opts.addOption([]const u8, "xm_name", std.fs.path.basename(selected_xm_file));
    xm_opts.addOption(bool, "xm_debug", xm_debug);
    const xm_build_options_mod = xm_opts.createModule();

    const sfx_opts = b.addOptions();
    sfx_opts.addOption(bool, "xm_debug", xm_debug);
    const sfx_build_options_mod = sfx_opts.createModule();

    createXmExample(
        b,
        gba_b,
        selected_xm_file,
        xm_build_options_mod,
    );

    createSfxExample(
        b,
        gba_b,
        selected_sfx_files,
        sfx_build_options_mod,
    );
}

fn createXmExample(
    b: *std.Build,
    gba_b: *ziggba.GbaBuild,
    selected_xm_file: []const u8,
    build_options_mod: *std.Build.Module,
) void {
    const mmutil_dep = b.dependency("mmutil_zig", .{});

    const xm_step = b.step("xm", "Build XM demo ROM");
    // Create XM soundbank generation step using mmutil
    const xm_create_soundbank = b.addRunArtifact(mmutil_dep.artifact("mmutil-zig"));
    xm_create_soundbank.addArgs(&.{
        selected_xm_file,
        "-oexamples/xm/soundbank.bin",
    });

    const default_dep_start = b.default_step.dependencies.items.len;

    // XM ROM
    const xm_exe = gba_b.addExecutable(.{
        .name = "xm",
        .root_source_file = b.path("examples/xm/main.zig"),
    });

    const maxmod_zig = createMaxmodModule(b, "maxmod_xm", build_options_mod, xm_exe.gba_module);
    xm_exe.step.root_module.addImport("maxmod", maxmod_zig);
    xm_exe.step.root_module.addImport("build_options", build_options_mod);
    xm_exe.step.step.dependOn(&xm_create_soundbank.step);
    dependOnNewDefaultDeps(xm_step, b, default_dep_start);
}

fn createSfxExample(
    b: *std.Build,
    gba_b: *ziggba.GbaBuild,
    selected_sfx_files: []const []const u8,
    build_options_mod: *std.Build.Module,
) void {
    const mmutil_dep = b.dependency("mmutil_zig", .{});

    const sfx_step = b.step("sfx", "Build SFX demo ROM");
    const sfx_create_soundbank = b.addRunArtifact(mmutil_dep.artifact("mmutil-zig"));
    sfx_create_soundbank.addArgs(selected_sfx_files);
    sfx_create_soundbank.addArg("-oexamples/sfx/soundbank.bin");

    const default_dep_start = b.default_step.dependencies.items.len;

    const sfx_exe = gba_b.addExecutable(.{
        .name = "sfx",
        .root_source_file = b.path("examples/sfx/main.zig"),
    });

    const maxmod_zig = createMaxmodModule(b, "maxmod_sfx", build_options_mod, sfx_exe.gba_module);
    sfx_exe.step.root_module.addImport("maxmod", maxmod_zig);
    sfx_exe.step.root_module.addImport("build_options", build_options_mod);
    sfx_exe.step.step.dependOn(&sfx_create_soundbank.step);
    dependOnNewDefaultDeps(sfx_step, b, default_dep_start);
}

fn createMaxmodModule(
    b: *std.Build,
    name: []const u8,
    build_options_mod: *std.Build.Module,
    gba_module: ?*std.Build.Module,
) *std.Build.Module {
    const maxmod_zig = b.addModule(name, .{
        .root_source_file = b.path("src/maxmod.zig"),
        .target = gba_target,
        .optimize = .ReleaseFast,
    });
    maxmod_zig.addObjectFile(b.path("src/mixer_asm.o"));
    maxmod_zig.addImport("build_options", build_options_mod);
    if (gba_module) |module| {
        maxmod_zig.addImport("gba", module);
    }
    return maxmod_zig;
}

fn dependOnNewDefaultDeps(step: *std.Build.Step, b: *std.Build, start_index: usize) void {
    const deps = b.default_step.dependencies.items;
    for (deps[start_index..]) |dep| {
        step.dependOn(dep);
    }
}

fn isSfxArgList(args: []const []const u8) bool {
    if (args.len == 0) return false;
    for (args) |arg| {
        if (!std.ascii.eqlIgnoreCase(std.fs.path.extension(arg), ".wav")) return false;
    }
    return true;
}
