const std = @import("std");
const masw = @import("mas_writer.zig");

pub const XmError = error{ InvalidXmFile, UnexpectedEof, InvalidPattern };

/// Representation of a single note/event in a pattern.
pub const XmEvent = struct {
    note: u8 = 255, // 0..95 => C-0..B-7, 255 = empty / key-off after translation
    instrument: u8 = 0, // 1..128, 0 = none
    volume: u8 = 0, // raw XM volume column byte
    effect: u8 = 0,
    param: u8 = 0,
};

/// Pattern rows * channels events.
/// `data` length = rows * channel_count.
pub const XmPattern = struct {
    rows: u16,
    data: []XmEvent,
};

/// Parse a single XM pattern starting at `data[offset..]`.
/// Returns the parsed pattern and the number of bytes consumed.
pub fn parseXmPattern(alloc: std.mem.Allocator, data: []const u8, channel_count: u16) !struct { pattern: XmPattern, bytes_read: usize } {
    if (data.len < 9) return XmError.UnexpectedEof; // minimum header size

    // 1. Pattern header length (uint32 LE)
    const header_length: u32 = readLeU32(data, 0);

    if (data.len < header_length + 4) return XmError.UnexpectedEof;

    // 2. Packing type (byte – must be 0)
    const packing_type: u8 = data[4];
    if (packing_type != 0) return XmError.InvalidPattern;

    // 3. Number of rows (u16 LE)
    const rows: u16 = readLeU16(data, 5);

    // 4. Packed pattern data size (u16 LE)
    const packed_length: u16 = readLeU16(data, 7);

    // Ensure we have the claimed packed length following the header
    const pattern_data_offset: usize = 4 + @as(usize, header_length); // where packed data begins

    if (data.len < pattern_data_offset + packed_length) return XmError.UnexpectedEof;

    const pattern_data = data[pattern_data_offset .. pattern_data_offset + packed_length];

    // Allocate event array
    const total_events: usize = @as(usize, rows) * @as(usize, channel_count);
    var events = try alloc.alloc(XmEvent, total_events);
    // Initialize with defaults
    for (events) |*ev| ev.* = XmEvent{};

    // If packed_length == 0 => pattern is empty – leave defaults and return.
    if (packed_length == 0) {
        return .{ .pattern = XmPattern{ .rows = rows, .data = events }, .bytes_read = pattern_data_offset };
    }

    var idx: usize = 0; // index within pattern_data
    var row: u16 = 0;
    while (row < rows) : (row += 1) {
        var ch: u16 = 0;
        while (ch < channel_count) : (ch += 1) {
            if (idx >= pattern_data.len) return XmError.UnexpectedEof;
            const b: u8 = pattern_data[idx];
            idx += 1;
            var note: u8 = 255;
            var instrument: u8 = 0;
            var volume: u8 = 0;
            var effect: u8 = 0;
            var param: u8 = 0;

            if ((b & 0x80) != 0) {
                // Packed entry
                if ((b & 0x01) != 0) {
                    if (idx >= pattern_data.len) return XmError.UnexpectedEof;
                    note = pattern_data[idx];
                    idx += 1;
                }
                if ((b & 0x02) != 0) {
                    if (idx >= pattern_data.len) return XmError.UnexpectedEof;
                    instrument = pattern_data[idx];
                    idx += 1;
                }
                if ((b & 0x04) != 0) {
                    if (idx >= pattern_data.len) return XmError.UnexpectedEof;
                    volume = pattern_data[idx];
                    idx += 1;
                }
                if ((b & 0x08) != 0) {
                    if (idx >= pattern_data.len) return XmError.UnexpectedEof;
                    effect = pattern_data[idx];
                    idx += 1;
                }
                if ((b & 0x10) != 0) {
                    if (idx >= pattern_data.len) return XmError.UnexpectedEof;
                    param = pattern_data[idx];
                    idx += 1;
                }
            } else {
                // Unpacked entry: first byte was the note, the next 4 follow.
                note = b;
                if (idx + 4 > pattern_data.len) return XmError.UnexpectedEof;
                instrument = pattern_data[idx];
                volume = pattern_data[idx + 1];
                effect = pattern_data[idx + 2];
                param = pattern_data[idx + 3];
                idx += 4;
            }

            // Translate note value as done in original C:
            if (note == 97) {
                note = 255; // key-off
            } else if (note >= 1 and note <= 96) {
                note = note + 11; // +12-1 to convert C-0 index so that 0=C-1? replicate
            } else {
                // 0 or other values => leave as-is (0 and 255 both mean empty in MM sources)
            }

            const event_index: usize = @as(usize, row) * @as(usize, channel_count) + @as(usize, ch);
            events[event_index] = XmEvent{
                .note = note,
                .instrument = instrument,
                .volume = volume,
                .effect = effect,
                .param = param,
            };
        }
    }

    return .{ .pattern = XmPattern{ .rows = rows, .data = events }, .bytes_read = pattern_data_offset + packed_length };
}

// ------------------------------------------------------
// Existing stubs (header & soundbank will be implemented later)

pub const XMFile = struct {
    samples: []XmSample,
};

