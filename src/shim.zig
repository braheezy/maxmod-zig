const mixer = @import("gba/mixer.zig");
const mm = @import("maxmod.zig");
const mas = @import("core/mas.zig");
const mm_gba = @import("gba/main_gba.zig");

pub export var mm_ch_mask: u32 = 0;
pub export var mm_bpmdv: u32 = 38144; // default divisor similar to mode 3

extern fn memset(dst: [*]u8, c: c_int, n: usize) [*]u8;

// Very simple bump allocator for tiny needs (calloc/free minimal)
var heap: [4096]u8 = undefined;
var heap_off: usize = 0;

pub fn calloc(nmemb: usize, size: usize) callconv(.C) ?*anyopaque {
    const bytes = nmemb * size;
    if (heap_off + bytes > heap.len) return null;
    const ptr = &heap[heap_off];
    heap_off += bytes;
    _ = memset(@ptrCast(ptr), 0, bytes);
    return ptr;
}

pub export fn free(_: ?*anyopaque) callconv(.C) void {
    // no-op
}

pub export var mpp_vars: mas.mpv_active_information = .{ .reserved = 0, .pattread_p = @ptrFromInt(0), .afvol = 0, .sampoff = 0, .volplus = 0, .notedelay = 0, .panplus = 0, .reserved2 = 0 };

pub const LayerType = enum {
    main,
    jingle,
};
pub var mpp_clayer: LayerType = .main;
pub export var mm_schannels: [4]mm.ModuleChannel = .{ .{}, .{}, .{}, .{} };

pub export var mm_mix_channels: [*c]mm.MixerChannel = @ptrFromInt(0);

// Explicit setter so other modules set the same global symbol
pub fn mmShimSetChannelMask(mask: u32) callconv(.C) void {
    mm_ch_mask = mask;
}

// Missing symbols expected by translated core; provide minimal forwards/no-ops
extern fn mmUpdateChannel_TN(ch: [*c]mm.ModuleChannel, layer: [*c]mm.LayerInfo, channel_counter: mm.Byte) callconv(.C) void;

pub export fn mpp_Update_ACHN_notest(layer: [*c]mm.LayerInfo, act_ch: [*c]mm.ActiveChannel, period: mm.Word, ch: mm.Word) callconv(.c) mm.Word {
    // Match C ordering exactly:
    // 1) Envelopes -> updated period/afv/fade (instrument must be valid)
    // 2) Auto vibrato -> updated period (sample must be valid or skip)
    // 3) Update/bind mixer (on START)
    // 4) Set pitch + volume
    // 5) Disable/panning

    var new_period: mm.Word = period;
    new_period = mas.mpp_Update_ACHN_notest_envelopes(layer, act_ch, new_period);
    new_period = mas.mpp_Update_ACHN_notest_auto_vibrato(layer, act_ch, new_period);
    const mix_ch: [*c]mm.MixerChannel = mas.mpp_Update_ACHN_notest_update_mix(layer, act_ch, ch);
    const clipped_vol: mm.Word = mas.mpp_Update_ACHN_notest_set_pitch_volume(layer, act_ch, new_period, mix_ch);
    mas.mpp_Update_ACHN_notest_disable_and_panning(clipped_vol, act_ch, mix_ch);
    return new_period;
}

// Port of mpp_Update_ACHN_notest_disable_and_panning (GBA path)
pub export fn mpp_Update_ACHN_notest_disable_and_panning(volume: mm.Word, act_ch: [*c]mm.ActiveChannel, mix_ch: [*c]mm.MixerChannel) callconv(.c) void {
    // Stop if fully silent and envelopes ended with no key-on
    if (volume == 0) {
        const env_end = (@as(c_int, @intCast(act_ch.*.flags)) & mas.MCAF_ENVEND) != 0;
        const key_on = (@as(c_int, @intCast(act_ch.*.flags)) & mas.MCAF_KEYON) != 0;
        if (env_end and !key_on) {
            mix_ch.*.src = mas.MIXCH_GBA_SRC_STOPPED;
            if (act_ch.*._type == mas.ACHN_FOREGROUND) {
                // free parent channel
                const parent_idx: usize = @intCast(act_ch.*.parent);
                const parent: [*c]mm.ModuleChannel = @ptrFromInt(@intFromPtr(mm_gba.mpp_channels) + parent_idx * @sizeOf(mm.ModuleChannel));
                parent.*.alloc = mas.NO_CHANNEL_AVAILABLE;
            }
            act_ch.*._type = mas.ACHN_DISABLED;
            return;
        }
    }

    // Audible path: set volume and pan, keep playing
    const vol8: u8 = @intCast(if (volume > 255) 255 else volume);
    mix_ch.*.vol = vol8;
    // If channel had stopped, disable foreground
    if ((mix_ch.*.src & mas.MIXCH_GBA_SRC_STOPPED) != 0) {
        if (act_ch.*._type == mas.ACHN_FOREGROUND) {
            const parent_idx2: usize = @intCast(act_ch.*.parent);
            const parent2: [*c]mm.ModuleChannel = @ptrFromInt(@intFromPtr(mm_gba.mpp_channels) + parent_idx2 * @sizeOf(mm.ModuleChannel));
            parent2.*.alloc = mas.NO_CHANNEL_AVAILABLE;
            act_ch.*._type = mas.ACHN_DISABLED;
            return;
        }
    }
    // Panning
    const pan: u8 = if (act_ch.*.panning != 0) act_ch.*.panning else 128;
    mix_ch.*.pan = pan;
}

// Zig implementation of mpp_Update_ACHN_notest_update_mix from C (GBA path)
pub export fn mpp_Update_ACHN_notest_update_mix(layer: [*c]mm.LayerInfo, act_ch: [*c]mm.ActiveChannel, channel: mm.Word) callconv(.c) [*c]mm.MixerChannel {
    const mix_ch: [*c]mm.MixerChannel = &mm_mix_channels[@as(usize, @intCast(channel))];

    // Only (re)bind on start, never reset read on subsequent ticks
    if (((@as(c_int, @intCast(act_ch.*.flags)) & mas.MCAF_START) == 0)) {
        return mix_ch;
    }

    // Clear start flag
    act_ch.*.flags = @as(mm.Byte, @intCast(@as(c_int, @intCast(act_ch.*.flags)) & ~mas.MCAF_START));

    // Validate sample
    if (act_ch.*.sample == 0) return mix_ch;

    const sample: [*c]mas.mm_mas_sample_info = mas.mpp_SamplePointer(layer, @as(mm.Word, @intCast(act_ch.*.sample)));
    // Bind from the sample's platform header regardless of MSL; the MAS writer
    // ensures data() points at the correct header for GBA.
    const gba_sample: *mas.mm_mas_gba_sample = @ptrCast(@alignCast(sample.*.data()));
    mix_ch.*.src = @intFromPtr(gba_sample.data());
    // Optional: uncomment for verbose bind logs
    // gba.debug.print("[BIND] ch={d} id={d} src={x} def_freq={d} len={d}\n", .{ channel, sample.*.msl_id, mix_ch.*.src, gba_sample.default_frequency, gba_sample.length }) catch unreachable;

    // Initialize read position from sampoff (done only at start)
    mix_ch.*.read = @as(mm.Word, @intCast(@as(u32, mas.mpp_vars.sampoff))) << (mas.MP_SAMPFRAC + 8);

    return mix_ch;
}
