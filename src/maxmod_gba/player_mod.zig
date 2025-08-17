const std = @import("std");
const audio = @import("audio.zig");
const mod = @import("mod.zig");
const mixer = @import("mixer_asm.zig");

// Maxmod fine sine table (256 entries), values in range [-64..64]
const VIBRATO_FINE_SINE: [256]i8 = [_]i8{
    0,   2,   3,   5,   6,   8,   9,   11,  12,  14,  16,  17,  19,  20,  22,  23,
    24,  26,  27,  29,  30,  32,  33,  34,  36,  37,  38,  39,  41,  42,  43,  44,
    45,  46,  47,  48,  49,  50,  51,  52,  53,  54,  55,  56,  56,  57,  58,  59,
    59,  60,  60,  61,  61,  62,  62,  62,  63,  63,  63,  64,  64,  64,  64,  64,
    64,  64,  64,  64,  64,  64,  63,  63,  63,  62,  62,  62,  61,  61,  60,  60,
    59,  59,  58,  57,  56,  56,  55,  54,  53,  52,  51,  50,  49,  48,  47,  46,
    45,  44,  43,  42,  41,  39,  38,  37,  36,  34,  33,  32,  30,  29,  27,  26,
    24,  23,  22,  20,  19,  17,  16,  14,  12,  11,  9,   8,   6,   5,   3,   2,
    0,   -2,  -3,  -5,  -6,  -8,  -9,  -11, -12, -14, -16, -17, -19, -20, -22, -23,
    -24, -26, -27, -29, -30, -32, -33, -34, -36, -37, -38, -39, -41, -42, -43, -44,
    -45, -46, -47, -48, -49, -50, -51, -52, -53, -54, -55, -56, -56, -57, -58, -59,
    -59, -60, -60, -61, -61, -62, -62, -62, -63, -63, -63, -64, -64, -64, -64, -64,
    -64, -64, -64, -64, -64, -64, -63, -63, -63, -62, -62, -62, -61, -61, -60, -60,
    -59, -59, -58, -57, -56, -56, -55, -54, -53, -52, -51, -50, -49, -48, -47, -46,
    -45, -44, -43, -42, -41, -39, -38, -37, -36, -34, -33, -32, -30, -29, -27, -26,
    -24, -23, -22, -20, -19, -17, -16, -14, -12, -11, -9,  -8,  -6,  -5,  -3,  -2,
};

// 16.16 finetune multipliers for 2^(k/96), k = -8..+7
const FINETUNE_MUL_16_16 = [_]u32{
    61847, // -8
    62299, // -7
    62754, // -6
    63211, // -5
    63671, // -4
    64134, // -3
    64599, // -2
    65068, // -1
    65536, //  0
    66010, // +1
    66488, // +2
    66970, // +3
    67455, // +4
    67944, // +5
    68437, // +6
    68933, // +7
};

// Consistent panning helper for all channel updates
fn panForChannel(total: u8, ch: u8) u8 {
    if (total == 4) {
        return switch (ch) {
            0 => 0, // L
            1 => 255, // R
            2 => 255, // R
            3 => 0, // L
            else => 128,
        };
    }
    return if ((@as(usize, ch) % 2) == 0) 0 else 255;
}

// Temporary debug: route logical ch 3 into mixer ch 2 to test channel mapping
fn phys(ch: u8) u8 {
    return if (ch == 3) 2 else ch;
}

const MasBuf = struct {
    data_ptr: [*]const u8 = undefined, // PCM start (12 bytes past header)
    len_bytes: u32 = 0,
    loop_len_bytes: u32 = 0,
};

// Fallback MAS header+PCM cache for non-banked samples (satisfy ASM header reads at src-12)
// Fallback pool to synthesize MAS headers + PCM copies when a GBSAMP bank
// isn't available. Size is moderate to cover typical MODs. If this pool
// is exhausted, we will skip triggering those notes on the ASM path to
// avoid garbage (better silence than noise).
// Keep fallback pool modest to fit GBA EWRAM alongside other buffers.
// This is enough for typical short, non-looped instruments. If exhausted,
// we skip triggering to avoid noise.
var fb_pool: [32 * 1024]u8 align(4) = undefined;
var fb_used: usize = 0;
var fb_slots: [31]?MasBuf = [_]?MasBuf{null} ** 31;

