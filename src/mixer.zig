pub const struct_mm_mixer_channel = extern struct {
    src: u32 = @import("std").mem.zeroes(u32),
    read: u32 = @import("std").mem.zeroes(u32),
    vol: u8 = @import("std").mem.zeroes(u8),
    pan: u8 = @import("std").mem.zeroes(u8),
    unused0: u8 = @import("std").mem.zeroes(u8),
    unused1: u8 = @import("std").mem.zeroes(u8),
    freq: u32 = @import("std").mem.zeroes(u32),
};
pub const mm_mixer_channel = struct_mm_mixer_channel;
pub extern var mm_mixbuffer: [*c]i32;
pub extern var mm_mix_channels: [*c]volatile mm_mixer_channel;
pub extern var mm_mixch_end: [*c]volatile mm_mixer_channel;
pub extern var mm_mixlen: u32;
pub extern var mm_ratescale: u32;
pub extern var mp_writepos: [*c]u16;
pub export var mm_fetch: [400]u8 align(4) = @import("std").mem.zeroes([400]u8);
pub export var mpm_nullsample: [4]u8 align(4) = [4]u8{
    128,
    128,
    128,
    128,
};
inline fn clamp_pcm8(value: c_int) c_int {
    if (value < -@as(c_int, 128)) {
        return -@as(c_int, 128);
    }
    if (value > @as(c_int, 127)) {
        return 127;
    }
    return value;
}
inline fn mix_step(frequency: u32) u32 {
    return (mm_ratescale * frequency) >> 14;
}
inline fn neutral_contribution(volume: u32) u32 {
    return if (volume != 0) (128 * volume) >> 5 else 0;
}
inline fn resolve_sample_data(src: u32) [*c]u8 {
    return @as([*c]u8, @ptrFromInt(@as(usize, @bitCast(@as(c_ulong, src)))));
}
inline fn sample_length_from_data(data: [*c]const u8) u32 {
    // Sample header: offset -12 is sample length (u32, little-endian)
    // Read bytes manually to handle unaligned access correctly on ARM
    const offset: usize = @intFromPtr(data) - 12;
    const bytes: [*]const u8 = @ptrFromInt(offset);
    return @as(u32, bytes[0]) |
           (@as(u32, bytes[1]) << 8) |
           (@as(u32, bytes[2]) << 16) |
           (@as(u32, bytes[3]) << 24);
}
inline fn loop_length_from_data(data: [*c]const u8) i32 {
    // Sample header: offset -8 is loop length (i32, little-endian)
    // Read bytes manually to handle unaligned access correctly on ARM
    const offset: usize = @intFromPtr(data) - 8;
    const bytes: [*]const u8 = @ptrFromInt(offset);
    const unsigned: u32 = @as(u32, bytes[0]) |
                          (@as(u32, bytes[1]) << 8) |
                          (@as(u32, bytes[2]) << 16) |
                          (@as(u32, bytes[3]) << 24);
    return @bitCast(unsigned);
}
pub fn copy_mix_words(dst: [*c]i32, src: [*c]const i32, count: usize) callconv(.c) void {
    var i: usize = 0;
    while (i < count) : (i += 1) {
        dst[i] = src[i];
    }
}
pub fn copy_channels(dst: [*c]mm_mixer_channel, src: [*c]const mm_mixer_channel, count: usize) callconv(.c) void {
    var i: usize = 0;
    while (i < count) : (i += 1) {
        dst[i] = src[i];
    }
}
pub fn zero_u32(dst: [*c]u32, count: usize) callconv(.c) void {
    var i: usize = 0;
    while (i < count) : (i += 1) {
        dst[i] = 0;
    }
}
pub fn zero_i32(dst: [*c]i32, count: usize) callconv(.c) void {
    var i: usize = 0;
    while (i < count) : (i += 1) {
        dst[i] = 0;
    }
}
inline fn read_dual_samples(data: [*c]const u8, read_pos: *u32, freq: u32) u32 {
    const s0: u32 = data[read_pos.* >> 12];
    read_pos.* +%= freq;
    const s1: u32 = data[read_pos.* >> 12];
    read_pos.* +%= freq;
    return s0 | (s1 << 16);
}
inline fn mix_dual_mono(frames: [*]i32, idx: u32, dual_samples: u32, volume: u32) void {
    const s0: u32 = dual_samples & 0xFF;
    const s1: u32 = (dual_samples >> 16) & 0xFF;
    frames[idx] += @as(i32, @intCast((s0 * volume) >> 5));
    frames[idx + 1] += @as(i32, @intCast((s1 * volume) >> 5));
}

