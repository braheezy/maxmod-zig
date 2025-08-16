const regs = @import("registers_gba.zig");
const audio = @import("audio.zig");

pub const MixChannel = extern struct {
    src: u32, // address of sample->data[0]
    read: u32, // 20.12 fixed-point position
    vol: u8,
    pan: u8,
    _unused0: u8,
    _unused1: u8,
    freq: u32, // mixer pitch step, scaled by mm_ratescale in ASM
};

// Exposed globals expected by mixer_asm.s
pub export var mm_mixbuffer: u32 = 0;
pub export var mm_mix_channels: u32 = 0;
pub export var mm_mixlen: u32 = 0;
pub export var mm_ratescale: u32 = 0;
pub export var mp_writepos: u32 = 0;
pub export var mm_mixch_end: u32 = 0;
var s_mix_rate_hz: u32 = 0;

// Local storage backing the exported pointers
var s_mix_channels: [8]MixChannel align(4) = [_]MixChannel{.{ .src = 1 << 31, .read = 0, .vol = 0, .pan = 128, ._unused0 = 0, ._unused1 = 0, .freq = 0 }} ** 8;
var s_mix_buffer: [4096]u8 align(4) = undefined; // intermediate 11-bit mix buffer (overprovisioned)
var s_wave_buffer: [4096]u8 align(4) = undefined; // interleaved output: left then right half
// Side arrays to hold sample metadata per channel (avoid relying on header before src)
var s_len_bytes: [8]u32 = [_]u32{0} ** 8;
var s_loop_bytes: [8]u32 = [_]u32{0} ** 8; // MSB set => no loop
var s_mp_mix_seg: u8 = 0;

// Optional external ASM mixer (from mixer_asm.o)
extern fn mmMixerMix(samples_count: u32) callconv(.C) void;

