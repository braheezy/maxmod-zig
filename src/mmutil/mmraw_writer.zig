const std = @import("std");

pub const Flags = struct {
    pub const looped: u16 = 1 << 0;
};

fn writeU16LE(w: anytype, v: u16) !void {
    var b: [2]u8 = .{ @as(u8, @intCast(v & 0x00FF)), @as(u8, @intCast((v >> 8) & 0x00FF)) };
    _ = try w.write(&b);
}

fn writeU32LE(w: anytype, v: u32) !void {
    var b: [4]u8 = .{
        @as(u8, @intCast(v & 0x000000FF)),
        @as(u8, @intCast((v >> 8) & 0x000000FF)),
        @as(u8, @intCast((v >> 16) & 0x000000FF)),
        @as(u8, @intCast((v >> 24) & 0x000000FF)),
    };
    _ = try w.write(&b);
}

pub fn writeMmrawU8(out_path: []const u8, sample_rate: u32, looped: bool, frames: []const u8) !void {
    var file = try std.fs.cwd().createFile(out_path, .{ .truncate = true });
    defer file.close();
    var w = file.writer();

    try writeU32LE(w, 0x5741524D);
    try writeU16LE(w, 1);
    try writeU16LE(w, if (looped) Flags.looped else 0);
    try writeU32LE(w, sample_rate);
    try writeU32LE(w, @as(u32, @intCast(frames.len)));
    try w.writeByte(8);
    try w.writeByte(1);
    try writeU16LE(w, 0);

    _ = try w.write(frames);
}

pub fn writeMmrawU16(out_path: []const u8, sample_rate: u32, looped: bool, frames: []const u16) !void {
    var file = try std.fs.cwd().createFile(out_path, .{ .truncate = true });
    defer file.close();
    var w = file.writer();

    try writeU32LE(w, 0x5741524D);
    try writeU16LE(w, 1);
    try writeU16LE(w, if (looped) Flags.looped else 0);
    try writeU32LE(w, sample_rate);
    try writeU32LE(w, @as(u32, @intCast(frames.len)));
    try w.writeByte(16);
    try w.writeByte(1);
    try writeU16LE(w, 0);

    var i: usize = 0;
    while (i < frames.len) : (i += 1) {
        try writeU16LE(w, frames[i]);
    }
}
