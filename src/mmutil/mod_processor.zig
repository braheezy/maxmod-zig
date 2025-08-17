const std = @import("std");

// MSL header structure
const MslHeader = struct {
    sample_count: u16,
    module_count: u16,
    reserved: [8]u8, // "*maxmod*" string
};

// MAS prefix structure
const MasPrefix = struct {
    size: u32,
    type: u8, // MAS_TYPE_SAMPLE_GBA = 1
    version: u8,
    reserved: [2]u8,
};

// MAS GBA sample structure
const MasGbaSample = struct {
    length: u32,
    loop_length: u32, // 0xFFFFFFFF if no loop
    format: u8, // MM_SFORMAT_8BIT = 0
    reserved: u8,
    default_frequency: u16,
};

// Sample info from MOD
const ModSampleInfo = struct {
    name: [22]u8,
    length_words: u16,
    finetune: i8,
    volume: u8,
    repeat_start_words: u16,
    repeat_len_words: u16,
    pcm_data: []const u8,
};

// MOD file structure
const ModFile = struct {
    name: [20]u8,
    samples: [31]ModSampleInfo,
    order_count: u8,
    restart_pos: u8,
    orders: [128]u8,
    signature: u32,
    channels: u8,
    pattern_count: u8,
    patterns: []const u8, // Raw pattern data
};

pub fn parseModFile(_: std.mem.Allocator, data: []const u8) !ModFile {
    if (data.len < 1084) return error.InvalidModFile;

    var mod: ModFile = .{
        .name = [_]u8{0} ** 20,
        .samples = [_]ModSampleInfo{.{
            .name = [_]u8{0} ** 22,
            .length_words = 0,
            .finetune = 0,
            .volume = 64,
            .repeat_start_words = 0,
            .repeat_len_words = 0,
            .pcm_data = &[_]u8{},
        }} ** 31,
        .order_count = 0,
        .restart_pos = 0,
        .orders = [_]u8{255} ** 128,
        .signature = 0,
        .channels = 4,
        .pattern_count = 0,
        .patterns = &[_]u8{},
    };

    // Parse title
    @memcpy(&mod.name, data[0..20]);

    // Parse 31 sample headers
    var offset: usize = 20;
    var i: usize = 0;
    while (i < 31) : (i += 1) {
        var sample: ModSampleInfo = .{
            .name = [_]u8{0} ** 22,
            .length_words = 0,
            .finetune = 0,
            .volume = 64,
            .repeat_start_words = 0,
            .repeat_len_words = 0,
            .pcm_data = &[_]u8{},
        };

        // Sample name
        @memcpy(&sample.name, data[offset .. offset + 22]);
        offset += 22;

        // Length in words (2 bytes)
        sample.length_words = (@as(u16, data[offset]) << 8) | data[offset + 1];
        offset += 2;

        // Finetune (high nibble unused)
        const ft = data[offset] & 0x0F;
        offset += 1;
        sample.finetune = if (ft >= 8) -@as(i8, @intCast(16 - ft)) else @as(i8, @intCast(ft));

        // Volume
        sample.volume = data[offset];
        offset += 1;

        // Repeat start in words
        sample.repeat_start_words = (@as(u16, data[offset]) << 8) | data[offset + 1];
        offset += 2;

        // Repeat length in words
        sample.repeat_len_words = (@as(u16, data[offset]) << 8) | data[offset + 1];
        offset += 2;

        mod.samples[i] = sample;
    }

    // Order count and restart position
    mod.order_count = data[offset];
    offset += 1;
    mod.restart_pos = data[offset];
    offset += 1;

    // Order list
    @memcpy(&mod.orders, data[offset .. offset + 128]);
    offset += 128;

    // Signature
    mod.signature = std.mem.bytesToValue(u32, data[offset .. offset + 4]);
    offset += 4;

    // Determine channel count from signature
    mod.channels = switch (mod.signature) {
        0x2E4B2E4D => 4, // ".K.M"
        0x4D2E4B2E => 4, // "M.K."
        0x4E483336 => 6, // "6CHN"
        0x4E483338 => 8, // "8CHN"
        else => 4,
    };

    // Find highest pattern index
    var max_pattern: u8 = 0;
    for (mod.orders[0..mod.order_count]) |order| {
        if (order < 254 and order > max_pattern) {
            max_pattern = order;
        }
    }
    mod.pattern_count = max_pattern + 1;

    // Calculate pattern data size and read it
    const pattern_size = @as(usize, mod.pattern_count) * 64 * @as(usize, mod.channels) * 4;
    if (offset + pattern_size > data.len) return error.InvalidModFile;

    mod.patterns = data[offset .. offset + pattern_size];
    offset += pattern_size;

    // Read sample PCM data
    for (0..31) |j| {
        var sample = &mod.samples[j];
        const sample_bytes = @as(usize, sample.length_words) * 2;

        if (sample_bytes > 0 and offset + sample_bytes <= data.len) {
            sample.pcm_data = data[offset .. offset + sample_bytes];
            offset += sample_bytes;
        } else {
            sample.pcm_data = &[_]u8{};
        }
    }

    return mod;
}

