const std = @import("std");

pub const XmError = error{ InvalidXm, UnexpectedEof };

/// Minimal representation of an XM module for early loading tasks.
/// Only header/order information is captured for now.
pub const Module = struct {
    name: [20]u8 = [_]u8{0} ** 20,
    channels: u16 = 0,
    order_count: u16 = 0,
    restart_pos: u16 = 0,
    pattern_count: u16 = 0,
    instrument_count: u16 = 0,
    default_tempo: u16 = 6, // ticks per row (Speed)
    default_bpm: u16 = 125,
    orders: []u8 = &[_]u8{},
};

/// Parse XM header and order table only.
/// Further parsing (patterns/instruments) will be added later.
pub fn parseHeader(alloc: std.mem.Allocator, data: []const u8) !Module {
    if (data.len < 60) return XmError.UnexpectedEof;
    if (!std.mem.startsWith(u8, data, "Extended Module:")) return XmError.InvalidXm;

    var mod: Module = .{};
    // Module name (20 bytes) at offset 17
    @memcpy(mod.name[0..], data[17 .. 17 + 20]);

    // Header starts at offset 60 (fixed)
    const header_offset: usize = 60;
    const header_size: u32 = readLeU32(data, header_offset - 4); // stored just before header
    if (data.len < header_offset + @as(usize, header_size)) return XmError.UnexpectedEof;

    const song_length: u16 = readLeU16(data, header_offset + 0);
    mod.order_count = song_length;
    mod.restart_pos = readLeU16(data, header_offset + 2);
    mod.channels = readLeU16(data, header_offset + 4);
    mod.pattern_count = readLeU16(data, header_offset + 6);
    mod.instrument_count = readLeU16(data, header_offset + 8);
    const flags: u16 = readLeU16(data, header_offset + 10);
    _ = flags; // unused yet
    mod.default_tempo = readLeU16(data, header_offset + 12);
    mod.default_bpm = readLeU16(data, header_offset + 14);

    // Order table (256 bytes) follows fixed header (size 20)
    const orders_off: usize = header_offset + 20;
    const order_table_bytes: usize = @min(@as(usize, mod.order_count), 256);
    mod.orders = try alloc.alloc(u8, order_table_bytes);
    @memcpy(mod.orders, data[orders_off .. orders_off + order_table_bytes]);

    return mod;
}

inline fn readLeU16(data: []const u8, off: usize) u16 {
    return @as(u16, data[off]) | (@as(u16, data[off + 1]) << 8);
}
inline fn readLeU32(data: []const u8, off: usize) u32 {
    return @as(u32, data[off]) |
        (@as(u32, data[off + 1]) << 8) |
        (@as(u32, data[off + 2]) << 16) |
        (@as(u32, data[off + 3]) << 24);
}
