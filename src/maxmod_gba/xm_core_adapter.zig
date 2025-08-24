const std = @import("std");
const maxmod = @import("maxmod_gba");
const tc_mm = @import("tc_maxmod_core_mas_auto");
const tc_types = @import("tc_maxmod_core_mas_auto");
const shim = @import("mmcore_shim");
const tc_arm = @import("tc_maxmod_core_mas_arm_auto");
const debugWrite = maxmod.dbgWrite;

// Point core directly to ASM mixer's channel buffer; no local buffer

var s_logged_once: bool = false;
var s_tick_log_count: u32 = 0;
var s_adv_logged: bool = false;
var s_test_pcm: [1024]u8 = undefined;
fn fillTestSquare() void {
    var i: usize = 0;
    while (i < s_test_pcm.len) : (i += 1) {
        // 50% duty square wave
        s_test_pcm[i] = if ((i / 16) % 2 == 0) 192 else 64;
    }
}

pub fn minimalInit() void {
    // Build a mm_gba_system to mirror C init and call mmInit
    shim.mpp_layerp = &shim.mmLayerMain;
    shim.mpp_clayer = @as(shim.mm_layer_type, @intCast(tc_mm.MM_MAIN));
    shim.mm_num_mch = 32;
    shim.mm_num_ach = 8;
    shim.mpp_nchannels = 32;
    shim.mpp_channels = shim.mm_pchannels;
    shim.initBpmDivisor();
    // Allow allocation on first N channels
    shim.mm_ch_mask = (@as(shim.mm_word, 1) << @as(u5, @intCast(shim.mm_num_mch))) - 1;
    // Point core channel buffer to ASM mixer's channels (via runtime shim)
    tc_mm.mm_mix_channels_core = @ptrFromInt(maxmod.getMixerChannelsPtr());

    // We manage mixer via our ASM path; translated core writes to its channels

    // Debug: log init
    var buf: [96]u8 = undefined;
    const msg = std.fmt.bufPrint(&buf, "[XM INIT] mix_ch_ptr=0x{X}\n", .{ @intFromPtr(tc_mm.mm_mix_channels_core) }) catch null;
    if (msg) |m| debugWrite(m);
}

