const std = @import("std");
const wav = @import("wav_reader.zig");

pub fn linearResampleU8(alloc: std.mem.Allocator, in_frames: []const u8, in_rate: u32, out_rate: u32) ![]u8 {
    if (in_rate == out_rate) {
        const copy = try alloc.alloc(u8, in_frames.len);
        @memcpy(copy, in_frames);
        return copy;
    }
    const in_len = in_frames.len;
    if (in_len == 0) return alloc.alloc(u8, 0);
    const out_len = @as(usize, @intCast((@as(u64, in_len) * out_rate + (in_rate / 2)) / in_rate));
    var out = try alloc.alloc(u8, out_len);
    var pos: f64 = 0;
    const step: f64 = @as(f64, @floatFromInt(in_rate)) / @as(f64, @floatFromInt(out_rate));
    var i: usize = 0;
    while (i < out_len) : (i += 1) {
        const idx = @as(usize, @intFromFloat(@floor(pos)));
        const frac = pos - @floor(pos);
        const a = in_frames[@min(idx, in_len - 1)];
        const b = in_frames[@min(idx + 1, in_len - 1)];
        const y = @floor((@as(f64, @floatFromInt(a)) * (1.0 - frac)) + (@as(f64, @floatFromInt(b)) * frac) + 0.5);
        out[i] = @as(u8, @intFromFloat(y));
        pos += step;
    }
    return out;
}

pub fn linearResampleI16(alloc: std.mem.Allocator, in_frames: []const i16, in_rate: u32, out_rate: u32) ![]i16 {
    if (in_rate == out_rate) {
        const copy = try alloc.alloc(i16, in_frames.len);
        @memcpy(copy, in_frames);
        return copy;
    }
    const in_len = in_frames.len;
    if (in_len == 0) return alloc.alloc(i16, 0);
    const out_len = @as(usize, @intCast((@as(u64, in_len) * out_rate + (in_rate / 2)) / in_rate));
    var out = try alloc.alloc(i16, out_len);
    var pos: f64 = 0;
    const step: f64 = @as(f64, @floatFromInt(in_rate)) / @as(f64, @floatFromInt(out_rate));
    var i: usize = 0;
    while (i < out_len) : (i += 1) {
        const idx = @as(usize, @intFromFloat(@floor(pos)));
        const frac = pos - @floor(pos);
        const a = in_frames[@min(idx, in_len - 1)];
        const b = in_frames[@min(idx + 1, in_len - 1)];
        const y = @floor((@as(f64, @floatFromInt(a)) * (1.0 - frac)) + (@as(f64, @floatFromInt(b)) * frac) + 0.5);
        out[i] = @as(i16, @intFromFloat(y));
        pos += step;
    }
    return out;
}
