const std = @import("std");
const audio = @import("audio.zig");
const player = @import("player.zig");
const mixer = @import("mixer_asm.zig");

pub fn init() void {
    audio.init();
    // Initialize mixer ASM path at 16 kHz (mode index 3)
    mixer.init(3);
}

pub fn disableAllDma() void {
    audio.silenceAllDma();
}

pub fn loadMmraw(data: []const u8) !void { try player.loadMmrawSlice(data); }

pub fn play() void {
    // If a MOD is active, the mixer path already configured DMA and Direct Sound.
    if (@import("player.zig").isModActive()) {
        return;
    } else {
        player.play();
    }
}

pub fn stop() void {
    player.stop();
}

pub fn tick() void {
    // If a MOD is active and ASM mixer is enabled, use mmFrame-style chunking
    const is_mod = @import("player.zig").isModActive();
    if (is_mod and s_use_asm) {
        mmFrameStyle();
    } else {
        // Drive mixer once per tick to advance buffers
        const seg: u32 = mixer.getMixLen();
        mixer.mixOneSegment();
        if (is_mod) {
            if (@import("player.zig").mod_player) |*mp| mp.onMixed(seg);
        }
        player.frame();
    }
}

// Expose vblank hook to examples
pub fn onVBlank() void {
    mixer.onVBlank();
}

// Allow selecting ASM vs Zig mixer at runtime
pub fn setAsmMixer(on: bool) void {
    mixer.setUseAsmMixer(on);
}

var s_use_asm: bool = false;
pub fn enableAsmFrame(on: bool) void {
    s_use_asm = on;
}

fn mmFrameStyle() void {
    // Emulate Maxmod's mmFrame loop: mix up to mm_mixlen samples, chunked at tick boundaries
    if (!@import("player.zig").isModActive()) return;
    var remaining: u32 = mixer.getMixLen();
    const p = &@import("player.zig").mod_player.?;
    while (true) {
        // Compute samples until next tick in the player
        const until_tick: u32 = if (p.samples_until_tick == 0) p.samples_per_tick else p.samples_until_tick;
        if (until_tick >= remaining) break;
        // Mix until tick boundary
        mixer.mixN(until_tick);
        p.onMixed(until_tick);
        remaining -= until_tick;
    }
    if (remaining > 0) {
        mixer.mixN(remaining);
        p.onMixed(remaining);
    }
    // Advance frame bookkeeping like original
    @import("player.zig").frame();
}

// --- GBSAMP (MAS bank) loader ---
var g_gbs_base: [*]const u8 = undefined;
var g_gbs_offsets: [32]u32 = [_]u32{0} ** 32; // sample parapointers
var g_gbs_count: u32 = 0; // number of samples
var g_gbs_song_offsets: [8]u32 = [_]u32{0} ** 8; // optional songs (MSL)
var g_gbs_song_count: u32 = 0;
var g_gbs_data_off: u32 = 0; // payload offset (GBS0)

fn readU16(p: [*]const u8) u16 {
    return @as(u16, p[0]) | (@as(u16, p[1]) << 8);
}
fn readU32(p: [*]const u8) u32 {
    return @as(u32, p[0]) | (@as(u32, p[1]) << 8) | (@as(u32, p[2]) << 16) | (@as(u32, p[3]) << 24);
}