fn allocFallbackMas(sample: mod.ModSample, idx: usize) ?MasBuf {
    if (idx >= fb_slots.len) return null;
    if (fb_slots[idx]) |m| return m;
    const total_len: usize = sample.pcm8.len;
    if (total_len == 0) return null;
    const loop_len_bytes_raw: u32 = @as(u32, sample.repeat_len_words) * 2;
    const loop_start_bytes: u32 = @as(u32, sample.repeat_start_words) * 2;
    // Effective sample length ends at loop_start + loop_len when looping, else full length
    var effective_len: usize = total_len;
    var loop_len_field: u32 = 0x8000_0000; // default: no loop (MSB set)
    if (loop_len_bytes_raw > 2 and loop_start_bytes < total_len) {
        const ll: usize = @intCast(loop_len_bytes_raw);
        const ls: usize = @intCast(loop_start_bytes);
        const end = @min(ls + ll, total_len);
        effective_len = end;
        loop_len_field = loop_len_bytes_raw; // MSB clear => loop enabled
    }
    const need: usize = 12 + effective_len;
    if (fb_used + need > fb_pool.len) return null;
    const base = fb_used;
    fb_used += need;
    // header: [len][loop_len][reserved]
    const hdr0: *[4]u8 = @ptrCast(&fb_pool[base + 0]);
    const hdr1: *[4]u8 = @ptrCast(&fb_pool[base + 4]);
    const hdr2: *[4]u8 = @ptrCast(&fb_pool[base + 8]);
    std.mem.writeInt(u32, hdr0, @as(u32, @intCast(effective_len)), .little);
    std.mem.writeInt(u32, hdr1, loop_len_field, .little);
    std.mem.writeInt(u32, hdr2, 0, .little);
    // data: convert MOD signed 8-bit PCM (-128..127) to unsigned (0..255) expected by ASM mixer
    var di: usize = 0;
    while (di < effective_len) : (di += 1) {
        const sv: i8 = @as(i8, @bitCast(sample.pcm8[di]));
        const uv: u8 = @as(u8, @intCast(@as(i16, sv) + 128));
        fb_pool[base + 12 + di] = uv;
    }
    const mas = MasBuf{
        .data_ptr = @ptrFromInt(@intFromPtr(&fb_pool) + base + 12),
        .len_bytes = @intCast(effective_len),
        .loop_len_bytes = loop_len_field,
    };
    fb_slots[idx] = mas;
    return mas;
}

// Amiga PAL period table (12 notes per octave, 3 octaves)
const PERIOD_TABLE = [_]u16{
    // Octave 0 (C-0 to B-0)
    856, 808, 762, 720, 678, 640, 604, 570, 538, 508, 480, 453,
    // Octave 1 (C-1 to B-1)
    428, 404, 381, 360, 339, 320, 302, 285, 269, 254, 240, 226,
    // Octave 2 (C-2 to B-2)
    214, 202, 190, 180, 170, 160, 151, 143, 135, 127, 120, 113,
};

// Convert note number (0-35) to period using the table
fn noteToPeriod(note: u8) u16 {
    if (note >= PERIOD_TABLE.len) return 0;
    return PERIOD_TABLE[note];
}

// Find the closest period in the table for portamento effects
fn findClosestPeriod(target: u16) u16 {
    if (target == 0) return 0;
    if (target <= 113) return 113;
    if (target >= 856) return 856;

    var closest: u16 = 856;
    var min_diff: u16 = 856;

    for (PERIOD_TABLE) |period| {
        const diff = if (period > target) period - target else target - period;
        if (diff < min_diff) {
            min_diff = diff;
            closest = period;
        }
    }
    return closest;
}

pub const ChannelState = struct {
    sample_index: u8 = 0, // 1..31
    period: u16 = 0,
    base_period: u16 = 0,
    volume: u8 = 64,
    porta_target: u16 = 0,
    porta_speed: u8 = 0,
    // Pending sample offset from 9xx (bytes)
    sample_offset_bytes: u32 = 0,
    // Vibrato state
    vibrato_pos: u8 = 0, // 0..255 into fine sine table
    vibrato_depth: u8 = 0, // Depth (scaled)
    vibrato_speed: u8 = 0, // Speed (scaled)
    // Tremolo state
    tremolo_pos: u8 = 0,
    tremolo_depth: u8 = 0,
    tremolo_speed: u8 = 0,
    vibrato_delay: u8 = 0, // Delay before vibrato starts
    // Pattern loop state
    loop_start: u8 = 0, // Pattern loop start row
    loop_count: u8 = 0, // Pattern loop counter
    // Note delay state
    note_delay: u8 = 0, // Ticks to delay note
    delayed_note: u16 = 0, // Note to play after delay
    delayed_sample: u8 = 0, // Sample to use after delay
};

