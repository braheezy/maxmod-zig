const std = @import("std");

pub const ModNote = struct {
    sample: u8 = 0, // 1..31
    period: u16 = 0,
    effect: u8 = 0,
    param: u8 = 0,
};

pub const ModPattern = struct {
    // Stored as channels x rows x 4 bytes parsed to ModNote on demand
    rows: u16,
    channels: u8,
    data: []const ModNote,

    pub fn getNote(self: ModPattern, row: u16, channel: u8) ModNote {
        const r: usize = @as(usize, row);
        const c: usize = @as(usize, channel);
        const idx: usize = r * @as(usize, self.channels) + c;
        return self.data[idx];
    }
};

pub const ModSample = struct {
    name: [22]u8 = [_]u8{0} ** 22,
    length_words: u16 = 0, // length in words (2 bytes)
    finetune: i8 = 0,
    volume: u8 = 64,
    repeat_start_words: u16 = 0,
    repeat_len_words: u16 = 0,
    pcm8: []const u8 = &[_]u8{},
};

pub const Module = struct {
    name: [20]u8 = [_]u8{0} ** 20,
    channels: u8 = 4,
    order_count: u8 = 1,
    restart_pos: u8 = 0,
    orders: [128]u8 = [_]u8{255} ** 128,
    pattern_count: u8 = 0,
    patterns: []const ModPattern = &[_]ModPattern{},
    samples: []const ModSample = &[_]ModSample{},
    initial_speed: u8 = 6,
    initial_tempo: u8 = 125,
};

pub fn parse(allocator: std.mem.Allocator, bytes: []const u8) !Module {
    if (bytes.len < 1084) return error.Invalid;
    var m: Module = .{};
    // Title
    @memcpy(&m.name, bytes[0..20]);
    // 31 samples meta
    var sample_headers: [31]ModSample = [_]ModSample{.{}} ** 31;
    var off: usize = 20;
    var i: usize = 0;
    while (i < 31) : (i += 1) {
        var s: ModSample = .{};
        @memcpy(&s.name, bytes[off .. off + 22]);
        off += 22;
        s.length_words = (@as(u16, bytes[off]) << 8) | bytes[off + 1];
        off += 2;
        const ft = bytes[off] & 0x0F;
        off += 1; // high nibble unused
        s.finetune = if (ft >= 8) -@as(i8, @intCast(16 - ft)) else @as(i8, @intCast(ft));
        s.volume = bytes[off];
        off += 1;
        s.repeat_start_words = (@as(u16, bytes[off]) << 8) | bytes[off + 1];
        off += 2;
        s.repeat_len_words = (@as(u16, bytes[off]) << 8) | bytes[off + 1];
        off += 2;
        sample_headers[i] = s;
    }
    m.order_count = bytes[off];
    off += 1;
    m.restart_pos = bytes[off];
    off += 1;
    @memcpy(m.orders[0..128], bytes[off .. off + 128]);
    off += 128;
    // Signature
    const sig = std.mem.bytesToValue(u32, bytes[off .. off + 4]);
    off += 4;
    m.channels = switch (sig) {
        0x2E4B2E4D => 4, // ".K.M"
        0x4D2E4B2E => 4, // "M.K."
        0x4E483336 => 6, // "6CHN"
        0x4E483338 => 8, // "8CHN"
        else => 4,
    };
    // Determine highest pattern index
    var maxp: u8 = 0;
    {
        var idx: usize = 0;
        while (idx < m.order_count) : (idx += 1) {
            const p = m.orders[idx];
            if (p < 254 and p > maxp) maxp = p;
        }
    }
    m.pattern_count = maxp + 1;
    // Read patterns
    var patterns = try allocator.alloc(ModPattern, m.pattern_count);
    var pat_data_list = try allocator.alloc([]ModNote, m.pattern_count);
    var p: usize = 0;
    while (p < m.pattern_count) : (p += 1) {
        // Each pattern in MOD is 64 rows, channel count known; 4 bytes per note entry
        const rows: u16 = 64;
        const entries = @as(usize, rows) * @as(usize, m.channels);
        var notes = try allocator.alloc(ModNote, entries);
        var e: usize = 0;
        while (e < entries) : (e += 1) {
            const a = bytes[off + 0];
            const b = bytes[off + 1];
            const c = bytes[off + 2];
            const d = bytes[off + 3];
            off += 4;
            var n: ModNote = .{};
            const period_high = @as(u16, a & 0x0F) << 8;
            n.period = period_high | b;
            n.sample = (a & 0xF0) | (c >> 4);
            n.effect = c & 0x0F;
            n.param = d;
            notes[e] = n;
        }
        patterns[p] = .{ .rows = rows, .channels = m.channels, .data = notes };
        pat_data_list[p] = notes;
    }
    m.patterns = patterns;
    // Read sample data
    var samples = try allocator.alloc(ModSample, 31);
    // All MOD sample PCM follows patterns; lengths are in words -> samples in bytes
    i = 0;
    while (i < 31) : (i += 1) {
        var s = sample_headers[i];
        const len_bytes: usize = @as(usize, s.length_words) * 2;
        if (len_bytes > 0 and off + len_bytes <= bytes.len) {
            s.pcm8 = bytes[off .. off + len_bytes];
            off += len_bytes;
        } else s.pcm8 = &[_]u8{};
        samples[i] = s;
    }
    m.samples = samples;
    return m;
}
