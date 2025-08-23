const std = @import("std");

/// MAS binary format constants
pub const MAS_TYPE_SONG: u8 = 0;
pub const MAS_VERSION: u8 = 0x18;
pub const BYTESMASHER: u8 = 0xBA;
/// MAS binary format constants
pub const MAS_TYPE_SAMPLE_GBA: u8 = 1;

/// Represents a single envelope point
pub const EnvelopePoint = struct {
    x: u16,
    y: u8,
};

/// Instrument envelope structure (volume or panning)
pub const Envelope = struct {
    node_count: u8,
    sustain_start: u8,
    sustain_end: u8,
    loop_start: u8,
    loop_end: u8,
    nodes: [12]EnvelopePoint,
    flags: u8,
};

/// Sample metadata & PCM reference
pub const Sample = struct {
    global_volume: u8,
    name: [32]u8,
    data_8: []const u8,
    data_16: []const u16,
    length_bytes: u32,
    loop_start: u32,
    loop_length: u32,
    flags: u8, // 0x10 = 16-bit, low bits = loop type
    default_volume: u8,
    default_panning: u8,
    finetune: i8,
    rel_note: i8,
    // Vibrato fields (from instrument header)
    vibtype: u8 = 0,
    vibdepth: u8 = 0,
    vibspeed: u8 = 0,
    vibrate: u8 = 0,
};

/// Pattern block
pub const Pattern = struct {
    nrows: u16,
    data: []const u8,
};

/// Module that will be written to MAS
pub const MAS_Module = struct {
    title: [32]u8 = [_]u8{0} ** 32,
    channel_count: u8,
    patterns: []const Pattern,
    instruments: []const Instrument,
    samples: []const Sample, // Added samples
    orders: [256]u8,

    order_count: u16,
    inst_count: u8,
    samp_count: u8,
    patt_count: u8,

    flags: u8,
    global_volume: u8,
    initial_speed: u8,
    initial_tempo: u8,
    restart_pos: u8,

    channel_volume: [32]u8,
    channel_panning: [32]u8,
};

/// Instrument structure containing envelope + sample map
pub const Instrument = struct {
    global_volume: u8,
    setpan: u8,
    fadeout: u16,
    random_volume: u8,
    nna: u8,
    dct: u8,
    dca: u8,
    env_flags: u8,
    notemap: [120]u16,

    name: [32]u8,
    sample_map: [96]u8,
    sample_count: u16 = 0,
    volume_env: ?Envelope,
    panning_env: ?Envelope,
    vibrato_type: u8,
    vibrato_sweep: u8,
    vibrato_depth: u8,
    vibrato_rate: u8,
    samples: []const Sample,
};

// --------------------------------------------------------------
// Envelope encoding helper – mimics original Write_Instrument_Envelope
// --------------------------------------------------------------

pub fn encodeEnvelope(writer: anytype, env: Envelope) !void {
    // Write node count etc.
    try writer.writeByte(env.node_count);
    try writer.writeByte(env.sustain_start);
    try writer.writeByte(env.sustain_end);
    try writer.writeByte(env.loop_start);
    try writer.writeByte(env.loop_end);
    try writer.writeByte(env.flags);

    // Write 12 nodes (x lo, x hi, y)
    var i: usize = 0;
    while (i < 12) : (i += 1) {
        const pt = env.nodes[i];
        try writer.writeByte(@as(u8, @intCast(pt.x & 0xFF)));
        try writer.writeByte(@as(u8, @intCast((pt.x >> 8) & 0xFF)));
        try writer.writeByte(pt.y);
    }
}

// --------------------------------------------------------------
// Sample and pattern writers – simplified
// --------------------------------------------------------------

pub fn writeSample(writer: anytype, samp: Sample) !void {
    // MAS prefix header (size calculated by caller)
    const size: u32 = 16 + samp.length_bytes; // 16 header + PCM
    try writer.writeAll(&[_]u8{
        @as(u8, @intCast(size & 0xFF)),         @as(u8, @intCast((size >> 8) & 0xFF)),
        @as(u8, @intCast((size >> 16) & 0xFF)), @as(u8, @intCast((size >> 24) & 0xFF)),
        MAS_TYPE_SAMPLE_GBA,                    1,
        0,                                      0,
    });

    // MAS GBA sample header
    var loop_len_bytes: u32 = 0xFFFFFFFF;
    if (samp.loop_length != 0) loop_len_bytes = samp.loop_length;
    try writer.writeAll(&[_]u8{
        @as(u8, @intCast(samp.length_bytes & 0xFF)),         @as(u8, @intCast((samp.length_bytes >> 8) & 0xFF)),
        @as(u8, @intCast((samp.length_bytes >> 16) & 0xFF)), @as(u8, @intCast((samp.length_bytes >> 24) & 0xFF)),
        @as(u8, @intCast(loop_len_bytes & 0xFF)),            @as(u8, @intCast((loop_len_bytes >> 8) & 0xFF)),
        @as(u8, @intCast((loop_len_bytes >> 16) & 0xFF)),    @as(u8, @intCast((loop_len_bytes >> 24) & 0xFF)),
        0, // format = 0 (8-bit) – 16-bit should be converted by caller
        0,
        0x93, 0x20, // default frequency 0x2093 (~8363 Hz) placeholder
    });

    // PCM data
    if ((samp.flags & 0x10) != 0) {
        // 16-bit – write raw little-endian
        for (samp.data_16) |v| {
            try writer.writeByte(@as(u8, @intCast(v & 0xFF)));
            try writer.writeByte(@as(u8, @intCast(v >> 8)));
        }
    } else {
        try writer.writeAll(samp.data_8);
    }
}

