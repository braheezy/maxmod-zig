const audio = @import("audio.zig");
const player = @import("player.zig");

pub fn init() void {
    audio.init();
}

pub fn disableAllDma() void {
    audio.silenceAllDma();
}

pub fn loadMmraw(data: []const u8) !void { try player.loadMmrawSlice(data); }

pub fn play() void {
    player.play();
}

pub fn stop() void {
    player.stop();
}

pub fn tick() void {
    player.frame();
}