pub fn createSoundbank(_: std.mem.Allocator, mod_file: ModFile, output_path: []const u8) !void {
    const file = try std.fs.cwd().createFile(output_path, .{});
    defer file.close();
    const writer = file.writer();

    // Count actual samples with data
    var sample_count: u16 = 0;
    for (mod_file.samples) |sample| {
        if (sample.pcm_data.len > 0) {
            sample_count += 1;
        }
    }

    // Write MSL header
    const msl_header = MslHeader{
        .sample_count = sample_count,
        .module_count = 0, // No modules in soundbank mode
        .reserved = [_]u8{ '*', 'm', 'a', 'x', 'm', 'o', 'd', '*' },
    };

    try writer.writeAll(&[_]u8{
        @as(u8, @intCast(msl_header.sample_count & 0xFF)),
        @as(u8, @intCast((msl_header.sample_count >> 8) & 0xFF)),
        @as(u8, @intCast(msl_header.module_count & 0xFF)),
        @as(u8, @intCast((msl_header.module_count >> 8) & 0xFF)),
    });

    // Write reserved bytes
    try writer.writeAll(&msl_header.reserved);

    // Calculate sample table offsets - only for samples with data
    var sample_offsets: [31]u32 = undefined;
    var current_offset: u32 = @as(u32, @intCast(4 + 8 + @as(usize, sample_count) * 4)); // header + sample table

    var sample_idx: u16 = 0;
    for (0..31) |i| {
        const sample = mod_file.samples[i];
        if (sample.pcm_data.len > 0) {
            sample_offsets[sample_idx] = current_offset;
            sample_idx += 1;
            // MAS prefix (16 bytes) + MAS sample header (16 bytes) + PCM data
            current_offset += 16 + 16 + @as(u32, @intCast(sample.pcm_data.len));
        }
    }

    // Write sample table - only for samples with data
    for (0..sample_count) |i| {
        try writer.writeAll(&[_]u8{
            @as(u8, @intCast(sample_offsets[i] & 0xFF)),
            @as(u8, @intCast((sample_offsets[i] >> 8) & 0xFF)),
            @as(u8, @intCast((sample_offsets[i] >> 16) & 0xFF)),
            @as(u8, @intCast((sample_offsets[i] >> 24) & 0xFF)),
        });
    }

    // Write each sample as a MAS file - only samples with data
    for (0..31) |i| {
        const sample = mod_file.samples[i];
        if (sample.pcm_data.len == 0) continue;

        // Write MAS prefix
        const mas_prefix = MasPrefix{
            .size = @as(u32, @intCast(16 + sample.pcm_data.len)), // header + data
            .type = 1, // MAS_TYPE_SAMPLE_GBA
            .version = 1, // MAS_VERSION
            .reserved = [_]u8{ 0, 0 },
        };

        try writer.writeAll(&[_]u8{
            @as(u8, @intCast(mas_prefix.size & 0xFF)),
            @as(u8, @intCast((mas_prefix.size >> 8) & 0xFF)),
            @as(u8, @intCast((mas_prefix.size >> 16) & 0xFF)),
            @as(u8, @intCast((mas_prefix.size >> 24) & 0xFF)),
            mas_prefix.type,
            mas_prefix.version,
            mas_prefix.reserved[0],
            mas_prefix.reserved[1],
        });

        // Write MAS GBA sample header
        const loop_length = if (sample.repeat_len_words > 0)
            @as(u32, @intCast(sample.repeat_len_words)) * 2
        else
            0xFFFFFFFF;

        const mas_sample = MasGbaSample{
            .length = @as(u32, @intCast(sample.pcm_data.len)),
            .loop_length = loop_length,
            .format = 0, // MM_SFORMAT_8BIT
            .reserved = 0,
            .default_frequency = 8363, // Default Amiga frequency
        };

        try writer.writeAll(&[_]u8{
            @as(u8, @intCast(mas_sample.length & 0xFF)),
            @as(u8, @intCast((mas_sample.length >> 8) & 0xFF)),
            @as(u8, @intCast((mas_sample.length >> 16) & 0xFF)),
            @as(u8, @intCast((mas_sample.length >> 24) & 0xFF)),
            @as(u8, @intCast(mas_sample.loop_length & 0xFF)),
            @as(u8, @intCast((mas_sample.loop_length >> 8) & 0xFF)),
            @as(u8, @intCast((mas_sample.loop_length >> 16) & 0xFF)),
            @as(u8, @intCast((mas_sample.loop_length >> 24) & 0xFF)),
            mas_sample.format,
            mas_sample.reserved,
            @as(u8, @intCast(mas_sample.default_frequency & 0xFF)),
            @as(u8, @intCast((mas_sample.default_frequency >> 8) & 0xFF)),
        });

        // Write PCM data
        try writer.writeAll(sample.pcm_data);
    }
}
