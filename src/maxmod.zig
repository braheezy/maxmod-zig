pub const sfx = @import("core/effect.zig");
pub const mas = @import("core/mas.zig");
pub const gba = @import("gba/main_gba.zig");
pub const mixer = @import("gba/mixer.zig");
pub const shim = @import("shim.zig");

// Conditionally pull in pure Zig mixer implementation
comptime {
    if (@import("build_options").use_zig_mixer) {
        _ = @import("mixer.zig");
    }
}

pub const Word = u32;
pub const Hword = u16;
pub const Sword = i32;
pub const Shword = i16;
pub const Byte = u8;
pub const Sbyte = i8;
pub const Sfxhand = u16;
pub const Addr = ?*anyopaque;

pub const LayerInfo = extern struct {
    // current tick count
    tick: Byte = 0,
    // current row being played
    row: Byte = 0,
    // module sequence position
    position: Byte = 0,
    // number of rows in current pattern
    nrows: Byte = 0,
    // global volume multiplier
    global_volume: Byte = 0,
    // speed of module (ticks / row)
    speed: Byte = 0,
    // module is active
    isplaying: Byte = 0,
    // tempo of module
    bpm: Byte = 0,
    // table of offsets (from MasHead base) to instrument data
    insttable: [*c]Word = @import("std").mem.zeroes([*c]Word),
    // table of offsets (from MasHead base) to sample data
    samptable: [*c]Word = @import("std").mem.zeroes([*c]Word),
    // table of offsets (from MasHead base) to pattern data
    patttable: [*c]Word = @import("std").mem.zeroes([*c]Word),
    // pointer to the current MAS module being played
    songadr: [*c]MasHead = @import("std").mem.zeroes([*c]MasHead),

    flags: Byte = 0,
    oldeffects: Byte = 0,
    pattjump: Byte = 0,
    pattjump_row: Byte = 0,
    fpattdelay: Byte = 0,
    pattdelay: Byte = 0,

    // variables used for pattern loops
    ploop_row: Byte = 0,
    ploop_times: Byte = 0,
    ploop_adr: [*c]Byte = @import("std").mem.zeroes([*c]Byte),

    pattread: [*c]Byte = @import("std").mem.zeroes([*c]Byte),
    ploop_jump: Byte = 0,
    valid: Byte = 0,
    // 1.15 fixed point OR sample count
    tickrate: Hword = 0,
    tick_data: TickData = @import("std").mem.zeroes(TickData),
    mode: Byte = 0,
    reserved2: Byte = 0,
    mch_update: Word = 0,
    volume: Hword = 0,
    reserved3: Hword = 0,
};
pub const MasHead = extern struct {
    // TODO: mmutil always exports 200. This is unused.
    order_count: Byte = 0,
    instr_count: Byte = 0,
    sampl_count: Byte = 0,
    pattn_count: Byte = 0,
    flags: Byte = 0,
    global_volume: Byte = 0,
    initial_speed: Byte = 0,
    initial_tempo: Byte = 0,
    repeat_position: Byte = 0,
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
    // allocated active channel number
    alloc: Byte = 0,
    // pattern comression flags, called "maskvariable" in ITTECH.TXT
    cflags: Byte = 0,
    panning: Byte = 0,
    // volume column command
    volcmd: Byte = 0,
    // effect number
    effect: Byte = 0,
    // effect parameter
    param: Byte = 0,
    // effect memory
    fxmem: Byte = 0,
    // translated note
    note: Byte = 0,
    // channel flags
    flags: Byte = 0,
    // instrument#
    inst: Byte = 0,
    // playback flags (unused)
    pflags: Byte = 0,
    vibdep: Byte = 0,
    vibspd: Byte = 0,
    vibpos: Byte = 0,
    volume: Byte = 0,
    cvolume: Byte = 0,
    period: Word = 0,
    bflags: Hword = 0,
    // pattern note
    pnoter: Byte = 0,
    memory: [15]Byte = @import("std").mem.zeroes([15]Byte),
    padding: [2]Byte = @import("std").mem.zeroes([2]Byte),
};
pub const ActiveChannel = extern struct {
    // internal period
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
    // can store this anywhere
    sfx: Byte = 0,
};
// A GBA mixer channel is active if "src & (1 << 31)" is zero.
pub const MixerChannel = extern struct {
    src: usize = 0,
    //  fixed point 20.12. See MP_SAMPFRAC
    read: Word = 0,
    vol: Byte = 0,
    pan: Byte = 0,
    unused_0: Byte = 0,
    unused_1: Byte = 0,
    freq: Word = 0,
};

const TickData = extern union {
    // sample timing
    sampcount: Hword,
    // vsync timing 0.16 fixed point
    tickfrac: Hword,
};