/// Comprehensive XM parse that gathers all samples (metadata+PCM).
/// Currently skips pattern decoding for speed.
pub fn parseXmFile(alloc: std.mem.Allocator, data: []const u8) !XMFile {
    if (data.len < 64 or !std.mem.startsWith(u8, data, "Extended Module:"))
        return XmError.InvalidXmFile;

    const header_size: u32 = readLeU32(data, 60);
    const song_header_start: usize = 64;

    if (data.len < song_header_start + 20) return XmError.UnexpectedEof;

    const pattern_count: u16 = readLeU16(data, song_header_start + 6);
    const instrument_count: u16 = readLeU16(data, song_header_start + 8);

    // C reference uses an absolute seek: 60 + header_size. Our slice-based
    // approach requires careful relative offset tracking.
    var offset: usize = 60 + @as(usize, header_size);
    if (data.len < offset) return XmError.UnexpectedEof;

    // --- Skip pattern data ---
    var i: u16 = 0;
    while (i < pattern_count) : (i += 1) {
        if (data.len < offset + 9) return XmError.UnexpectedEof;
        const headstart: usize = offset;
        const headsize: u32 = readLeU32(data, offset);
        // Move to start of packed data: headstart + headsize (C reference)
        offset = headstart + @as(usize, headsize);
        if (data.len < offset) return XmError.UnexpectedEof;
        const packed_size: u16 = readLeU16(data, headstart + 7);
        offset += @as(usize, packed_size);
        if (data.len < offset) return XmError.UnexpectedEof;
    }

    // --- Parse instruments & collect samples ---
    var samples_dyn = std.ArrayList(XmSample).init(alloc);
    defer samples_dyn.deinit();

    var inst_idx: u16 = 0;
    while (inst_idx < instrument_count) : (inst_idx += 1) {
        const result = try parseXmInstrument(alloc, data[offset..]);
        errdefer {
            for (result.instrument.samples) |s| {
                if (s.pcm8.len > 0) alloc.free(s.pcm8);
                if (s.pcm16.len > 0) alloc.free(s.pcm16);
            }
            alloc.free(result.instrument.samples);
        }
        offset += result.bytes_read;
        for (result.instrument.samples) |samp| try samples_dyn.append(samp);
        // After appending, we've transferred ownership of the sample data.
        // We must free the container slice, but not the PCM data within.
        alloc.free(result.instrument.samples);
    }

    return XMFile{ .samples = try samples_dyn.toOwnedSlice() };
}

pub fn createSoundbank(_: std.mem.Allocator, xm: XMFile, output_path: []const u8) !void {
    // For now, emit an empty MSL header so tooling can be wired up.
    const file = try std.fs.cwd().createFile(output_path, .{});
    defer file.close();
    const writer = file.writer();

    const sample_count: u16 = @as(u16, @intCast(xm.samples.len));
    const module_count: u16 = 0;

    // MSL header: sample_count, module_count, reserved "*maxmod*"
    try writer.writeAll(&[_]u8{
        @as(u8, @intCast(sample_count & 0xFF)),
        @as(u8, @intCast((sample_count >> 8) & 0xFF)),
        @as(u8, @intCast(module_count & 0xFF)),
        @as(u8, @intCast((module_count >> 8) & 0xFF)),
    });
    try writer.writeAll(&[_]u8{ '*', 'm', 'a', 'x', 'm', 'o', 'd', '*' });
    // No sample table or MAS chunks yet – will be added in later streams.
}

// ----------------- Internal helpers -----------------
inline fn readLeU16(data: []const u8, offset: usize) u16 {
    return (@as(u16, data[offset])) | (@as(u16, data[offset + 1]) << 8);
}

inline fn readLeU32(data: []const u8, offset: usize) u32 {
    return (@as(u32, data[offset])) |
        (@as(u32, data[offset + 1]) << 8) |
        (@as(u32, data[offset + 2]) << 16) |
        (@as(u32, data[offset + 3]) << 24);
}

// ============================================================
// Stream A Task 3: Instrument Parser
// ============================================================

/// Single envelope point (time,value)
pub const XmEnvelopePoint = struct { x: u16, y: u8 };

pub const XmEnvelope = struct {
    points: [12]XmEnvelopePoint,
    point_count: u8,
    sustain_start: u8,
    sustain_end: u8,
    loop_start: u8,
    loop_end: u8,
    flags: u8, // bit0=on, bit1=sustain, bit2=loop (combined similar to maxmod)
};

pub const XmSampleHeader = struct {
    length: u32,
    loop_start: u32,
    loop_length: u32,
    volume: u8,
    finetune: i8,
    type_flags: u8,
    panning: u8,
    rel_note: i8,
    name: [22]u8,
};

pub const XmInstrument = struct {
    name: [22]u8,
    sample_count: u16,
    sample_map: [96]u8, // note -> sample index mapping (0-based)
    volume_env: XmEnvelope,
    panning_env: XmEnvelope,
    vibrato_type: u8,
    vibrato_sweep: u8,
    vibrato_depth: u8,
    vibrato_rate: u8,
    fadeout: u16,
    samples: []XmSample, // allocated slice, may be empty
};

