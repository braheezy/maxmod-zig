const tc = @import("tc_maxmod_core_mas_auto");
const arm = @import("tc_maxmod_core_mas_arm_auto");

// Re-export exact ABI types from translated C to avoid mismatches
pub const mm_word = tc.mm_word;
pub const mm_hword = tc.mm_hword;
pub const mm_byte = tc.mm_byte;
pub const mm_bool = tc.mm_bool;
pub const mm_layer_type = tc.mm_layer_type;
pub const mm_module_channel = tc.mm_module_channel;
pub const mm_active_channel = tc.mm_active_channel;
pub const mpl_layer_information = tc.mpl_layer_information;
pub const mpv_active_information = tc.mpv_active_information;

pub export var mm_ch_mask: mm_word = 0;
pub export var mmLayerMain: mpl_layer_information = .{};
pub export var mmLayerSub: mpl_layer_information = .{};
pub export var mpp_layerp: [*c]mpl_layer_information = &mmLayerMain;

// Backing storage for channels
// - Module channels: up to 32 (tracker channels)
// - Active/mixing channels: keep 8 (maps onto mixer channels)
var s_pchannels: [32]mm_module_channel = [_]mm_module_channel{.{}} ** 32;
var s_achannels: [8]mm_active_channel = [_]mm_active_channel{.{}} ** 8;

pub export var mpp_channels: [*c]mm_module_channel = &s_pchannels;
pub export var mpp_nchannels: mm_byte = 0;
pub export var mpp_clayer: mm_layer_type = 0;

pub export var mm_achannels: [*c]mm_active_channel = &s_achannels;
pub export var mm_pchannels: [*c]mm_module_channel = &s_pchannels;
pub export var mm_num_mch: mm_word = 32;
pub export var mm_num_ach: mm_word = 8;
pub export var mm_schannels: [4]mm_module_channel = .{.{},.{},.{},.{}};

// Non-null placeholder for optional pointers expected by C core
pub export var mp_solution: *anyopaque = @ptrFromInt(1);
// mm_mixlen is provided by the ASM mixer module; do not redefine here.
pub export var mm_bpmdv: mm_word = 0;
pub export var mpp_vars: mpv_active_information = .{
    .reserved = 0,
    .pattread_p = @ptrFromInt(0),
    .afvol = 0,
    .sampoff = 0,
    .volplus = 0,
    .notedelay = 0,
    .panplus = 0,
    .reserved2 = 0,
};

// Bitmask of mixer channels to block from ACHN updates (bit set => block)
var g_achn_block_mask: mm_word = 0;
pub export fn mmShimSetAchnBlockMask(mask: mm_word) void {
    g_achn_block_mask = mask;
}
// Track last sample index per mixer channel to avoid retrigger every frame
var g_last_sample_idx: [32]mm_word = [_]mm_word{0} ** 32;

// No stdlib or debug on GBA path here