const build_options = @import("build_options");

// Static arrays at file scope - must persist across calls
var left_frames_static: [1056]i32 linksection(".iwram") = undefined;
var right_frames_static: [1056]i32 linksection(".iwram") = undefined;

pub export fn mmMixerMix(sample_count: u32) linksection(".iwram") callconv(.C) void {
    if (sample_count == 0) {
        return;
    }

    // Comptime check: ensure struct sizes match
    // Note: Can't import maxmod from here due to circular dependency
    // Just check against expected size: 4+4+4+4 = 16 bytes
    comptime {
        if (@sizeOf(mm_mixer_channel) != 16) {
            @compileError("mixer channel struct should be 16 bytes!");
        }
    }

    const left_frames = &left_frames_static;
    const right_frames = &right_frames_static;

    var frame_count: u32 = sample_count;
    if (frame_count > 1056) {
        frame_count = 1056;
    }

    const padded_frames: u32 = (frame_count + 1) & ~@as(u32, 1);
    const words_per_channel: u32 = padded_frames >> 1;
    const total_words: usize = @intCast(words_per_channel * 2);

    var mix_words: [*c]u32 = @ptrCast(@alignCast(mm_mixbuffer));
    zero_u32(mix_words, total_words);

    zero_i32(@ptrCast(left_frames), @intCast(padded_frames));
    zero_i32(@ptrCast(right_frames), @intCast(padded_frames));

    var total_left_volume: u32 = 0;
    var total_right_volume: u32 = 0;

    var channel: [*c]volatile mm_mixer_channel = mm_mix_channels;
    while (channel < mm_mixch_end) : (channel += 1) {
        const src: u32 = channel.*.src;
        if ((src & 0x80000000) != 0) {
            continue;
        }

        const frequency: u32 = channel.*.freq;
        if (frequency == 0) {
            continue;
        }

        const step: u32 = mix_step(frequency);
        if (step == 0) {
            continue;
        }

        const sample_data: [*c]u8 = resolve_sample_data(src);
        const sample_length: u32 = sample_length_from_data(sample_data);
        const loop_length: i32 = loop_length_from_data(sample_data);
        const sample_length_fp: u32 = sample_length << 12;
        var loop_length_fp: u32 = 0;

        const pan: u32 = channel.*.pan;
        const volume: u32 = channel.*.vol;
        const left_volume: u32 = ((256 - pan) * volume) >> 8;
        const right_volume: u32 = (pan * volume) >> 8;

        total_left_volume += left_volume;
        total_right_volume += right_volume;

        const neutral_left: u32 = neutral_contribution(left_volume);
        const neutral_right: u32 = neutral_contribution(right_volume);

        var read_position: u32 = channel.*.read;

        if (sample_length_fp == 0) {
            channel.*.src = 0x80000000;
            channel.*.read = 0;
            continue;
        }

        if (loop_length > 0 and @as(u32, @intCast(loop_length)) <= sample_length) {
            loop_length_fp = @as(u32, @intCast(loop_length)) << 12;
        }

        var frame_index: u32 = 0;
        const is_centered = left_volume == right_volume;
        const is_mono = (left_volume == 0 or right_volume == 0);

        while (frame_index < frame_count) {
            if (read_position >= sample_length_fp) {
                if (loop_length_fp == 0) {
                    channel.*.src = 0x80000000;
                    read_position = 0;
                    break;
                }
                while (read_position >= sample_length_fp) {
                    read_position -= loop_length_fp;
                }
            }

            const remaining_samples_fp: u32 = sample_length_fp - read_position;
            const frames_until_end: u32 = (remaining_samples_fp + step - 1) / step;
            const frames_available: u32 = frame_count - frame_index;
            var frames_to_mix: u32 = if (frames_until_end < frames_available) frames_until_end else frames_available;

            while (frames_to_mix >= 8) {
                var i: u32 = 0;
                while (i < 4) : (i += 1) {
                    const dual_samples = read_dual_samples(sample_data, &read_position, step);
                    const fidx = frame_index;

                    if (is_centered and left_volume > 0) {
                        mix_dual_mono(left_frames, fidx, dual_samples, left_volume);
                        mix_dual_mono(right_frames, fidx, dual_samples, left_volume);
                    } else if (!is_mono and left_volume > 0 and right_volume > 0) {
                        mix_dual_mono(left_frames, fidx, dual_samples, left_volume);
                        mix_dual_mono(right_frames, fidx, dual_samples, right_volume);
                    } else if (left_volume > 0) {
                        mix_dual_mono(left_frames, fidx, dual_samples, left_volume);
                    } else if (right_volume > 0) {
                        mix_dual_mono(right_frames, fidx, dual_samples, right_volume);
                    }

                    frame_index += 2;
                }
                frames_to_mix -= 8;
            }

            while (frames_to_mix > 0) {
                const sample_offset: u32 = read_position >> 12;
                const sample_value: u8 = sample_data[sample_offset];

                if (left_volume != 0) {
                    left_frames[frame_index] += @as(i32, @intCast((@as(u32, sample_value) * left_volume) >> 5));
                }
                if (right_volume != 0) {
                    right_frames[frame_index] += @as(i32, @intCast((@as(u32, sample_value) * right_volume) >> 5));
                }

                read_position += step;
                frame_index += 1;
                frames_to_mix -= 1;
            }
        }

        channel.*.read = read_position;

        if (loop_length_fp == 0 and frame_index < frame_count) {
            const remaining: u32 = frame_count - frame_index;
            if (left_volume != 0) {
                var i: u32 = 0;
                while (i < remaining) : (i += 1) {
                    left_frames[frame_index + i] += @as(i32, @intCast(neutral_left));
                }
            }
            if (right_volume != 0) {
                var i: u32 = 0;
                while (i < remaining) : (i += 1) {
                    right_frames[frame_index + i] += @as(i32, @intCast(neutral_right));
                }
            }
        }
    }

    var frames_to_output: u32 = frame_count;
    if (frames_to_output > mm_mixlen) {
        frames_to_output = mm_mixlen;
    }

    var padded_output_frames: u32 = (frames_to_output + 1) & ~@as(u32, 1);
    if (padded_output_frames > padded_frames) {
        padded_output_frames = padded_frames;
    }

    const words_to_output: u32 = padded_output_frames >> 1;
    const prvol_left: i32 = @as(i32, @intCast((total_left_volume >> 1) << 3));
    const prvol_right: i32 = @as(i32, @intCast((total_right_volume >> 1) << 3));

    var left_cursor: [*c]u16 = mp_writepos;
    var right_cursor: [*c]u16 = mp_writepos + mm_mixlen;

    var pair: u32 = 0;
    while (pair < words_to_output) : (pair += 1) {
        var frame0: u32 = pair << 1;
        var frame1: u32 = frame0 + 1;

        if (frame0 >= padded_frames) {
            frame0 = padded_frames - 1;
        }
        if (frame1 >= padded_frames) {
            frame1 = if (padded_frames > 0) padded_frames - 1 else frame0;
        }

        const left0: i32 = (left_frames[frame0] - prvol_left) >> 3;
        const left1: i32 = (left_frames[frame1] - prvol_left) >> 3;
        const right0: i32 = (right_frames[frame0] - prvol_right) >> 3;
        const right1: i32 = (right_frames[frame1] - prvol_right) >> 3;

        const left_byte0: u8 = @as(u8, @bitCast(@as(i8, @truncate(clamp_pcm8(left0)))));
        const left_byte1: u8 = @as(u8, @bitCast(@as(i8, @truncate(clamp_pcm8(left1)))));
        const right_byte0: u8 = @as(u8, @bitCast(@as(i8, @truncate(clamp_pcm8(right0)))));
        const right_byte1: u8 = @as(u8, @bitCast(@as(i8, @truncate(clamp_pcm8(right1)))));

        const left_word: u16 = @as(u16, left_byte0) | (@as(u16, left_byte1) << 8);
        const right_word: u16 = @as(u16, right_byte0) | (@as(u16, right_byte1) << 8);

        left_cursor[0] = left_word;
        left_cursor += 1;
        right_cursor[0] = right_word;
        right_cursor += 1;

        const left_word_index: u32 = pair << 1;
        mix_words[left_word_index] = (@as(u32, @intCast(left_frames[frame1] & 0xFFFF)) << 16) | @as(u32, @intCast(left_frames[frame0] & 0xFFFF));
        mix_words[left_word_index + 1] = (@as(u32, @intCast(right_frames[frame1] & 0xFFFF)) << 16) | @as(u32, @intCast(right_frames[frame0] & 0xFFFF));
    }

    mp_writepos = left_cursor;
}
