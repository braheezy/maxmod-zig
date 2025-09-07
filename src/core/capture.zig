const std = @import("std");
const mm = @import("../maxmod.zig");

// Compile-time switch to ensure capture has zero cost when disabled
const debug_enabled = @import("build_options").xm_debug;

pub const Kind = enum(u8) {
    UmixSetPitch, // a=period, b=freq, c=fvol, d=unused
    UmixAudible,  // a=ch, b=vol, c=pan, d=stopped
    UmixSnap,     // a=ch, b=flags, c=sample, d=read (src printed as extra)
    Bind,         // a=ch, b=msl_id, c=src, d=def_freq (len printed as extra)
    PatternSnap,  // a=entry, b=row_count, c=pattern_ptr, d=unused
    ReadPatStart, // a=pattread, b=pattread_p, c=nch, d=row
    Start,        // a=ch, b=inst, c=sample, d=flags
    Stop,         // a=ch, b=reason, c=src_hi, d=src_lo
};

pub const Event = packed struct {
    kind: Kind,
    // row/pos/tick at capture time
    position: u16,
    row: u8,
    tick: u8,
    a: i32,
    b: i32,
    c: i32,
    d: i32,
    extra: u32, // optional payload (e.g., src pointer or length)
};

// Small ring buffer — large enough to hold one tick worth of traces
// Big enough to hold many events within a tick without perturbing timing
var buf: [4096]Event = undefined;
var widx: usize = 0;

inline fn layerSnapshot(layer: [*c]const mm.LayerInfo) struct { pos: u16, row: u8, tick: u8 } {
    return .{ .pos = layer.*.position, .row = layer.*.row, .tick = layer.*.tick };
}

pub inline fn capture(layer: [*c]const mm.LayerInfo, kind: Kind, a: i32, b: i32, c: i32, d: i32, extra: u32) void {
    if (!debug_enabled) return;
    const snap = layerSnapshot(layer);
    const i = widx % buf.len;
    buf[i] = .{
        .kind = kind,
        .position = snap.pos,
        .row = snap.row,
        .tick = snap.tick,
        .a = a,
        .b = b,
        .c = c,
        .d = d,
        .extra = extra,
    };
    widx +%= 1;
}

pub fn dump() void {
    if (!debug_enabled) return;
    if (widx == 0) return;
    const gba_dbg = @import("gba").debug;
    var i: usize = 0;
    while (i < @min(widx, buf.len)) : (i += 1) {
        const e = buf[i];
        switch (e.kind) {
            .UmixSetPitch => gba_dbg.print(
                "[UMIX] set_pitch period={d} freq={d} fvol={d} @ pos={d} row={d} tick={d}\n",
                .{ e.a, e.b, e.c, e.position, e.row, e.tick },
            ) catch {},
            .UmixAudible => gba_dbg.print(
                "[UMIX] audible ch={d} vol={d} pan={d} stopped={d} @ pos={d} row={d} tick={d}\n",
                .{ e.a, e.b, e.c, e.d, e.position, e.row, e.tick },
            ) catch {},
            .UmixSnap => gba_dbg.print(
                "[UMIX] ch={d} flags={x:0>2} sample={d} src0={x:0>8} read0={d} @ pos={d} row={d} tick={d}\n",
                .{ e.a, e.b, e.c, e.extra, e.d, e.position, e.row, e.tick },
            ) catch {},
            .Bind => gba_dbg.print(
                "[BIND] ch={d} id={d} src={x} def_freq={d} len={d} @ pos={d} row={d} tick={d}\n",
                .{ e.a, e.b, e.c, e.d, e.extra, e.position, e.row, e.tick },
            ) catch {},
            .PatternSnap => gba_dbg.print(
                "[PATT] entry={d} ptr=0x{x} rows={d} @ pos={d} row={d} tick={d}\n",
                .{ e.a, e.c, e.b, e.position, e.row, e.tick },
            ) catch {},
            .Start => gba_dbg.print(
                "[START] ch={d} inst={d} sample={d} flags={x:0>2} @ pos={d} row={d} tick={d}\n",
                .{ e.a, e.b, e.c, e.d, e.position, e.row, e.tick },
            ) catch {},
            .Stop => gba_dbg.print(
                "[STOP] ch={d} reason={d} src_hi={x:0>4} src_lo={x:0>4} @ pos={d} row={d} tick={d}\n",
                .{ e.a, e.b, e.c, e.d, e.position, e.row, e.tick },
            ) catch {},
            .ReadPatStart => blk: {
                gba_dbg.print(
                    "[PREAD] pattread=0x{x} pattread_p=0x{x} nch={d} row={d}\n",
                    .{ e.a, e.b, e.c, e.d },
                ) catch {};
                const p: [*]const u8 = @ptrFromInt(@as(usize, @intCast(@as(u32, @bitCast(e.b)))));
                const b0 = p[0]; const b1 = p[1]; const b2 = p[2]; const b3 = p[3];
                const b4 = p[4]; const b5 = p[5]; const b6 = p[6]; const b7 = p[7];
                gba_dbg.print("[PBYTES] {x:0>2} {x:0>2} {x:0>2} {x:0>2} {x:0>2} {x:0>2} {x:0>2} {x:0>2}\n", .{ b0, b1, b2, b3, b4, b5, b6, b7 }) catch {};
                break :blk;
            },
        }
    }
    // reset after flush
    widx = 0;
}