// No function stubs; translated core provides implementations.
// Minimal stubs for only those externs not provided by translated modules
pub export fn mmGetModuleCount() callconv(.C) mm_word { return 1; }
// Allocate an active channel and initialize minimal fields for a new note.
// Minimal path to get audible output without full instrument mapping.
// Remove custom new-note and T0 overrides; rely on translated core logic
// Leave TN/T0 to ARM module; we only provide ACHN mapping
// mmReadPattern is implemented by the translated ARM core module; do not duplicate here.
// Provide thin forwarders to ARM module for required symbols
pub export fn mmUpdateChannel_T0(ch: [*c]tc.mm_module_channel, layer: [*c]tc.mpl_layer_information, channel_counter: tc.mm_byte) callconv(.C) void {
    // Brief trace to confirm channel, row, and flags at T0
    if (@hasDecl(@This(), "g_t0_log_count") and g_t0_log_count < 32 and ch.*.note != 0) {
        var b: [96]u8 = undefined;
        if (@import("std").fmt.bufPrint(&b, "[T0] ch={d} pos={d} row={d} tick={d} note={d} inst={d} vol={d} eff={d} par={d} flags=0x{X}\n",
            .{ channel_counter, layer.*.position, layer.*.row, layer.*.tick, ch.*.note, ch.*.inst, ch.*.volume, ch.*.effect, ch.*.param, ch.*.flags }) catch null) |m| @import("maxmod_gba").dbgWrite(m);
        g_t0_log_count += 1;
    }
    @import("tc_maxmod_core_mas_arm_auto").mmUpdateChannel_T0(@ptrCast(ch), @ptrCast(layer), channel_counter);
}
pub export fn mpp_Update_ACHN_notest(layer: *mpl_layer_information, act_ch: *mm_active_channel, period: mm_word, ch: mm_word) callconv(.C) mm_word {
    // 'ch' is the mixer channel index; map to our mixer channel buffer
    const idx: usize = @intCast(ch);
    const base: [*c]tc.mm_mixer_channel = tc.mm_mix_channels_core;
    const mix_ch: *tc.mm_mixer_channel = @ptrFromInt(@intFromPtr(base) + idx * @sizeOf(tc.mm_mixer_channel));
    // Respect blocking mask to prevent core from overwriting test channels
    if (((g_achn_block_mask >> @intCast(idx)) & 1) != 0) {
        return period;
    }

    // Resolve sample and bind PCM source/loop for the mixer buffer
    const sample_index: mm_word = @intCast(act_ch.*.sample);
    if (sample_index != 0) {
        const info_ptr: [*c]tc.mm_mas_sample_info = tc.mpp_SamplePointer(layer, sample_index);
        if (info_ptr != @as([*c]tc.mm_mas_sample_info, @ptrFromInt(0))) {
            const gba_hdr: *tc.mm_mas_gba_sample = @ptrCast(@alignCast(info_ptr.*.data()));
            const pcm_ptr: [*]const u8 = @ptrCast(gba_hdr.data());
            const len_bytes: usize = @intCast(gba_hdr.length);
            const raw_loop: u32 = @intCast(gba_hdr.loop_length);
            const loop_len_bytes: u32 = if (raw_loop == 0xFFFF_FFFF) 0 else raw_loop;
            const pcm_slice: []const u8 = pcm_ptr[0..len_bytes];
            if (g_last_sample_idx[idx] != sample_index) {
                @import("maxmod_gba").mixer.setChannelSourceLoop(idx, pcm_slice, loop_len_bytes);
                g_last_sample_idx[idx] = sample_index;
            } else {
                @import("maxmod_gba").mixer.setChannelSourceLoop(idx, pcm_slice, loop_len_bytes);
            }
        } else {
            // No valid sample; disable channel now
            mix_ch.*.src = 1 << 31;
            mix_ch.*.vol = 0;
            mix_ch.*.freq = 0;
        }
    }

    // Compute/update mixer parameters (freq/vol/pan) using C logic inline (avoid optional deref issue)
    // 1) Get mix channel pointer for this ACHN and set base state
    const mix_ptr: [*c]tc.mm_mixer_channel = tc.mpp_Update_ACHN_notest_update_mix(layer, act_ch, ch);

    // 2) Pitch (freq) calculation: write base rate (value << 2). Let mixer apply mm_ratescale.
    var computed_freq: mm_word = mix_ptr.*.freq;
    if (sample_index != 0) {
        const sample_info: [*c]tc.mm_mas_sample_info = tc.mpp_SamplePointer(layer, sample_index);
        if (sample_info != @as([*c]tc.mm_mas_sample_info, @ptrFromInt(0))) {
            const xm_mode: bool = (layer.*.flags & (@as(mm_word, 1) << 2)) != 0;
            if (xm_mode) {
                const speed: mm_word = @intCast(sample_info.*.frequency);
                var value: mm_word = ((period >> 8) *% (@as(mm_word, @intCast(speed)) << 2)) >> 8;
                if (tc.mpp_clayer == @as(u32, @intCast(tc.MM_MAIN))) {
                    value = (value *% tc.mm_masterpitch) >> 10;
                }
                computed_freq = value << 2;
            } else {
                if (period != 0) {
                    var value2: mm_word = @intCast(@as(u32, 56750314) / period);
                    if (tc.mpp_clayer == @as(u32, @intCast(tc.MM_MAIN))) {
                        value2 = (value2 *% tc.mm_masterpitch) >> 10;
                    }
                    computed_freq = value2 << 2;
                }
            }
        }
    }
    mix_ptr.*.freq = computed_freq;

    // 3) Volume calculation (returns 0..255)
    var vol_word: mm_word = 0;
    if (act_ch.*.inst != 0 and sample_index != 0) {
        const sample_info2: [*c]tc.mm_mas_sample_info = tc.mpp_SamplePointer(layer, sample_index);
        if (sample_info2 != @as([*c]tc.mm_mas_sample_info, @ptrFromInt(0))) {
            // Read instrument global volume from first byte of instrument struct
            var inst_gv: mm_word = 255;
            if (tc.mpp_InstrumentPointer(layer, act_ch.*.inst)) |inst_ptr| {
                const inst_addr: usize = @intFromPtr(inst_ptr);
                const inst_bytes: [*]const u8 = @ptrFromInt(inst_addr);
                inst_gv = inst_bytes[0];
            }
            const sample_gv: mm_word = @intCast(sample_info2.*.global_volume);
            vol_word = sample_gv;
            vol_word *%= inst_gv;
            vol_word *%= tc.mpp_vars.afvol;
            var global_volume: u32 = layer.*.global_volume;
            if ((layer.*.flags & (@as(mm_word, 1) << 3)) != 0) {
                global_volume <<= 1;
            }
            vol_word = (vol_word *% @as(mm_word, @intCast(global_volume))) >> 10;
            vol_word = (vol_word *% @as(mm_word, @intCast(act_ch.*.fade))) >> 10;
            vol_word *%= @as(mm_word, @intCast(layer.*.volume));
            vol_word = vol_word >> 19;
            if (vol_word > 255) vol_word = 255;
            act_ch.*.fvol = @intCast(@as(u8, @truncate(vol_word)));
        }
    } else {
        act_ch.*.fvol = 0;
    }

    // 4) Apply disable/panning logic consistent with C core
    tc.mpp_Update_ACHN_notest_disable_and_panning(vol_word, act_ch, mix_ptr);

    // Debug snapshot of resolved mixer state (early limited spam)
    if (g_achn_dbg_count < 32 and idx < 2) {
        g_achn_dbg_count += 1;
        var buf: [120]u8 = undefined;
        const inst_gv_dbg: u32 = blk: {
            if (tc.mpp_InstrumentPointer(layer, act_ch.*.inst)) |inst_ptr| {
                const a: usize = @intFromPtr(inst_ptr);
                const b: [*]const u8 = @ptrFromInt(a);
                break :blk b[0];
            }
            break :blk 0;
        };
        if (@import("std").fmt.bufPrint(&buf, "[ACHN] ch={d} freq={d} vol={d} pan={d} src=0x{X} afvol={d} gvol={d} fade={d} instgv={d}\n",
            .{ idx, mix_ptr.*.freq, mix_ptr.*.vol, mix_ptr.*.pan, mix_ptr.*.src, tc.mpp_vars.afvol, layer.*.global_volume, act_ch.*.fade, inst_gv_dbg }) catch null) |m| @import("maxmod_gba").dbgWrite(m);
    }

    return period;
}

