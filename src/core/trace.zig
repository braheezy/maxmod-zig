const mm = @import("../maxmod.zig");
const mixer = @import("../gba/mixer.zig");

const debug_enabled = @import("build_options").xm_debug;

pub const ChanState = struct {
    ch: u8 = 0,
    // ModuleChannel snapshot
    m_flags: u8 = 0,
    m_cflags: u8 = 0,
    m_inst: u8 = 0,
    m_note: u8 = 0,
    m_pnoter: u8 = 0,
    m_volcmd: u8 = 0,
    m_effect: u8 = 0,
    m_param: u8 = 0,
    // ActiveChannel snapshot
    a_type: u8 = 0,
    a_flags: u8 = 0,
    a_inst: u8 = 0,
    a_samp: u8 = 0,
    a_vol: u8 = 0,
    a_fvol: u8 = 0,
    a_pan: u8 = 0,
    a_per: u32 = 0,
    // Mixer snapshot
    x_src: u32 = 0,
    x_read: u32 = 0,
    x_vol: u8 = 0,
    x_pan: u8 = 0,
    x_freq: u32 = 0,
};

pub const FrameState = struct {
    pos: u8 = 0,
    row: u8 = 0,
    tick: u8 = 0,
    nrows: u8 = 0,
    patt_ptr: usize = 0,
    pattread: usize = 0,
    update_bits: u32 = 0,
    chans: [3]ChanState = .{ .{}, .{}, .{} },
};

var cur: FrameState = .{};

pub inline fn begin(layer: [*c]const mm.LayerInfo) void {
    if (!debug_enabled) return;
    cur = .{};
    cur.pos = layer.*.position;
    cur.row = layer.*.row;
    cur.tick = layer.*.tick;
    cur.nrows = layer.*.nrows;
    cur.patt_ptr = @intFromPtr(layer.*.pattread) - 1; // row_count at patt_ptr-1
    cur.pattread = @intFromPtr(layer.*.pattread);
    cur.update_bits = layer.*.mch_update;
}

pub inline fn fillChannels(layer: [*c]const mm.LayerInfo, pch: [*c]const mm.ModuleChannel) void {
    if (!debug_enabled) return;
    _ = layer; // not used yet
    const idxs = [_]u8{ 0, 1, 9 };
    var i: usize = 0;
    while (i < idxs.len) : (i += 1) {
        const ch = idxs[i];
        var s: *ChanState = &cur.chans[i];
        s.ch = ch;
        const mc: [*c]const mm.ModuleChannel = pch + ch;
        s.m_flags = mc.*.flags;
        s.m_cflags = mc.*.cflags;
        s.m_inst = mc.*.inst;
        s.m_note = mc.*.note;
        s.m_pnoter = mc.*.pnoter;
        s.m_volcmd = mc.*.volcmd;
        s.m_effect = mc.*.effect;
        s.m_param = mc.*.param;
        // Use exported symbol via gba module
        const base_ach: [*c]const mm.ActiveChannel = @import("../gba/main_gba.zig").achannels;
        const a: [*c]const mm.ActiveChannel = base_ach + ch;
        s.a_type = a.*._type;
        s.a_flags = a.*.flags;
        s.a_inst = a.*.inst;
        s.a_samp = a.*.sample;
        s.a_vol = a.*.volume;
        s.a_fvol = a.*.fvol;
        s.a_pan = a.*.panning;
        s.a_per = a.*.period;
        const mx: [*c]const mm.MixerChannel = mixer.mm_mix_channels + ch;
        s.x_src = mx.*.src;
        s.x_read = mx.*.read;
        s.x_vol = mx.*.vol;
        s.x_pan = mx.*.pan;
        s.x_freq = mx.*.freq;
    }
}

pub inline fn dump() void {
    if (!debug_enabled) return;
    const dbg = @import("gba").debug;
    dbg.print("[TRACE] pos={d} row={d} tick={d} nrows={d} patt=0x{x} read=0x{x} upd={x}\n",
        .{ cur.pos, cur.row, cur.tick, cur.nrows, cur.patt_ptr, cur.pattread, cur.update_bits }) catch {};
    var i: usize = 0;
    while (i < cur.chans.len) : (i += 1) {
        const s = cur.chans[i];
        dbg.print(
            "[CH] {d} mf={x:0>2} cf={x:0>2} inst={d} note={d} pnr={d} vcmd={x:0>2} eff={x:0>2} par={x:0>2} | at={d} af={x:0>2} ai={d} as={d} av={d} afv={d} ap={d} per={d} | xs={x} xr={d} xv={d} xp={d} xf={d}\n",
            .{ s.ch, s.m_flags, s.m_cflags, s.m_inst, s.m_note, s.m_pnoter, s.m_volcmd, s.m_effect, s.m_param,
               s.a_type, s.a_flags, s.a_inst, s.a_samp, s.a_vol, s.a_fvol, s.a_pan, s.a_per,
               s.x_src, s.x_read, s.x_vol, s.x_pan, s.x_freq },
        ) catch {};
    }
}
