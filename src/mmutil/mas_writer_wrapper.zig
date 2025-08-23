const std = @import("std");

// Test that this module is being loaded
comptime {
    _ = "MAS_WRITER_WRAPPER_LOADED";
}

// Add a simple test function to verify the module is loaded
pub fn testWrapper() void {
    std.debug.print("=== MAS WRAPPER MODULE IS LOADED ===\n", .{});
}

// Import the translated C modules
const mas_c = @import("mas_c_raw");
const simple_c = @import("simple_c_raw");
const masw = @import("mas_writer.zig");

// Provide missing global variables that the C code expects
pub export var target_system: c_int = 0; // 0 = SYSTEM_GBA
pub export var MAS_FILESIZE: u32 = 0;

// Functions are provided by simple_c_raw module, no need to re-export
// But we need to reference them so they get linked
comptime {
    _ = simple_c.sample_dsformat;
    _ = simple_c.sample_dsreptype;
}

/// Initialize file writing for MAS generation
pub fn initMasWriter(output_path: []const u8) !void {
    std.debug.print("=== INIT MAS WRITER ===\n", .{});
    std.debug.print("Opening file: {s}\n", .{output_path});

    // Use the embedded file writer from mas_c_raw
    try mas_c.initFileWriter(output_path);
    std.debug.print("File opened successfully!\n", .{});
}

/// Close the MAS file writer
pub fn closeMasWriter() void {
    mas_c.closeFileWriter();
}

/// Convert our Zig MAS module to the C structure and write it
pub fn writeMasFile(
    allocator: std.mem.Allocator,
    zig_module: anytype, // This will be our Zig MAS_Module
    output_path: []const u8,
    verbose: bool,
    msl_dep: bool,
) !void {
    std.debug.print("writeMasFile called with {} instruments, {} samples, {} patterns\n", .{ zig_module.instruments.len, zig_module.samples.len, zig_module.patterns.len });

    // Initialize file writing
    try initMasWriter(output_path);
    defer closeMasWriter();

    // Convert our Zig module to the C structure
    var c_module = try convertZigModuleToCModule(allocator, zig_module);

    // --- BEGIN NEW CODE ---
    // Sanity-check: ensure the converted counts match the Zig view
    if (c_module.inst_count != zig_module.inst_count or
        c_module.samp_count != zig_module.samp_count or
        c_module.patt_count != zig_module.patt_count)
    {
        std.debug.print("[WARN] Count mismatch after conversion. Zig: inst={} samp={} patt={} | C: inst={} samp={} patt={}\n", .{ zig_module.inst_count, zig_module.samp_count, zig_module.patt_count, c_module.inst_count, c_module.samp_count, c_module.patt_count });
    } else {
        std.debug.print("[OK] Counts verified. instruments={} samples={} patterns={}\n", .{ c_module.inst_count, c_module.samp_count, c_module.patt_count });
    }
    // --- END NEW CODE ---

    // Call the translated C function
    std.debug.print("Calling Write_MAS with module: {} instruments, {} samples, {} patterns\n", .{ c_module.inst_count, c_module.samp_count, c_module.patt_count });
    // Ensure flags mirror C XM path
    c_module.xm_mode = 1;
    c_module.old_effects = 1;
    const result = mas_c.Write_MAS(&c_module, @intFromBool(verbose), @intFromBool(msl_dep));
    std.debug.print("Write_MAS result: {}\n", .{result});
    if (result != 0) {
        // Ensure we free any converted allocations before returning an error
        freeConvertedModule(allocator, &c_module);
        return error.MASWriteFailed;
    }

    // Free temporary converted module allocations to prevent leaks
    freeConvertedModule(allocator, &c_module);
}

