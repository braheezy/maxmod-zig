const mm = @import("maxmod.zig");

pub const MIXCH_GBA_SRC_STOPPED: usize = 0x80000000;

// EWRAM-based heap allocator (matches C malloc behavior)
// Worst case: 32 channels = 1056 + (32 * 84) = 3744 bytes
// Using 8KB to be safe with alignment and padding
var heap: [8192]u8 align(4) = undefined;
var heap_off: usize = 0;

pub fn calloc(nmemb: usize, size: usize) ?*anyopaque {
    const bytes = nmemb * size;

    // Align to 4-byte boundary (required by GBA)
    const aligned_bytes = (bytes + 3) & ~@as(usize, 3);

    if (heap_off + aligned_bytes > heap.len) return null;

    const ptr = &heap[heap_off];
    heap_off += aligned_bytes;

    // Zero out the memory (calloc behavior)
    @memset(@as([*]u8, @ptrCast(ptr))[0..bytes], 0);

    return ptr;
}

pub fn free(ptr: ?*anyopaque) void {
    // Simple bump allocator - no free needed for maxmod
    // Maxmod only allocates once at startup
    _ = ptr;
}

// !!!!!!!!!!!!!!!!!!!!!!!!!!!!!
// ! Cursed Debug Land !!!!!!!!!
// !!!!!!!!!!!!!!!!!!!!!!!!!!!!!
const gba = @import("gba");
// Event type for T0 tracing
pub const T0Event = struct {
    tag: u8, // 1=enter, 2=dont_start, 3=start, 4=channel_started
    ch: u8,
    mch_flags: u8,
    mch_alloc: u8,
    mch_bflags: u16,
    mch_inst: u8,
    mch_note: u8,
    mch_pnoter: u8,
    mch_volume: u8,
    mch_panning: u8,
    act_exists: u8,
    act_type: u8,
    act_flags: u8,
    act_fade: u16,
    act_sample: u8,
    act_parent: u8,
    period_after: u32,
};
pub const SpvEvent = struct {
    ch: u8,
    per: u32,
    freq: u32,
    fvol: u8,
    inst: u8,
    sample: u8,
    xm: u8,
};
pub const DapEvent = struct {
    ch: u8,
    vol: u8,
    pan: u8,
    src: u32,
    typ: u8,
};
pub const VolEvent = struct {
    ch: u8,
    module_vol: u8,
    module_cvol: u8,
    afvol: u8,
    sample_defvol: u8,
    sample_gvol: u8,
    inst_gvol: u8,
    layer_gvol: u8,
    xm_mode: u8,
    layer_vol: u16,
    fade: u16,
    raw_vol: u32,
    clipped: u16,
    fvol: u8,
};
pub const MixEvent = struct {
    stage: u8,
    samples: u16,
    data: [8]u32,
};
pub const UmixStage = enum(u8) {
    entry,
    exit,
};
pub const UmixUpdateEvent = struct {
    stage: UmixStage = .entry,
    ch: u8 = 0,
    tick: u8 = 0,
    act_flags: u8 = 0,
    start: u8 = 0,
    sample: u8 = 0,
    msl_id: u16 = 0,
    offset: u32 = 0,
    src: u32 = 0,
    read: u32 = 0,
    vol: u8 = 0,
};
pub const UpdEvent = struct {
    tick: u8,
    row: u8,
    bits: u32,
};
// Debug configuration - can be toggled at build time
const debug_enabled = @import("build_options").xm_debug;
const spv_log_enabled = false;
const umix_log_enabled = false;
const umix_trace_channel: u8 = 0;
const vol_trace_channel: i32 = 0;
const mix_hash_log_enabled = true;
// Debug printing helper that can be compiled out
inline fn debugPrint(comptime fmt: []const u8, args: anytype) void {
    if (!debug_enabled) return;
    gba.debug.print(fmt, args) catch {};
}