// Software mixer in Zig to replace GAS ASM path when ASM is disabled.
// Mixes into `s_wave_buffer` interleaved halves (left block, then right block),
// updating `mp_writepos` as the current left write position.
fn zig_mmMixerMix(samples_count: u32) callconv(.C) void {
    if (samples_count == 0) return;

    // Resolve pointers/values from exported globals
    // const rate_scale: u32 = mm_ratescale; // unused in Zig mixer; freq is already 20.12 step

    const channels_ptr: [*]MixChannel = @ptrFromInt(mm_mix_channels);
    const channels_end: [*]MixChannel = @ptrFromInt(mm_mixch_end);

    const base_wave_addr: usize = @intFromPtr(&s_wave_buffer);
    const half_bytes: usize = @as(usize, mm_mixlen) * 2;
    const left_base: usize = base_wave_addr;
    const left_end: usize = left_base + half_bytes;
    const right_base: usize = left_end;
    const right_end: usize = right_base + half_bytes;

    var left_write_addr: usize = @intCast(mp_writepos);
    if (left_write_addr < left_base or left_write_addr >= left_end) {
        left_write_addr = left_base; // sanitize
    }
    var right_write_addr: usize = right_base + (left_write_addr - left_base);

    // Precompute channel parameters
    const max_channels: usize = (@intFromPtr(channels_end) - @intFromPtr(channels_ptr)) / @sizeOf(MixChannel);
    var step_fixed: [16]u32 = [_]u32{0} ** 16; // supports up to 16 channels
    var src_addr_list: [16]u32 = [_]u32{0} ** 16;
    var read_pos_list: [16]u32 = [_]u32{0} ** 16;
    var vol_l_list: [16]u16 = [_]u16{0} ** 16;
    var vol_r_list: [16]u16 = [_]u16{0} ** 16;
    var len_list: [16]u32 = [_]u32{0} ** 16;
    var loop_list: [16]u32 = [_]u32{0} ** 16;
    var chan_index_list: [16]u8 = [_]u8{0} ** 16;

    var active_count: usize = 0;
    var ch_index: usize = 0;
    while (ch_index < max_channels and active_count < step_fixed.len) : (ch_index += 1) {
        const ch: *MixChannel = &channels_ptr[ch_index];
        const src_addr = ch.src;
        // MSB set => disabled
        if ((src_addr & 0x8000_0000) != 0) continue;
        if (ch.freq == 0) continue;

        // Use frequency field as precomputed 20.12 step directly
        const step: u32 = ch.freq;

        // Volumes
        const vol: u32 = ch.vol;
        const pan: u32 = ch.pan; // 0..255
        const left_mul: u32 = (256 - pan) * vol; // 0..(256*255)
        const right_mul: u32 = pan * vol;

        // Read sample metadata from side arrays (indexed by channel index)
        const len_bytes: u32 = s_len_bytes[ch_index];
        const loop_val: u32 = s_loop_bytes[ch_index];

        step_fixed[active_count] = step;
        src_addr_list[active_count] = src_addr;
        read_pos_list[active_count] = ch.read;
        vol_l_list[active_count] = @intCast(left_mul >> 8);
        vol_r_list[active_count] = @intCast(right_mul >> 8);
        len_list[active_count] = len_bytes;
        loop_list[active_count] = loop_val;
        chan_index_list[active_count] = @intCast(ch_index);
        active_count += 1;
    }

    // Mix and pack two 8-bit samples per 16-bit halfword like Maxmod post-processing
    // Calculate volume accumulators like the ASM code
    var vol_accum: u32 = 0;
    for (0..active_count) |k| {
        const vl: u32 = vol_l_list[k];
        const vr: u32 = vol_r_list[k];
        vol_accum += vl;
        vol_accum += vr << 16;
    }
    const prvolL: i32 = (@as(i32, @intCast(vol_accum & 0xFFFF)) >> 1) << 3;
    const prvolR: i32 = (@as(i32, @intCast(vol_accum >> 16)) >> 1) << 3;
    var n: u32 = 0;
    while (n < samples_count) : (n += 2) {
        var acc_l0: i32 = 0;
        var acc_r0: i32 = 0;
        var acc_l1: i32 = 0;
        var acc_r1: i32 = 0;

        var k: usize = 0;
        while (k < active_count) : (k += 1) {
            var read_pos = read_pos_list[k];
            const src_addr = src_addr_list[k];
            const len_bytes = len_list[k];
            const loop_val = loop_list[k];

            // sample 0
            var idx0: u32 = read_pos >> 12;
            if (idx0 >= len_bytes) {
                if ((loop_val & 0x8000_0000) != 0) {
                    const ch_ptr = &channels_ptr[chan_index_list[k]];
                    ch_ptr.src = 1 << 31;
                    continue;
                } else {
                    const over: u32 = idx0 - len_bytes;
                    const loop_len = if (loop_val == 0) 1 else loop_val;
                    const over_mod: u32 = over % loop_len;
                    const new_idx: u32 = len_bytes - loop_len + over_mod;
                    const frac: u32 = read_pos & 0xFFF;
                    read_pos = (new_idx << 12) | frac;
                    idx0 = new_idx;
                }
            }
            const s0: i32 = blk: {
                const p: [*]const u8 = @ptrFromInt(src_addr + idx0);
                break :blk @as(i32, @intCast(@as(i8, @bitCast(p[0]))));
            };
            read_pos += step_fixed[k];

            // sample 1 (next time step)
            var idx1: u32 = read_pos >> 12;
            if (idx1 >= len_bytes) {
                if ((loop_val & 0x8000_0000) != 0) {
                    const ch_ptr = &channels_ptr[chan_index_list[k]];
                    ch_ptr.src = 1 << 31;
                    continue;
                } else {
                    const over2: u32 = idx1 - len_bytes;
                    const loop_len2 = if (loop_val == 0) 1 else loop_val;
                    const over_mod2: u32 = over2 % loop_len2;
                    const new_idx2: u32 = len_bytes - loop_len2 + over_mod2;
                    const frac2: u32 = read_pos & 0xFFF;
                    read_pos = (new_idx2 << 12) | frac2;
                    idx1 = new_idx2;
                }
            }
            const s1: i32 = blk: {
                const p: [*]const u8 = @ptrFromInt(src_addr + idx1);
                break :blk @as(i32, @intCast(@as(i8, @bitCast(p[0]))));
            };
            read_pos += step_fixed[k];
            read_pos_list[k] = read_pos;

            const vl: i32 = @intCast(vol_l_list[k]);
            const vr: i32 = @intCast(vol_r_list[k]);
            acc_l0 += (s0 * vl) >> 5;
            acc_r0 += (s0 * vr) >> 5;
            acc_l1 += (s1 * vl) >> 5;
            acc_r1 += (s1 * vr) >> 5;
        }

        // Convert to signed and clamp like the ASM code
        // Left channel
        var l0: i32 = acc_l0 - prvolL;
        l0 = (l0 << 16) >> (16 + 3); // mask low hword with sign extension and convert 11-bit to 8-bit
        if (l0 < -128) l0 = -128;
        if (l0 > 127) l0 = 127;

        var l1: i32 = acc_l1 - prvolL;
        l1 = (l1 << 16) >> (16 + 3);
        if (l1 < -128) l1 = -128;
        if (l1 > 127) l1 = 127;

        // Right channel
        var r0: i32 = acc_r0 - prvolR;
        r0 = (r0 << 16) >> (16 + 3);
        if (r0 < -128) r0 = -128;
        if (r0 > 127) r0 = 127;

        var r1: i32 = acc_r1 - prvolR;
        r1 = (r1 << 16) >> (16 + 3);
        if (r1 < -128) r1 = -128;
        if (r1 > 127) r1 = 127;

        // Pack samples into 16-bit halfwords
        const l0_u8: u8 = @bitCast(@as(i8, @intCast(l0)));
        const l1_u8: u8 = @bitCast(@as(i8, @intCast(l1)));
        const r0_u8: u8 = @bitCast(@as(i8, @intCast(r0)));
        const r1_u8: u8 = @bitCast(@as(i8, @intCast(r1)));
        const lw: u16 = @as(u16, l0_u8) | (@as(u16, l1_u8) << 8);
        const rw: u16 = @as(u16, r0_u8) | (@as(u16, r1_u8) << 8);
        const lhw: *u16 = @ptrFromInt(left_write_addr);
        const rhw: *u16 = @ptrFromInt(right_write_addr);
        lhw.* = lw;
        rhw.* = rw;

        left_write_addr += 2;
        right_write_addr += 2;
        if (left_write_addr >= left_end) left_write_addr = left_base;
        if (right_write_addr >= right_end) right_write_addr = right_base;
    }

    // Write back read positions mapped to their actual mixer channel indices
    var a: usize = 0;
    while (a < active_count) : (a += 1) {
        const ch_idx: usize = chan_index_list[a];
        channels_ptr[ch_idx].read = read_pos_list[a];
    }

    // Update mp_writepos (left block pointer)
    mp_writepos = @intCast(left_write_addr);
}

