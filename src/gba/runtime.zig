//! Static-storage convenience setup for the MaxMod GBA runtime.

const mm = @import("../maxmod.zig");
const gba = @import("main_gba.zig");

/// Compile-time configuration for a GBA MaxMod runtime.
pub const RuntimeConfig = struct {
    mixing_mode: gba.MixMode = ._8khz,
    module_channels: u8,
    mix_channels: u8,
};

/// Return a MaxMod GBA runtime with statically allocated, correctly aligned
/// mixer storage.
///
/// The caller owns the soundbank, interrupt hookup, and music/effect policy.
/// `init` only constructs the existing `GBASystem` and initializes MaxMod.
pub fn Runtime(comptime config: RuntimeConfig) type {
    if (config.module_channels == 0 or config.module_channels > 32) {
        @compileError("MaxMod module_channels must be between 1 and 32");
    }
    if (config.mix_channels == 0 or config.mix_channels > 32) {
        @compileError("MaxMod mix_channels must be between 1 and 32");
    }

    const mixing_buffer_byte_len = gba.mixingBufferByteLen(config.mixing_mode);

    return struct {
        const Self = @This();

        module_channels: [config.module_channels]mm.ModuleChannel align(4) = [_]mm.ModuleChannel{.{}} ** config.module_channels,
        active_channels: [config.mix_channels]mm.ActiveChannel align(4) = [_]mm.ActiveChannel{.{}} ** config.mix_channels,
        mixing_channels: [config.mix_channels]mm.MixerChannel align(4) = [_]mm.MixerChannel{.{}} ** config.mix_channels,
        mixing_memory: [mixing_buffer_byte_len / @sizeOf(u32)]u32 align(4) = [_]u32{0} ** (mixing_buffer_byte_len / @sizeOf(u32)),
        wave_memory: [mixing_buffer_byte_len]u8 align(4) = [_]u8{0} ** mixing_buffer_byte_len,

        /// Initialize MaxMod with this runtime's static storage and soundbank.
        pub fn init(self: *Self, soundbank: []const u8) error{InvalidConfiguration}!void {
            if (soundbank.len == 0) return error.InvalidConfiguration;
            var setup: gba.GBASystem = .{
                .mixing_mode = config.mixing_mode,
                .mod_channel_count = config.module_channels,
                .mix_channel_count = config.mix_channels,
                .module_channels = @ptrCast(&self.module_channels[0]),
                .active_channels = @ptrCast(&self.active_channels[0]),
                .mixing_channels = @ptrCast(&self.mixing_channels[0]),
                .mixing_memory = @ptrCast(&self.mixing_memory[0]),
                .wave_memory = @ptrCast(&self.wave_memory[0]),
                .soundbank = @ptrCast(@constCast(soundbank.ptr)),
            };
            if (!gba.init(&setup)) return error.InvalidConfiguration;
        }
    };
}

test "Runtime allocates storage for its configured mixing mode" {
    const runtime_type = Runtime(.{
        .mixing_mode = ._13khz,
        .module_channels = 4,
        .mix_channels = 6,
    });
    try @import("std").testing.expectEqual(@as(usize, 896), runtime_type.mixing_buffer_byte_len);
    try @import("std").testing.expectEqual(@as(usize, 4), runtime_type.module_channels.len);
    try @import("std").testing.expectEqual(@as(usize, 6), runtime_type.mixing_channels.len);
}
