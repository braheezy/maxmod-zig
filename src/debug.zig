const gba = @import("gba");

pub fn printInt(label: []const u8, value: anytype) void {
    _ = gba.debug.print("{s}={d}\n", .{ label, value }) catch {};
}