/// Parse an XM instrument and its in-file sample headers.
/// Returns the parsed instrument plus the total bytes consumed from `data`.
pub fn parseXmInstrument(alloc: std.mem.Allocator, data: []const u8) !struct { instrument: XmInstrument, bytes_read: usize } {
    if (data.len < 4) return XmError.UnexpectedEof;
    const header_size: u32 = readLeU32(data, 0);

    // After this point, all reads are relative to the start of the instrument data.
    var offset: usize = 4;

    if (data.len < header_size) return XmError.UnexpectedEof;

    var name: [22]u8 = undefined;
    @memcpy(&name, data[offset .. offset + 22]);
    offset += 22;

    const instrument_type: u8 = data[offset]; // should be 0
    _ = instrument_type;
    offset += 1;

    const sample_count: u16 = readLeU16(data, offset);
    offset += 2;

    var sample_header_size: u32 = 0;
    var sample_map: [96]u8 = [_]u8{0} ** 96;
    var volume_env: XmEnvelope = undefined;
    var panning_env: XmEnvelope = undefined;
    var vibrato_type: u8 = 0;
    var vibrato_sweep: u8 = 0;
    var vibrato_depth: u8 = 0;
    var vibrato_rate: u8 = 0;
    var fadeout: u16 = 0;

    if (sample_count > 0) {
        if (data.len < offset + 4) return XmError.UnexpectedEof;
        sample_header_size = readLeU32(data, offset);
        offset += 4;

        if (data.len < offset + 96) return XmError.UnexpectedEof;
        @memcpy(&sample_map, data[offset .. offset + 96]);
        offset += 96;

        // Volume envelope points (12 x (x,y))
        for (0..12) |i| {
            if (offset + 4 > data.len) return XmError.UnexpectedEof;
            const x_val: u16 = readLeU16(data, offset);
            offset += 2;
            const y_val: u8 = @as(u8, @intCast(readLeU16(data, offset) & 0xFF));
            offset += 2;
            volume_env.points[i] = XmEnvelopePoint{ .x = x_val, .y = y_val };
        }
        // Panning envelope points
        for (0..12) |i| {
            if (offset + 4 > data.len) return XmError.UnexpectedEof;
            const x_val: u16 = readLeU16(data, offset);
            offset += 2;
            const y_val: u8 = @as(u8, @intCast(readLeU16(data, offset) & 0xFF));
            offset += 2;
            panning_env.points[i] = XmEnvelopePoint{ .x = x_val, .y = y_val };
        }

        if (offset + 12 > data.len) return XmError.UnexpectedEof;
        volume_env.point_count = data[offset];
        offset += 1;
        panning_env.point_count = data[offset];
        offset += 1;

        volume_env.sustain_start = data[offset];
        volume_env.sustain_end = volume_env.sustain_start;
        offset += 1;
        volume_env.loop_start = data[offset];
        offset += 1;
        volume_env.loop_end = data[offset];
        offset += 1;

        panning_env.sustain_start = data[offset];
        panning_env.sustain_end = panning_env.sustain_start;
        offset += 1;
        panning_env.loop_start = data[offset];
        offset += 1;
        panning_env.loop_end = data[offset];
        offset += 1;

        const volbits: u8 = data[offset];
        offset += 1;
        const panbits: u8 = data[offset];
        offset += 1;

        var env_flags: u8 = 0;
        if ((volbits & 1) != 0) env_flags |= 1 | 8; // enable volume envelope + on flag
        if ((panbits & 1) != 0) env_flags |= 2; // enable panning envelope
        volume_env.flags = env_flags;
        panning_env.flags = env_flags; // simplified: same flags

        vibrato_type = data[offset];
        vibrato_sweep = data[offset + 1];
        vibrato_depth = data[offset + 2];
        vibrato_rate = data[offset + 3];
        offset += 4;

        fadeout = readLeU16(data, offset) / 32; // apply scalar like C (>>5)
        offset += 2;

        // Skip reserved word
        offset += 2;
    } else {
        // No samples, still need default envs
        volume_env = XmEnvelope{
            .points = [_]XmEnvelopePoint{.{ .x = 0, .y = 0 }} ** 12,
            .point_count = 0,
            .sustain_start = 255,
            .sustain_end = 255,
            .loop_start = 255,
            .loop_end = 255,
            .flags = 0,
        };
        panning_env = volume_env;
    }

    // After instrument header, we are at the start of the sample headers.
    // The C code seeks to `inst_headstart + inst_size`, which is where we are now.
    offset = @as(usize, header_size);

    // --------------------------------------------------
    // Parse sample headers and PCM data
    var samples: []XmSample = &[_]XmSample{};
    if (sample_count > 0) {
        samples = try alloc.alloc(XmSample, sample_count);
        errdefer alloc.free(samples); // Ensure cleanup on error

        if (data.len < offset + @as(usize, sample_count) * @as(usize, sample_header_size))
            return XmError.UnexpectedEof;

        // First pass: read headers only
        var i: usize = 0;
        while (i < sample_count) : (i += 1) {
            var pos: usize = offset + i * @as(usize, sample_header_size);
            const len_bytes: u32 = readLeU32(data, pos);
            pos += 4;
            const loop_start: u32 = readLeU32(data, pos);
            pos += 4;
            const loop_len: u32 = readLeU32(data, pos);
            pos += 4;
            const vol: u8 = data[pos];
            pos += 1;
            const ft: i8 = @as(i8, @bitCast(data[pos]));
            pos += 1;
            const typef: u8 = data[pos];
            pos += 1;
            const pan: u8 = data[pos];
            pos += 1;
            const rel: i8 = @as(i8, @bitCast(data[pos]));
            pos += 1;
            pos += 1; // reserved byte
            var sname: [22]u8 = undefined;
            @memcpy(&sname, data[pos .. pos + 22]);
            // Build sample struct with empty PCM slices (filled later)
            samples[i] = XmSample{
                .length_bytes = len_bytes,
                .length_frames = 0,
                .loop_start = loop_start,
                .loop_length = loop_len,
                .volume = vol,
                .finetune = ft,
                .type_flags = typef,
                .panning = pan,
                .rel_note = rel,
                .name = sname,
                .pcm8 = &[_]u8{},
                .pcm16 = &[_]u16{},
            };
        }
        // Move offset past all headers
        offset += @as(usize, sample_count) * @as(usize, sample_header_size);

        // Second pass: decode PCM data sequentially
        for (samples) |*samp| {
            if (samp.length_bytes == 0) continue;
            const is16: bool = (samp.type_flags & 0x10) != 0;
            if (is16) {
                const frame_count: usize = @as(usize, samp.length_bytes) / 2;
                if (data.len < offset + @as(usize, samp.length_bytes)) {
                    // Manually free allocated sample data before returning error
                    for (samples) |s| {
                        if (s.pcm16.len > 0) alloc.free(s.pcm16);
                        if (s.pcm8.len > 0) alloc.free(s.pcm8);
                    }
                    return XmError.UnexpectedEof;
                }
                var frames = try alloc.alloc(u16, frame_count);
                errdefer alloc.free(frames);
                var sample_old: i32 = 0;
                var j: usize = 0;
                while (j < frame_count) : (j += 1) {
                    const lo: u8 = data[offset];
                    const hi: u8 = data[offset + 1];
                    offset += 2;
                    const delta: i16 = @bitCast(@as(i16, @intCast(@as(u16, lo) | (@as(u16, hi) << 8))));
                    sample_old = sample_old + delta;
                    frames[j] = @as(u16, @intCast((sample_old + 32768) & 0xFFFF));
                }
                samp.pcm16 = frames;
                samp.pcm8 = &[_]u8{};
                samp.length_frames = @as(u32, @intCast(frame_count));
                // Adjust loop parameters
                samp.loop_start /= 2;
                samp.loop_length /= 2;
            } else {
                const frame_count8: usize = @as(usize, samp.length_bytes);
                if (data.len < offset + frame_count8) {
                    for (samples) |s| {
                        if (s.pcm16.len > 0) alloc.free(s.pcm16);
                        if (s.pcm8.len > 0) alloc.free(s.pcm8);
                    }
                    return XmError.UnexpectedEof;
                }
                var frames = try alloc.alloc(u8, frame_count8);
                errdefer alloc.free(frames);
                var sample_old: i32 = 0;
                var j: usize = 0;
                while (j < frame_count8) : (j += 1) {
                    const delta: i8 = @as(i8, @bitCast(data[offset]));
                    offset += 1;
                    sample_old = sample_old + delta;
                    frames[j] = @as(u8, @intCast((sample_old + 128) & 0xFF));
                }
                samp.pcm8 = frames;
                samp.pcm16 = &[_]u16{};
                samp.length_frames = samp.length_bytes;
            }
        }
    }

    // bytes_read must be the final offset relative to the start of the input slice,
    // which now correctly includes inst header, sample headers, and sample data.
    return .{
        .instrument = XmInstrument{
            .name = name,
            .sample_count = sample_count,
            .sample_map = sample_map,
            .volume_env = volume_env,
            .panning_env = panning_env,
            .vibrato_type = vibrato_type,
            .vibrato_sweep = vibrato_sweep,
            .vibrato_depth = vibrato_depth,
            .vibrato_rate = vibrato_rate,
            .fadeout = fadeout,
            .samples = samples,
        },
        .bytes_read = offset,
    };
}

