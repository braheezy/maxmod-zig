const audio = @import("audio.zig");
const regs = @import("registers_gba.zig");

const Header = extern struct {
    magic: u32,
    version: u16,
    flags: u16,
    sample_rate_hz: u32,
    sample_count: u32,
    bits_per_sample: u8,
    channels: u8,
    reserved: u16,
};

const FLAGS_LOOPED: u16 = 1 << 0;

var loaded_data: [*]const u8 = undefined;
var loaded_size: usize = 0;
var hdr: Header = undefined;

// For minimal path: we pre-expand one 32-bit word that repeats to feed FIFO if we are silent
// Silence word kept for potential future CPU-fed mode (unused now)
var dma_silence_word: u32 = 0x00000000;

var playing: bool = false;
var looped: bool = false;
var bits16: bool = false;
var sample_words_total: u32 = 0;
var base_ptr: [*]const u8 = undefined;
var cur_ptr: [*]const u8 = undefined;
var words_remaining: u32 = 0;
var frame_index: u32 = 0;
var stream_from_rom: bool = false;

// Simple aligned PCM buffer in EWRAM for DMA-fed streaming
const MAX_PCM_BYTES: usize = 128 * 1024;
var pcm_buf: [MAX_PCM_BYTES]u8 align(4) = undefined;
var pcm_len: u32 = 0;
var sample_pos_frames: u32 = 0; // reserved
var frac_accum: u32 = 0; // reserved
const FADE_IN_SAMPLES: u16 = 128;
var fade_in_remaining: u16 = 0;
// VBlank countdown to stop DMA cleanly at (approximate) end-of-sample
var vblank_remaining: u32 = 0;

fn le16(p: [*]const u8) u16 {
    return @as(u16, p[0]) | (@as(u16, p[1]) << 8);
}
fn le32(p: [*]const u8) u32 {
    return @as(u32, p[0]) | (@as(u32, p[1]) << 8) | (@as(u32, p[2]) << 16) | (@as(u32, p[3]) << 24);
}

pub fn loadMmrawSlice(data: []const u8) !void {
    if (data.len < @sizeOf(Header)) return error.Invalid;
    // Read header safely from possibly unaligned memory
    const p: [*]const u8 = data.ptr;
    const h: Header = .{
        .magic = le32(p),
        .version = le16(p + 4),
        .flags = le16(p + 6),
        .sample_rate_hz = le32(p + 8),
        .sample_count = le32(p + 12),
        .bits_per_sample = (p + 16)[0],
        .channels = (p + 17)[0],
        .reserved = le16(p + 18),
    };
    hdr = h;
    if (hdr.magic != 0x5741524D) return error.BadMagic;
    if (hdr.version != 1) return error.BadVersion;
    if (hdr.channels != 1) return error.NotMono;
    if (!(hdr.bits_per_sample == 8 or hdr.bits_per_sample == 16)) return error.BadBps;

    loaded_data = p + @sizeOf(Header);
    loaded_size = data.len - @sizeOf(Header);
    looped = (hdr.flags & FLAGS_LOOPED) != 0;
    bits16 = hdr.bits_per_sample == 16;

    // DMA FIFO wants 32-bit words. Precompute total words.
    const total_bytes: u32 = if (bits16) hdr.sample_count * 2 else hdr.sample_count;
    sample_words_total = (total_bytes + 3) / 4;

    // Choose streaming strategy: large assets stream directly from ROM if 8-bit
    stream_from_rom = (!bits16) and (total_bytes > @as(u32, @intCast(MAX_PCM_BYTES)));

    // Align base pointer to 4-byte boundary for DMA; drop up to 3 leading bytes
    var data_ptr: [*]const u8 = loaded_data;
    const addr: usize = @intFromPtr(data_ptr);
    const mis: usize = addr & 3;
    if (mis != 0) {
        const skip: usize = 4 - mis;
        data_ptr += skip;
        if (!bits16) {
            if (hdr.sample_count > skip) {
                hdr.sample_count -= @intCast(skip);
            } else {
                hdr.sample_count = 0;
            }
        } else {
            // For 16-bit, ensure even alignment first; then skip whole frames
            const frame_skip: usize = (skip + 1) / 2;
            if (hdr.sample_count > frame_skip) {
                hdr.sample_count -= @intCast(frame_skip);
            } else {
                hdr.sample_count = 0;
            }
        }
    }
    base_ptr = data_ptr;
    cur_ptr = base_ptr;
    words_remaining = sample_words_total;
    sample_pos_frames = 0;
    pcm_len = if (!bits16) hdr.sample_count else hdr.sample_count * 1; // we downconvert to 8-bit when copying

    return;
}

