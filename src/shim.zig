const mm = @import("maxmod.zig");

pub const MIXCH_GBA_SRC_STOPPED = 1 << ((@sizeOf(usize) * 8) - 1);

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

const gba = @import("gba");
// Debug configuration - can be toggled at build time
const debug_enabled = @import("build_options").xm_debug;
// Debug printing helper that can be compiled out
inline fn debugPrint(comptime fmt: []const u8, args: anytype) void {
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
};

pub var debug_state: DebugState = .{};
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
    gba.debug.write("END debug_state=================>") catch {};
}