/// Represents a fully decoded sample (metadata + PCM frames)
pub const XmSample = struct {
    length_bytes: u32,
    length_frames: u32 = 0, // filled after decode
    loop_start: u32,
    loop_length: u32,
    volume: u8,
    finetune: i8,
    type_flags: u8,
    panning: u8,
    rel_note: i8,
    name: [22]u8,
    pcm8: []u8,
    pcm16: []u16,
};

// ============================================================
// Stream A Task 5: XM ➜ MAS Converter (MAS module writer)
// ============================================================

/// Convert XM data to MAS module structure
pub fn convertXmToMas(alloc: std.mem.Allocator, xm_data: []const u8) !masw.MAS_Module {
    // Parse XM header
    if (xm_data.len < 64 or !std.mem.startsWith(u8, xm_data, "Extended Module:"))
        return XmError.InvalidXmFile;

    _ = readLeU32(xm_data, 60); // header_size - not used
    const song_header_start: usize = 64;

    if (xm_data.len < song_header_start + 20) return XmError.UnexpectedEof;

    // XM Song Header layout (relative to song_header_start):
    // +0: song length (order count)
    // +2: restart position
    // +4: channel count
    // +6: pattern count
    // +8: instrument count
    // +10: flags
    // +12: default tempo (ticks/row)
    // +14: default BPM
    const order_count: u16 = readLeU16(xm_data, song_header_start + 0);
    const restart_pos: u16 = readLeU16(xm_data, song_header_start + 2);
    _ = readLeU16(xm_data, song_header_start + 4); // channel_count - not used here
    const pattern_count: u16 = readLeU16(xm_data, song_header_start + 6);
    const instrument_count: u16 = readLeU16(xm_data, song_header_start + 8);
    const xm_flags: u16 = readLeU16(xm_data, song_header_start + 10);
    const initial_speed: u16 = readLeU16(xm_data, song_header_start + 12);
    const initial_tempo: u16 = readLeU16(xm_data, song_header_start + 14);
    const freq_mode: u16 = xm_flags; // bit0: 1 = linear freq table

    // Extract title
    var title: [20]u8 = undefined;
    @memcpy(&title, xm_data[17 .. 17 + 20]);

    // Read order table
    var orders: [256]u8 = [_]u8{255} ** 256;
    var offset: usize = song_header_start + 16;
    const read_count: usize = @min(@as(usize, order_count), 200);
    if (xm_data.len < offset + read_count) return XmError.UnexpectedEof;
    @memcpy(orders[0..read_count], xm_data[offset .. offset + read_count]);
    // Fill remaining up to 200 with 255 (already set by init)
    // Skip rest of order table bytes (200..255)
    // We will reposition using header_size below, so no need to adjust offset further here.

    // Trim at first 0xFF (255) to match C behavior
    var effective_order_count: u16 = 0;
    while (effective_order_count < 200 and orders[effective_order_count] != 255) : (effective_order_count += 1) {}
    if (effective_order_count == 0) effective_order_count = order_count;

    // Parse patterns to get to instruments
    // Patterns come before instruments in XM file structure
    // The C code seeks to 60 + header_size, which should be where patterns start
    const header_size = readLeU32(xm_data, 60);
    offset = 60 + @as(usize, header_size);
    if (xm_data.len < offset) return XmError.UnexpectedEof;

    // Parse all patterns and store them
    var patterns_dyn = std.ArrayList(masw.Pattern).init(alloc);
    defer patterns_dyn.deinit();

    var i: u16 = 0;
    while (i < pattern_count) : (i += 1) {
        if (xm_data.len < offset + 9) return XmError.UnexpectedEof;
        const headstart: usize = offset;
        const headsize: u32 = readLeU32(xm_data, offset);
        offset = headstart + @as(usize, headsize);
        if (xm_data.len < offset) return XmError.UnexpectedEof;
        const packed_size: u16 = readLeU16(xm_data, headstart + 7);

        // Read pattern rows from header
        const rows: u16 = readLeU16(xm_data, headstart + 5);

        // Parse the actual pattern data
        // The pattern data starts after the 9-byte header (4 bytes header length + 1 byte packing + 2 bytes rows + 2 bytes packed size)
        const pattern_data_start = headstart + 9;
        const pattern_data = xm_data[pattern_data_start .. pattern_data_start + @as(usize, packed_size)];

        // Debug: print pattern info
        std.debug.print("Pattern {}: rows={}, packed_size={}, data_start={}, data_len={}\n", .{ i, rows, packed_size, pattern_data_start, pattern_data.len });

        // Parse the pattern data into events
        const total_events = @as(usize, rows) * 32; // XM supports up to 32 channels
        var events = try alloc.alloc(XmEvent, total_events);
        // Initialize with defaults
        for (events) |*ev| ev.* = XmEvent{};

        // Parse the actual XM pattern data
        if (packed_size > 0) {
            try parseXmPatternData(pattern_data, events, rows, 32);
        }

        // Ensure events is recognized as mutated
        if (events.len > 0) {
            events[0] = events[0];
        }

        const mas_pattern_data = try convertXmEventsToMasPatternData(alloc, events);

        // Free events array now that pattern data is built
        alloc.free(events);

        const mas_pattern = masw.Pattern{
            .nrows = rows,
            .data = mas_pattern_data,
        };
        patterns_dyn.append(mas_pattern) catch {
            // free allocated pattern data on failure
            alloc.free(mas_pattern_data);
            return XmError.UnexpectedEof;
        };

        offset += @as(usize, packed_size);
        if (xm_data.len < offset) return XmError.UnexpectedEof;
    }

    // Debug: print what we're parsing
    std.debug.print("Parsing XM: patterns={}, instruments={}, offset after patterns={}\n", .{ pattern_count, instrument_count, offset });

    // Parse instruments and samples
    var samples_dyn = std.ArrayList(masw.Sample).init(alloc);
    defer samples_dyn.deinit();
    var instruments_dyn = std.ArrayList(masw.Instrument).init(alloc);
    defer instruments_dyn.deinit();

    var inst_idx: u16 = 0;
    while (inst_idx < instrument_count) : (inst_idx += 1) {
        std.debug.print("Parsing instrument {} at offset {}\n", .{ inst_idx, offset });
        const result = try parseXmInstrument(alloc, xm_data[offset..]);
        errdefer {
            for (result.instrument.samples) |s| {
                if (s.pcm8.len > 0) alloc.free(s.pcm8);
                if (s.pcm16.len > 0) alloc.free(s.pcm16);
            }
            alloc.free(result.instrument.samples);
        }
        offset += result.bytes_read;

        // Convert XM instrument to MAS instrument
        var mas_name: [32]u8 = [_]u8{0} ** 32;
        @memcpy(mas_name[0..22], &result.instrument.name);

        const mas_inst = masw.Instrument{
            .global_volume = 128,
            .setpan = 128,
            .fadeout = result.instrument.fadeout,
            .random_volume = 0,
            .nna = 0,
            .dct = 0,
            .dca = 0,
            .env_flags = result.instrument.volume_env.flags,
            .notemap = [_]u16{0} ** 120, // Simplified for now
            .name = mas_name,
            .sample_map = result.instrument.sample_map,
            .sample_count = @as(u16, @intCast(result.instrument.samples.len)),
            .volume_env = if (result.instrument.volume_env.flags & 1 != 0) convertXmEnvelope(result.instrument.volume_env) else null,
            .panning_env = if (result.instrument.panning_env.flags & 1 != 0) convertXmEnvelope(result.instrument.panning_env) else null,
            .vibrato_type = result.instrument.vibrato_type,
            .vibrato_sweep = result.instrument.vibrato_sweep,
            .vibrato_depth = result.instrument.vibrato_depth,
            .vibrato_rate = result.instrument.vibrato_rate,
            .samples = &[_]masw.Sample{}, // Samples are handled separately
        };

        // Convert XM samples to MAS samples
        for (result.instrument.samples) |xm_samp| {
            var mas_sample_name: [32]u8 = [_]u8{0} ** 32;
            @memcpy(mas_sample_name[0..22], &xm_samp.name);

            // Ensure 8-bit PCM for GBA path to match C writer expectations
            var data8: []u8 = xm_samp.pcm8;
            var data16: []u16 = xm_samp.pcm16;
            var length_bytes: u32 = xm_samp.length_bytes;
            // Preserve loop-type bits (0..2) from XM; 16-bit bit handled below
            var flags: u8 = @as(u8, xm_samp.type_flags & 0x03);
            if (data16.len > 0) {
                // Convert 16-bit unsigned to 8-bit by taking the high byte
                const frames: usize = data16.len;
                var conv = try alloc.alloc(u8, frames);
                for (data16, 0..) |v, idx| {
                    conv[idx] = @as(u8, @intCast(v >> 8));
                }
                data8 = conv;
                data16 = &[_]u16{};
                length_bytes = @as(u32, @intCast(frames));
                // Now 8-bit; keep loop-type bits only
                flags &= 0x03;
            }

            const mas_samp = masw.Sample{
                .global_volume = xm_samp.volume,
                .default_volume = xm_samp.volume,
                .default_panning = xm_samp.panning,
                .length_bytes = length_bytes,
                .loop_start = xm_samp.loop_start,
                .loop_length = xm_samp.loop_length,
                .flags = flags,
                .finetune = xm_samp.finetune,
                .rel_note = xm_samp.rel_note,
                .vibtype = result.instrument.vibrato_type,
                .vibdepth = result.instrument.vibrato_depth,
                .vibspeed = result.instrument.vibrato_rate,
                .vibrate = result.instrument.vibrato_sweep,
                .name = mas_sample_name,
                .data_8 = data8,
                .data_16 = data16,
            };
            try samples_dyn.append(mas_samp);
        }

        try instruments_dyn.append(mas_inst);
        // After appending, we've transferred ownership of the sample data.
        // We must free the container slice, but not the PCM data within.
        alloc.free(result.instrument.samples);
    }

    // Use the parsed patterns
    const patterns = try patterns_dyn.toOwnedSlice();
    const instruments = try instruments_dyn.toOwnedSlice();
    const samples = try samples_dyn.toOwnedSlice();
    defer {
        for (samples) |s| {
            if (s.data_8.len > 0) alloc.free(s.data_8);
            if (s.data_16.len > 0) alloc.free(s.data_16);
        }
        alloc.free(samples);
    }

    // Filter instruments that have zero samples (original mmutil skips these)
    var filtered_insts = instruments;
    if (instruments.len > 0) {
        var temp = std.ArrayList(masw.Instrument).init(alloc);
        for (instruments) |inst| {
            // --- CHANGED: keep all instruments ---
            try temp.append(inst);
        }
        const owned = try temp.toOwnedSlice();
        // Free the original instruments slice if replaced
        if (owned.ptr != instruments.ptr) {
            if (instruments.len > 0) alloc.free(instruments);
        }
        filtered_insts = owned;
    }

    // Create a MAS_Module compatible with mas_writer
    var mas_module = masw.MAS_Module{
        .title = blk: {
            var t: [32]u8 = [_]u8{0} ** 32;
            @memcpy(t[0..20], title[0..20]);
            break :blk t;
        },
        .channel_count = 32, // Max channels
        .patterns = patterns,
        .instruments = filtered_insts,
        .samples = samples,
        .orders = orders,
        .order_count = effective_order_count,
        .inst_count = @as(u8, @intCast(filtered_insts.len)),
        .samp_count = @as(u8, @intCast(samples.len)),
        .patt_count = @as(u8, @intCast(pattern_count)),
        .flags = 0, // Will be calculated based on booleans
        .global_volume = 64,
        .initial_speed = @as(u8, @intCast(initial_speed & 0xFF)),
        .initial_tempo = @as(u8, @intCast(initial_tempo & 0xFF)),
        .restart_pos = @as(u8, @intCast(restart_pos)),
        .channel_volume = [_]u8{64} ** 32,
        .channel_panning = [_]u8{128} ** 32,
    };

    // Set flags
    if (false) mas_module.flags |= 1; // link_gxx
    if (true) mas_module.flags |= 2; // old_effects
    if ((freq_mode & 1) != 0) mas_module.flags |= 4;
    if (true) mas_module.flags |= 8; // xm_mode
    if (false) mas_module.flags |= 32; // old_mode

    // TODO: Convert and assign instruments, samples, and patterns
    // For now, we return a module with header info populated.

    return mas_module;
}

