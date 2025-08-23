const std = @import("std");
const audio = @import("audio.zig");
const player = @import("player.zig");
const mixer = @import("mixer_asm.zig");
const xm = @import("xm.zig");
const mas = @import("mas.zig");

pub fn init() void {
    audio.init();
    // Initialize mixer ASM path at 16 kHz (mode index 3)
    mixer.init(3);
}

pub fn disableAllDma() void {
    audio.silenceAllDma();
}

pub fn loadMmraw(data: []const u8) !void {
    try player.loadMmrawSlice(data);
}

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
    const is_mas = true; // FORCE MAS mode for debugging
    
    if (is_mod and s_use_asm) {
        mmFrameStyle();
    } else {
        // Drive mixer once per tick to advance buffers
        const seg: u32 = mixer.getMixLen();
        mixer.mixOneSegment();
        if (is_mod) {
            if (@import("player.zig").mod_player) |*mp| mp.onMixed(seg);
        } else if (is_mas) {
            // Simple MAS sample cycling - change sample every 60 ticks (1 second)
            mas_tick_counter += 1;
            const sample_idx = (mas_tick_counter / 60) % g_gbs_count;
            const sample = resolveGbsSample(sample_idx) orelse {
                // Fallback to square wave if sample fails
                const testbuf = [_]u8{192, 64} ** 256;
                mixerTestSetChannelFromPcm8(0, &testbuf, testbuf.len, 255, 128, 0x1200);
                return;
            };
            const base_step: u32 = 200;
            const step_fixed = base_step + (sample_idx * 50); // Vary pitch per sample
            const loop_len: u32 = if ((sample.loop_len_bytes & 0x8000_0000) != 0) 
                @as(u32, @intCast(sample.pcm.len)) else sample.loop_len_bytes;
            mixerTestSetChannelFromPcm8(0, sample.pcm, loop_len, 255, 128, step_fixed);
            // For MAS mode, don't call player.frame() - we're using mixer directly
        } else {
            player.frame();
        }
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

// --- Test helpers ---
pub fn mixerTestSetChannelFromPcm8(index: usize, pcm: []const u8, loop_len: u32, vol: u8, pan: u8, step_fixed_20_12: u32) void {
    mixer.setChannelFromPcm8(index, pcm, loop_len, vol, pan, step_fixed_20_12);
}

// --- GBSAMP (MAS bank) loader ---
var g_gbs_base: [*]const u8 = undefined;
var g_gbs_data: []const u8 = &[_]u8{}; // Keep original data slice for MAS parsing
var g_gbs_offsets: [32]u32 = [_]u32{0} ** 32; // sample parapointers
var g_gbs_count: u32 = 0; // number of samples
var g_gbs_song_offsets: [8]u32 = [_]u32{0} ** 8; // optional songs (MSL)
var g_gbs_song_count: u32 = 0;
var g_gbs_data_off: u32 = 0; // payload offset (GBS0)
var g_song_map: [32]u16 = [_]u16{0xFFFF} ** 32; // MOD sample(1..31)->MSL sample index
var g_song_map_valid: bool = false;
var g_is_msl: bool = false;
var g_is_mas_single: bool = false;

fn readU16(p: [*]const u8) u16 {
    return @as(u16, p[0]) | (@as(u16, p[1]) << 8);
}
fn readU32(p: [*]const u8) u32 {
    return @as(u32, p[0]) | (@as(u32, p[1]) << 8) | (@as(u32, p[2]) << 16) | (@as(u32, p[3]) << 24);
}

pub fn loadGbsamp(data: []const u8) !void {
    if (data.len < 12) return error.InvalidGbsamp;
    const p: [*]const u8 = data.ptr;
    g_gbs_data = data; // Store original data slice
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
    // Detect MAS single-song file header: [u32 filesize][u8 type=0][u8 version][0xBA][0xBA]
    if (data.len >= 8 and p[4] == 0 and p[6] == 0xBA and p[7] == 0xBA) {
        g_is_msl = false;
        g_is_mas_single = true;
        g_gbs_base = p;
        g_gbs_data_off = 0;
        var q: [*]const u8 = p + 8; // MAS payload begins after 8 bytes
        
        // Ensure we have enough data to read the header
        if (data.len < 8 + 9 + 3 + 32 + 32 + 200) return error.InvalidMasHeader;
        
        const inst_count: u8 = q[1];
        const samp_count: u8 = q[2];
        const patt_count: u8 = q[3];
        _ = patt_count;
        // Skip to offsets table
        q += 9; // flags+init
        q += 3; // BA
        q += 32; // ch vol
        q += 32; // ch pan
        q += 200; // orders
        
        // Ensure we have enough data for instrument and sample offsets
        const offsets_start = 8 + 9 + 3 + 32 + 32 + 200;
        const needed_size = offsets_start + @as(usize, inst_count) * 4 + @as(usize, samp_count) * 4;
        if (data.len < needed_size) return error.InvalidMasOffsets;
        
        q += @as(usize, inst_count) * 4; // skip inst offsets
        // Read sample offsets (relative to MAS payload base)
        g_gbs_count = samp_count;
        var i: usize = 0;
        while (i < g_gbs_count and i < g_gbs_offsets.len) : (i += 1) {
            const rel = readU32(q + i * 4);
            g_gbs_offsets[i] = rel + 8; // absolute offset from file start
        }
        g_gbs_song_count = 1;
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
    g_is_msl = true;
    g_is_mas_single = false;
    var i: usize = 0;
    while (i < nsamp and i < g_gbs_offsets.len) : (i += 1) {
        g_gbs_offsets[i] = readU32(p + header_bytes + i * 4);
    }
    var j: usize = 0;
    while (j < nsongs and j < g_gbs_song_offsets.len) : (j += 1) {
        g_gbs_song_offsets[j] = readU32(p + header_bytes + @as(usize, nsamp) * 4 + j * 4);
    }
}

pub fn loadMasBank(data: []const u8) !void {
    // Reuse existing GBSAMP/MSL loader – MAS files produced by mmutil comply with MSL layout
    try loadGbsamp(data);
}

/// Play MAS module by index (0 if writer outputs single song). Currently a no-op stub
/// until pattern decoder is fully integrated; returns false if unsupported.
pub fn playMasModule(index: usize) bool {
    if (g_is_msl) {
        return setActiveGbsSong(index);
    }
    if (g_is_mas_single) {
        // Initialize MAS player for full song playback like C maxmod does
        if (mas_fba == null) {
            mas_fba = std.heap.FixedBufferAllocator.init(mas_arena[0..]);
        }
        var fba_ptr = &mas_fba.?;
        
        // Parse the MAS module from the loaded data
        const mas_module = mas.parse(fba_ptr.allocator(), g_gbs_data) catch {
            return false;
        };
        
        // Initialize the MAS player
        mas_player = mas.MasPlayer.init(fba_ptr.allocator(), mas_module) catch {
            return false;
        };
        
        // Enable the MAS player to drive pattern playback
        // Remove the manual sample triggering and let the pattern player work
        
        return true;
    }
    return false;
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
        const raw_loop = readU32(hdr_ptr + 4);
        // Standardize contract: MSB set => no loop; else value is loop length (bytes)
        const loop_len: u32 = if (raw_loop == 0xFFFF_FFFF) 0x8000_0000 else raw_loop;
        const pcm_ptr: [*]const u8 = hdr_ptr + 12;
        const pcm = pcm_ptr[0..@as(usize, len)];
        return .{ .pcm = pcm, .loop_len_bytes = loop_len };
    }
    if (g_is_mas_single) {
        if (index >= g_gbs_count) return null;
        const off: u32 = g_gbs_offsets[index];
        if (off == 0) return null;
        const base = @intFromPtr(g_gbs_base);
        const sptr: [*]const u8 = @ptrFromInt(base + off);
        const msl_index = readU16(sptr + 10);
        if (msl_index != 0xFFFF) return null;
        const sd: [*]const u8 = sptr + 12;
        const len = readU32(sd + 0);
        const raw_loop = readU32(sd + 4);
        const loop_len: u32 = if (raw_loop == 0xFFFF_FFFF) 0x8000_0000 else raw_loop;
        const pcm_ptr: [*]const u8 = sd + 12;
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
    const raw_loop = readU32(sample_hdr + 4);
    const loop_len: u32 = if (raw_loop == 0xFFFF_FFFF) 0x8000_0000 else raw_loop;
    const pcm_ptr: [*]const u8 = sample_hdr + 12;
    const pcm = pcm_ptr[0..@as(usize, len)];
    return .{ .pcm = pcm, .loop_len_bytes = loop_len };
}

// Parse a single MSL song entry to extract sample->msl_index mapping.
// This reads the MAS song structure written by mmutil (Write_MAS with msl_dep=true).
pub fn setActiveGbsSong(song_index: usize) bool {
    if (g_gbs_song_count == 0) return false;
    if (song_index >= g_gbs_song_count) return false;
    const song_off = g_gbs_song_offsets[song_index];
    if (song_off == 0) return false;
    const base = @intFromPtr(g_gbs_base);
    var p: [*]const u8 = @ptrFromInt(base + song_off);
    if (p[0..4].len < 4) return false;
    const file_size: u32 = readU32(p);
    _ = file_size;
    p += 4; // MAS file starts after size
    // Expect BYTESMASHER then type/version and 2 smasher bytes
    const magic = readU32(p);
    if (magic == 0) return false; // basic check
    p += 4; // magic
    p += 4; // type/version + 2x smasher
    // MAS_OFFSET points here in writer; proceed to read counts
    const order_count: u8 = p[0];
    const inst_count: u8 = p[1];
    const samp_count: u8 = p[2];
    const patt_count: u8 = p[3];
    _ = order_count;
    // patt_count used below to skip pattern offsets
    p += 9; // skip counts (4), flags(1), glob vol(1), speed(1), tempo(1), restart(1)
    p += 3; // three BA bytes reserved
    p += 32; // channel volumes (MAX_CHANNELS assumed 32)
    p += 32; // channel panning
    p += 200; // orders block padded to 200
    // Offsets table: inst_count*4 then samp_count*4 then patt_count*4
    // Skip instrument offsets
    p += @as(usize, inst_count) * 4;
    // Read sample offsets
    if (samp_count == 0 or samp_count > 32) return false;
    var sample_offsets: [32]u32 = [_]u32{0} ** 32;
    var i: usize = 0;
    while (i < samp_count) : (i += 1) {
        sample_offsets[i] = readU32(p + i * 4);
    }
    p += @as(usize, samp_count) * 4;
    // Skip pattern offsets (not needed)
    p += @as(usize, patt_count) * 4;
    // For each sample offset, read its msl_index from the sample struct
    var k: usize = 0;
    while (k < samp_count and k < g_song_map.len) : (k += 1) {
        const soff = sample_offsets[k];
        if (soff == 0) {
            g_song_map[k] = 0xFFFF;
            continue;
        }
        const sptr: [*]const u8 = @ptrFromInt((base + song_off) + 4 + @as(usize, soff));
        // sample struct layout in Write_Sample:
        // default_volume(1), default_panning(1), freq_div4(2), vibtype(1), vibdepth(1),
        // vibspeed(1), global_volume(1), vibrate(2), msl_index(2)
        const msl_index: u16 = readU16(sptr + 10);
        g_song_map[k] = msl_index;
    }
    g_song_map_valid = true;
    return true;
}

// Resolve a MOD sample index (0-based) via active song mapping to a bank sample
pub fn resolveGbsSampleForMod(mod_sample_index: usize) ?struct { pcm: []const u8, loop_len_bytes: u32 } {
    if (!g_song_map_valid) return null;
    if (mod_sample_index >= g_song_map.len) return null;
    const idx = g_song_map[mod_sample_index];
    if (idx == 0xFFFF) return null;
    return resolveGbsSample(idx);
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

var xm_module_loaded: bool = false;

// MAS player state
var mas_player: ?mas.MasPlayer = null;
var mas_arena: [64 * 1024]u8 = undefined;
var mas_fba: ?std.heap.FixedBufferAllocator = null;

// Global counter to track pattern player activity
var mas_tick_counter: u32 = 0;

// Process MAS player channel updates and trigger sample playback
fn processMasChannelUpdates(mp: *mas.MasPlayer) void {
    mas_tick_counter += 1;
    
    const update_bits = mp.getChannelUpdateBits();
    if (update_bits == 0) {
        // No channel updates yet - play different samples based on time to simulate pattern progression
        const sample_idx = (mas_tick_counter / 60) % g_gbs_count; // Change sample every second
        const sample = resolveGbsSample(sample_idx) orelse return;
        const base_step: u32 = 200; // Higher pitch to be more audible
        const step_fixed = base_step + (sample_idx * 100); // Vary pitch per sample
        const loop_len: u32 = if ((sample.loop_len_bytes & 0x8000_0000) != 0) 
            @as(u32, @intCast(sample.pcm.len)) else sample.loop_len_bytes;
        mixerTestSetChannelFromPcm8(0, sample.pcm, loop_len, 255, 128, step_fixed);
        return;
    }
    
    // Process each updated channel
    var chan_bit: u5 = 0;
    while (chan_bit < 32) : (chan_bit += 1) {
        if ((update_bits & (@as(u32, 1) << chan_bit)) == 0) continue;
        
        const mas_chan = mp.getChannel(chan_bit) orelse continue;
        
        // Skip if no instrument or note cut/off  
        if (mas_chan.inst == 0 or (mas_chan.flags & (128 | 64)) != 0) { // MF_NOTECUT | MF_NOTEOFF
            // Stop the channel
            mixerTestSetChannelFromPcm8(chan_bit, &[_]u8{}, 0, 0, 128, 0);
            continue;
        }
        
        // Get the sample for this instrument
        // For now, map instrument directly to sample (simplified)
        const sample_idx = if (mas_chan.inst > 0) mas_chan.inst - 1 else 0;
        const sample = resolveGbsSample(sample_idx) orelse continue;
        
        // Calculate playback parameters
        const volume = @min(mas_chan.volume, 64) * 3; // Scale to 0-192
        const panning = mas_chan.panning;
        
        // Calculate frequency/step from note
        const note = mas_chan.pnoter;
        const step_fixed = calculateStepFromNote(note, sample_idx);
        
        const loop_len: u32 = if ((sample.loop_len_bytes & 0x8000_0000) != 0) 
            @as(u32, @intCast(sample.pcm.len)) else sample.loop_len_bytes;
            
        // Start sample playback on this mixer channel
        mixerTestSetChannelFromPcm8(chan_bit, sample.pcm, loop_len, @intCast(volume), panning, step_fixed);
    }
}

// Calculate step value from XM note number and sample
fn calculateStepFromNote(note: u8, sample_idx: usize) u32 {
    if (note == 0) return 1 << 12; // Default step
    
    // Get sample frequency from header
    const off: u32 = g_gbs_offsets[sample_idx];
    const base = @intFromPtr(g_gbs_base);
    const sptr: [*]const u8 = @ptrFromInt(base + off);
    const sd: [*]const u8 = sptr + 12; // sample data header
    const base_freq = readU16(sd + 10);
    
    // XM note calculation: C-4 (note 48) = base frequency
    // Each semitone is 2^(1/12) ≈ 1.059463 ratio
    // Simplified: use lookup table or approximation
    const note_offset: i32 = @as(i32, note) - 48; // C-4 is reference
    
    // Rough approximation: each octave doubles/halves frequency
    var freq = base_freq;
    if (note_offset > 0) {
        freq = @as(u16, @intCast(@min(65535, (@as(u32, freq) * (@as(u32, @intCast(note_offset)) + 12)) / 12)));
    } else if (note_offset < 0) {
        freq = @as(u16, @intCast(@max(1, (@as(u32, freq) * 12) / (@as(u32, @intCast(-note_offset)) + 12))));
    }
    
    // Calculate step: (sample_freq * 4096) / mixer_freq
    const mixer_freq: u32 = 16384;
    return if (freq > 0) (freq * 4096) / mixer_freq else (1 << 12);
}

pub fn loadXm(data: []const u8) !void {
    if (mod_fba == null) {
        const fba = std.heap.FixedBufferAllocator.init(mod_arena[0..]);
        mod_fba = fba;
    }
    var fba_ptr: *std.heap.FixedBufferAllocator = &mod_fba.?;
    // Clear previous arena allocations
    fba_ptr.reset();

    // Parse XM header/order table using minimal parser
    _ = try xm.parseHeader(fba_ptr.allocator(), data);
    xm_module_loaded = true;
    // For now, playback engine is not implemented. This just validates.
}