/// Convert our Zig module structure to the C module structure
fn convertZigModuleToCModule(allocator: std.mem.Allocator, zig_module: anytype) !mas_c.MAS_Module {
    var c_module: mas_c.MAS_Module = std.mem.zeroes(mas_c.MAS_Module);

    // Set title (C module has this field, Zig module doesn't)
    @memcpy(&c_module.title, &zig_module.title);

    // Copy basic fields
    c_module.order_count = @intCast(zig_module.order_count);
    c_module.inst_count = @intCast(zig_module.inst_count);
    c_module.samp_count = @intCast(zig_module.samp_count);
    c_module.patt_count = @intCast(zig_module.patt_count);
    c_module.restart_pos = zig_module.restart_pos;

    // Map Zig flags to individual C boolean fields (@"bool" = u8)
    c_module.stereo = 0; // mono
    c_module.inst_mode = 1;
    // XM defaults from C Load_XM
    c_module.old_effects = 1;
    c_module.xm_mode = 1;
    c_module.old_mode = 0;
    // best-effort freq mode: assume linear table for XM unless flags say otherwise
    c_module.freq_mode = 1;
    c_module.link_gxx = 0;

    c_module.global_volume = 64;
    c_module.initial_speed = zig_module.initial_speed;
    c_module.initial_tempo = zig_module.initial_tempo;

    // Copy channel arrays
    @memcpy(&c_module.channel_volume, &zig_module.channel_volume);
    @memcpy(&c_module.channel_panning, &zig_module.channel_panning);
    @memcpy(&c_module.orders, &zig_module.orders);

    // Convert instruments
    if (zig_module.instruments.len > 0) {
        var c_instruments = try allocator.alloc(mas_c.Instrument, zig_module.instruments.len);
        var ns_base: u16 = 0;
        for (0..zig_module.instruments.len) |i| {
            c_instruments[i] = try convertInstrumentWithBase(allocator, zig_module.instruments[i], ns_base);
            // advance base by this instrument's sample count (zig side provides it)
            ns_base +%= @as(u16, @intCast(zig_module.instruments[i].sample_count));
        }
        c_module.instruments = c_instruments.ptr;
    }

    // Convert samples
    if (zig_module.samples.len > 0) {
        var c_samples = try allocator.alloc(mas_c.Sample, zig_module.samples.len);
        for (0..zig_module.samples.len) |i| {
            c_samples[i] = try convertSample(allocator, zig_module.samples[i]);
        }
        c_module.samples = c_samples.ptr;
    }

    // Convert patterns
    if (zig_module.patterns.len > 0) {
        var c_patterns = try allocator.alloc(mas_c.Pattern, zig_module.patterns.len);
        for (0..zig_module.patterns.len) |i| {
            c_patterns[i] = try convertPattern(allocator, zig_module.patterns[i]);
        }
        c_module.patterns = c_patterns.ptr;
    }

    return c_module;
}

fn convertInstrumentWithBase(allocator: std.mem.Allocator, zig_inst: anytype, ns_base: u16) !mas_c.Instrument {
    _ = allocator; // TODO: implement if needed
    var c_inst: mas_c.Instrument = std.mem.zeroes(mas_c.Instrument);

    // Set parapointer to 0 (will be filled by Write_Instrument)
    c_inst.parapointer = 0;

    c_inst.global_volume = zig_inst.global_volume;
    c_inst.setpan = zig_inst.setpan;
    c_inst.fadeout = zig_inst.fadeout;
    c_inst.random_volume = zig_inst.random_volume;
    c_inst.nna = zig_inst.nna;
    c_inst.dct = zig_inst.dct;
    c_inst.dca = zig_inst.dca;
    // Mirror C: env_flags |= (1|8) if volume envelope enabled; |=2 if pan envelope enabled
    c_inst.env_flags = 0;
    if (zig_inst.volume_env) |_| c_inst.env_flags |= 1 | 8;
    if (zig_inst.panning_env) |_| c_inst.env_flags |= 2;
    @memcpy(&c_inst.name, &zig_inst.name);
    // Rebuild notemap exactly like C (xm.c lines ~121-129):
    // first map 96 entries to notes 12..107 with sample indices + ns + 1
    var i: usize = 0;
    // We don't have running ns here; assume 0-based sample block per instrument, so +1.
    // This matches mmutil behavior when samples are written in instrument order.
    while (i < 96) : (i += 1) {
        const sample_plus: u16 = ns_base + @as(u16, zig_inst.sample_map[i]) + 1;
        const note: u16 = @as(u16, 12 + @as(u16, @intCast(i)));
        c_inst.notemap[12 + i] = (sample_plus << 8) | (note & 0xFF);
    }
    // Low 12 notes use first notemap sample, note index stays 0..11
    const base_sample: u16 = c_inst.notemap[12] & 0xFF00;
    i = 0;
    while (i < 12) : (i += 1) {
        c_inst.notemap[i] = base_sample | @as(u16, @intCast(i));
    }
    // High 12 notes 108..119 also use first notemap sample
    i = 96;
    while (i < 120) : (i += 1) {
        c_inst.notemap[i] = base_sample | @as(u16, @intCast(i));
    }

    // Convert envelopes if present
    if (zig_inst.volume_env) |env| {
        c_inst.envelope_volume = convertEnvelope(env);
    }
    if (zig_inst.panning_env) |env| {
        c_inst.envelope_pan = convertEnvelope(env);
    }

    // Initialize pitch envelope only
    c_inst.envelope_pitch = std.mem.zeroes(mas_c.Instrument_Envelope);

    return c_inst;
}

fn getXmFrequency(rel_note: i8, finetune: i8) u32 {
    const rn: f64 = @floatFromInt(rel_note);
    const ft: f64 = @floatFromInt(finetune);
    const middle_c: f64 = 8363.0;
    const freq: f64 = middle_c * std.math.pow(f64, 2.0, (1.0 / 12.0) * rn + (1.0 / (12.0 * 128.0)) * ft);
    return @intFromFloat(freq);
}