fn convertXmEnvelope(xm_env: XmEnvelope) masw.Envelope {
    var mas_env: masw.Envelope = undefined;
    mas_env.node_count = xm_env.point_count;
    mas_env.sustain_start = xm_env.sustain_start;
    mas_env.sustain_end = xm_env.sustain_end;
    mas_env.loop_start = xm_env.loop_start;
    mas_env.loop_end = xm_env.loop_end;
    mas_env.flags = xm_env.flags;

    for (xm_env.points, 0..) |pt, i| {
        mas_env.nodes[i] = .{ .x = pt.x, .y = pt.y };
    }
    return mas_env;
}

/// Parse XM pattern data into events (without header parsing)
fn parseXmPatternData(data: []const u8, events: []XmEvent, rows: u16, channel_count: u16) !void {
    var idx: usize = 0;
    var row: u16 = 0;

    std.debug.print("parseXmPatternData: data.len={}, rows={}, channels={}\n", .{ data.len, rows, channel_count });

    // Initialize all events with defaults (like C code does)
    for (events) |*ev| {
        ev.note = 250; // Default note value
        ev.volume = 0; // Default volume
    }

    while (row < rows and idx < data.len) : (row += 1) {
        var ch: u16 = 0;
        while (ch < channel_count and idx < data.len) : (ch += 1) {
            const b: u8 = data[idx];
            idx += 1;

            var note: u8 = 250; // Default
            var instrument: u8 = 0;
            var volume: u8 = 0;
            var effect: u8 = 0;
            var param: u8 = 0;

            if ((b & 0x80) != 0) {
                // Packed entry (like C code)
                if ((b & 0x01) != 0) {
                    if (idx >= data.len) return XmError.UnexpectedEof;
                    note = data[idx];
                    idx += 1;
                }
                if ((b & 0x02) != 0) {
                    if (idx >= data.len) return XmError.UnexpectedEof;
                    instrument = data[idx];
                    idx += 1;
                }
                if ((b & 0x04) != 0) {
                    if (idx >= data.len) return XmError.UnexpectedEof;
                    volume = data[idx];
                    idx += 1;
                }
                if ((b & 0x08) != 0) {
                    if (idx >= data.len) return XmError.UnexpectedEof;
                    effect = data[idx];
                    idx += 1;
                }
                if ((b & 0x10) != 0) {
                    if (idx >= data.len) return XmError.UnexpectedEof;
                    param = data[idx];
                    idx += 1;
                }
            } else {
                // Unpacked entry: first byte was the note, the next 4 follow
                note = b;
                if (idx + 4 > data.len) return XmError.UnexpectedEof;
                instrument = data[idx];
                volume = data[idx + 1];
                effect = data[idx + 2];
                param = data[idx + 3];
                idx += 4;
            }

            // Translate note value as done in original C:
            if (note == 97) {
                note = 255; // key-off
            } else if (note >= 1 and note <= 96) {
                note = note + 11; // +12-1 to convert C-0 index
            }

            const event_index: usize = @as(usize, row) * @as(usize, channel_count) + @as(usize, ch);
            if (event_index < events.len) {
                events[event_index] = XmEvent{
                    .note = note,
                    .instrument = instrument,
                    .volume = volume,
                    .effect = effect,
                    .param = param,
                };
            }
        }
    }
}