fn setExports(mode_index: u32) void {
    // Tables from mixer.c (mode 0..7)
    const mp_mixing_lengths = [_]u16{ 136, 176, 224, 264, 304, 352, 448, 528 };
    const mp_rate_scales = [_]u16{ 31812, 24576, 19310, 16384, 14228, 12288, 9655, 8192 };

    const mixlen: u32 = mp_mixing_lengths[mode_index];
    const rate_scale: u32 = mp_rate_scales[mode_index];

    mm_mixlen = mixlen;
    mm_ratescale = rate_scale;

    // Export pointers
    mm_mixbuffer = @intFromPtr(&s_mix_buffer);
    mm_mix_channels = @intFromPtr(&s_mix_channels);
    const end_ptr: [*]MixChannel = @ptrFromInt(@intFromPtr(&s_mix_channels) + s_mix_channels.len * @sizeOf(MixChannel));
    mm_mixch_end = @intFromPtr(end_ptr);
    mp_writepos = @intFromPtr(&s_wave_buffer);
}

pub fn init(mode_index: u32) void {
    // Stop any existing DMA
    audio.silenceAllDma();

    setExports(mode_index);

    // Configure sound and DMA similar to C mmMixerInit
    regs.REG_SOUNDCNT_X.* = regs.SOUNDCNT_X_ENABLE;
    regs.REG_SNDBIAS.* = 0x0200;

    // Reset direct sound
    regs.REG_SOUNDCNT_H.* = 0;
    // DIRECT SOUND A/B reset pulse and setup: A=left, B=right, Timer0, 100%
    regs.REG_SOUNDCNT_H.* = 0x9A0C;

    // Setup DMA sources (left/right halves) - keep sources fixed at start
    const base = @as(u32, @intCast(@intFromPtr(&s_wave_buffer)));
    regs.REG_DMA1SAD.* = base;
    regs.REG_DMA2SAD.* = base + mm_mixlen * 2;

    regs.REG_DMA1DAD.* = @as(u32, @intCast(regs.FIFO_A));
    regs.REG_DMA2DAD.* = @as(u32, @intCast(regs.FIFO_A + 0x4)); // FIFO_B = FIFO_A + 4

    // Enable DMA [enable, fifo request, 32-bit, repeat]
    regs.REG_DMA1CNT.* = 0xB6000000;
    regs.REG_DMA2CNT.* = 0xB6000000;

    // Timer0 to 16kHz if mode_index=3
    const mix_rates = [_]u32{ 8000, 10512, 13379, 15768, 18157, 21024, 26758, 31536 };
    s_mix_rate_hz = mix_rates[mode_index];
    audio.setTimer0(s_mix_rate_hz);
}

