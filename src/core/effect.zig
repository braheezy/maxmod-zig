const mm = @import("../maxmod.zig");
const mixer = @import("../gba/mixer.zig");
const mm_gba = @import("../gba/main_gba.zig");
const shim = @import("../shim.zig");
const mas = @import("mas.zig");

pub const LoopData = extern union {
    loop_length: mm.Word,
    length: mm.Word,
};
const DsSample = extern struct {
    loop_start: mm.Word = 0,
    loop_data: LoopData = @import("std").mem.zeroes(LoopData),
    format: mm.Byte = 0,
    repeat_mode: mm.Byte = 0,
    base_rate: mm.Hword = 0,
    data: mm.Addr = @import("std").mem.zeroes(mm.Addr),
};
const SampleData = extern union {
    id: mm.Word,
    sample: [*c]DsSample,
};
const SoundEffect = extern struct {
    sample_data: SampleData = @import("std").mem.zeroes(SampleData),
    rate: mm.Hword = 0,
    handle: mm.Sfxhand = 0,
    volume: mm.Byte = 0,
    panning: mm.Byte = 0,
};
const MasGbaSample = extern struct {
    length: mm.Word align(4) = 0,
    loop_length: mm.Word = 0,
    format: mm.Byte = 0,
    reserved: mm.Byte = 0,
    default_frequency: mm.Hword = 0,

    pub fn data(self: anytype) @import("std").zig.c_translation.FlexibleArrayType(@TypeOf(self), u8) {
        const Intermediate = @import("std").zig.c_translation.FlexibleArrayType(@TypeOf(self), u8);
        const ReturnType = @import("std").zig.c_translation.FlexibleArrayType(@TypeOf(self), u8);
        return @as(ReturnType, @ptrCast(@alignCast(@as(Intermediate, @ptrCast(self)) + 12)));
    }
};
const MasPrefix = extern struct {
    size: mm.Word = 0,
    type: mm.Byte = 0,
    version: mm.Byte = 0,
    reserved: [2]mm.Byte = @import("std").mem.zeroes([2]mm.Byte),
};

var sfx_mastervolume: mm.Word = 0;
const sfx_channel_state = extern struct {
    mix_channel: mm.Byte = 0,
    counter: mm.Byte = 0,
};
var sfx_channels: [16]sfx_channel_state = @import("std").mem.zeroes([16]sfx_channel_state);
var sfx_bitmask: mm.Word = 0;
var sfx_counter: mm.Byte = 0;