fn convertXmEventsToMasPatternData(alloc: std.mem.Allocator, events: []const XmEvent) ![]u8 {
    // Each event becomes 5 bytes: note, inst, vol, fx, param
    var data = try alloc.alloc(u8, events.len * 5);
    errdefer alloc.free(data);

    for (events, 0..) |event, i| {
        const base = i * 5;
        var note: u8 = event.note;
        if (note == 0) {
            note = 250;
        } else if (note == 97) {
            note = 255;
        } else if (note != 0) {
            const tmp: u16 = @as(u16, note) + 11; // 12-1
            note = @as(u8, @truncate(tmp));
        }
        data[base + 0] = note;
        data[base + 1] = event.instrument;
        data[base + 2] = event.volume;
        var fx = event.effect;
        var pm = event.param;
        convertXmEffect(&fx, &pm);
        data[base + 3] = fx;
        data[base + 4] = pm;
    }
    return data;
}

fn convertXmEffect(fx_ptr: *u8, param_ptr: *u8) void {
    const cho: u8 = 64;
    var wfx: u8 = fx_ptr.*;
    var wpm: u8 = param_ptr.*;
    switch (wfx) {
        0 => {
            if (wpm != 0) wfx = ('J') - cho else {
                wfx = 0;
                wpm = 0;
            }
        },
        1 => {
            wfx = ('F') - cho;
            if (wpm >= 0xE0) wpm = 0xDF;
        },
        2 => {
            wfx = ('E') - cho;
            if (wpm >= 0xE0) wpm = 0xDF;
        },
        3 => {
            wfx = ('G') - cho;
        },
        4 => {
            wfx = ('H') - cho;
        },
        5 => {
            wfx = ('L') - cho;
        },
        6 => {
            wfx = ('K') - cho;
        },
        7 => {
            wfx = ('R') - cho;
        },
        8 => {
            wfx = ('X') - cho;
        },
        9 => {
            wfx = ('O') - cho;
        },
        0xA => {
            wfx = ('D') - cho;
        },
        0xB => {
            wfx = ('B') - cho;
        },
        0xC => {
            wfx = 27;
        },
        0xD => {
            wfx = ('C') - cho;
            const tens: u8 = (wpm >> 4) * 10;
            const ones: u8 = (wpm & 0xF);
            wpm = tens + ones;
        },
        0xE => {
            const sub: u8 = wpm >> 4;
            switch (sub) {
                1 => {
                    wfx = ('F') - cho;
                    wpm = 0xF0 | (wpm & 0xF);
                },
                2 => {
                    wfx = ('E') - cho;
                    wpm = 0xF0 | (wpm & 0xF);
                },
                3, 5 => {
                    wfx = 0;
                    wpm = 0;
                },
                4 => {
                    wfx = ('S') - cho;
                    wpm = 0x30 | (wpm & 0xF);
                },
                6 => {
                    wfx = ('S') - cho;
                    wpm = 0xB0 | (wpm & 0xF);
                },
                7 => {
                    wfx = ('S') - cho;
                    wpm = 0x40 | (wpm & 0xF);
                },
                8 => {
                    wfx = ('X') - cho;
                    wpm = (@as(u8, wpm & 0xF)) * 16;
                },
                9 => {
                    wfx = ('S') - cho;
                    wpm = 0x20 | (wpm & 0xF);
                },
                10 => {
                    wfx = ('S') - cho;
                    wpm = 0x00 | (wpm & 0xF);
                },
                11 => {
                    wfx = ('S') - cho;
                    wpm = 0x10 | (wpm & 0xF);
                },
                12 => {
                    wfx = ('S') - cho;
                    wpm = 0xC0 | (wpm & 0xF);
                },
                13 => {
                    wfx = ('S') - cho;
                    wpm = 0xD0 | (wpm & 0xF);
                },
                14 => {
                    wfx = ('S') - cho;
                    wpm = 0xE0 | (wpm & 0xF);
                },
                15 => {
                    wfx = ('S') - cho;
                },
                else => {
                    wfx = 0;
                    wpm = 0;
                },
            }
        },
        0xF => {
            if (wpm >= 32) wfx = ('T') - cho else wfx = ('A') - cho;
        },
        16 => {
            wfx = ('V') - cho;
        },
        17 => {
            wfx = ('W') - cho;
        },
        20 => {
            wfx = 28;
        },
        21 => {
            wfx = 29;
        },
        25 => {
            wfx = ('P') - cho;
        },
        27 => {
            wfx = ('Q') - cho;
        },
        29 => {
            wfx = 30;
        },
        33 => {
            const sub: u8 = wpm >> 4;
            if (sub == 1) {
                wfx = ('F') - cho;
                wpm = 0xE0 | (wpm & 0xF);
            } else if (sub == 2) {
                wfx = ('E') - cho;
                wpm = 0xE0 | (wpm & 0xF);
            } else {
                wfx = 0;
                wpm = 0;
            }
        },
        18, 19, 22, 23, 24, 26, 28, 30, 31, 32, 34, 35 => {
            wfx = 0;
            wpm = 0;
        },
        else => {},
    }
    fx_ptr.* = wfx;
    param_ptr.* = wpm;
}