pub const DebugState = struct {
    soundbank_addr: usize = 0,
    number_of_channels: u32 = 0,
    sample_count: u16 = 0,
    module_count: u16 = 0,
    module_offset: usize = 0,
    active_offset: usize = 0,
    mixing_offset: usize = 0,
    mod_ch: u32 = 0,
    mix_ch: u32 = 0,
    channel_mask: u32 = 0,
    mixlen: u32 = 0,
    ratescale: u32 = 0,
    timerfreq: u32 = 0,
    bpmdv: u32 = 0,
    module_address_offset: usize = 0,
    module_address: usize = 0,
    num_instr: u32 = 0,
    num_sampl: u32 = 0,
    inst_tbl_peek: u32 = 0,
    samp_tbl_peek: u32 = 0,
    patt_tbl_peek: u32 = 0,
    pattern_entry: u8 = 0,
    layer_position: u32 = 0,
    layer_nrows: u8 = 0,
    pattern_ptr_offset: usize = 0,
    patt_peek: u8 = 0,
    tickrate: u32 = 0,
    layer1: mm.LayerInfo = .{},
    header_channel_volumes: [32]u8 = [_]u8{0} ** 32,
    header_channel_panning: [32]u8 = [_]u8{0} ** 32,
    new_bitmask: u32 = 0,
    remaining_lens: [4]u32 = [_]u32{0} ** 4,
    mp_mix_seg_vblank1: u8 = 0,
    tick_data_sampcount: u32 = 0,
    mpp_layer_update_bits: u32 = 0,
    // Captured sequence of updateChannel_T0 events (first 64)
    t0_events: [128]T0Event = [_]T0Event{.{
        .tag = 0,
        .ch = 0,
        .mch_flags = 0,
        .mch_alloc = 0,
        .mch_bflags = 0,
        .mch_inst = 0,
        .mch_note = 0,
        .mch_pnoter = 0,
        .mch_volume = 0,
        .mch_panning = 0,
        .act_exists = 0,
        .act_type = 0,
        .act_flags = 0,
        .act_fade = 0,
        .act_sample = 0,
        .act_parent = 0,
        .period_after = 0,
    }} ** 128,
    t0_len: u8 = 0,
    spv_events: [256]SpvEvent = [_]SpvEvent{.{ .ch = 0, .per = 0, .freq = 0, .fvol = 0, .inst = 0, .sample = 0, .xm = 0 }} ** 256,
    spv_len: u8 = 0,
    dap_events: [256]DapEvent = [_]DapEvent{.{ .ch = 0, .vol = 0, .pan = 0, .src = 0, .typ = 0 }} ** 256,
    dap_len: u8 = 0,
    vol_events: [256]VolEvent = [_]VolEvent{.{
        .ch = 0,
        .module_vol = 0,
        .module_cvol = 0,
        .afvol = 0,
        .sample_defvol = 0,
        .sample_gvol = 0,
        .inst_gvol = 0,
        .layer_gvol = 0,
        .xm_mode = 0,
        .layer_vol = 0,
        .fade = 0,
        .raw_vol = 0,
        .clipped = 0,
        .fvol = 0,
    }} ** 256,
    vol_len: u8 = 0,
    umix_update_events: [64]UmixUpdateEvent = [_]UmixUpdateEvent{.{}} ** 64,
    umix_update_len: u8 = 0,
    mix_events: [64]MixEvent = [_]MixEvent{.{ .stage = 0, .samples = 0, .data = [_]u32{0} ** 8 }} ** 64,
    mix_len: u8 = 0,
    upd_events: [128]UpdEvent = [_]UpdEvent{.{ .tick = 0, .row = 0, .bits = 0 }} ** 128,
    upd_len: u8 = 0,
};

