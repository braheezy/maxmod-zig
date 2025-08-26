pub export var mm_ch_mask: u32 = 0;
pub export var mm_bpmdv: u32 = 38144; // default divisor similar to mode 3

extern fn memset(dst: [*]u8, c: c_int, n: usize) [*]u8;

// Very simple bump allocator for tiny needs (calloc/free minimal)
var heap: [4096]u8 = undefined;
var heap_off: usize = 0;

pub export fn calloc(nmemb: usize, size: usize) callconv(.C) ?*anyopaque {
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

const core = @import("mm_port_core_mas");
const gba = @import("gba");
pub extern var mp_solution: [*c]core.msl_head;

pub export var mmLayerMain: core.mpl_layer_information = .{};
pub export var mmLayerSub: core.mpl_layer_information = .{};
pub export var mpp_layerp: [*c]core.mpl_layer_information = &mmLayerMain;
pub export var mpp_vars: core.mpv_active_information = .{ .reserved = 0, .pattread_p = @ptrFromInt(0), .afvol = 0, .sampoff = 0, .volplus = 0, .notedelay = 0, .panplus = 0, .reserved2 = 0 };

pub export var mpp_channels: [*c]core.mm_module_channel = @ptrFromInt(0);
pub export var mpp_nchannels: core.mm_byte = 0;
pub export var mpp_clayer: core.mm_layer_type = 0;

pub export var mm_achannels: [*c]core.mm_active_channel = @ptrFromInt(0);
pub export var mm_pchannels: [*c]core.mm_module_channel = @ptrFromInt(0);
pub export var mm_num_mch: core.mm_word = 8;
pub export var mm_num_ach: core.mm_word = 8;
pub export var mm_schannels: [4]core.mm_module_channel = .{ .{}, .{}, .{}, .{} };

pub export var mm_mixlen: core.mm_word = 0;
pub export var mm_mix_channels: [*c]core.mm_mixer_channel = @ptrFromInt(0);

// Explicit setter so other modules set the same global symbol
pub export fn mmShimSetChannelMask(mask: u32) callconv(.C) void {
    mm_ch_mask = mask;
}

// Missing symbols expected by translated core; provide minimal forwards/no-ops
extern fn mmUpdateChannel_TN(ch: [*c]core.mm_module_channel, layer: [*c]core.mpl_layer_information, channel_counter: core.mm_byte) callconv(.C) void;

pub export fn mpp_Update_ACHN_notest(layer: [*c]core.mpl_layer_information, act_ch: [*c]core.mm_active_channel, period: core.mm_word, ch: core.mm_word) callconv(.c) core.mm_word {
    // Follow the original Maxmod pipeline implemented in the translated core:
    // 1) Bind/initialize mixer channel on start
    // 2) Apply envelopes and auto-vibrato to compute new period
    // 3) Compute mixer frequency and effective volume
    // 4) Apply disable/panning logic and write volume/pan to mixer

    const mix_ch: [*c]core.mm_mixer_channel = core.mpp_Update_ACHN_notest_update_mix(layer, act_ch, ch);

    var new_period: core.mm_word = period;
    new_period = core.mpp_Update_ACHN_notest_envelopes(layer, act_ch, new_period);
    new_period = core.mpp_Update_ACHN_notest_auto_vibrato(layer, act_ch, new_period);

    const clipped_vol: core.mm_word = core.mpp_Update_ACHN_notest_set_pitch_volume(layer, act_ch, new_period, mix_ch);
    core.mpp_Update_ACHN_notest_disable_and_panning(clipped_vol, act_ch, mix_ch);

    return new_period;
}

// Port of mpp_Update_ACHN_notest_disable_and_panning (GBA path)
pub export fn mpp_Update_ACHN_notest_disable_and_panning(volume: core.mm_word, act_ch: [*c]core.mm_active_channel, mix_ch: [*c]core.mm_mixer_channel) callconv(.c) void {
    // Stop if fully silent and envelopes ended with no key-on
    if (volume == 0) {
        const env_end = (@as(c_int, @intCast(act_ch.*.flags)) & core.MCAF_ENVEND) != 0;
        const key_on = (@as(c_int, @intCast(act_ch.*.flags)) & core.MCAF_KEYON) != 0;
        if (env_end and !key_on) {
            mix_ch.*.src = core.MIXCH_GBA_SRC_STOPPED;
            if (act_ch.*.type == core.ACHN_FOREGROUND) {
                // free parent channel
                const parent_idx: usize = @intCast(act_ch.*.parent);
                const parent: [*c]core.mm_module_channel = @ptrFromInt(@intFromPtr(core.mpp_channels) + parent_idx * @sizeOf(core.mm_module_channel));
                parent.*.alloc = core.NO_CHANNEL_AVAILABLE;
            }
            act_ch.*.type = core.ACHN_DISABLED;
            return;
        }
    }

    // Audible path: set volume and pan, keep playing
    const vol8: u8 = @intCast(if (volume > 255) 255 else volume);
    mix_ch.*.vol = vol8;
    // If channel had stopped, disable foreground
    if ((mix_ch.*.src & core.MIXCH_GBA_SRC_STOPPED) != 0) {
        if (act_ch.*.type == core.ACHN_FOREGROUND) {
            const parent_idx2: usize = @intCast(act_ch.*.parent);
            const parent2: [*c]core.mm_module_channel = @ptrFromInt(@intFromPtr(core.mpp_channels) + parent_idx2 * @sizeOf(core.mm_module_channel));
            parent2.*.alloc = core.NO_CHANNEL_AVAILABLE;
            act_ch.*.type = core.ACHN_DISABLED;
            return;
        }
    }
    // Panning
    const pan: u8 = if (act_ch.*.panning != 0) act_ch.*.panning else 128;
    mix_ch.*.pan = pan;
}

// Zig implementation of mpp_Update_ACHN_notest_update_mix from C (GBA path)
pub export fn mpp_Update_ACHN_notest_update_mix(layer: [*c]core.mpl_layer_information, act_ch: [*c]core.mm_active_channel, channel: core.mm_word) callconv(.c) [*c]core.mm_mixer_channel {
    const mix_ch: [*c]core.mm_mixer_channel = &mm_mix_channels[@as(usize, @intCast(channel))];

    // Only (re)bind on start, never reset read on subsequent ticks
    if (((@as(c_int, @intCast(act_ch.*.flags)) & core.MCAF_START) == 0)) {
        return mix_ch;
    }

    // Clear start flag
    act_ch.*.flags = @as(core.mm_byte, @intCast(@as(c_int, @intCast(act_ch.*.flags)) & ~core.MCAF_START));

    // Validate sample
    if (act_ch.*.sample == 0) return mix_ch;

    const sample: [*c]core.mm_mas_sample_info = core.mpp_SamplePointer(layer, @as(core.mm_word, @intCast(act_ch.*.sample)));

    // Provided sample directly in MAS stream (0xFFFF)
    if (sample.*.msl_id == @as(c_ushort, 0xFFFF)) {
        const gba_sample: *core.mm_mas_gba_sample = @ptrCast(@alignCast(sample.*.data()));
        mix_ch.*.src = @intFromPtr(gba_sample.data());
        gba.debug.print("GBA sample bound ch={d} src={x} len={d} freq={d}\n", .{ channel, mix_ch.*.src, gba_sample.length, gba_sample.default_frequency }) catch unreachable;
    }

    // Initialize read position from sampoff (done only at start)
    mix_ch.*.read = @as(core.mm_word, @intCast(@as(u32, core.mpp_vars.sampoff))) << (core.MP_SAMPFRAC + 8);

    return mix_ch;
}