pub const ModPlayer = struct {
    module: mod.Module,
    order_index: u8,
    row_index: u8,
    speed_ticks: u8, // ticks per row
    bpm: u8,
    samples_until_tick: u32,
    samples_per_tick: u32,
    tick_in_row: u8,
    oldeffects: u8 = 0, // MOD: 0 (affects vibrato depth scaling)
    patt_delay: u8 = 0, // pattern delay (rows remaining)

    // Simple channel state
    channels: []ChannelState,
    // No MAS buffers when using Zig mixer path

    pub fn init(allocator: std.mem.Allocator, m: mod.Module) ModPlayer {
        const chans = allocator.alloc(ChannelState, m.channels) catch @panic("oom");
        for (chans) |*c| c.* = .{};
        // Zig mixer path: no MAS buffers required
        var p = ModPlayer{
            .module = m,
            .order_index = 0,
            .row_index = 0,
            .speed_ticks = if (m.initial_speed == 0) 6 else m.initial_speed,
            .bpm = if (m.initial_tempo == 0) 125 else m.initial_tempo,
            .samples_until_tick = 0,
            .samples_per_tick = 0,
            .tick_in_row = 0,
            .channels = chans,
        };
        p.recomputeTickLen();

        // Initialize mixer with mode 3 (15768 Hz) for best quality/performance balance
        mixer.init(3);

        // Initialize classic Amiga panning across 4 channels
        // Amiga: ch0=L, ch1=R, ch2=R, ch3=L
        var ch: usize = 0;
        while (ch < m.channels) : (ch += 1) {
            const pan = panForChannel(m.channels, @intCast(ch));
            mixer.setChannelFromPcm8(phys(@intCast(ch)), &[_]u8{0}, 0, 0, pan, 0);
        }
        return p;
    }

    fn recomputeTickLen(self: *ModPlayer) void {
        // tick duration = 2.5 / BPM seconds -> samples_per_tick = rate * 2.5 / BPM
        const rate: u32 = @import("mixer_asm.zig").getMixRate();
        // Use rounding to minimize tempo drift
        self.samples_per_tick = @intCast(((@as(u64, rate) * 25) + (@as(u64, self.bpm) * 5)) / (@as(u64, self.bpm) * 10));
        self.samples_until_tick = self.samples_per_tick;
    }

    // --- Helpers ported from Maxmod (Amiga domain) ---
    fn pitchSlideUpAmiga(period: u16, slide_value: u16) u16 {
        const delta: u32 = (@as(u32, slide_value)) << 4;
        if (delta > period) return 0;
        return @intCast(period - @as(u16, @intCast(delta)));
    }
    fn pitchSlideDownAmiga(period: u16, slide_value: u16) u16 {
        const delta: u32 = (@as(u32, slide_value)) << 4;
        var p: u32 = period;
        p += delta;
        // Clamp to 16.5 fixed ceiling (emulate Maxmod safeguard)
        if (p > 0xFFFF) return 0xFFFF;
        return @intCast(p);
    }

    fn doVibrato(self: *ModPlayer, ch: u8, period: u16) u16 {
        // mppe_DoVibrato equivalent (MOD/Amiga semantics)
        var pos: u8 = self.channels[ch].vibrato_pos;
        if (self.oldeffects == 0 or self.tick_in_row != 0) {
            pos = pos +% self.channels[ch].vibrato_speed;
            self.channels[ch].vibrato_pos = pos;
        }
        const sine_val: i32 = VIBRATO_FINE_SINE[pos];
        const depth: i32 = @as(i32, self.channels[ch].vibrato_depth) << @as(u3, @intCast(self.oldeffects));
        const value: i32 = (sine_val * depth) >> 8;
        if (value < 0) {
            return ModPlayer.pitchSlideDownAmiga(period, @intCast(-value));
        } else {
            return ModPlayer.pitchSlideUpAmiga(period, @intCast(value));
        }
    }

    // Compute mix channel freq field in the same domain Maxmod GBA expects (pre-mm_ratescale)
    fn periodToAsmFreq(self: *const ModPlayer, period: u16, sample_idx: u8) u32 {
        if (period == 0) return 0;
        // Amiga frequencies (match Maxmod mas.c): value = MOD_FREQ_DIVIDER_PAL / period
        const MOD_FREQ_DIVIDER_PAL: u32 = 56_750_314; // exact constant used by Maxmod
        // Maxmod uses a period domain with 5 fractional bits; emulate by dividing by 16.
        // This brings the step into the correct 20.12 range for the ASM mixer.
        var value: u32 = @intCast(MOD_FREQ_DIVIDER_PAL / (@as(u32, period) << 4));
        // Apply per-sample finetune (-8..+7) as multiplier 2^(ft/96)
        var finetune: i8 = 0;
        if (sample_idx > 0 and sample_idx <= self.module.samples.len) {
            finetune = self.module.samples[sample_idx - 1].finetune;
        }
        if (finetune != 0) {
            const ft_index: usize = @intCast(finetune + 8);
            const ft_mul: u32 = FINETUNE_MUL_16_16[ft_index];
            value = @intCast((@as(u64, value) * @as(u64, ft_mul)) >> 16);
        }
        // mix_ch->freq = (scale * value) >> 16, scale: (4096*65536)/15768 (GBA path)
        const scale: u32 = @intCast((@as(u64, 4096) * 65536) / 15768);
        const freq_field: u32 = @intCast((@as(u64, scale) * @as(u64, value)) >> 16);
        return freq_field;
    }

    pub fn onMixed(self: *ModPlayer, mixed_samples: u32) void {
        var remaining: u32 = mixed_samples;
        while (remaining > 0) {
            if (self.samples_until_tick == 0) self.samples_until_tick = self.samples_per_tick;
            if (remaining >= self.samples_until_tick) {
                remaining -= self.samples_until_tick;
                self.samples_until_tick = 0;
                self.advanceTick();
            } else {
                self.samples_until_tick -= remaining;
                remaining = 0;
            }
        }
    }

    pub fn startRow(self: *ModPlayer) void {
        self.tick_in_row = 0;
        self.processRow(); // tick 0
    }

    fn advanceTick(self: *ModPlayer) void {
        // Tick advancement: tick 0 handled by processRow; ticks 1..speed-1 apply effects
        if (self.tick_in_row == 0) {
            // already processed
        } else {
            self.applyTickEffects(self.tick_in_row);
        }
        self.tick_in_row += 1;
        if (self.tick_in_row >= self.speed_ticks) {
            self.tick_in_row = 0;
            // Pattern delay: if active, repeat current row (do not advance)
            if (self.patt_delay > 0) {
                self.patt_delay -= 1;
            } else {
                self.row_index += 1;
            }
            if (self.row_index >= 64) {
                self.row_index = 0;
                self.order_index += 1;
                if (self.order_index >= self.module.order_count or self.module.orders[self.order_index] >= 0xFE) {
                    self.order_index = 0; // loop song
                }
            }
            self.processRow(); // next row tick 0
        }
    }

    fn applyTickEffects(self: *ModPlayer, _: u8) void {
        const pat_index: u8 = self.module.orders[self.order_index];
        if (pat_index >= self.module.pattern_count) return;
        const pat = self.module.patterns[pat_index];
        var ch: u8 = 0;
        while (ch < self.module.channels) : (ch += 1) {
            const note = pat.getNote(self.row_index, ch);
            var period_changed = false;
            var temp_only: bool = false; // true for vibrato/arpeggio/tremolo
            var temp_period: u16 = self.channels[ch].period;
            var vol_override: ?u8 = null; // volume override for tremolo
            // Handle tone portamento target capture on tick 0
            if (note.effect == 0x03 and note.period != 0) {
                self.channels[ch].porta_target = note.period;
            }
            var period = self.channels[ch].period;

            // Effect 4xy: Vibrato (exact Maxmod semantics)
            if (note.effect == 0x04) {
                const x = (note.param >> 4) & 0xF;
                const y = note.param & 0xF;
                if (x != 0) self.channels[ch].vibrato_speed = x * 4;
                if (y != 0) self.channels[ch].vibrato_depth = y * 4;
                if (period > 0) {
                    // Tick 0: only apply if depth set (y!=0), otherwise apply on tick>0
                    if (self.tick_in_row == 0) {
                        if (y != 0) {
                            const p2 = self.doVibrato(ch, period);
                            temp_period = @intCast(@max(@min(@as(i32, p2), 856), 113));
                            temp_only = true;
                        }
                    } else {
                        const p2 = self.doVibrato(ch, period);
                        temp_period = @intCast(@max(@min(@as(i32, p2), 856), 113));
                        temp_only = true;
                    }
                }
            }

            // Effect Axy: Volume slide
            if (note.effect == 0x0A) {
                const up = (note.param >> 4) & 0xF;
                const down = note.param & 0xF;
                var v: i16 = self.channels[ch].volume;
                v = @intCast(@max(@min(@as(i16, v) + @as(i16, @intCast(up)) - @as(i16, @intCast(down)), 64), 0));
                self.channels[ch].volume = @intCast(v);
            }

            // Effect 6xy: Vibrato + Volume slide (like 4xy + Axy)
            if (note.effect == 0x06) {
                // Vibrato part
                if (period > 0) {
                    const p2 = self.doVibrato(ch, period);
                    temp_period = @intCast(@max(@min(@as(i32, p2), 856), 113));
                    temp_only = true;
                }
                // Apply volume slide
                const up = (note.param >> 4) & 0xF;
                const down = note.param & 0xF;
                var v: i16 = self.channels[ch].volume;
                v = @intCast(@max(@min(@as(i16, v) + @as(i16, @intCast(up)) - @as(i16, @intCast(down)), 64), 0));
                self.channels[ch].volume = @intCast(v);
            }

            // Effect 7xy: Tremolo (MOD)
            if (note.effect == 0x07) {
                const x = (note.param >> 4) & 0xF;
                const y = note.param & 0xF;
                if (x != 0) self.channels[ch].tremolo_speed = x * 4;
                if (y != 0) self.channels[ch].tremolo_depth = y; // depth 0..15
                // Compute volume addition
                const pos: u8 = self.channels[ch].tremolo_pos +% self.channels[ch].tremolo_speed;
                self.channels[ch].tremolo_pos = pos;
                const sine = VIBRATO_FINE_SINE[pos];
                const add: i32 = (sine * @as(i32, self.channels[ch].tremolo_depth)) >> 6; // per mas.c
                // Apply to volume temporarily
                var v: i32 = self.channels[ch].volume;
                v += add;
                if (v < 0) v = 0;
                if (v > 64) v = 64;
                // Set volume override for single update at end
                vol_override = @intCast(@min(@as(u16, @intCast(v)) * 4, 255));
            }

            // Effect 1xx: Portamento up (Amiga: delta = speed << 4) on ticks > 0
            if (note.effect == 0x01 and period > 0) {
                const spd = if (note.param != 0) note.param else self.channels[ch].porta_speed;
                if (self.tick_in_row != 0) {
                    const delta: u16 = @as(u16, spd) << 4;
                    var p: i32 = period;
                    p -= @as(i32, delta);
                    if (p < 0) p = 0;
                    if (p < 113) p = 113;
                    period = @intCast(p);
                    period_changed = true;
                }
                if (note.param != 0) self.channels[ch].porta_speed = note.param;
            }

            // Effect 2xx: Portamento down (Amiga: delta = speed << 4) on ticks > 0
            if (note.effect == 0x02 and period > 0) {
                const spd = if (note.param != 0) note.param else self.channels[ch].porta_speed;
                if (self.tick_in_row != 0) {
                    const delta: u16 = @as(u16, spd) << 4;
                    var p: i32 = period;
                    p += @as(i32, delta);
                    if (p > 856) p = 856;
                    period = @intCast(p);
                    period_changed = true;
                }
                if (note.param != 0) self.channels[ch].porta_speed = note.param;
            }

            // Effect 3xx: Tone portamento (Amiga delta per tick)
            if (note.effect == 0x03 and self.channels[ch].porta_target != 0) {
                const target: u16 = self.channels[ch].porta_target;
                const spd = if (note.param != 0) note.param else self.channels[ch].porta_speed;
                if (self.tick_in_row != 0) {
                    const delta: u16 = @as(u16, spd) << 4;
                    var p: i32 = period;
                    if (p < target) {
                        p += @as(i32, delta);
                        if (p > target) p = target;
                    } else if (p > target) {
                        p -= @as(i32, delta);
                        if (p < target) p = target;
                    }
                    if (p < 113) p = 113;
                    if (p > 856) p = 856;
                    period = @intCast(p);
                    period_changed = true;
                }
                if (note.param != 0) self.channels[ch].porta_speed = note.param;
            }

            // Effect Jxy: Arpeggio (MOD)
            if (note.effect == 0x00 and note.param != 0) {
                const tick_mod = @mod(self.tick_in_row, 3);
                const hi: u8 = (note.param >> 4) & 0xF;
                const lo: u8 = note.param & 0xF;
                var semis: i8 = 0;
                if (tick_mod == 1) semis = @as(i8, @intCast(hi));
                if (tick_mod == 2) semis = @as(i8, @intCast(lo));
                if (semis != 0) {
                    // temp period = period * 2^(-semis/12)
                    // Precompute 16.16 multipliers for +/- semitones 0..15
                    const SEMI_MUL: [16]u32 = .{ 65536, 61707, 58254, 55056, 52105, 49388, 46890, 44599, 42500, 40583, 38834, 37244, 35799, 34491, 33311, 32245 };
                    // Above are approximations for 2^(n/12) scaled by 65536; for down we divide
                    const mul = SEMI_MUL[@intCast(semis & 0x0F)];
                    temp_period = @intCast((@as(u64, period) * @as(u64, 65536)) / mul);
                    if (temp_period < 113) temp_period = 113;
                    if (temp_period > 856) temp_period = 856;
                    temp_only = true;
                }
            }

            // Update channel
            const pan = panForChannel(self.module.channels, ch);
            const base_vol: u8 = @intCast(@min(@as(u16, self.channels[ch].volume) * 4, 255));
            const out_vol: u8 = vol_override orelse base_vol;

            if (temp_only) {
                const step = self.periodToAsmFreq(temp_period, self.channels[ch].sample_index);
                mixer.updateChannel(phys(ch), out_vol, pan, step);
            } else if (period_changed) {
                self.channels[ch].period = period;
                const step = self.periodToAsmFreq(period, self.channels[ch].sample_index);
                mixer.updateChannel(phys(ch), out_vol, pan, step);
            } else if (vol_override != null) {
                const step = self.periodToAsmFreq(self.channels[ch].period, self.channels[ch].sample_index);
                mixer.updateChannel(phys(ch), out_vol, pan, step);
            }
        }
    }

    fn processRow(self: *ModPlayer) void {
        const pat_index: u8 = self.module.orders[self.order_index];
        if (pat_index >= self.module.pattern_count) return;
        const pat = self.module.patterns[pat_index];
        // Track tick0 vs ticks>0 minimal state
        var new_instruments: [32]bool = [_]bool{false} ** 32;
        var ch: u8 = 0;
        while (ch < self.module.channels) : (ch += 1) {
            const note = pat.getNote(self.row_index, ch);
            var period_changed = false;
            // Effect Fxx: speed/tempo
            if (note.effect == 0x0F) {
                if (note.param <= 0x1F and note.param != 0) self.speed_ticks = note.param;
                if (note.param >= 0x20) {
                    self.bpm = note.param;
                    self.recomputeTickLen();
                }
            }
            // Effect Cxx: set volume
            if (note.effect == 0x0C) {
                self.channels[ch].volume = if (note.param > 64) 64 else note.param;
            }
            // Bxx: position jump (next row)
            if (note.effect == 0x0B) {
                self.order_index = note.param;
                self.row_index = 0;
                // restart row processing with new order (simple approach)
            }
            // Dxx: pattern break, xx in BCD -> row = tens*10 + ones
            if (note.effect == 0x0D) {
                self.order_index += 1;
                if (self.order_index >= self.module.order_count) self.order_index = 0;
                const tens: u8 = (note.param >> 4) & 0xF;
                const ones: u8 = note.param & 0xF;
                const target_row: u8 = @intCast(@min(@as(u16, tens) * 10 + ones, 63));
                self.row_index = target_row;
            }
            // 9xx: Sample offset (xx * 256 bytes), applied when note triggers this row
            if (note.effect == 0x09) {
                if (note.param != 0) {
                    self.channels[ch].sample_offset_bytes = @as(u32, note.param) * 256;
                }
            }
            // E9x: note cut after x ticks (minimal)
            // Effect Ex: Extended effects
            if (note.effect == 0x0E) {
                const ext_cmd = (note.param >> 4) & 0xF;
                const ext_param = note.param & 0xF;

                switch (ext_cmd) {
                    0x1 => { // E1x: Fine portamento up (Amiga: delta = x << 2), tick 0 only
                        if (self.tick_in_row == 0 and self.channels[ch].period > 0) {
                            const delta: u16 = @as(u16, ext_param) << 2;
                            var p: i32 = self.channels[ch].period;
                            p -= @as(i32, delta);
                            if (p < 0) p = 0;
                            if (p < 113) p = 113;
                            self.channels[ch].period = @intCast(p);
                            period_changed = true;
                        }
                    },
                    0x2 => { // E2x: Fine portamento down (Amiga: delta = x << 2), tick 0 only
                        if (self.tick_in_row == 0 and self.channels[ch].period > 0) {
                            const delta: u16 = @as(u16, ext_param) << 2;
                            var p: i32 = self.channels[ch].period;
                            p += @as(i32, delta);
                            if (p > 856) p = 856;
                            self.channels[ch].period = @intCast(p);
                            period_changed = true;
                        }
                    },
                    0x6 => { // E6x: Pattern loop
                        if (self.tick_in_row == 0) {
                            if (ext_param == 0) {
                                // Set loop start point
                                self.channels[ch].loop_start = self.row_index;
                            } else {
                                // Loop x times
                                if (self.channels[ch].loop_count == 0) {
                                    self.channels[ch].loop_count = ext_param;
                                    self.row_index = self.channels[ch].loop_start;
                                } else {
                                    self.channels[ch].loop_count -= 1;
                                    if (self.channels[ch].loop_count > 0) {
                                        self.row_index = self.channels[ch].loop_start;
                                    }
                                }
                            }
                        }
                    },
                    0x9 => { // E9x: Retrigger note every x ticks (1..15)
                        const r: u8 = ext_param & 0x0F;
                        if (r != 0 and (self.tick_in_row % r) == 0) {
                            mixer.retriggerChannel(ch);
                        }
                    },
                    0xA => { // EAx: Fine volume slide up
                        if (self.tick_in_row == 0) {
                            var v: i16 = self.channels[ch].volume;
                            v = @intCast(@max(@min(@as(i16, v) + @as(i16, ext_param), 64), 0));
                            self.channels[ch].volume = @intCast(v);
                        }
                    },
                    0xB => { // EBx: Fine volume slide down
                        if (self.tick_in_row == 0) {
                            var v: i16 = self.channels[ch].volume;
                            v = @intCast(@max(@min(@as(i16, v) - @as(i16, ext_param), 64), 0));
                            self.channels[ch].volume = @intCast(v);
                        }
                    },
                    0xC => { // ECx: Note cut
                        if (self.tick_in_row == ext_param) {
                            self.channels[ch].volume = 0;
                        }
                    },
                    0xD => { // EDx: Note delay
                        if (self.tick_in_row == 0) {
                            if (note.period != 0) {
                                self.channels[ch].delayed_note = note.period;
                                self.channels[ch].delayed_sample = note.sample;
                                self.channels[ch].note_delay = ext_param;
                            }
                        } else if (self.tick_in_row == ext_param) {
                            if (self.channels[ch].delayed_note != 0) {
                                self.channels[ch].period = self.channels[ch].delayed_note;
                                if (self.channels[ch].delayed_sample != 0) {
                                    const sidx: usize = (self.channels[ch].delayed_sample - 1);
                                    if (sidx < self.module.samples.len) {
                                        const s = self.module.samples[sidx];
                                        self.channels[ch].sample_index = self.channels[ch].delayed_sample;
                                        self.channels[ch].volume = s.volume;
                                        var pcm: []const u8 = s.pcm8;
                                        var loop_len_bytes: u32 = @as(u32, s.repeat_len_words) * 2;
                                        var have_mas: bool = false;
                                        if (@hasDecl(@import("lib.zig"), "resolveGbsSample")) {
                                            if (@import("lib.zig").resolveGbsSample(sidx)) |blk| {
                                                pcm = blk.pcm;
                                                loop_len_bytes = blk.loop_len_bytes;
                                                have_mas = true;
                                            } else if (allocFallbackMas(s, sidx)) |mb| {
                                                pcm = @as([*]const u8, mb.data_ptr)[0..@as(usize, mb.len_bytes)];
                                                loop_len_bytes = mb.loop_len_bytes;
                                                have_mas = true;
                                            } else {
                                                // No MAS header: avoid triggering on ASM mixer path to prevent garbage.
                                                continue;
                                            }
                                        } else if (allocFallbackMas(s, sidx)) |mb2| {
                                            pcm = @as([*]const u8, mb2.data_ptr)[0..@as(usize, mb2.len_bytes)];
                                            loop_len_bytes = mb2.loop_len_bytes;
                                            have_mas = true;
                                        } else {
                                            continue;
                                        }
                                        const pan: u8 = panForChannel(self.module.channels, ch);
                                        const vol_scaled: u8 = @intCast(@min(@as(u16, self.channels[ch].volume) * 4, 255));
                                        if (have_mas) {
                                            const stepv = self.periodToAsmFreq(self.channels[ch].period, self.channels[ch].sample_index);
                                            const start_off = self.channels[ch].sample_offset_bytes;
                                            // Defensive normalize: MSB set => no loop
                                            if (loop_len_bytes == 0) loop_len_bytes = 0x8000_0000;
                                            // Apply consistent loop logic: only enable loop if length > 2 and start < total
                                            if (loop_len_bytes != 0x8000_0000 and loop_len_bytes <= 2) {
                                                loop_len_bytes = 0x8000_0000; // disable short loops
                                            }

                                            if (start_off != 0) {
                                                mixer.setChannelFromPcm8WithOffset(phys(ch), pcm, loop_len_bytes, vol_scaled, pan, stepv, start_off);
                                            } else {
                                                mixer.setChannelFromPcm8(phys(ch), pcm, loop_len_bytes, vol_scaled, pan, stepv);
                                            }
                                            self.channels[ch].sample_offset_bytes = 0;
                                        }
                                    }
                                }
                            }
                            self.channels[ch].delayed_note = 0;
                            self.channels[ch].delayed_sample = 0;
                            self.channels[ch].note_delay = 0;
                        }
                    },
                    0xE => { // EEx: Pattern delay (add x+1 extra row delays)
                        if (self.tick_in_row == 0) {
                            const x = ext_param & 0xF;
                            if (x != 0) self.patt_delay +%= x;
                        }
                    },
                    else => {},
                }
            }
            if (note.sample != 0) {
                const sidx: usize = (note.sample - 1);
                if (sidx < self.module.samples.len) {
                    const s = self.module.samples[sidx];
                    self.channels[ch].sample_index = note.sample;
                    self.channels[ch].volume = s.volume;
                    // Remember base period for arpeggio
                    if (note.period != 0) self.channels[ch].base_period = note.period;
                    // If tone-portamento (3xx) is active with a note, do not retrigger the sample.
                    if (note.effect == 0x03 and note.period != 0) {
                        const step_np = self.periodToAsmFreq(self.channels[ch].period, self.channels[ch].sample_index);
                        const pan_np: u8 = panForChannel(self.module.channels, ch);
                        const vol_np: u8 = @intCast(@min(@as(u16, self.channels[ch].volume) * 4, 255));
                        // Capture target period for tone portamento and do not retrigger
                        self.channels[ch].porta_target = note.period;
                        mixer.updateChannel(phys(ch), vol_np, pan_np, step_np);
                    } else {
                        // Normal note trigger
                        if (note.period != 0) {
                            var p: u16 = note.period;
                            if (p < 113) p = 113;
                            if (p > 856) p = 856;
                            self.channels[ch].period = p;
                        }
                        const step = self.periodToAsmFreq(self.channels[ch].period, self.channels[ch].sample_index);
                        var loop_len_bytes: u32 = @as(u32, s.repeat_len_words) * 2;
                        var pcm: []const u8 = s.pcm8;
                        var have_mas: bool = false;
                        const start_offset: u32 = self.channels[ch].sample_offset_bytes;
                        if (@hasDecl(@import("lib.zig"), "resolveGbsSample")) {
                            if (@import("lib.zig").resolveGbsSample(sidx)) |blk| {
                                pcm = blk.pcm;
                                loop_len_bytes = blk.loop_len_bytes;
                                have_mas = true;
                            } else if (allocFallbackMas(s, sidx)) |mb| {
                                pcm = @as([*]const u8, mb.data_ptr)[0..@as(usize, mb.len_bytes)];
                                loop_len_bytes = mb.loop_len_bytes;
                                have_mas = true;
                            }
                        } else if (allocFallbackMas(s, sidx)) |mb2| {
                            pcm = @as([*]const u8, mb2.data_ptr)[0..@as(usize, mb2.len_bytes)];
                            loop_len_bytes = mb2.loop_len_bytes;
                            have_mas = true;
                        }
                        // Pan default: classic layout (ch 0,3 left; ch 1,2 right)
                        const pan: u8 = panForChannel(self.module.channels, ch);
                        const vol_scaled: u8 = @intCast(@min(@as(u16, self.channels[ch].volume) * 4, 255));
                        if (have_mas) {
                            // Defensive normalize: MSB set => no loop (standardized contract)
                            if (loop_len_bytes == 0) loop_len_bytes = 0x8000_0000;
                            // Apply consistent loop logic: only enable loop if length > 2 and start < total
                            if (loop_len_bytes != 0x8000_0000 and loop_len_bytes <= 2) {
                                loop_len_bytes = 0x8000_0000; // disable short loops
                            }
                            // Debug for channel 3 (index 2)

                            if (start_offset != 0) {
                                mixer.setChannelFromPcm8WithOffset(phys(ch), pcm, loop_len_bytes, vol_scaled, pan, step, start_offset);
                            } else {
                                mixer.setChannelFromPcm8(phys(ch), pcm, loop_len_bytes, vol_scaled, pan, step);
                            }
                            self.channels[ch].sample_offset_bytes = 0;
                            new_instruments[ch] = true;
                        } else {
                            // No valid sample buffer with MAS header; skip to avoid noise
                        }
                    }
                } else {
                    // No sample available; keep channel disabled
                }
            } else if (note.period != 0) {
                // Change pitch without retrigger
                self.channels[ch].period = note.period;
                const step2 = self.periodToAsmFreq(self.channels[ch].period, self.channels[ch].sample_index);
                const pan2: u8 = panForChannel(self.module.channels, ch);
                const vol_scaled2: u8 = @intCast(@min(@as(u16, self.channels[ch].volume) * 4, 255));
                mixer.updateChannel(phys(ch), vol_scaled2, pan2, step2);
            }
        }
        // Apply Axy (vol slide) minimally as immediate per-row step (until proper per-tick)
        ch = 0;
        while (ch < self.module.channels) : (ch += 1) {
            const note = pat.getNote(self.row_index, ch);
            if (note.effect == 0x0A) {
                const up = (note.param >> 4) & 0xF;
                const down = note.param & 0xF;
                var v: i16 = self.channels[ch].volume;
                v = @intCast(@max(@min(@as(i16, v) + @as(i16, @intCast(up)) - @as(i16, @intCast(down)), 64), 0));
                self.channels[ch].volume = @intCast(v);
                const step = self.periodToAsmFreq(self.channels[ch].period, self.channels[ch].sample_index);
                const pan: u8 = panForChannel(self.module.channels, ch);
                const vol_scaled3: u8 = @intCast(@min(@as(u16, self.channels[ch].volume) * 4, 255));
                if (new_instruments[ch]) {
                    // already set via setChannelFromPcm8
                } else {
                    mixer.updateChannel(phys(ch), vol_scaled3, pan, step);
                }
            }
        }
    }
};