pub fn effect(sample_ID: mm.Word) mm.Sfxhand {
    var eff: SoundEffect = SoundEffect{
        .sample_data = SampleData{
            .id = sample_ID,
        },
        .rate = 1024,
        .handle = 0,
        .volume = 255,
        .panning = 128,
    };
    return effectEx(&eff);
}
pub fn effectEx(sound: [*c]SoundEffect) mm.Sfxhand {
    if (sound.*.sample_data.id >= mm_gba.getSampleCount()) return 0;
    const sfx_channel = -1;
    var mix_channel = 255;
    var sfx_count: mm.Byte = undefined;
    var reused_handle: bool = false;
    if (sound.*.handle != 0) {
        mix_channel = getMixChannelIndex(sound.*.handle);
        if (mix_channel >= 0) {
            sfx_channel = (sound.*.handle & 255) - 1;
            sfx_count = @as(mm.Byte, @bitCast(@as(i8, @truncate(sound.*.handle >> 8))));
            reused_handle = true;
        }
    }
    if (!reused_handle) {
        sfx_channel = getFreeSfxChannel();
        if (sfx_channel < 0) return 0;
        mix_channel = @bitCast(mas.allocChannel());
        if (mix_channel == 255) return 0;
        sfx_count = sfx_counter;
        sfx_counter +%= 1;
    }
    const handle: mm.Sfxhand = @bitCast((sfx_count << 8) | (sfx_channel + 1));
    sfx_channels[@as(c_uint, @intCast(sfx_channel))].mix_channel = @as(mm.Byte, @bitCast(@as(i8, @truncate(mix_channel + 1))));
    sfx_channels[@as(c_uint, @intCast(sfx_channel))].counter = sfx_count;
    sfx_bitmask |= @as(mm.Word, @bitCast(1 << @intCast(sfx_channel)));
    const act_ch: [*c]mm.ActiveChannel = &(blk: {
        const tmp = mix_channel;
        if (tmp >= 0) break :blk mm_gba.achannels + @as(usize, @intCast(tmp)) else break :blk mm_gba.achannels - ~@as(usize, @bitCast(@as(isize, @intCast(tmp)) +% -1));
    }).*;
    act_ch.*.fvol = 200;
    if (@as(c_int, @bitCast(@as(c_uint, handle))) == 0) {
        act_ch.*._type = 2;
    } else {
        act_ch.*._type = 4;
    }
    act_ch.*.flags = @as(mm.Byte, @bitCast(@as(i8, @truncate(1 << @intCast(7)))));
    const mix_ch: [*c]volatile mm.MixerChannel = &(blk: {
        const tmp = mix_channel;
        if (tmp >= 0) break :blk mixer.mm_mix_channels + @as(usize, @intCast(tmp)) else break :blk mixer.mm_mix_channels - ~@as(usize, @bitCast(@as(isize, @intCast(tmp)) +% -1));
    }).*;
    const sample_offset: usize = @as(usize, @intCast(mm_gba.getSampleTable()[sound.*.sample_data.id & 65535]));
    const sample_addr: [*c]mm.Byte = @as([*c]mm.Byte, @ptrCast(@alignCast(mm_gba.mp_solution))) + sample_offset;
    const sample: [*c]MasGbaSample = @as([*c]MasGbaSample, @ptrCast(@alignCast(sample_addr + @sizeOf(MasPrefix))));
    mix_ch.*.src = @intFromPtr(&sample.*.data()[0]);
    mix_ch.*.freq = @as(mm.Word, @bitCast((@as(c_int, @bitCast(@as(c_uint, sound.*.rate))) * @as(c_int, @bitCast(@as(c_uint, sample.*.default_frequency)))) >> @intCast(10 - 2)));
    mix_ch.*.read = 0;
    mix_ch.*.vol = @as(mm.Byte, @bitCast(@as(u8, @truncate((@as(mm.Word, @bitCast(@as(c_uint, sound.*.volume))) *% sfx_mastervolume) >> @intCast(10)))));
    mix_ch.*.pan = sound.*.panning;
    return handle;
}
pub fn effectVolume(handle: mm.Sfxhand, volume: mm.Word) void {
    var vol = volume;
    const mix_channel = getMixChannelIndex(handle);
    if (mix_channel < 0) return;
    const shift = 10;
    vol = (vol *% sfx_mastervolume) >> @intCast(shift);
    mixer.setVolume(mix_channel, vol);
}
pub fn effectPanning(handle: mm.Sfxhand, panning: mm.Byte) void {
    const mix_channel = getMixChannelIndex(handle);
    if (mix_channel < 0) return;
    mixer.setPan(mix_channel, panning);
}
pub fn effectRate(handle: mm.Sfxhand, rate: mm.Word) void {
    const mix_channel = getMixChannelIndex(handle);
    if (mix_channel < 0) return;
    mixer.setFreq(mix_channel, rate);
}
pub fn effectScaleRate(handle: mm.Sfxhand, factor: mm.Word) void {
    const mix_channel = getMixChannelIndex(handle);
    if (mix_channel < 0) return;
    mixer.mulFreq(mix_channel, factor);
}
pub fn effectActive(handle: mm.Sfxhand) bool {
    const mix_channel = getMixChannelIndex(handle);
    if (mix_channel < 0) return false;
    return true;
}
pub fn effectCancel(handle: mm.Sfxhand) mm.Word {
    const mix_channel = getMixChannelIndex(handle);
    if (mix_channel < 0) return 0;
    const act_ch: [*c]mm.ActiveChannel = &(blk: {
        const tmp = mix_channel;
        if (tmp >= 0) break :blk mm_gba.achannels + @as(usize, @intCast(tmp)) else break :blk mm_gba.achannels - ~@as(usize, @bitCast(@as(isize, @intCast(tmp)) +% -1));
    }).*;
    act_ch.*._type = 2;
    act_ch.*.fvol = 0;
    const sfx_channel: mm.Word = @as(mm.Word, @bitCast((@as(c_int, @bitCast(@as(c_uint, handle))) & 255) - 1));
    clearSfxChannel(@as(c_int, @bitCast(sfx_channel)));
    mixer.stopChannel(mix_channel);
    return 1;
}
pub fn effectRelease(handle: mm.Sfxhand) void {
    const mix_channel = getMixChannelIndex(handle);
    if (mix_channel < 0) return;
    const act_ch: [*c]mm.ActiveChannel = &(blk: {
        const tmp = mix_channel;
        if (tmp >= 0) break :blk mm_gba.achannels + @as(usize, @intCast(tmp)) else break :blk mm_gba.achannels - ~@as(usize, @bitCast(@as(isize, @intCast(tmp)) +% -1));
    }).*;
    act_ch.*._type = 2;
    const sfx_channel: mm.Word = @as(mm.Word, @bitCast((@as(c_int, @bitCast(@as(c_uint, handle))) & 255) - 1));
    clearSfxChannel(@as(c_int, @bitCast(sfx_channel)));
}
pub fn setEffectsVolume(volume: mm.Word) void {
    var vol = volume;
    if (vol > 1024) {
        vol = 1024;
    }
    sfx_mastervolume = vol;
}
pub fn effectCancelAll() void {
    resetEffects();
    var mix_ch: [*c]volatile mm.MixerChannel = &mixer.mm_mix_channels[0];
    var act_ch: [*c]mm.ActiveChannel = &mm_gba.achannels[0];
    {
        var i: mm.Word = 0;
        while (i < mm_gba.num_ach) : (_ = blk: {
            _ = blk_1: {
                i +%= 1;
                break :blk_1 blk_2: {
                    const ref = &act_ch;
                    const tmp = ref.*;
                    ref.* += 1;
                    break :blk_2 tmp;
                };
            };
            break :blk blk_1: {
                const ref = &mix_ch;
                const tmp = ref.*;
                ref.* += 1;
                break :blk_1 tmp;
            };
        }) {
            if ((@as(c_int, @bitCast(@as(c_uint, act_ch.*.flags))) & (1 << 7)) == 0) continue;
            mix_ch.*.src = shim.MIXCH_GBA_SRC_STOPPED;
        }
    }
}
pub fn resetEffects() void {
    {
        var i: usize = 0;
        while (i < 16) : (i += 1) {
            sfx_channels[i].counter = 0;
            sfx_channels[i].mix_channel = 0;
        }
    }
    sfx_bitmask = 0;
}
pub fn updateEffects() void {
    var new_bitmask: mm.Word = 0;

    var i: usize = 0;
    while (i < 16) : (i += 1) {
        if ((sfx_bitmask & (@as(usize, 1) << @intCast(i))) == 0) continue;
        const mix_channel = sfx_channels[i].mix_channel - 1;
        if (mix_channel < 0) continue;
        const mix_ch: [*c]volatile mm.MixerChannel = &(blk: {
            const tmp = mix_channel;
            if (tmp >= 0) break :blk mixer.mm_mix_channels + @as(usize, @intCast(tmp)) else break :blk mixer.mm_mix_channels - ~@as(usize, @bitCast(@as(isize, @intCast(tmp)) - 1));
        }).*;
        if ((mix_ch.*.src & shim.MIXCH_GBA_SRC_STOPPED) == 0) {
            new_bitmask |= @as(usize, 1) << @intCast(i);
            continue;
        }
        const act_ch: [*c]mm.ActiveChannel = &(blk: {
            const tmp = mix_channel;
            if (tmp >= 0) break :blk mm_gba.achannels + @as(usize, @intCast(tmp)) else break :blk mm_gba.achannels - ~@as(usize, @bitCast(@as(isize, @intCast(tmp)) +% -1));
        }).*;
        act_ch.*._type = 0;
        act_ch.*.flags = 0;
        sfx_channels[i].counter = 0;
        sfx_channels[i].mix_channel = 0;
    }
    shim.debug_state.new_bitmask = new_bitmask;

    sfx_bitmask = new_bitmask;
}
pub fn getMixChannelIndex(handle: mm.Sfxhand) c_int {
    const sfx_channel = (@as(c_int, @bitCast(@as(c_uint, handle))) & 255) - 1;

    const handle_counter = @as(mm.Byte, @bitCast(@as(i8, @truncate(@as(c_int, @bitCast(@as(c_uint, handle))) >> @intCast(8)))));

    if (sfx_channel < 0) return -1;
    if (sfx_channel >= 16) return -1;
    const state: [*c]sfx_channel_state = &sfx_channels[@as(c_uint, @intCast(sfx_channel))];

    if (@as(c_int, @bitCast(@as(c_uint, state.*.counter))) != @as(c_int, @bitCast(@as(c_uint, handle_counter)))) return -1;
    return @as(c_int, @bitCast(@as(c_uint, state.*.mix_channel))) - 1;
}
pub fn clearSfxChannel(arg_sfx_channel: c_int) void {
    const sfx_channel = arg_sfx_channel;
    sfx_channels[@as(c_uint, @intCast(sfx_channel))].counter = 0;
    sfx_channels[@as(c_uint, @intCast(sfx_channel))].mix_channel = 0;
    const bit_flag: mm.Word = 1 << @intCast(sfx_channel);
    sfx_bitmask &= ~bit_flag;
}
pub fn getFreeSfxChannel() callconv(.c) c_int {
    {
        var i = 0;
        while (i < 16) : (i += 1) {
            if ((sfx_bitmask & @as(mm.Word, 1 << i)) != 0) continue;
            return i;
        }
    }
    return -1;
}
