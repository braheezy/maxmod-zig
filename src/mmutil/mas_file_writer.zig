const std = @import("std");

/// Global state for the MAS file writer
var current_file: ?std.fs.File = null;
var current_writer: ?std.fs.File.Writer = null;
var mas_offset: u32 = 0;
var mas_filesize: u32 = 0;

/// Initialize the file writer for a new MAS file
pub fn initFileWriter(file_path: []const u8) !void {
    if (current_file) |f| f.close();
    current_file = try std.fs.cwd().createFile(file_path, .{});
    current_writer = current_file.?.writer();
    mas_offset = 0;
    mas_filesize = 0;
}

/// Close the current file writer
pub fn closeFileWriter() void {
    if (current_file) |f| {
        f.close();
        current_file = null;
        current_writer = null;
    }
}

/// Get the current write position
pub fn file_tell_write() i32 {
    if (current_file) |f| {
        return @as(i32, @intCast(f.getPos() catch 0));
    }
    return 0;
}

/// Seek to a specific position in the file
pub fn file_seek_write(offset: i32, whence: i32) i32 {
    if (current_file) |f| {
        const pos: u64 = switch (whence) {
            0 => @as(u64, @intCast(offset)), // SEEK_SET
            1 => (f.getPos() catch 0) +% @as(u64, @intCast(offset)), // SEEK_CUR
            2 => (f.getPos() catch 0) +% @as(u64, @intCast(offset)), // SEEK_END (approximate)
            else => return -1,
        };
        f.seekTo(pos) catch return -1;
        return 0;
    }
    return -1;
}

/// Write a single byte
pub fn write8(value: u8) void {
    if (current_writer) |w| {
        w.writeByte(value) catch {};
    }
}

/// Write a 16-bit value in little-endian
pub fn write16(value: u16) void {
    if (current_writer) |w| {
        w.writeIntLittle(u16, value) catch {};
    }
}

/// Write a 32-bit value in little-endian
pub fn write32(value: u32) void {
    if (current_writer) |w| {
        w.writeIntLittle(u32, value) catch {};
    }
}

/// Align the file to 32-bit boundary
pub fn align32() void {
    if (current_file) |f| {
        const pos = f.getPos() catch 0;
        const aligned_pos = (pos + 3) & ~@as(u64, 3);
        if (aligned_pos > pos) {
            const padding = aligned_pos - pos;
            if (current_writer) |w| {
                for (0..padding) |_| {
                    w.writeByte(0) catch {};
                }
            }
        }
    }
}

/// Get the current MAS offset
pub fn getMAS_OFFSET() u32 {
    return mas_offset;
}

/// Set the current MAS offset
pub fn setMAS_OFFSET(offset: u32) void {
    mas_offset = offset;
}

/// Get the current MAS filesize
pub fn getMAS_FILESIZE() u32 {
    return mas_filesize;
}

/// Set the current MAS filesize
pub fn setMAS_FILESIZE(size: u32) void {
    mas_filesize = size;
}

/// Get the current file writer
pub fn getCurrentWriter() ?std.fs.File.Writer {
    return current_writer;
}

/// Get the current file
pub fn getCurrentFile() ?std.fs.File {
    return current_file;
}