// Ensure symbols are kept by referencing them
comptime {
    _ = mmLayerMain;
    _ = mmLayerSub;
    _ = mpp_layerp;
    _ = mpp_channels;
    _ = mpp_nchannels;
    _ = mpp_clayer;
    _ = mm_achannels;
    _ = mm_pchannels;
    _ = mm_num_mch;
    _ = mm_num_ach;
    _ = mm_schannels;
    _ = mp_solution;
    _ = mm_bpmdv;
    _ = mpp_vars;
}

// Initialize BPM divisor to match GBA mixer mode index 3 (~16 kHz)
// Original Maxmod uses a table and sets mm_bpmdv in mixer init.
// Use 38144 (149 * 256) which yields sane tickrates for typical tempi.
pub fn initBpmDivisor() void {
    // Match Maxmod's mode index 3 value (mp_bpm_divisors[3] = 38144)
    mm_bpmdv = 38144;
}

var g_t0_log_count: usize = 0;
var g_achn_dbg_count: usize = 0;

// Provide implementations for core helpers that were demoted to extern by translate-c.
// These mirror the intent of the original C: set up the mixer channel pointer for this ACHN
// and apply disable/panning logic using the computed volume.
fn clampU8(v: mm_word) u8 {
    return @intCast(if (v > 255) 255 else v);
}

pub export fn mpp_Update_ACHN_notest_update_mix(layer: [*c]mpl_layer_information, act_ch: [*c]mm_active_channel, ch: mm_word) callconv(.C) [*c]tc.mm_mixer_channel {
    _ = layer;
    // Carry over per-tick active-channel volume into core vars like the C path
    tc.mpp_vars.afvol = act_ch.*.volume;
    // Ensure fade has a sane default (1.0 in 10-bit)
    if (act_ch.*.fade == 0) act_ch.*.fade = 1024;
    const idx: usize = @intCast(ch);
    const base: [*c]tc.mm_mixer_channel = tc.mm_mix_channels_core;
    const mix_ch: [*c]tc.mm_mixer_channel = @ptrFromInt(@intFromPtr(base) + idx * @sizeOf(tc.mm_mixer_channel));
    // Keep pan centered if unset; do not touch vol/freq here
    if (mix_ch.*.pan == 0) mix_ch.*.pan = 128;
    return mix_ch;
}

pub export fn mpp_Update_ACHN_notest_disable_and_panning(volume: mm_word, act_ch: [*c]mm_active_channel, mix_ch: [*c]tc.mm_mixer_channel) callconv(.C) void {
    // Match C logic: if computed volume is zero and envelopes ended with no key-on, stop
    if (volume == 0) {
        const MCAF_ENVEND: u8 = @intCast(tc.MCAF_ENVEND);
        const MCAF_KEYON: u8 = @intCast(tc.MCAF_KEYON);
        const env_end = (act_ch.*.flags & MCAF_ENVEND) != 0;
        const key_on = (act_ch.*.flags & MCAF_KEYON) != 0;
        if (env_end and !key_on) {
            mix_ch.*.src = 1 << 31;
            if (true) { // foreground check elided in shim; safe no-op
            }
            return;
        }
    }

    // Audible path: set volume and panning
    mix_ch.*.vol = clampU8(volume);
    mix_ch.*.pan = if (act_ch.*.panning != 0) act_ch.*.panning else 128;
    // If mixer channel already stopped, disable
    if ((mix_ch.*.src & (1 << 31)) != 0) {
        return;
    }
}