pub fn onVBlank() void {
    // Swap mixing segment and restart DMA periodically to keep sources aligned
    s_mp_mix_seg = ~s_mp_mix_seg;
    if (s_mp_mix_seg != 0) {
        // Disable DMA
        regs.REG_DMA1CNT_H.* &= ~regs.DMA_ENABLE;
        regs.REG_DMA2CNT_H.* &= ~regs.DMA_ENABLE;
        // Restart DMA
        regs.REG_DMA1CNT_H.* = regs.DMA_ENABLE | regs.DMA_START_FIFO | regs.DMA_REPEAT | regs.DMA_32 | regs.DMA_SRC_INC | regs.DMA_DEST_FIXED;
        regs.REG_DMA2CNT_H.* = regs.DMA_ENABLE | regs.DMA_START_FIFO | regs.DMA_REPEAT | regs.DMA_32 | regs.DMA_SRC_INC | regs.DMA_DEST_FIXED;
    } else {
        // Reset write position to start of wave buffer
        mp_writepos = @intFromPtr(&s_wave_buffer);
    }
}

pub fn getMixLen() u32 {
    return mm_mixlen;
}
pub fn getMixRate() u32 {
    return s_mix_rate_hz;
}

pub fn setChannelFromPcm8(channel_index: usize, pcm: []const u8, loop_len: u32, vol: u8, pan: u8, step_fixed_20_12: u32) void {
    if (channel_index >= s_mix_channels.len) return;
    const data_addr: u32 = @intCast(@intFromPtr(pcm.ptr));
    s_mix_channels[channel_index] = .{
        .src = data_addr,
        .read = 0,
        .vol = vol,
        .pan = pan,
        ._unused0 = 0,
        ._unused1 = 0,
        .freq = step_fixed_20_12,
    };
    s_len_bytes[channel_index] = @intCast(pcm.len);
    s_loop_bytes[channel_index] = if (loop_len == 0) 0x8000_0000 else loop_len;
}

pub fn updateChannel(channel_index: usize, vol: u8, pan: u8, step_fixed_20_12: u32) void {
    if (channel_index >= s_mix_channels.len) return;
    s_mix_channels[channel_index].vol = vol;
    s_mix_channels[channel_index].pan = pan;
    s_mix_channels[channel_index].freq = step_fixed_20_12;
}

pub fn mixOneSegment() void {
    // Generate next segment of length mm_mixlen
    const n: u32 = mm_mixlen;
    const use_asm = blk: {
        if (@hasDecl(@import("lib_options"), "use_asm_mixer")) {
            break :blk @import("lib_options").use_asm_mixer;
        } else break :blk false;
    };
    if (use_asm) {
        mmMixerMix(n);
    } else {
        zig_mmMixerMix(n);
    }
    // Notify player state about tick timing if present
    if (@hasDecl(@import("player_mod.zig"), "ModPlayer")) {
        // Try to call into player to advance tick accounting
        // This is a loose coupling; player may not be loaded
        // (No-op here; player will call on its own path)
    }
}