/// Calculate XM middle-C frequency like original mmutil Get_XM_Frequency()
fn getXmFrequency(rel_note: i8, finetune: i8) u16 {
    const rn = @as(f64, @floatFromInt(rel_note));
    const ft = @as(f64, @floatFromInt(finetune));
    const freq = 8363.0 * std.math.pow(f64, 2.0, (1.0 / 12.0) * rn + (1.0 / (12.0 * 128.0)) * ft);
    return @as(u16, @intFromFloat(freq));
}

/// Free all heap allocations held inside a MAS_Module produced by convertXmToMas
pub fn freeMasModule(alloc: std.mem.Allocator, mod: *const masw.MAS_Module) void {
    // Free pattern data buffers
    for (mod.patterns) |p| {
        if (p.data.len > 0) alloc.free(p.data);
    }
    if (mod.patterns.len > 0) alloc.free(mod.patterns);

    // Free sample PCM data
    for (mod.samples) |s| {
        if (s.data_8.len > 0) alloc.free(s.data_8);
        if (s.data_16.len > 0) alloc.free(s.data_16);
    }
    if (mod.samples.len > 0) alloc.free(mod.samples);

    // Free instrument slices (envelopes are value types)
    if (mod.instruments.len > 0) alloc.free(mod.instruments);
}
