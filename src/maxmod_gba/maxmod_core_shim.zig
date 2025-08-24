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
    // Determine sample index: prefer act_ch.sample, else fall back to instrument id
    var sample_index: mm_word = @intCast(act_ch.*.sample);
    if (sample_index == 0 and act_ch.*.inst != 0) {
        sample_index = @intCast(act_ch.*.inst);
        var b0: [96]u8 = undefined;
        if (@import("std").fmt.bufPrint(&b0, "[ACHN] ch={d} sample=0 -> inst={d}\n", .{ idx, act_ch.*.inst }) catch null) |m| @import("maxmod_gba").dbgWrite(m);
    }
    // Ensure a valid sample index; if still zero, skip activation
    if (sample_index != 0) {
        const sampleN: mm_word = sample_index;
        const info_ptr: [*c]tc.mm_mas_sample_info = tc.mpp_SamplePointer(layer, sampleN);
        if (info_ptr != @as([*c]tc.mm_mas_sample_info, @ptrFromInt(0))) {
            const gba_hdr: *tc.mm_mas_gba_sample = @ptrCast(@alignCast(info_ptr.*.data()));
            const pcm_ptr: [*]const u8 = @ptrCast(gba_hdr.data());
            const len_bytes: usize = @intCast(gba_hdr.length);
            const raw_loop: u32 = @intCast(gba_hdr.loop_length);
            const loop_len_bytes: u32 = if (raw_loop == 0xFFFF_FFFF) 0 else raw_loop;
            // Calculate mixer step from tracker period (Amiga-style; adequate for initial XM testing)
            const mixer_rate: u32 = @import("maxmod_gba").getMixRate();
            const p: u32 = period;
            const MOD_FREQ_DIVIDER_PAL: u32 = 56_750_314;
            const value: u32 = if (p == 0) 0 else @intCast(MOD_FREQ_DIVIDER_PAL / (p << 4));
            const scale: u32 = @intCast((@as(u64, 4096) * 65536) / (if (mixer_rate == 0) 15768 else mixer_rate));
            const step: u32 = @intCast((@as(u64, scale) * @as(u64, value)) >> 16);
            const set_step: u32 = if (step == 0) (1 << 12) else step;
            // Build slice and let mixer path set side arrays and channel fields
            const pcm_slice: []const u8 = pcm_ptr[0..len_bytes];
            // Use the translated core-provided volume/pan defaults; if zero, set safe defaults
            var vol_u8: u8 = act_ch.*.volume;
            if (vol_u8 == 0) vol_u8 = 96;
            var pan_u8: u8 = act_ch.*.panning;
            if (pan_u8 == 0) pan_u8 = 128;
            @import("maxmod_gba").mixerTestSetChannelFromPcm8(idx, pcm_slice, loop_len_bytes, vol_u8, pan_u8, set_step);
            // Also reflect freq/vol/pan into the mix channel for debug
            mix_ch.*.freq = set_step;
            mix_ch.*.vol = vol_u8;
            mix_ch.*.pan = pan_u8;
            // Debug: log activation
            {
                const dbg = @import("maxmod_gba");
                var buf: [96]u8 = undefined;
                if (@import("std").fmt.bufPrint(&buf, "[ACHN] ch={d} ptr=0x{X} len={d} loop=0x{X} step={d} vol={d} pan={d}\n", .{ idx, @intFromPtr(pcm_ptr), len_bytes, loop_len_bytes, set_step, vol_u8, pan_u8 }) catch null) |m| dbg.dbgWrite(m);
            }
        } else {
            // Sample resolution failed; disable channel explicitly
            mix_ch.*.src = 1 << 31;
            mix_ch.*.vol = 0;
            mix_ch.*.freq = 0;
            var b: [64]u8 = undefined;
            if (@import("std").fmt.bufPrint(&b, "[ACHN] ch={d} no-sample\n", .{ idx }) catch null) |m| @import("maxmod_gba").dbgWrite(m);
        }
    } else {
        var b2: [64]u8 = undefined;
        if (@import("std").fmt.bufPrint(&b2, "[ACHN] ch={d} sample=0 skip\n", .{ idx }) catch null) |m| @import("maxmod_gba").dbgWrite(m);
    }
    // Minimal volume/panning to get audible output without deep envelope stack
    var vol: mm_byte = act_ch.*.volume;
    if (vol == 0) vol = 120;
    mix_ch.*.vol = vol;
    // If panning is unset, center it
    var pan: mm_byte = act_ch.*.panning;
    if (pan == 0) pan = 128;
    mix_ch.*.pan = pan;
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
