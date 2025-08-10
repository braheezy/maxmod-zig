const std = @import("std");

pub const PcmDepth = enum { pcm8, pcm16 };

pub const WavInfo = struct {
    sample_rate_hz: u32,
    bits_per_sample: PcmDepth,
    num_channels: u16,
    total_frames: u32,

    // mono frames in native depth, owned by allocator
    mono_frames_8: []u8 = &[_]u8{},
    mono_frames_16: []i16 = &[_]i16{},
};

fn readExact(reader: anytype, buf: []u8) !void {
    var remaining = buf;
    while (remaining.len > 0) {
        const n = try reader.read(remaining);
        if (n == 0) return error.UnexpectedEof;
        remaining = remaining[n..];
    }
}

fn readLe32(reader: anytype) !u32 {
    var tmp: [4]u8 = undefined;
    try readExact(reader, &tmp);
    return std.mem.readInt(u32, &tmp, .little);
}
fn readLe16(reader: anytype) !u16 {
    var tmp: [2]u8 = undefined;
    try readExact(reader, &tmp);
    return std.mem.readInt(u16, &tmp, .little);
}

pub fn loadToMono(alloc: std.mem.Allocator, path: []const u8) !WavInfo {
    var file = try std.fs.cwd().openFile(path, .{});
    defer file.close();
    var reader = file.reader();

    var riff: [4]u8 = undefined;
    try readExact(reader, &riff);
    if (!std.mem.eql(u8, &riff, "RIFF")) return error.InvalidWav;
    _ = try readLe32(reader); // total size
    var wave: [4]u8 = undefined;
    try readExact(reader, &wave);
    if (!std.mem.eql(u8, &wave, "WAVE")) return error.InvalidWav;

    var audio_format: u16 = 0;
    var num_channels: u16 = 0;
    var sample_rate: u32 = 0;
    var bits_per_sample: u16 = 0;

    var data_size_bytes: u32 = 0;
    var data_offset: u64 = 0;

    // Iterate chunks
    while (true) {
        var ckid: [4]u8 = undefined;
        const got = reader.read(&ckid) catch |e| return e;
        if (got == 0) break;
        if (got != 4) return error.UnexpectedEof;
        const cksize = try readLe32(reader);
        if (std.mem.eql(u8, &ckid, "fmt ")) {
            audio_format = try readLe16(reader);
            num_channels = try readLe16(reader);
            sample_rate = try readLe32(reader);
            _ = try readLe32(reader); // byte rate
            _ = try readLe16(reader); // block align
            bits_per_sample = try readLe16(reader);
            if (cksize > 16) {
                // skip any extra fmt bytes
                try file.seekBy(@as(i64, @intCast(cksize - 16)));
            }
        } else if (std.mem.eql(u8, &ckid, "data")) {
            data_size_bytes = cksize;
            data_offset = try file.getPos();
            try file.seekBy(@as(i64, @intCast(cksize))); // skip for now
        } else {
            // skip unknown chunk
            try file.seekBy(@as(i64, @intCast(cksize)));
        }
        // chunks are word-aligned
        if ((cksize & 1) != 0) try file.seekBy(1);
    }

    if (audio_format != 1) return error.UnsupportedFormat; // PCM only
    if (num_channels == 0) return error.InvalidWav;
    if (!(bits_per_sample == 8 or bits_per_sample == 16)) return error.UnsupportedDepth;
    if (data_size_bytes == 0) return error.InvalidWav;

    // Read samples
    try file.seekTo(data_offset);
    const total_samples: u32 = switch (bits_per_sample) {
        8 => @as(u32, @intCast(data_size_bytes)),
        16 => @as(u32, @intCast(data_size_bytes / 2)),
        else => unreachable,
    } / @as(u32, @intCast(num_channels));

    var info = WavInfo{
        .sample_rate_hz = sample_rate,
        .bits_per_sample = if (bits_per_sample == 8) .pcm8 else .pcm16,
        .num_channels = num_channels,
        .total_frames = total_samples,
    };

    if (info.bits_per_sample == .pcm8) {
        // read as bytes
        const total_frames = info.total_frames;
        const tmp = try alloc.alloc(u8, total_frames * @as(usize, @intCast(num_channels)));
        defer alloc.free(tmp);
        _ = try file.readAll(tmp);
        const mono = try alloc.alloc(u8, total_frames);
        // downmix average
        if (num_channels == 1) {
            @memcpy(mono, tmp);
        } else {
            var i: usize = 0;
            var o: usize = 0;
            while (i < tmp.len) : (o += 1) {
                var acc: u32 = 0;
                var c: usize = 0;
                while (c < num_channels) : (c += 1) {
                    acc += tmp[i + c];
                }
                mono[o] = @as(u8, @intCast(acc / num_channels));
                i += num_channels;
            }
        }
        info.mono_frames_8 = mono;
    } else {
        // read as i16 little endian (PCM 16-bit is signed)
        const total_frames = info.total_frames;
        const tmp = try alloc.alloc(i16, total_frames * @as(usize, @intCast(num_channels)));
        defer alloc.free(tmp);
        const tmp_bytes = std.mem.sliceAsBytes(tmp);
        _ = try file.readAll(tmp_bytes);
        // convert bytes to u16 LE
        var idx: usize = 0;
        while (idx < tmp.len) : (idx += 1) {
            tmp[idx] = std.mem.littleToNative(i16, tmp[idx]);
        }
        const mono = try alloc.alloc(i16, total_frames);
        if (num_channels == 1) {
            @memcpy(mono, tmp);
        } else {
            var i: usize = 0;
            var o: usize = 0;
            while (i < tmp.len) : (o += 1) {
                var acc: i32 = 0;
                var c: usize = 0;
                while (c < num_channels) : (c += 1) {
                    acc += tmp[i + c];
                }
                mono[o] = @as(i16, @intCast(@divTrunc(acc, @as(i32, @intCast(num_channels)))));
                i += num_channels;
            }
        }
        info.mono_frames_16 = mono;
    }

    return info;
}