pub fn startWithMas(head: []const u8) void {
    // Ensure core channel buffer points to ASM mixer's channels
    tc_mm.mm_mix_channels_core = @ptrFromInt(maxmod.getMixerChannelsPtr());
    // Start module on main layer with loop mode; set XM mode flag if present
    if (head.len > 0) {
        var logbuf: [96]u8 = undefined;
        const start_msg = std.fmt.bufPrint(&logbuf, "[XM START] mas=0x{X} len={d}\n", .{ @intFromPtr(head.ptr), head.len }) catch null;
        if (start_msg) |mm| debugWrite(mm);
        // We cannot modify ROM header bytes; instead, enforce XM flag at runtime post-start
        // Ensure sane defaults for tempo/pitch and initial speed/tempo
        tc_mm.mmSetModuleTempo(1024); // 1.0 in 10-bit fixed
        tc_mm.mmSetModulePitch(1024); // neutral pitch
        // Core init akin to C mmInit/mmStart: bind channel/table globals and reset
        tc_mm.mpp_channels = tc_mm.mm_pchannels;
        tc_mm.mpp_nchannels = 32;
        tc_mm.mm_num_mch = 32;
        tc_mm.mm_num_ach = 8;
        tc_mm.mm_ch_mask = (@as(tc_mm.mm_word, 1) << @as(u5, 8)) - 1; // allow 8 mixer channels
        tc_mm.mpp_layerp = &tc_mm.mmLayerMain;
        tc_mm.mpp_resetchannels(tc_mm.mpp_channels, tc_mm.mpp_nchannels);
        // Derive and assign patttable and songadr from header before starting
        const header_ptr: [*c]tc_mm.mm_mas_head = @ptrFromInt(@intFromPtr(head.ptr));
        tc_mm.mmLayerMain.songadr = header_ptr;
        const instn_size: tc_mm.mm_word = @as(tc_mm.mm_word, header_ptr.*.instr_count);
        const sampn_size: tc_mm.mm_word = @as(tc_mm.mm_word, header_ptr.*.sampl_count);
        // tables(): instrument offsets, then sample offsets, then pattern offsets
        const patt_table_ptr: [*c]tc_mm.mm_word = @ptrCast(@alignCast(&header_ptr.*.tables()[instn_size +% sampn_size]));
        tc_mm.mmLayerMain.patttable = patt_table_ptr;
        // If header speed/tempo stalls, the core will set a default after mmPlayModule.
        tc_mm.mmPlayModule(
            @intFromPtr(head.ptr),
            @as(tc_mm.mm_word, @intCast(tc_mm.MM_PLAY_LOOP)),
            @as(tc_mm.mm_word, @intCast(tc_mm.MM_MAIN)),
        );
        const started_msg = std.fmt.bufPrint(&logbuf, "[XM STARTED]\n", .{}) catch null;
        if (started_msg) |mm2| debugWrite(mm2);

        // Ensure layer flags/speed/tempo sane and mark playing at runtime
        // Ensure both resolver views point to same layer memory
        var addr_buf: [96]u8 = undefined;
        const p_core: usize = @intFromPtr(&tc_mm.mmLayerMain);
        const p_shim: usize = @intFromPtr(&shim.mmLayerMain);
        if (std.fmt.bufPrint(&addr_buf, "[XM LAYER PTR] core=0x{X} shim=0x{X}\n", .{ p_core, p_shim }) catch null) |msg| debugWrite(msg);
        // Force sane runtime state on the actual core layer
        tc_mm.mmLayerMain.flags |= @as(tc_mm.mm_byte, @intCast(tc_mm.MAS_HEADER_FLAG_XM_MODE));
        tc_mm.mmLayerMain.valid = 1;
        tc_mm.mmLayerMain.isplaying = 1;
        // Also keep shim view in sync
        shim.mmLayerMain.flags = tc_mm.mmLayerMain.flags;
        shim.mmLayerMain.valid = 1;
        shim.mmLayerMain.isplaying = 1;
        tc_mm.mpp_layerp = &tc_mm.mmLayerMain;
        // Seed from header explicit values and seed first pattern read
        tc_mm.mmLayerMain.speed = if (header_ptr.*.initial_speed != 0) header_ptr.*.initial_speed else 6;
        const init_bpm: u8 = if (header_ptr.*.initial_tempo != 0) header_ptr.*.initial_tempo else 125;
        tc_mm.mmLayerMain.bpm = init_bpm;
        tc_mm.mpp_setbpm(&tc_mm.mmLayerMain, @as(tc_mm.mm_word, init_bpm));
        tc_mm.mpp_setposition(&tc_mm.mmLayerMain, @as(tc_mm.mm_word, 0));
        tc_mm.mmLayerMain.valid = 1;
        tc_mm.mmLayerMain.isplaying = 1;
        // One-time seed: choose first pattern via order table, probe base offsets, then set pattread
        const base_addr: usize = @intFromPtr(header_ptr);
        const patt_count: usize = @intCast(header_ptr.*.pattn_count);
        const order_count: usize = @intCast(header_ptr.*.order_count);
        var chosen_pat: usize = 0;
        var iord: usize = 0;
        while (iord < order_count) : (iord += 1) {
            const pi: usize = @intCast(header_ptr.*.sequence[iord]);
            if (pi < patt_count and patt_table_ptr[pi] != 0) { chosen_pat = pi; break; }
        }
        // Fallback: find first non-zero pattern offset
        if (patt_table_ptr[chosen_pat] == 0) {
            var k: usize = 0; while (k < patt_count) : (k += 1) { if (patt_table_ptr[k] != 0) { chosen_pat = k; break; } }
        }
        // Note: using mpp_PatternPointer below; keep chosen_off unused removed

        // Log songadr and patttable addresses for sanity
        {
            var abuf: [96]u8 = undefined;
            if (std.fmt.bufPrint(&abuf, "[PTR] songadr=0x{X} patttable=0x{X}\n", .{ base_addr, @intFromPtr(patt_table_ptr) }) catch null) |m| debugWrite(m);
        }

        // Helper to read a u32 from an address (may cross ROM/EWRAM; assume aligned little-endian)
        const peekU32 = struct {
            fn at(addr: usize) u32 {
                const p: [*]const u8 = @ptrFromInt(addr);
                return @as(u32, p[0]) | (@as(u32, p[1]) << 8) | (@as(u32, p[2]) << 16) | (@as(u32, p[3]) << 24);
            }
        };

        // Preferred: resolve mm_mas_pattern via core helper, then use pattern_data() pointer
        const patt_ptr: [*c]tc_mm.mm_mas_pattern = tc_mm.mpp_PatternPointer(&tc_mm.mmLayerMain, @as(tc_mm.mm_word, @intCast(chosen_pat)));
        const patt_addr0: usize = @intFromPtr(patt_ptr);
        const rowc: u8 = patt_ptr.*.row_count;
        // Primary seed: pattern_data starts at +1
        const seed_addr_primary: usize = patt_addr0 + 1;
        // Fallbacks: +5, +9 in case of unexpected embedded words
        const candidate_addrs: [3]usize = .{ seed_addr_primary, patt_addr0 + 5, patt_addr0 + 9 };
        {
            var ibuf: [96]u8 = undefined;
            if (std.fmt.bufPrint(&ibuf, "[PAT] ptr=0x{X} rowc={d}\n", .{ patt_addr0, rowc }) catch null) |pm| debugWrite(pm);
        }
        var seeded = false;
        var ci: usize = 0;
        while (ci < candidate_addrs.len) : (ci += 1) {
            const addr = candidate_addrs[ci];
            const hdr32 = peekU32.at(addr);
            var pbuf: [96]u8 = undefined;
            if (std.fmt.bufPrint(&pbuf, "[PROBE] patt=0x{X} +{d} hdr=0x{X}\n", .{ patt_addr0, @as(usize, addr - patt_addr0), hdr32 }) catch null) |pm| debugWrite(pm);
            tc_mm.mmLayerMain.pattread = @ptrFromInt(addr);
            tc_mm.mpp_vars.pattread_p = @ptrFromInt(addr);
            // Ensure playing flag before read
            tc_mm.mmLayerMain.isplaying = 1;
            const ok = tc_mm.mmReadPattern(&tc_mm.mmLayerMain);
            var sbuf: [96]u8 = undefined;
            if (std.fmt.bufPrint(&sbuf, "[SEED] ok={d} base=+{d} row={d} pos={d} upd=0x{X}\n", .{ @intFromBool(ok != 0), @as(usize, addr - patt_addr0), tc_mm.mmLayerMain.row, tc_mm.mmLayerMain.position, tc_mm.mmLayerMain.mch_update }) catch null) |sm| debugWrite(sm);
            if (ok != 0) { seeded = true; break; }
        }
        if (!seeded) {
            // Dump first 16 bytes at primary candidate to help diagnose
            const p: [*]const u8 = @ptrFromInt(seed_addr_primary);
            var hex: [64]u8 = undefined;
            var idx: usize = 0;
            var w: usize = 0;
            while (idx < 16 and (w + 3) < hex.len) : (idx += 1) {
                const b: u8 = p[idx];
                const n = std.fmt.bufPrint(hex[w..], "{X:0>2} ", .{ b }) catch break;
                w += n.len;
            }
            var dbuf: [96]u8 = undefined;
            if (std.fmt.bufPrint(&dbuf, "[DUMP] patt+1: {s}\n", .{ hex[0..w] }) catch null) |dm| debugWrite(dm);
        }
        // Report channel limits
        {
            var cb: [96]u8 = undefined;
            if (std.fmt.bufPrint(&cb, "[CHAN] mod={d} mix={d} mpp_n={d}\n", .{ tc_mm.mm_num_mch, tc_mm.mm_num_ach, tc_mm.mpp_nchannels }) catch null) |m| debugWrite(m);
        }
        // Immediate tick diagnostics
        {
            var ub0: [96]u8 = undefined;
            if (std.fmt.bufPrint(&ub0, "[UPD0] mask=0x{X} row={d} tick={d}\n", .{ tc_mm.mmLayerMain.mch_update, tc_mm.mmLayerMain.row, tc_mm.mmLayerMain.tick }) catch null) |m| debugWrite(m);
        }
        tc_mm.mppProcessTick();
        {
            var ub1: [96]u8 = undefined;
            if (std.fmt.bufPrint(&ub1, "[UPD1] mask=0x{X} row={d} tick={d}\n", .{ tc_mm.mmLayerMain.mch_update, tc_mm.mmLayerMain.row, tc_mm.mmLayerMain.tick }) catch null) |m| debugWrite(m);
        }
        // Snapshot a few module channels
        var ci2: usize = 0;
        while (ci2 < 4) : (ci2 += 1) {
            const chp_opt: [*c]tc_mm.mm_module_channel = tc_mm.mm_pchannels + ci2;
            const chp: *tc_mm.mm_module_channel = @ptrCast(chp_opt);
            var line: [96]u8 = undefined;
            if (std.fmt.bufPrint(&line, "[CH] i={d} note={d} inst={d} vol={d} eff={d} par={d} flags=0x{X}\n",
                .{ ci2, chp.*.note, chp.*.inst, chp.*.volume, chp.*.effect, chp.*.param, chp.*.flags }) catch null) |m| debugWrite(m);
        }
        // Boost global volume if zero
        if (tc_mm.mmLayerMain.global_volume == 0) tc_mm.mmLayerMain.global_volume = 128;
        // Brief header/layer dump
        var db: [96]u8 = undefined;
        const hdr = @as([*]const u8, head.ptr);
        const flags_byte: u8 = if (head.len > 4) hdr[4] else 0;
        const init_speed: u8 = if (head.len > 6) hdr[6] else 0;
        const init_tempo: u8 = if (head.len > 7) hdr[7] else 0;
        const dmsg = std.fmt.bufPrint(&db, "[XM LAYER] flags=0x{X} speed={d} bpm={d}\n", .{ flags_byte, shim.mmLayerMain.speed, shim.mmLayerMain.bpm }) catch null;
        if (dmsg) |mm3| debugWrite(mm3);
        var hb: [96]u8 = undefined;
        if (std.fmt.bufPrint(&hb, "[MAS HDR] ord={d} inst={d} samp={d} patt={d} spd={d} tmp={d}\n", .{ hdr[0], hdr[1], hdr[2], hdr[3], init_speed, init_tempo }) catch null) |hm| debugWrite(hm);
        // After starting, force a few initial ticks to get pattern reader going
        var k: usize = 0;
        while (k < 8) : (k += 1) {
            tc_mm.mppProcessTick();
        }

        // Ensure song 0 mapping is available; do not inject fallback audio here
        _ = @import("maxmod_gba").setActiveGbsSong(0);
        // Allow ACHN updates on all channels
        @import("mmcore_shim").mmShimSetAchnBlockMask(0);
    }
}

