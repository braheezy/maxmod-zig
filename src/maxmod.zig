pub const sfx = @import("core/effect.zig");
pub const mas = @import("core/mas.zig");
pub const gba = @import("gba/main_gba.zig");
pub const mixer = @import("gba/mixer.zig");
pub const shim = @import("shim.zig");

pub const Word = u32;
pub const Hword = u16;
pub const Sword = i32;
pub const Byte = u8;
pub const Sbyte = i8;
pub const Sfxhand = u16;

pub const Addr = ?*anyopaque;

pub const LayerInfo = extern struct {
    tick: Byte = @import("std").mem.zeroes(Byte),
    row: Byte = @import("std").mem.zeroes(Byte),
    position: Byte = @import("std").mem.zeroes(Byte),
    nrows: Byte = @import("std").mem.zeroes(Byte),
    global_volume: Byte = @import("std").mem.zeroes(Byte),
    speed: Byte = @import("std").mem.zeroes(Byte),
    isplaying: Byte = @import("std").mem.zeroes(Byte),
    bpm: Byte = @import("std").mem.zeroes(Byte),
    insttable: [*c]Word = @import("std").mem.zeroes([*c]Word),
    samptable: [*c]Word = @import("std").mem.zeroes([*c]Word),
    patttable: [*c]Word = @import("std").mem.zeroes([*c]Word),
    songadr: [*c]MasHead = @import("std").mem.zeroes([*c]MasHead),
    flags: Byte = @import("std").mem.zeroes(Byte),
    oldeffects: Byte = @import("std").mem.zeroes(Byte),
    pattjump: Byte = @import("std").mem.zeroes(Byte),
    pattjump_row: Byte = @import("std").mem.zeroes(Byte),
    fpattdelay: Byte = @import("std").mem.zeroes(Byte),
    pattdelay: Byte = @import("std").mem.zeroes(Byte),
    ploop_row: Byte = @import("std").mem.zeroes(Byte),
    ploop_times: Byte = @import("std").mem.zeroes(Byte),
    ploop_adr: [*c]Byte = @import("std").mem.zeroes([*c]Byte),
    pattread: [*c]Byte = @import("std").mem.zeroes([*c]Byte),
    ploop_jump: Byte = @import("std").mem.zeroes(Byte),
    valid: Byte = @import("std").mem.zeroes(Byte),
    tickrate: Hword = 0,
    tick_data: TickData = @import("std").mem.zeroes(TickData),
    mode: Byte = @import("std").mem.zeroes(Byte),
    reserved2: Byte = @import("std").mem.zeroes(Byte),
    mch_update: Word = 0,
    volume: Hword = 0,
    reserved3: Hword = 0,
};

const TickData = extern union {
    sampcount: Hword,
    tickfrac: Hword,
};

pub const MasHead = extern struct {
    order_count: Byte = @import("std").mem.zeroes(Byte),
    instr_count: Byte = @import("std").mem.zeroes(Byte),
    sampl_count: Byte = @import("std").mem.zeroes(Byte),
    pattn_count: Byte = @import("std").mem.zeroes(Byte),
    flags: Byte = @import("std").mem.zeroes(Byte),
    global_volume: Byte = @import("std").mem.zeroes(Byte),
    initial_speed: Byte = @import("std").mem.zeroes(Byte),
    initial_tempo: Byte = @import("std").mem.zeroes(Byte),
    repeat_position: Byte = @import("std").mem.zeroes(Byte),
    reserved: [3]Byte = @import("std").mem.zeroes([3]Byte),
    channel_volume: [32]Byte = @import("std").mem.zeroes([32]Byte),
    channel_panning: [32]Byte = @import("std").mem.zeroes([32]Byte),
    sequence: [200]Byte = @import("std").mem.zeroes([200]Byte),

    pub fn tables(self: anytype) @import("std").zig.c_translation.FlexibleArrayType(@TypeOf(self), ?*anyopaque) {
        const Intermediate = @import("std").zig.c_translation.FlexibleArrayType(@TypeOf(self), u8);
        const ReturnType = @import("std").zig.c_translation.FlexibleArrayType(@TypeOf(self), ?*anyopaque);
        return @as(ReturnType, @ptrCast(@alignCast(@as(Intermediate, @ptrCast(self)) + 276)));
    }
};

pub const ModuleChannel = extern struct {
    alloc: Byte = 0,
    cflags: Byte = 0,
    panning: Byte = 0,
    volcmd: Byte = 0,
    effect: Byte = 0,
    param: Byte = 0,
    fxmem: Byte = 0,
    note: Byte = 0,
    flags: Byte = 0,
    inst: Byte = 0,
    pflags: Byte = 0,
    vibdep: Byte = 0,
    vibspd: Byte = 0,
    vibpos: Byte = 0,
    volume: Byte = 0,
    cvolume: Byte = 0,
    period: Word = 0,
    bflags: Hword = 0,
    pnoter: Byte = 0,
    memory: [15]Byte = @import("std").mem.zeroes([15]Byte),
    padding: [2]Byte = @import("std").mem.zeroes([2]Byte),
};
pub const ActiveChannel = extern struct {
    period: Word = 0,
    fade: Hword = 0,
    envc_vol: Hword = 0,
    envc_pan: Hword = 0,
    envc_pic: Hword = 0,
    avib_dep: Hword = 0,
    avib_pos: Hword = 0,
    fvol: Byte = 0,
    _type: Byte = 0,
    inst: Byte = 0,
    panning: Byte = 0,
    volume: Byte = 0,
    sample: Byte = 0,
    parent: Byte = 0,
    flags: Byte = 0,
    envn_vol: Byte = 0,
    envn_pan: Byte = 0,
    envn_pic: Byte = 0,
    sfx: Byte = 0,
};
pub const MixerChannel = extern struct {
    src: usize = 0,
    read: Word = 0,
    vol: Byte = 0,
    pan: Byte = 0,
    unused_0: Byte = 0,
    unused_1: Byte = 0,
    freq: Word = 0,
};