fn convertSample(allocator: std.mem.Allocator, zig_samp: anytype) !mas_c.Sample {
    _ = allocator; // TODO: implement if needed
    var c_samp: mas_c.Sample = std.mem.zeroes(mas_c.Sample);

    // Set parapointer to 0 (will be filled by Write_Sample)
    c_samp.parapointer = 0;

    // C sets sample global volume to 64
    c_samp.global_volume = 64;
    c_samp.default_volume = zig_samp.default_volume;
    // C mmutil sets default_panning = (xm_panning>>1) | 128
    c_samp.default_panning = (@as(u8, @intCast((@as(u16, zig_samp.default_panning) >> 1))) | 128);
    // Compute sample length and loop bounds in frames like C (divide by 2 if 16-bit)
    const is16: bool = (zig_samp.data_16.len > 0);
    const length_bytes: u32 = zig_samp.length_bytes;
    var loop_start_bytes: u32 = zig_samp.loop_start;
    var loop_end_bytes: u32 = zig_samp.loop_start +| zig_samp.loop_length;
    if (c_samp.loop_type == 0) {
        loop_start_bytes = 0;
        loop_end_bytes = 0;
    }
    if (is16) {
        c_samp.sample_length = length_bytes / 2;
        c_samp.loop_start = loop_start_bytes / 2;
        c_samp.loop_end = loop_end_bytes / 2;
    } else {
        c_samp.sample_length = length_bytes;
        c_samp.loop_start = loop_start_bytes;
        c_samp.loop_end = loop_end_bytes;
    }
    c_samp.frequency = getXmFrequency(zig_samp.rel_note, zig_samp.finetune);

    // Vibrato fields copied from instrument context via mas_writer.Sample
    c_samp.vibtype = zig_samp.vibtype;
    c_samp.vibdepth = zig_samp.vibdepth;
    c_samp.vibspeed = zig_samp.vibspeed;
    c_samp.vibrate = zig_samp.vibrate;

    // Point to the sample data
    if (zig_samp.data_16.len > 0) {
        c_samp.data = @ptrCast(@constCast(zig_samp.data_16.ptr));
        c_samp.format = 1; // 16-bit
    } else if (zig_samp.data_8.len > 0) {
        c_samp.data = @ptrCast(@constCast(zig_samp.data_8.ptr));
        c_samp.format = 0; // 8-bit
    }

    @memcpy(&c_samp.name, &zig_samp.name);
    // Ensure null termination
    c_samp.name[31] = 0;
    // Mirror C defaults
    c_samp.msl_index = 0xFFFF;
    c_samp.rsamp_index = 0;
    // Copy filename prefix from name (first 12 bytes)
    var fi: usize = 0;
    while (fi < 12) : (fi += 1) c_samp.filename[fi] = c_samp.name[fi];

    return c_samp;
}

fn convertPattern(allocator: std.mem.Allocator, zig_patt: anytype) !mas_c.Pattern {
    _ = allocator; // TODO: implement if needed
    var c_patt: mas_c.Pattern = std.mem.zeroes(mas_c.Pattern);

    // Set parapointer to 0 (will be filled by Write_Pattern)
    c_patt.parapointer = 0;
    c_patt.nrows = zig_patt.nrows;
    c_patt.clength = 0; // Will be calculated by Write_Pattern

    // Convert zig_patt.data (5 bytes per event) to PatternEntry array
    // Events are in row-major over 32 channels
    const bytes: []const u8 = zig_patt.data;
    if (bytes.len % 5 != 0) return error.InvalidPatternData;
    const event_count = bytes.len / 5;
    if (event_count > c_patt.data.len) return error.PatternTooLarge;
    var i: usize = 0;
    while (i < event_count) : (i += 1) {
        const base = i * 5;
        c_patt.data[i].note = bytes[base + 0];
        c_patt.data[i].inst = bytes[base + 1];
        c_patt.data[i].vol = bytes[base + 2];
        c_patt.data[i].fx = bytes[base + 3];
        c_patt.data[i].param = bytes[base + 4];
    }

    return c_patt;
}

fn freeConvertedModule(allocator: std.mem.Allocator, c_module: *mas_c.MAS_Module) void {
    if (c_module.instruments != null) {
        allocator.free(@as([*]mas_c.Instrument, @ptrCast(c_module.instruments))[0..c_module.inst_count]);
    }
    if (c_module.samples != null) {
        allocator.free(@as([*]mas_c.Sample, @ptrCast(c_module.samples))[0..c_module.samp_count]);
    }
    if (c_module.patterns != null) {
        allocator.free(@as([*]mas_c.Pattern, @ptrCast(c_module.patterns))[0..c_module.patt_count]);
    }
}

fn convertEnvelope(env: masw.Envelope) mas_c.Instrument_Envelope {
    var c_env: mas_c.Instrument_Envelope = std.mem.zeroes(mas_c.Instrument_Envelope);
    c_env.node_count = env.node_count;
    c_env.sus_start = env.sustain_start;
    c_env.sus_end = env.sustain_end;
    c_env.loop_start = env.loop_start;
    c_env.loop_end = env.loop_end;
    // copy nodes
    var i: usize = 0;
    while (i < 12) : (i += 1) {
        c_env.node_x[i] = env.nodes[i].x;
        c_env.node_y[i] = env.nodes[i].y;
    }
    return c_env;
}