comptime {
    // Ensure ARM core exports are linked
    _ = tc_arm.mmReadPattern;
    _ = tc_arm.mmGetPeriod;
    _ = tc_arm.mmUpdateChannel_TN;
}

pub fn preMixUpdate() void {
    // Drive one tick using the translated C driver, which handles tick gating,
    // pattern read, and T0/TN updates internally.
    if (tc_mm.mmLayerMain.valid != 0) {
        tc_mm.mpp_layerp = &tc_mm.mmLayerMain;
        if (tc_mm.mmLayerMain.isplaying == 0) tc_mm.mmLayerMain.isplaying = 1;
        tc_mm.mppProcessTick();
        // Log mch_update mask to see if any channel updates are scheduled
        var ubuf: [96]u8 = undefined;
        if (std.fmt.bufPrint(&ubuf, "[UPD] mask=0x{X}\n", .{ tc_mm.mmLayerMain.mch_update }) catch null) |m| debugWrite(m);
    }
    // Dump layer state for first few ticks to confirm advancement
    if (s_tick_log_count < 64) {
        var sb: [96]u8 = undefined;
        const st = std.fmt.bufPrint(&sb, "[XM STATE] pos={d} row={d} tick={d} speed={d} bpm={d} play={d}\n",
            .{ tc_mm.mmLayerMain.position, tc_mm.mmLayerMain.row, tc_mm.mmLayerMain.tick, tc_mm.mmLayerMain.speed, tc_mm.mmLayerMain.bpm, tc_mm.mmLayerMain.isplaying }) catch null;
        if (st) |m| debugWrite(m);
        s_tick_log_count += 1;
    }
    // Brief one-time channel snapshot for diagnostics
    if (!s_logged_once) {
        s_logged_once = true;
        const mix_ptr: [*]tc_types.mm_mixer_channel = @ptrCast(tc_mm.mm_mix_channels_core);
        var any_active: bool = false;
        var i: usize = 0;
        while (i < 8) : (i += 1) {
            const ch = &mix_ptr[i];
            if ((ch.src & 0x8000_0000) == 0 and ch.freq != 0 and ch.vol != 0) {
                any_active = true;
                break;
            }
        }
        var b: [96]u8 = undefined;
        const m = std.fmt.bufPrint(&b, "[XM TICK] active={d} ch0 src=0x{X} vol={d} pan={d} freq={d}\n",
            .{ @intFromBool(any_active), mix_ptr[0].src, mix_ptr[0].vol, mix_ptr[0].pan, mix_ptr[0].freq }) catch null;
        if (m) |mm| debugWrite(mm);
    }
}
