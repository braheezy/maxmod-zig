const std = @import("std");
// Bring in translated C MAS headers for constants/layout parity (future use)
pub const tc_mas = @import("tc_mas_c_raw");

/// MAS format constants (subset)
pub const MAS_TYPE_SAMPLE_GBA: u8 = 1;

/// Represents a decoded GBA sample header and pointer to PCM data in ROM.
pub const MasSample = struct {
    length: u32,
    loop_length: u32,
    format: u8, // 0 = 8-bit unsigned; 1 = ADPCM (not supported)
    default_freq: u16,
    pcm: [*]const u8,
};

/// Loaded MAS bank with samples table (modules skipped for now).
pub const MasBank = struct {
    samples: []MasSample,
};

/// Parse a MAS/MSL soundbank from in-memory bytes.
/// Currently reads only the sample table and each MAS chunk.
pub fn loadMasBank(alloc: std.mem.Allocator, data: []const u8) !MasBank {
    if (data.len < 12) return error.InvalidMasBank;
    // MSL header: sample_count, module_count, reserved
    const sample_count: u16 = readLeU16(data, 0);
    const module_count: u16 = readLeU16(data, 2);
    _ = module_count; // TODO: modules later
    if (!std.mem.eql(u8, data[4..12], "*maxmod*")) return error.InvalidMasBank;

    var samples = try alloc.alloc(MasSample, sample_count);

    const sample_table_off: usize = 12;
    const module_table_off: usize = sample_table_off + sample_count * 4;
    if (data.len < module_table_off) return error.InvalidMasBank;

    // Iterate over sample table
    var i: usize = 0;
    while (i < sample_count) : (i += 1) {
        const off: usize = readLeU32(data, sample_table_off + i * 4);
        if (off + 32 > data.len) return error.InvalidMasBank;
        // Parse MAS prefix
        _ = readLeU32(data, off); // size in bytes
        const mtype: u8 = data[off + 4];
        if (mtype != MAS_TYPE_SAMPLE_GBA) return error.UnsupportedMasType;
        const header_off: usize = off + 8; // skip 8-byte prefix (size/type/ver/res)
        const length: u32 = readLeU32(data, header_off);
        const loop_len: u32 = readLeU32(data, header_off + 4);
        const fmt: u8 = data[header_off + 8];
        const default_freq: u16 = readLeU16(data, header_off + 10);
        const pcm_off: usize = header_off + 16;
        if (pcm_off + length > data.len) return error.InvalidMasBank;
        samples[i] = MasSample{
            .length = length,
            .loop_length = loop_len,
            .format = fmt,
            .default_freq = default_freq,
            .pcm = data[pcm_off .. pcm_off + length].ptr,
        };
    }
    return MasBank{ .samples = samples };
}

// ---- Tiny helpers ----
inline fn readLeU16(buf: []const u8, off: usize) u16 {
    return @as(u16, buf[off]) | (@as(u16, buf[off + 1]) << 8);
}
inline fn readLeU32(buf: []const u8, off: usize) u32 {
    return @as(u32, buf[off]) | (@as(u32, buf[off + 1]) << 8) | (@as(u32, buf[off + 2]) << 16) | (@as(u32, buf[off + 3]) << 24);
}

// MAS file format structures based on maxmod C implementation
pub const MasPrefix = struct {
    size: u32,
    type: u8, // MAS_TYPE_SONG, MAS_TYPE_SAMPLE_GBA or MAS_TYPE_SAMPLE_NDS
    version: u8,
    reserved: [2]u8,
};

pub const MasHead = struct {
    order_count: u8,
    instr_count: u8,
    sampl_count: u8,
    pattn_count: u8,
    flags: u8,
    global_volume: u8,
    initial_speed: u8,
    initial_tempo: u8,
    repeat_position: u8,
    reserved: [3]u8,
    channel_volume: [32]u8,
    channel_panning: [32]u8,
    sequence: [200]u8,
};

pub const MasInstrument = struct {
    global_volume: u8,
    fadeout: u8,
    random_volume: u8,
    dct: u8,
    nna: u8,
    env_flags: u8,
    panning: u8,
    dca: u8,
    note_map_offset: u15,
    is_note_map_invalid: u1,
    reserved: u16,
};

pub const MasSampleInfo = struct {
    default_volume: u8,
    panning: u8,
    frequency: u16,
    av_type: u8, // VIT (auto vibrato)
    av_depth: u8, // VID
    av_speed: u8, // VIS
    global_volume: u8, // GV
    av_rate: u16, // VIR
    msl_id: u16,
};

pub const MasModule = struct {
    // Backing data for the entire MAS blob (starting at prefix)
    data: []const u8,
    // Byte offset (from start of data) where MasHead begins
    head_off: usize,
    head: MasHead,
    // Offset tables (relative to start of head)
    insttable: []u32,
    samptable: []u32,
    patttable: []u32,
};

