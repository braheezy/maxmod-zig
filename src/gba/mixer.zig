const mm = @import("../maxmod.zig");
const mm_gba = @import("../gba/main_gba.zig");
const shim = @import("../shim.zig");
const gba = @import("gba");

// Debug configuration - can be toggled at build time
const debug_enabled = @import("build_options").xm_debug;
var set_debug_budget: u32 = 64;
const dbg_vblank = false;

pub export var mm_mix_channels: [*c]volatile mm.MixerChannel = @ptrFromInt(0);
pub export var mm_mixch_end: [*c]volatile mm.MixerChannel = @ptrFromInt(0);
pub export var mm_mixbuffer: mm.Addr = @import("std").mem.zeroes(mm.Addr);
pub export var mm_ratescale: mm.Word = 0;
pub export var mp_writepos: mm.Addr = @import("std").mem.zeroes(mm.Addr);

pub var vblank_handler_enabled: bool = false;
pub var mp_mix_seg: mm.Byte = 0;
pub var mm_bpmdv: mm.Word = 38144; // default divisor similar to mode 3;

var wavebuffer: mm.Addr = @import("std").mem.zeroes(mm.Addr);
var mixch_count: mm.Word = 0;
var timerfreq: mm.Word = 0;
var vblank_function: voidfunc = @import("std").mem.zeroes(voidfunc);
pub const voidfunc = ?*const fn () void;

const mp_mixing_lengths = struct {
    const static: [8]mm.Hword = [8]mm.Hword{ 136, 176, 224, 264, 304, 352, 448, 528 };
};
const mp_rate_scales = struct {
    const static: [8]mm.Hword = [8]mm.Hword{ 31812, 24576, 19310, 16384, 14228, 12288, 9655, 8192 };
};
const mp_timing_sheet = struct {
    const static: [8]mm.Hword = [8]mm.Hword{
        @as(mm.Hword, @bitCast(@as(i16, -2066))),
        @as(mm.Hword, @bitCast(@as(i16, -1596))),
        @as(mm.Hword, @bitCast(@as(i16, -1254))),
        @as(mm.Hword, @bitCast(@as(i16, -1064))),
        @as(mm.Hword, @bitCast(@as(i16, -924))),
        @as(mm.Hword, @bitCast(@as(i16, -798))),
        @as(mm.Hword, @bitCast(@as(i16, -627))),
        @as(mm.Hword, @bitCast(@as(i16, -532))),
    };
};
const mp_bpm_divisors = struct {
    const static: [8]mm.Word = [8]mm.Word{ 20302, 26280, 33447, 39420, 45393, 52560, 66895, 78840 };
};

const FIFO_A_ADDR = gba.mem.io + 0x00A0;
const fifo_a_ptr: *volatile u32 = @ptrFromInt(FIFO_A_ADDR);
const FIFO_B_ADDR = gba.mem.io + 0x00A4;
const fifo_b_ptr: *volatile u32 = @ptrFromInt(FIFO_B_ADDR);
const SOUNDCNT_H_ADDR = gba.mem.io + 0x0082;
const soundcnt_h_ptr: *volatile u16 = @ptrFromInt(SOUNDCNT_H_ADDR);
const SOUNDCNT_X_ADDR = gba.mem.io + 0x0084;
const soundcnt_x_ptr: *volatile u16 = @ptrFromInt(SOUNDCNT_X_ADDR);
const DMA1SAD_ADDR = gba.mem.io + 0x00BC;
const dma1sad_ptr: *volatile u32 = @ptrFromInt(DMA1SAD_ADDR);
const DMA1DAD_ADDR = gba.mem.io + 0x00C0;
const dma1dad_ptr: *volatile u32 = @ptrFromInt(DMA1DAD_ADDR);
const DMA1CNT_ADDR = gba.mem.io + 0x00C4;
const dma1cnt_ptr: *volatile u32 = @ptrFromInt(DMA1CNT_ADDR);
const DMA2SAD_ADDR = gba.mem.io + 0x00C8;
const dma2sad_ptr: *volatile u32 = @ptrFromInt(DMA2SAD_ADDR);
const DMA2DAD_ADDR = gba.mem.io + 0x00CC;
const dma2dad_ptr: *volatile u32 = @ptrFromInt(DMA2DAD_ADDR);
const DMA2CNT_ADDR = gba.mem.io + 0x00D0;
const dma2cnt_ptr: *volatile u32 = @ptrFromInt(DMA2CNT_ADDR);
const TM0CNT_ADDR = gba.mem.io + 0x0100;
const tm0cnt_ptr: *volatile u32 = @ptrFromInt(TM0CNT_ADDR);