// Unused in DMA-fed path
fn fillHalf(index: u8) void {
    _ = index;
}

pub fn play() void {
    // Configure Direct Sound A now (not during init) and pulse reset
    // Route outputs and master volumes
    regs.REG_SOUNDCNT_L.* = 0x077F;
    regs.REG_SOUNDCNT_H.* = regs.SOUNDCNT_H_DMG100 | regs.SOUNDCNT_H_FIFO_RESET_A;
    regs.REG_SOUNDCNT_H.* = regs.SOUNDCNT_H_DMG100 | regs.SOUNDCNT_H_DS_A_LR_TIMER0_100;
    // Configure Timer0 to sample rate
    const rate: u32 = if (hdr.sample_rate_hz != 0) hdr.sample_rate_hz else audio.mix_rate_hz;
    audio.setTimer0(rate);

    {
        // Stage into EWRAM for stable FIFO timing. Limit to a few seconds
        // to avoid large ROM streaming that can cause audible artifacts.
        // Allow up to 4 seconds or buffer size, whichever is smaller.
        const max_samples_by_time: u32 = 4 * rate;
        const max_samples: u32 = @min(hdr.sample_count, @min(@as(u32, @intCast(MAX_PCM_BYTES)), max_samples_by_time));
        var i: u32 = 0;
        while (i < max_samples) : (i += 1) {
            const v: u8 = if (!bits16) blk: {
                const u: u8 = base_ptr[@as(usize, @intCast(i))];
                const s: i8 = @as(i8, @intCast(@as(i16, u) - 128));
                break :blk @bitCast(s);
            } else blk: {
                const off: usize = @as(usize, @intCast(i)) * 2;
                const lo: u16 = base_ptr[off];
                const hi: u16 = base_ptr[off + 1];
                const u16v: u16 = (hi << 8) | lo;
                const s16: i16 = @bitCast(u16v ^ 0x8000);
                const s8: i8 = @intCast(@as(i32, s16) >> 8);
                break :blk @bitCast(s8);
            };
            pcm_buf[@as(usize, @intCast(i))] = v;
        }
        pcm_len = i;

        // Prime FIFO with a few words to avoid initial underflow
        const fifo_ptr: *volatile u32 = @ptrFromInt(regs.FIFO_A);
        var w: u32 = 0;
        while (w < 16) : (w += 1) {
            fifo_ptr.* = 0;
        }
        regs.REG_DMA1SAD.* = @as(u32, @intCast(@intFromPtr(&pcm_buf)));
        regs.REG_DMA1DAD.* = @as(u32, @intCast(regs.FIFO_A));
        regs.REG_DMA1CNT_L.* = 4;
        regs.REG_DMA1CNT_H.* = regs.DMA_ENABLE | regs.DMA_START_FIFO | regs.DMA_REPEAT | regs.DMA_32 | regs.DMA_SRC_INC | regs.DMA_DEST_FIXED;
    }
    playing = true;

    // Approximate stop time via VBlank countdown to avoid reading past buffer
    // Number of 8-bit samples we will play (either full stream or staged length)
    const play_samples: u32 = if (stream_from_rom and !bits16) hdr.sample_count else pcm_len;
    // frames = ceil(samples * 60 / rate)
    const num: u64 = @as(u64, play_samples) * 60 + (rate - 1);
    vblank_remaining = @as(u32, @intCast(num / rate));
}

pub fn stop() void {
    // Disable all DMA and DS A
    regs.REG_DMA0CNT_H.* &= ~regs.DMA_ENABLE;
    regs.REG_DMA1CNT_H.* &= ~regs.DMA_ENABLE;
    regs.REG_DMA2CNT_H.* &= ~regs.DMA_ENABLE;
    regs.REG_DMA3CNT_H.* &= ~regs.DMA_ENABLE;
    playing = false;
    // Reset DS A FIFO to ensure clean restart
    audio.pulseFifoResetA();
    // Stop Timer1 if it was running
    regs.REG_TM1CNT_H.* &= ~regs.TM_ENABLE;
}

pub fn frame() void {
    if (!playing) return;
    if (vblank_remaining > 0) {
        vblank_remaining -= 1;
        if (vblank_remaining == 0 and !looped) {
            stop();
        }
    }
}

// To be called from the system's DMA1 interrupt handler
export fn mmgba_frame_irq() void {
    // Not used in CPU-fed mode
}

// Timer1 IRQ: write next FIFO word (4 samples) paced precisely
export fn mmgba_timer1_irq() void {
    // Not used in DMA-fed mode
    // Acknowledge Timer1 (in case enabled elsewhere)
    regs.REG_IF.* = (1 << 4);
}
