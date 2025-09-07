const mm = @import("../maxmod.zig");
const mm_gba = @import("../gba/main_gba.zig");
const shim = @import("../shim.zig");

// Debug configuration - can be toggled at build time
const debug_enabled = @import("build_options").xm_debug;
// Debug printing helper that can be compiled out
inline fn debugPrint(comptime fmt: []const u8, args: anytype) void {
    if (debug_enabled) {
        @import("gba").debug.print(fmt, args) catch {};
    }
}
var set_debug_budget: u32 = 64;
const dbg_vblank = false;

pub export var mm_mix_channels: [*c]mm.MixerChannel = @ptrFromInt(0);
pub export var mm_mixch_end: [*c]mm.MixerChannel = @import("std").mem.zeroes([*c]mm.MixerChannel);
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

pub fn vBlank() linksection(".iwram") void {
    if (dbg_vblank) debugPrint("[mmVBlank] enter: {any}\n", .{vblank_handler_enabled});
    if (vblank_handler_enabled) {
        mp_mix_seg = @as(mm.Byte, @bitCast(@as(i8, @truncate(~@as(c_int, @bitCast(@as(c_uint, mp_mix_seg)))))));
        if (@as(c_int, @bitCast(@as(c_uint, mp_mix_seg))) != @as(c_int, 0)) {
            @as([*c]volatile u16, @ptrFromInt(@as(c_int, 67109062))).* = @as(u16, @bitCast(@as(c_short, @truncate(@as(c_int, 1088)))));
            @as([*c]volatile u16, @ptrFromInt(@as(c_int, 67109074))).* = @as(u16, @bitCast(@as(c_short, @truncate(@as(c_int, 1088)))));
            @as([*c]volatile u16, @ptrFromInt(@as(c_int, 67109062))).* = @as(u16, @bitCast(@as(c_short, @truncate(@as(c_int, 46592)))));
            @as([*c]volatile u16, @ptrFromInt(@as(c_int, 67109074))).* = @as(u16, @bitCast(@as(c_short, @truncate(@as(c_int, 46592)))));
        } else {
            mp_writepos = wavebuffer;
        }
    }
    if (vblank_function != @as(voidfunc, @ptrCast(@alignCast(@as(?*anyopaque, @ptrFromInt(0)))))) {
        vblank_function.?();
    }
    debugPrint("[mmVBlank] exit\n", .{});
}
pub fn setVBlankHandler(func: voidfunc) void {
    vblank_function = func;
}
pub fn init(setup: *mm_gba.GBASystem) void {
    mixch_count = setup.*.mix_channel_count;
    mm_mix_channels = @as([*c]mm.MixerChannel, @ptrCast(@alignCast(setup.*.mixing_channels)));
    mm_mixch_end = &mm_mix_channels[mixch_count];
    mm_mixbuffer = setup.*.mixing_memory;
    wavebuffer = setup.*.wave_memory;
    mp_writepos = wavebuffer;
    const mode: mm.Word = @as(mm.Word, @intFromEnum(setup.*.mixing_mode));
    const mp_mixing_lengths = struct {
        const static: [8]mm.Hword = [8]mm.Hword{ 136, 176, 224, 264, 304, 352, 448, 528 };
    };
    mm_gba.mm_mixlen = @as(mm.Word, @bitCast(@as(c_uint, mp_mixing_lengths.static[mode])));
    const mp_rate_scales = struct {
        const static: [8]mm.Hword = [8]mm.Hword{ 31812, 24576, 19310, 16384, 14228, 12288, 9655, 8192 };
    };
    mm_ratescale = @as(mm.Word, @bitCast(@as(c_uint, mp_rate_scales.static[mode])));
    const mp_timing_sheet = struct {
        const static: [8]mm.Hword = [8]mm.Hword{
            @as(mm.Hword, @bitCast(@as(c_short, @truncate(-@as(c_int, 2066))))),
            @as(mm.Hword, @bitCast(@as(c_short, @truncate(-@as(c_int, 1596))))),
            @as(mm.Hword, @bitCast(@as(c_short, @truncate(-@as(c_int, 1254))))),
            @as(mm.Hword, @bitCast(@as(c_short, @truncate(-@as(c_int, 1064))))),
            @as(mm.Hword, @bitCast(@as(c_short, @truncate(-@as(c_int, 924))))),
            @as(mm.Hword, @bitCast(@as(c_short, @truncate(-@as(c_int, 798))))),
            @as(mm.Hword, @bitCast(@as(c_short, @truncate(-@as(c_int, 627))))),
            @as(mm.Hword, @bitCast(@as(c_short, @truncate(-@as(c_int, 532))))),
        };
    };
    timerfreq = @as(mm.Word, @bitCast(@as(c_uint, mp_timing_sheet.static[mode])));
    const mp_bpm_divisors = struct {
        const static: [8]mm.Word = [8]mm.Word{ 20302, 26280, 33447, 39420, 45393, 52560, 66895, 78840 };
    };
    mm_bpmdv = mp_bpm_divisors.static[mode];
    mp_mix_seg = 0;
    const mix_ch: [*c]mm.MixerChannel = &mm_mix_channels[0];
    {
        var i: mm.Word = 0;
        while (i < mixch_count) : (i +%= 1) {
            mix_ch[i].src = shim.MIXCH_GBA_SRC_STOPPED;
        }
    }
    vblank_handler_enabled = true;
    // Clear FIFOs A/B
    @as([*c]volatile u32, @ptrFromInt(@as(c_int, 0x040000A0))).* = 0; // REG_SGFIFOA
    @as([*c]volatile u32, @ptrFromInt(@as(c_int, 0x040000A4))).* = 0; // REG_SGFIFOB
    // Reset and configure direct sound
    @as([*c]volatile u16, @ptrFromInt(@as(c_int, 0x04000082))).* = 0; // REG_SOUNDCNT_H = 0
    @as([*c]volatile u16, @ptrFromInt(@as(c_int, 0x04000082))).* = 0x9A0C; // DIRECT A/B, timer0, full vol
    // Setup DMA sources (wavebuffer halves)
    @as([*c]volatile u32, @ptrFromInt(@as(c_int, 0x040000BC))).* = @as(mm.Word, @intCast(@intFromPtr(wavebuffer))); // DMA1SAD
    @as([*c]volatile u32, @ptrFromInt(@as(c_int, 0x040000C0))).* = @as(mm.Word, @intCast(@intFromPtr(@as([*c]volatile u32, @ptrFromInt(@as(c_int, 0x040000A0)))))); // DMA1DAD -> FIFO A
    @as([*c]volatile u32, @ptrFromInt(@as(c_int, 0x040000C4))).* = 0xB6000000; // DMA1CNT
    @as([*c]volatile u32, @ptrFromInt(@as(c_int, 0x040000C8))).* = @as(mm.Word, @intCast(@intFromPtr(wavebuffer))) +% (mm_gba.mm_mixlen *% 2); // DMA2SAD
    @as([*c]volatile u32, @ptrFromInt(@as(c_int, 0x040000CC))).* = @as(mm.Word, @intCast(@intFromPtr(@as([*c]volatile u32, @ptrFromInt(@as(c_int, 0x040000A4)))))); // DMA2DAD -> FIFO B
    @as([*c]volatile u32, @ptrFromInt(@as(c_int, 0x040000D0))).* = 0xB6000000; // DMA2CNT
    // Master sound enable (SOUNDCNT_X)
    @as([*c]volatile u16, @ptrFromInt(@as(c_int, 0x04000084))).* = 0x0080;
    // Enable sampling timer0 at mm_timerfreq
    @as([*c]volatile u32, @ptrFromInt(@as(c_int, 0x04000100))).* = timerfreq | @as(mm.Word, @bitCast(@as(c_int, 128) << @intCast(16)));
}
// Expose the current mixer channel pointer so other modules can unify usage
pub fn mm_get_mix_channels_ptr() [*c]mm.MixerChannel {
    return mm_mix_channels;
}
pub fn mmMixerSetRead(channel: c_int, value: mm.Word) void {
    (blk: {
        const tmp = channel;
        if (tmp >= 0) break :blk mm_mix_channels + @as(usize, @intCast(tmp)) else break :blk mm_mix_channels - ~@as(usize, @bitCast(@as(isize, @intCast(tmp)) +% -1));
    }).*.read = value;
    if ((channel == 0 or channel == 1 or channel == 9) and set_debug_budget > 0) {
        debugPrint("[SETREAD] ch={d} v={d}\n", .{ channel, value });
        set_debug_budget -= 1;
    }
}
pub fn mmMixerEnd() void {
    @as([*c]volatile u16, @ptrFromInt(67108994)).* = 0;
    vblank_handler_enabled = false;
    @as([*c]volatile u32, @ptrFromInt(67109060)).* = 0;
    @as([*c]volatile u32, @ptrFromInt(67109072)).* = 0;
    @as([*c]volatile u32, @ptrFromInt(67109120)).* = 0;
}
pub fn setVolume(channel: c_int, volume: mm.Word) void {
    (blk: {
        const tmp = channel;
        if (tmp >= 0) break :blk mm_mix_channels + @as(usize, @intCast(tmp)) else break :blk mm_mix_channels - ~@as(usize, @bitCast(@as(isize, @intCast(tmp)) +% -1));
    }).*.vol = @as(mm.Byte, @bitCast(@as(u8, @truncate(volume))));
    if ((channel == 0 or channel == 1 or channel == 9) and set_debug_budget > 0) {
        @import("gba").debug.print("[SETVOL] ch={d} v={d}\n", .{ channel, volume }) catch {};
        set_debug_budget -= 1;
    }
}
pub fn setPan(channel: c_int, panning: mm.Byte) void {
    (blk: {
        const tmp = channel;
        if (tmp >= 0) break :blk mm_mix_channels + @as(usize, @intCast(tmp)) else break :blk mm_mix_channels - ~@as(usize, @bitCast(@as(isize, @intCast(tmp)) +% -1));
    }).*.pan = panning;
    if ((channel == 0 or channel == 1 or channel == 9) and set_debug_budget > 0) {
        debugPrint("[SETPAN] ch={d} v={d}\n", .{ channel, panning });
        set_debug_budget -= 1;
    }
}
pub fn mulFreq(channel: c_int, factor: mm.Word) void {
    var freq: mm.Word = (blk: {
        const tmp = channel;
        if (tmp >= 0) break :blk mm_mix_channels + @as(usize, @intCast(tmp)) else break :blk mm_mix_channels - ~@as(usize, @bitCast(@as(isize, @intCast(tmp)) +% -1));
    }).*.freq;
    freq = (freq *% factor) >> @intCast(10);
    (blk: {
        const tmp = channel;
        if (tmp >= 0) break :blk mm_mix_channels + @as(usize, @intCast(tmp)) else break :blk mm_mix_channels - ~@as(usize, @bitCast(@as(isize, @intCast(tmp)) +% -1));
    }).*.freq = freq;
    if ((channel == 0 or channel == 1 or channel == 9) and set_debug_budget > 0) {
        debugPrint("[MULFREQ] ch={d} v={d}\n", .{ channel, freq });
        set_debug_budget -= 1;
    }
}
pub fn stopChannel(channel: c_int) void {
    (blk: {
        const tmp = channel;
        if (tmp >= 0) break :blk mm_mix_channels + @as(usize, @intCast(tmp)) else break :blk mm_mix_channels - ~@as(usize, @bitCast(@as(isize, @intCast(tmp)) +% -1));
    }).*.src = shim.MIXCH_GBA_SRC_STOPPED;
}
pub fn setFreq(channel: c_int, rate: mm.Word) void {
    (blk: {
        const tmp = channel;
        if (tmp >= 0) break :blk mm_mix_channels + @as(usize, @intCast(tmp)) else break :blk mm_mix_channels - ~@as(usize, @bitCast(@as(isize, @intCast(tmp)) +% -1));
    }).*.freq = rate << @intCast(2);
    if ((channel == 0 or channel == 1 or channel == 9) and set_debug_budget > 0) {
        debugPrint("[SETFREQ] ch={d} v={d}\n", .{ channel, rate << 2 });
        set_debug_budget -= 1;
    }
}