pub fn writePattern(writer: anytype, patt: Pattern) !void {
    // Compute packed size – we will store as uncompressed 4-byte events
    const header_size: u32 = 9;
    const data_size: u32 = @as(u32, patt.nrows) * @as(u32, patt.data.len) / patt.nrows * 4;

    // Pattern header
    try writer.writeAll(&[_]u8{
        @as(u8, @intCast(header_size & 0xFF)),         @as(u8, @intCast((header_size >> 8) & 0xFF)),
        @as(u8, @intCast((header_size >> 16) & 0xFF)), @as(u8, @intCast((header_size >> 24) & 0xFF)),
        0, // packing type
        @as(u8, @intCast(patt.nrows & 0xFF)),
        @as(u8, @intCast((patt.nrows >> 8) & 0xFF)),
        @as(u8, @intCast(data_size & 0xFF)),
        @as(u8, @intCast((data_size >> 8) & 0xFF)),
    });

    // Pattern data – write events verbatim
    for (patt.data) |ev| {
        try writer.writeByte(ev.a);
        try writer.writeByte(ev.b);
        try writer.writeByte(ev.c);
        try writer.writeByte(ev.d);
    }
}

// --------------------------------------------------------------------
// High-level Write_MAS orchestrator – simplified (module + samples)
// --------------------------------------------------------------------

pub fn writeMas(alloc: std.mem.Allocator, module: MAS_Module, out_path: []const u8) !void {
    const file = try std.fs.cwd().createFile(out_path, .{});
    defer file.close();
    const w = file.writer();

    // MAS Header
    try w.writeInt(u32, BYTESMASHER, .little); // Placeholder for file size
    try w.writeByte(MAS_TYPE_SONG);
    try w.writeByte(MAS_VERSION);
    try w.writeByte(BYTESMASHER);
    try w.writeByte(BYTESMASHER);

    const mas_offset = try file.getPos();

    // Module properties
    try w.writeByte(@as(u8, @intCast(module.order_count)));
    try w.writeByte(@as(u8, @intCast(module.inst_count)));
    try w.writeByte(@as(u8, @intCast(module.samp_count)));
    try w.writeByte(@as(u8, @intCast(module.patt_count)));
    try w.writeByte(module.flags);
    try w.writeByte(module.global_volume);
    try w.writeByte(module.initial_speed);
    try w.writeByte(module.initial_tempo);
    try w.writeByte(module.restart_pos);

    // Reserved/padding
    try w.writeByte(BYTESMASHER);
    try w.writeByte(BYTESMASHER);
    try w.writeByte(BYTESMASHER);

    // Channel settings
    for (module.channel_volume) |vol| try w.writeByte(vol);
    for (module.channel_panning) |pan| try w.writeByte(pan);

    // Order list
    var i: usize = 0;
    while (i < module.order_count) : (i += 1) {
        try w.writeByte(module.orders[i]);
    }
    while (i < 200) : (i += 1) {
        try w.writeByte(255); // Pad order list
    }

    const fpos_pointer = try file.getPos();

    // Reserve space for offsets
    const total_offsets = module.inst_count + module.samp_count + module.patt_count;
    try w.writeByteNTimes(BYTESMASHER, total_offsets * 4);

    // --- Data Writing Pass ---
    // (For now, we just write placeholders and will implement real writers later)

    const inst_offsets = try alloc.alloc(u32, module.inst_count);
    defer alloc.free(inst_offsets);
    // TODO: Write instruments and collect offsets

    const samp_offsets = try alloc.alloc(u32, module.samp_count);
    defer alloc.free(samp_offsets);
    // TODO: Write samples and collect offsets

    const patt_offsets = try alloc.alloc(u32, module.patt_count);
    defer alloc.free(patt_offsets);
    // TODO: Write patterns and collect offsets

    // --- Finalization Pass ---
    const final_pos = try file.getPos();
    const file_size = final_pos - mas_offset;

    // Back-patch file size
    try file.seekTo(0);
    try w.writeInt(u32, @intCast(file_size), .little);

    // Back-patch offset tables
    try file.seekTo(fpos_pointer);
    for (inst_offsets) |offset| try w.writeInt(u32, offset, .little);
    for (samp_offsets) |offset| try w.writeInt(u32, offset, .little);
    for (patt_offsets) |offset| try w.writeInt(u32, offset, .little);
}