pub fn parse(allocator: std.mem.Allocator, bytes: []const u8) !MasModule {
    if (bytes.len < @sizeOf(MasPrefix)) return error.InvalidMasFile;

    var offset: usize = 0;

    // Parse prefix
    const prefix_bytes = bytes[offset .. offset + @sizeOf(MasPrefix)];
    const prefix = std.mem.bytesToValue(MasPrefix, prefix_bytes);
    offset += @sizeOf(MasPrefix);

    if (prefix.type != 0) return error.NotMasSong; // Must be MAS_TYPE_SONG

    // Parse header (immediately after prefix)
    if (offset + @sizeOf(MasHead) > bytes.len) return error.InvalidMasFile;
    const head_bytes = bytes[offset .. offset + @sizeOf(MasHead)];
    const head = std.mem.bytesToValue(MasHead, head_bytes);
    const head_off = offset;
    offset += @sizeOf(MasHead);

    // Build offset tables: instrument, sample, and pattern tables live right after head
    // Each entry is a 32-bit offset relative to the start of the head
    var insttable = try allocator.alloc(u32, head.instr_count);
    var i: usize = 0;
    while (i < insttable.len) : (i += 1) {
        if (offset + 4 > bytes.len) return error.InvalidMasFile;
        const b0: u32 = bytes[offset + 0];
        const b1: u32 = bytes[offset + 1];
        const b2: u32 = bytes[offset + 2];
        const b3: u32 = bytes[offset + 3];
        insttable[i] = (b0) | (b1 << 8) | (b2 << 16) | (b3 << 24);
        offset += 4;
    }

    var samptable = try allocator.alloc(u32, head.sampl_count);
    var s: usize = 0;
    while (s < samptable.len) : (s += 1) {
        if (offset + 4 > bytes.len) return error.InvalidMasFile;
        const c0: u32 = bytes[offset + 0];
        const c1: u32 = bytes[offset + 1];
        const c2: u32 = bytes[offset + 2];
        const c3: u32 = bytes[offset + 3];
        samptable[s] = (c0) | (c1 << 8) | (c2 << 16) | (c3 << 24);
        offset += 4;
    }

    var patttable = try allocator.alloc(u32, head.pattn_count);
    var p: usize = 0;
    while (p < patttable.len) : (p += 1) {
        if (offset + 4 > bytes.len) return error.InvalidMasFile;
        const d0: u32 = bytes[offset + 0];
        const d1: u32 = bytes[offset + 1];
        const d2: u32 = bytes[offset + 2];
        const d3: u32 = bytes[offset + 3];
        patttable[p] = (d0) | (d1 << 8) | (d2 << 16) | (d3 << 24);
        offset += 4;
    }

    return MasModule{
        .data = bytes,
        .head_off = head_off,
        .head = head,
        .insttable = insttable,
        .samptable = samptable,
        .patttable = patttable,
    };
}

// Module channel structure (mirrors C mm_module_channel)
pub const MasModuleChannel = struct {
    inst: u8 = 0, // Instrument#
    pflags: u8 = 0, // Playback flags (unused)
    vibdep: u8 = 0, // Vibrato depth
    vibspd: u8 = 0, // Vibrato speed
    vibpos: u8 = 0, // Vibrato position
    volume: u8 = 64, // Channel volume
    cvolume: u8 = 64, // Channel volume (copy)
    period: u32 = 0, // Period
    bflags: u16 = 0, // Behavior flags
    pnoter: u8 = 0, // Pattern note
    cflags: u8 = 0, // Compression flags
    volcmd: u8 = 0, // Volume command
    effect: u8 = 0, // Effect
    param: u8 = 0, // Effect parameter
    flags: u8 = 0, // Pattern flags
    memory: [15]u8 = [_]u8{0} ** 15, // Effect memory
    fxmem: u8 = 0, // Effect memory for retrigger
    panning: u8 = 128, // Panning
    alloc: u8 = 255, // Allocated active channel (255 = none)
};

// Compression flags
const COMPR_FLAG_NOTE = 1 << 0;
const COMPR_FLAG_INSTR = 1 << 1;
const COMPR_FLAG_VOLC = 1 << 2;
const COMPR_FLAG_EFFC = 1 << 3;

// Pattern flags
const MF_START = 1;
const MF_DVOL = 2;
const MF_HASVCMD = 4;
const MF_HASFX = 8;
const MF_NEWINSTR = 16;
const MF_NOTEOFF = 64;
const MF_NOTECUT = 128;

// Special note values
const NOTE_CUT = 254;
const NOTE_OFF = 255;

// MAS Player implementation
// Remove Zig MAS player; we will drive mixing from C-like decoded state in lib.zig