pub var debug_state: DebugState = .{};
pub inline fn t0Record(tag: u8) void {
    _ = tag; // compatibility no-op
}
pub inline fn t0Capture(
    tag: u8,
    ch: u8,
    module_channel: *const mm.ModuleChannel,
    act_ch: ?*const mm.ActiveChannel,
    period_after: u32,
) void {
    if (!debug_enabled) return;
    if (debug_state.t0_len >= debug_state.t0_events.len) return;
    const e = &debug_state.t0_events[debug_state.t0_len];
    e.* = .{
        .tag = tag,
        .ch = ch,
        .mch_flags = module_channel.flags,
        .mch_alloc = module_channel.alloc,
        .mch_bflags = module_channel.bflags,
        .mch_inst = module_channel.inst,
        .mch_note = module_channel.note,
        .mch_pnoter = module_channel.pnoter,
        .mch_volume = module_channel.volume,
        .mch_panning = module_channel.panning,
        .act_exists = if (act_ch == null) 0 else 1,
        .act_type = if (act_ch) |a| a._type else 0,
        .act_flags = if (act_ch) |a| a.flags else 0,
        .act_fade = if (act_ch) |a| a.fade else 0,
        .act_sample = if (act_ch) |a| a.sample else 0,
        .act_parent = if (act_ch) |a| a.parent else 0,
        .period_after = period_after,
    };
    debugPrint(
        "[T0E] t={d} ch={d} mf=0x{x} mb=0x{x} inst={d} note={d} pnoter={d} vol={d} pan={d} ae={d} at={d} af=0x{x} fade={d} samp={d} par={d} per={d}\n",
        .{
            e.tag,
            e.ch,
            e.mch_flags,
            e.mch_bflags,
            e.mch_inst,
            e.mch_note,
            e.mch_pnoter,
            e.mch_volume,
            e.mch_panning,
            e.act_exists,
            e.act_type,
            e.act_flags,
            e.act_fade,
            e.act_sample,
            e.act_parent,
            e.period_after,
        },
    );
    debug_state.t0_len +%= 1;
}
pub inline fn spvCapture(ch: u8, per: u32, freq: u32, fvol: u8, inst: u8, sample: u8, xm: bool) void {
    if (!debug_enabled) return;
    if (debug_state.spv_len >= debug_state.spv_events.len) return;
    const e = &debug_state.spv_events[debug_state.spv_len];
    e.* = .{ .ch = ch, .per = per, .freq = freq, .fvol = fvol, .inst = inst, .sample = sample, .xm = if (xm) 1 else 0 };
    if (spv_log_enabled and debug_enabled) {
        debugPrint(
            "[SPV] ch={d} per={d} freq={d} fvol={d} inst={d} samp={d} xm={d}\n",
            .{ e.ch, e.per, e.freq, e.fvol, e.inst, e.sample, e.xm },
        );
    }
    debug_state.spv_len +%= 1;
}
pub inline fn dapCapture(ch: u8, vol: u8, pan: u8, src: u32, typ: u8) void {
    if (!debug_enabled) return;
    if (debug_state.dap_len >= debug_state.dap_events.len) return;
    const e = &debug_state.dap_events[debug_state.dap_len];
    e.* = .{ .ch = ch, .vol = vol, .pan = pan, .src = src, .typ = typ };
    debug_state.dap_len +%= 1;
}
pub inline fn volCapture(
    ch: i32,
    module_vol: u8,
    module_cvol: u8,
    afvol: u8,
    sample_defvol: u8,
    sample_gvol: u8,
    inst_gvol: u8,
    layer_gvol: u8,
    xm_mode: bool,
    layer_vol: u16,
    fade: u16,
    raw_vol: u32,
    clipped: u16,
    fvol: u8,
) void {
    if (!debug_enabled) return;
    if (debug_state.vol_len >= debug_state.vol_events.len) return;
    if (ch != vol_trace_channel) return;
    const e = &debug_state.vol_events[debug_state.vol_len];
    e.* = .{
        .ch = @as(u8, @intCast(ch)),
        .module_vol = module_vol,
        .module_cvol = module_cvol,
        .afvol = afvol,
        .sample_defvol = sample_defvol,
        .sample_gvol = sample_gvol,
        .inst_gvol = inst_gvol,
        .layer_gvol = layer_gvol,
        .xm_mode = if (xm_mode) 1 else 0,
        .layer_vol = layer_vol,
        .fade = fade,
        .raw_vol = raw_vol,
        .clipped = clipped,
        .fvol = fvol,
    };
    debugPrint(
        "[VOL] ch={d} mvol={d} mcvol={d} af={d} sdf={d} sgv={d} igv={d} lgv={d} xm={d} lvol={d} fade={d} raw={d} clip={d} fvol={d}\n",
        .{ e.ch, e.module_vol, e.module_cvol, e.afvol, e.sample_defvol, e.sample_gvol, e.inst_gvol, e.layer_gvol, e.xm_mode, e.layer_vol, e.fade, e.raw_vol, e.clipped, e.fvol },
    );
    debug_state.vol_len +%= 1;
}
pub inline fn umixUpdateCapture(
    stage: UmixStage,
    ch: u8,
    tick: u8,
    act_flags: u8,
    start: bool,
    sample: u8,
    msl_id: u16,
    offset: u32,
    src: u32,
    read: u32,
    vol: u8,
) void {
    if (!debug_enabled) return;
    if (ch != umix_trace_channel) return;
    if (debug_state.umix_update_len >= debug_state.umix_update_events.len) return;
    const idx = debug_state.umix_update_len;
    const start_val: u8 = if (start) 1 else 0;
    debug_state.umix_update_events[idx] = .{
        .stage = stage,
        .ch = ch,
        .tick = tick,
        .act_flags = act_flags,
        .start = start_val,
        .sample = sample,
        .msl_id = msl_id,
        .offset = offset,
        .src = src,
        .read = read,
        .vol = vol,
    };
    debug_state.umix_update_len +%= 1;
    const stage_str = switch (stage) {
        .entry => "entry",
        .exit => "exit",
    };
    if (umix_log_enabled) {
        debugPrint(
            "[UMIX] stage={s} tick={d} flags=0x{x:0>2} start={d} sample={d} msl={d} off=0x{x:0>8} src=0x{x:0>8} read=0x{x:0>8} vol={d}\n",
            .{ stage_str, tick, act_flags, start_val, sample, msl_id, offset, src, read, vol },
        );
    }
}
pub inline fn mixCapture(stage: u8, samples: i32, values: [8]u32) void {
    if (!debug_enabled) return;
    if (debug_state.mix_len >= debug_state.mix_events.len) return;
    debug_state.mix_events[debug_state.mix_len] = .{
        .stage = stage,
        .samples = @as(u16, @intCast(samples)),
        .data = values,
    };
    debug_state.mix_len +%= 1;
}
pub fn logMixHash(frame_idx: u32) void {
    if (!(mix_hash_log_enabled and debug_enabled)) return;
    var hash: u32 = 0;
    const count = @as(usize, @intCast(mm.mixer.getCount()));
    const bank_base = @as(usize, @intCast(@intFromPtr(mm.gba.bank_base)));
    var i: usize = 0;
    while (i < count) : (i += 1) {
        const ch = mm.mixer.mm_mix_channels[i];
        var src_rel: u32 = 0;
        const src_val = @as(u32, @truncate(ch.src));
        if ((src_val & 0x8000_0000) != 0) {
            src_rel = 0x8000_0000;
        } else {
            const src_usize = @as(usize, @intCast(src_val));
            if (src_usize >= bank_base)
                src_rel = @as(u32, @intCast(src_usize - bank_base));
        }
        hash ^= src_rel;
        hash ^= @as(u32, ch.read);
        hash ^= @as(u32, ch.vol) << @intCast(i & 7);
        hash ^= @as(u32, ch.pan) << @intCast((i + 3) & 7);
        hash ^= @as(u32, ch.freq) << @intCast((i + 5) & 7);
    }
    debugPrint("[MXSUM] frame={d} hash=0x{x:0>8}\n", .{ frame_idx, hash });
}
pub fn logMixChannels(frame_idx: u32) void {
    if (!(mix_hash_log_enabled and debug_enabled)) return;
    if (frame_idx < 100 or frame_idx > 110) return;
    const count = @as(usize, @intCast(mm.mixer.getCount()));
    const bank_base = @as(usize, @intCast(@intFromPtr(mm.gba.bank_base)));
    var i: usize = 0;
    while (i < count) : (i += 1) {
        const ch = mm.mixer.mm_mix_channels[i];
        var src_rel: u32 = 0;
        const src_val = @as(u32, @truncate(ch.src));
        if ((src_val & 0x8000_0000) != 0) {
            src_rel = 0x8000_0000;
        } else {
            const src_usize = @as(usize, @intCast(src_val));
            if (src_usize >= bank_base)
                src_rel = @as(u32, @intCast(src_usize - bank_base));
        }
        debugPrint(
            "[MXCH] frame={d} idx={d} src=0x{x:0>8} read=0x{x:0>8} vol={d} pan={d} freq={d}\n",
            .{ frame_idx, i, src_rel, @as(u32, ch.read), ch.vol, ch.pan, @as(u32, ch.freq) },
        );
    }
}
pub fn print() void {
    gba.debug.write("BEGIN debug_state=================>") catch {};

    debugPrint("[initDefault] soundbank=0x{x} nch={d}", .{ debug_state.soundbank_addr, debug_state.number_of_channels });
    debugPrint("[init] sampleCount={d} moduleCount={d}\n", .{ debug_state.sample_count, debug_state.module_count });
    debugPrint("[init] moduleOffset={d} activeOffset={d} mixingOffset={d}\n", .{ debug_state.module_offset, debug_state.active_offset, debug_state.mixing_offset });
    debugPrint("[init] mod_ch={d} mix_ch={d}\n", .{ debug_state.mod_ch, debug_state.mix_ch });
    debugPrint("[init] channel_mask=0x{x}\n", .{debug_state.channel_mask});
    debugPrint("[mixer init] mixlen={d} ratescale={d} timerfreq={d} bpmdv={d}\n", .{ debug_state.mixlen, debug_state.ratescale, debug_state.timerfreq, debug_state.bpmdv });
    debugPrint("[mpps_backdoor] module_address=0x{x} module_address_offset=0x{x}\n", .{ debug_state.module_address, debug_state.module_address_offset });
    debugPrint("[mmPlayModule] num_instr={d} num_sampl={d}\n", .{ debug_state.num_instr, debug_state.num_sampl });
    debugPrint("[mmPlayMAS] insttable=0x{x} samptable=0x{x} patttable=0x{x}\n", .{ debug_state.inst_tbl_peek, debug_state.samp_tbl_peek, debug_state.patt_tbl_peek });
    debugPrint("[mmPlayMAS] layer_position={d} pattern_entry={d}\n", .{ debug_state.layer_position, debug_state.pattern_entry });
    debugPrint("[mmPlayMAS] layer_nrows={d}\n", .{debug_state.layer_nrows});
    debugPrint("[mmPlayMAS] pattern_ptr_offset={d} patt_peek={d}\n", .{ debug_state.pattern_ptr_offset, debug_state.patt_peek });
    debugPrint("[mpp_setbpm] tickrate={d}\n", .{debug_state.tickrate});
    debugPrint("[mmPlayMAS] layer1={any}\n", .{debug_state.layer1});
    debugPrint("[mmPlayMAS] header_channel_volumes={any}\n", .{debug_state.header_channel_volumes});
    debugPrint("[mmPlayMAS] header_channel_panning={any}\n", .{debug_state.header_channel_panning});
    debugPrint("[mmPlayMAS] new_bitmask={x}\n", .{debug_state.new_bitmask});
    debugPrint("[mmPlayMAS] remaining_lens={any}\n", .{debug_state.remaining_lens});
    debugPrint("[mmPlayMAS] mp_mix_seg_vblank1={d}\n", .{debug_state.mp_mix_seg_vblank1});
    debugPrint("[mmPlayMAS] tick_data_sampcount={d}\n", .{debug_state.tick_data_sampcount});
    debugPrint("[readPattern] mpp_layer_update_bits={any}\n", .{debug_state.mpp_layer_update_bits});
    if (debug_state.mix_len > 0) {
        debugPrint("[MIX] count={d}\n", .{debug_state.mix_len});
        var m: usize = 0;
        while (m < debug_state.mix_len) : (m += 1) {
            const ev = debug_state.mix_events[m];
            const stage_str = switch (ev.stage) {
                'L', 'l' => "loop",
                else => "final",
            };
            debugPrint(
                "[MIX] stage={s} samples={d} data={d} {d} {d} {d} {d} {d} {d} {d}\n",
                .{ stage_str, ev.samples, ev.data[0], ev.data[1], ev.data[2], ev.data[3], ev.data[4], ev.data[5], ev.data[6], ev.data[7] },
            );
        }
    }
    gba.debug.write("END debug_state=================>") catch {};
    debug_state.t0_len = 0;
    debug_state.spv_len = 0;
    debug_state.dap_len = 0;
    debug_state.vol_len = 0;
    debug_state.umix_update_len = 0;
    debug_state.mix_len = 0;
    debug_state.upd_len = 0;
}