pub fn loadGbsamp(data: []const u8) !void {
    if (data.len < 12) return error.InvalidGbsamp;
    const p: [*]const u8 = data.ptr;
    // First try legacy GBS0 (custom bank used earlier)
    const sig4 = readU32(p);
    if (sig4 == (@as(u32, 'G') | (@as(u32, 'B') << 8) | (@as(u32, 'S') << 16) | (@as(u32, '0') << 24))) {
        const count = readU32(p + 4);
        if (count == 0 or count > 32) return error.BadCount;
        const data_off = readU32(p + 8);
        g_gbs_base = p;
        g_gbs_count = count;
        g_gbs_song_count = 0;
        g_gbs_data_off = data_off;
        // Offsets after 12-byte header
        var i: usize = 0;
        while (i < count and i < g_gbs_offsets.len) : (i += 1) g_gbs_offsets[i] = readU32(p + 12 + i * 4);
        return;
    }
    // Detect MSL (Maxmod soundbank) format: u16 nsamp, u16 nsongs, 8-byte magic "*maxmod*"
    const nsamp = readU16(p + 0);
    const nsongs = readU16(p + 2);
    const magic0 = p[4..12];
    const is_msl = magic0[0] == '*' and magic0[1] == 'm' and magic0[2] == 'a' and magic0[3] == 'x' and magic0[4] == 'm' and magic0[5] == 'o' and magic0[6] == 'd' and magic0[7] == '*';
    if (!is_msl) return error.InvalidMagic;
    // Read parapointers
    const header_bytes: usize = 12;
    const need_bytes: usize = header_bytes + (@as(usize, nsamp) + @as(usize, nsongs)) * 4;
    if (need_bytes > data.len) return error.InvalidGbsamp;
    g_gbs_base = p;
    g_gbs_count = nsamp;
    g_gbs_song_count = nsongs;
    g_gbs_data_off = 0;
    var i: usize = 0;
    while (i < nsamp and i < g_gbs_offsets.len) : (i += 1) {
        g_gbs_offsets[i] = readU32(p + header_bytes + i * 4);
    }
    var j: usize = 0;
    while (j < nsongs and j < g_gbs_song_offsets.len) : (j += 1) {
        g_gbs_song_offsets[j] = readU32(p + header_bytes + @as(usize, nsamp) * 4 + j * 4);
    }
}

pub fn resolveGbsSample(index: usize) ?struct { pcm: []const u8, loop_len_bytes: u32 } {
    // Legacy GBS0: base + data_off + off points to sample header (len/loop_len/..)
    if (g_gbs_data_off != 0) {
        if (index >= g_gbs_count) return null;
        const off: u32 = g_gbs_offsets[index];
        if (off == 0) return null;
        const base = @intFromPtr(g_gbs_base);
        const hdr_ptr: [*]const u8 = @ptrFromInt(base + g_gbs_data_off + off);
        const len = readU32(hdr_ptr);
        const loop_len = readU32(hdr_ptr + 4);
        const pcm_ptr: [*]const u8 = hdr_ptr + 12;
        const pcm = pcm_ptr[0..@as(usize, len)];
        return .{ .pcm = pcm, .loop_len_bytes = loop_len };
    }
    // MSL sample: at base + offset we have:
    //   u32 file_size
    //   u8 type, u8 version, u8 flags, u8 BYTESMASHER
    //   SampleData (GBA): len(4), loop_len(4), fmt(1), BA(1), freq(2)
    //   PCM data... + 4 padding
    if (index >= g_gbs_count) return null;
    const off: u32 = g_gbs_offsets[index];
    if (off == 0) return null;
    const base = @intFromPtr(g_gbs_base);
    const samp_ptr: [*]const u8 = @ptrFromInt(base + off);
    if (off + 20 > @as(u32, @intCast(@as(usize, @intFromPtr(g_gbs_base + off)) - base + 20))) {
        // Bound check elided; rely on len
    }
    const filesize = readU32(samp_ptr);
    _ = filesize;
    // sample data header starts after 4 (size) + 4 (type+ver+flags+BA)
    const sample_hdr: [*]const u8 = samp_ptr + 8;
    const len = readU32(sample_hdr + 0);
    const loop_len = readU32(sample_hdr + 4);
    const pcm_ptr: [*]const u8 = sample_hdr + 12;
    const pcm = pcm_ptr[0..@as(usize, len)];
    return .{ .pcm = pcm, .loop_len_bytes = loop_len };
}

// --- MOD (tracker) helpers ---
// Arena for MOD parsing and small runtime allocations
// Reduce arena size to fit within EWRAM budget alongside PCM and mixer buffers
var mod_arena: [32 * 1024]u8 = undefined;
var mod_fba: ?std.heap.FixedBufferAllocator = null;

pub fn loadMod(data: []const u8) !void {
    if (mod_fba == null) {
        const fba = std.heap.FixedBufferAllocator.init(mod_arena[0..]);
        mod_fba = fba;
    }
    // Safe to unwrap because we just initialized if null
    var fba_ptr: *std.heap.FixedBufferAllocator = &mod_fba.?;
    try player.loadModSlice(fba_ptr.allocator(), data);
}