// VBL wrapper, used to reset DMA. It needs the highest priority.
pub fn vBlank() linksection(".iwram") void {
    // Disable until ready
    if (vblank_handler_enabled) {
        // Swap mixing segment
        mp_mix_seg = @as(mm.Byte, @bitCast(@as(i8, @truncate(~@as(i32, mp_mix_seg)))));
        if (mp_mix_seg != 0) {
            // DMA control: Restart DMA
            // Disable DMA
            @as([*c]volatile u16, @ptrFromInt(0x40000C6)).* = 1088;
            @as([*c]volatile u16, @ptrFromInt(0x40000D2)).* = 1088;
            // Restart DMA
            @as([*c]volatile u16, @ptrFromInt(0x40000C6)).* = 46592;
            @as([*c]volatile u16, @ptrFromInt(0x40000D2)).* = 46592;
        } else {
            // Restart write position
            mp_writepos = wavebuffer;
        }
    }
    if (vblank_function != null) {
        // Call user handler
        vblank_function.?();
    }
}
pub fn setVBlankHandler(func: voidfunc) void {
    vblank_function = func;
}
pub fn getCount() mm.Word {
    return mixch_count;
}

///! Initialize mixer
pub fn init(setup: *mm_gba.GBASystem) void {
    mixch_count = setup.*.mix_channel_count;
    mm_mix_channels = @as([*c]volatile mm.MixerChannel, @ptrCast(@alignCast(setup.*.mixing_channels)));
    mm_mixch_end = &mm_mix_channels[mixch_count];
    mm_mixbuffer = setup.*.mixing_memory;
    wavebuffer = setup.*.wave_memory;
    mp_writepos = wavebuffer;
    const mode: mm.Word = @intFromEnum(setup.*.mixing_mode);
    mm_gba.mm_mixlen = @intCast(mp_mixing_lengths.static[mode]);
    mm_ratescale = @intCast(mp_rate_scales.static[mode]);
    timerfreq = @intCast(mp_timing_sheet.static[mode]);
    mm_bpmdv = mp_bpm_divisors.static[mode];

    if (debug_enabled) {
        shim.debug_state.mixlen = mm_gba.mm_mixlen;
        shim.debug_state.ratescale = mm_ratescale;
        shim.debug_state.timerfreq = timerfreq;
        shim.debug_state.bpmdv = mm_bpmdv;
    }
    // Reset mixing segment
    mp_mix_seg = 0;
    // Disable mixing channels
    const mix_ch: [*c]volatile mm.MixerChannel = &mm_mix_channels[0];
    var i: mm.Word = 0;
    while (i < mixch_count) : (i +%= 1) {
        mix_ch[i].src = shim.MIXCH_GBA_SRC_STOPPED;
    }
    // Enable VBL routine
    vblank_handler_enabled = true;
    // Clear FIFOs A/B
    fifo_a_ptr.* = 0; // REG_SGFIFOA
    fifo_b_ptr.* = 0; // REG_SGFIFOB
    // Reset and configure direct sound
    soundcnt_h_ptr.* = 0; // REG_SOUNDCNT_H = 0
    soundcnt_h_ptr.* = 0x9A0C; // DIRECT A/B, timer0, full vol
    // Ensure sound bias is enabled
    @as([*c]volatile u16, @ptrFromInt(0x04000088)).* = 0x0200;
    // Setup DMA source addresses (playback buffers)
    dma1sad_ptr.* = @intCast(@intFromPtr(wavebuffer.?));
    dma2sad_ptr.* = @intCast(@intFromPtr(wavebuffer.?) + mm_gba.mm_mixlen * 2);
    // Setup DMA destination (sound fifo)
    dma1dad_ptr.* = @intCast(@intFromPtr(fifo_a_ptr));
    dma2dad_ptr.* = @intCast(@intFromPtr(fifo_b_ptr));
    // Enable DMA [enable, fifo request, 32-bit, repeat]
    dma1cnt_ptr.* = 0xB6000000; // DMA1CNT
    dma2cnt_ptr.* = 0xB6000000; // DMA2CNT
    // Master sound enable (SOUNDCNT_X)
    soundcnt_x_ptr.* = 0x0080;
    // Enable sampling timer0 at mm_timerfreq
    tm0cnt_ptr.* = timerfreq | 128 << 16;
}
///! Set channel read position
pub fn mmMixerSetRead(channel: i32, value: mm.Word) void {
    (blk: {
        const tmp = channel;
        if (tmp >= 0) break :blk mm_mix_channels + @as(usize, @intCast(tmp)) else break :blk mm_mix_channels - ~@as(usize, @bitCast(@as(isize, @intCast(tmp)) +% -1));
    }).*.read = value;
}
pub fn mmMixerEnd() void {
    // Silence direct sound channels
    @as([*c]volatile u16, @ptrFromInt(67108994)).* = 0;
    // Disable VBL routine
    vblank_handler_enabled = false;
    // Disable DMA
    @as([*c]volatile u32, @ptrFromInt(67109060)).* = 0; // DMA1CNT
    @as([*c]volatile u32, @ptrFromInt(67109072)).* = 0; // DMA2CNT
    // Disable sampling timer
    @as([*c]volatile u32, @ptrFromInt(67109120)).* = 0; // TM0CNT
}
///! Set channel volume
pub fn setVolume(channel: i32, volume: mm.Word) void {
    (blk: {
        const tmp = channel;
        if (tmp >= 0) break :blk mm_mix_channels + @as(usize, @intCast(tmp)) else break :blk mm_mix_channels - ~@as(usize, @bitCast(@as(isize, @intCast(tmp)) +% -1));
    }).*.vol = @as(mm.Byte, @bitCast(@as(u8, @truncate(volume))));
}
///! Set channel panning
pub fn setPan(channel: i32, panning: mm.Byte) void {
    (blk: {
        const tmp = channel;
        if (tmp >= 0) break :blk mm_mix_channels + @as(usize, @intCast(tmp)) else break :blk mm_mix_channels - ~@as(usize, @bitCast(@as(isize, @intCast(tmp)) +% -1));
    }).*.pan = panning;
}
///! Scale mixing frequency
pub fn mulFreq(channel: i32, factor: mm.Word) void {
    var freq: mm.Word = (blk: {
        const tmp = channel;
        if (tmp >= 0) break :blk mm_mix_channels + @as(usize, @intCast(tmp)) else break :blk mm_mix_channels - ~@as(usize, @bitCast(@as(isize, @intCast(tmp)) +% -1));
    }).*.freq;
    freq = (freq *% factor) >> @intCast(10);
    (blk: {
        const tmp = channel;
        if (tmp >= 0) break :blk mm_mix_channels + @as(usize, @intCast(tmp)) else break :blk mm_mix_channels - ~@as(usize, @bitCast(@as(isize, @intCast(tmp)) +% -1));
    }).*.freq = freq;
}
///! Stop mixing channel
pub fn stopChannel(channel: i32) void {
    (blk: {
        const tmp = channel;
        if (tmp >= 0) break :blk mm_mix_channels + @as(usize, @intCast(tmp)) else break :blk mm_mix_channels - ~@as(usize, @bitCast(@as(isize, @intCast(tmp)) +% -1));
    }).*.src = shim.MIXCH_GBA_SRC_STOPPED;
}
pub fn setFreq(channel: i32, rate: mm.Word) void {
    (blk: {
        const tmp = channel;
        if (tmp >= 0) break :blk mm_mix_channels + @as(usize, @intCast(tmp)) else break :blk mm_mix_channels - ~@as(usize, @bitCast(@as(isize, @intCast(tmp)) +% -1));
    }).*.freq = rate << @intCast(2);
}
