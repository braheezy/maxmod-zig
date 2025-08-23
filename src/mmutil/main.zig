const std = @import("std");
const wav = @import("wav_reader.zig");
const rs = @import("resampler.zig");
const mmw = @import("mmraw_writer.zig");
const mod_proc = @import("mod_processor.zig");
const xm_proc = @import("xm_processor.zig");
// Ensure translate-c shim is compiled and its exported globals are linked
const tc_shim = @import("tc_shim");
// Force-include C-translated support so symbols are available for linking
const _tc_simple_force = @import("tc_simple_c_raw");
const tc_samplefix = @import("tc_samplefix_c_raw");
const _force_fixsample_ref = tc_samplefix.FixSample; // ensure codegen
// Also force-link tracker loaders used by MSL builder
const tc_wav = @import("tc_wav_c_raw");
const _force_wav = tc_wav.Load_WAV;
const _tc_adpcm_force = @import("tc_adpcm_c_raw");

const default_rate: u32 = 0; // 0 means preserve source rate unless overridden

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const alloc = gpa.allocator();

    var args = try std.process.argsWithAllocator(alloc);
    defer args.deinit();

    _ = args.next(); // exe name
    const in_path = args.next() orelse return usage();

    // Default to GBA path for MAS writer
    tc_shim.target_system = 0; // SYSTEM_GBA

    var out_path: ?[]const u8 = null;
    var rate: u32 = default_rate;
    var rate_set: bool = false;
    var bps16 = false;
    var raw8 = false;
    var looped = false;
    var is_mod = false;
    var is_xm = false;
    var is_mas = false;
    var to_mas = false;

    while (args.next()) |a| {
        if (std.mem.eql(u8, a, "-o")) {
            out_path = args.next() orelse return error.InvalidArgument;
        } else if (std.mem.eql(u8, a, "--rate")) {
            const s = args.next() orelse return error.InvalidArgument;
            rate = try std.fmt.parseInt(u32, s, 10);
            rate_set = true;
        } else if (std.mem.eql(u8, a, "--bps")) {
            const s = args.next() orelse return error.InvalidArgument;
            const v = try std.fmt.parseInt(u8, s, 10);
            if (v == 16) {
                bps16 = true;
            } else if (v == 8) {
                bps16 = false;
            } else {
                return error.InvalidArgument;
            }
        } else if (std.mem.eql(u8, a, "--loop")) {
            looped = true;
        } else if (std.mem.eql(u8, a, "--raw8")) {
            raw8 = true;
        } else if (std.mem.eql(u8, a, "--mod")) {
            is_mod = true;
        } else if (std.mem.eql(u8, a, "--xm")) {
            is_xm = true;
        } else if (std.mem.eql(u8, a, "--mas")) {
            is_mas = true;
        } else if (std.mem.eql(u8, a, "-m")) {
            to_mas = true;
        } else {
            return usage();
        }
    }

    const out = out_path orelse return usage();

    if (is_mod) {
        // Process MOD file and create soundbank
        const mod_data = try std.fs.cwd().readFileAlloc(alloc, in_path, 64 * 1024 * 1024);
        defer alloc.free(mod_data);

        const mod_file = try mod_proc.parseModFile(alloc, mod_data);
        try mod_proc.createSoundbank(alloc, mod_file, out);

        std.debug.print("Created soundbank from MOD file: {s}\n", .{in_path});
        return;
    } else if (is_xm) {
        const xm_data = try std.fs.cwd().readFileAlloc(alloc, in_path, 64 * 1024 * 1024);
        defer alloc.free(xm_data);
        if (to_mas) {
            // Use translate-c path for byte-identical output
            const tc_files = @import("tc_files_c_raw");
            const tc_xm = @import("tc_xm_c_raw");
            const tc_mas = @import("tc_mas_c_raw");
            // Open input/output via translated file glue
            if (tc_files.file_open_read(@constCast(@ptrCast(in_path.ptr))) != 0) return error.FileNotFound;
            if (tc_files.file_open_write(@constCast(@ptrCast(out.ptr))) != 0) return error.FileAccess;
            var mod_c: tc_mas.MAS_Module = std.mem.zeroes(tc_mas.MAS_Module);
            const mod_for_xm: [*c]tc_xm.MAS_Module = @ptrCast(&mod_c);
            _ = tc_xm.Load_XM(mod_for_xm, @as(u8, 0));
            _ = tc_mas.Write_MAS(&mod_c, @as(u8, 0), @as(u8, 0));
            tc_files.file_close_read();
            tc_files.file_close_write();
            std.debug.print("[tc] Created MAS soundbank from XM file: {s}\n", .{in_path});
        } else {
            const xm_file = try xm_proc.parseXmFile(alloc, xm_data);
            defer {
                for (xm_file.samples) |s| {
                    if (s.pcm8.len > 0) alloc.free(s.pcm8);
                    if (s.pcm16.len > 0) alloc.free(s.pcm16);
                }
                alloc.free(xm_file.samples);
            }
            try xm_proc.createSoundbank(alloc, xm_file, out);
            std.debug.print("Created soundbank from XM file: {s}\n", .{in_path});
        }
        return;
    } else if (is_mas) {
        // Use translate-c path for XM->MAS direct
        const tc_files = @import("tc_files_c_raw");
        const tc_xm = @import("tc_xm_c_raw");
        const tc_mas = @import("tc_mas_c_raw");
        if (tc_files.file_open_read(@constCast(@ptrCast(in_path.ptr))) != 0) return error.FileNotFound;
        if (tc_files.file_open_write(@constCast(@ptrCast(out.ptr))) != 0) return error.FileAccess;
        var mod_c: tc_mas.MAS_Module = std.mem.zeroes(tc_mas.MAS_Module);
        const mod_for_xm: [*c]tc_xm.MAS_Module = @ptrCast(&mod_c);
        _ = tc_xm.Load_XM(mod_for_xm, @as(u8, 0));
        _ = tc_mas.Write_MAS(&mod_c, @as(u8, 0), @as(u8, 0));
        tc_files.file_close_read();
        tc_files.file_close_write();
        std.debug.print("[tc] Created MAS soundbank from XM file: {s}\n", .{in_path});
        return;
    }

    if (raw8) {
        if (!rate_set) return error.InvalidArgument;
        const data = try std.fs.cwd().readFileAlloc(alloc, in_path, 64 * 1024 * 1024);
        defer alloc.free(data);
        // Write directly as 8-bit unsigned frames
        try mmw.writeMmrawU8(out, rate, looped, data);
        return;
    }

    const info = try wav.loadToMono(alloc, in_path);
    defer if (info.bits_per_sample == .pcm8) alloc.free(info.mono_frames_8) else alloc.free(info.mono_frames_16);

    if (!rate_set) {
        rate = info.sample_rate_hz; // preserve source rate by default
    }

    // Helper: simple DC removal and peak normalization
    var acc: i64 = 0;
    if (info.bits_per_sample == .pcm16) {
        for (info.mono_frames_16) |v| acc += v;
        const mean: i16 = @as(i16, @intCast(@divTrunc(acc, @as(i64, @intCast(info.mono_frames_16.len)))));
        var peak: i32 = 1;
        var i: usize = 0;
        while (i < info.mono_frames_16.len) : (i += 1) {
            var s: i32 = info.mono_frames_16[i] -% mean;
            if (s < -32768) s = -32768;
            if (s > 32767) s = 32767;
            const a: i32 = if (s < 0) -s else s;
            if (a > peak) peak = a;
            info.mono_frames_16[i] = @as(i16, @intCast(s));
        }
        const target: f32 = 0.89 * 32767.0;
        const gain: f32 = if (peak > 0) target / @as(f32, @floatFromInt(peak)) else 1.0;
        i = 0;
        while (i < info.mono_frames_16.len) : (i += 1) {
            const s: f32 = @as(f32, @floatFromInt(info.mono_frames_16[i])) * gain;
            var si: i32 = @as(i32, @intFromFloat(@floor(s + 0.5)));
            if (si < -32768) si = -32768;
            if (si > 32767) si = 32767;
            info.mono_frames_16[i] = @as(i16, @intCast(si));
        }
        // simple low-pass smoothing
        var y: f32 = 0.0;
        const fs: f32 = @as(f32, @floatFromInt(info.sample_rate_hz));
        const fc: f32 = 0.22 * fs;
        const alpha: f32 = fc / (fs + fc);
        i = 0;
        while (i < info.mono_frames_16.len) : (i += 1) {
            const x: f32 = @as(f32, @floatFromInt(info.mono_frames_16[i]));
            y = y + alpha * (x - y);
            var clip: f32 = y;
            if (clip < -32768.0) clip = -32768.0;
            if (clip > 32767.0) clip = 32767.0;
            info.mono_frames_16[i] = @as(i16, @intCast(@as(i32, @intFromFloat(@floor(clip + 0.5)))));
        }
    }

    // Resample if needed
    if (info.bits_per_sample == .pcm8) {
        const frames = try rs.linearResampleU8(alloc, info.mono_frames_8, info.sample_rate_hz, rate);
        defer alloc.free(frames);
        if (bps16) {
            // widen and offset to unsigned 16
            var wide = try alloc.alloc(u16, frames.len);
            defer alloc.free(wide);
            var i: usize = 0;
            while (i < frames.len) : (i += 1) wide[i] = @as(u16, frames[i]) * 0x0101;
            try mmw.writeMmrawU16(out, rate, looped, wide);
        } else {
            try mmw.writeMmrawU8(out, rate, looped, frames);
        }
    } else {
        // Preprocess already applied above
        const frames = try rs.linearResampleI16(alloc, info.mono_frames_16, info.sample_rate_hz, rate);
        defer alloc.free(frames);
        if (bps16) {
            // Convert signed i16 to unsigned u16 for transport (bias 0x8000)
            var u = try alloc.alloc(u16, frames.len);
            defer alloc.free(u);
            var i: usize = 0;
            while (i < frames.len) : (i += 1) u[i] = @as(u16, @bitCast(frames[i])) ^ 0x8000;
            try mmw.writeMmrawU16(out, rate, looped, u);
        } else {
            // down-convert to unsigned 8-bit with light low-pass + TPDF dither
            var narrow = try alloc.alloc(u8, frames.len);
            defer alloc.free(narrow);

            // 3-tap FIR [1,2,1]/4 to tame high frequencies before 8-bit quantization
            var prev: i32 = frames[0];
            var i: usize = 0;
            var rng_state: u32 = 0x12345678;
            inline for (.{}) |_| {}
            while (i < frames.len) : (i += 1) {
                const s0: i32 = if (i == 0) frames[i] else frames[i - 1];
                const s1: i32 = frames[i];
                const s2: i32 = if (i + 1 < frames.len) frames[i + 1] else frames[i];
                var f: i32 = (s0 + (s1 << 1) + s2) >> 2;

                // TPDF dither in +/- 0.5 LSB of 8-bit
                rng_state ^= rng_state << 13;
                rng_state ^= rng_state >> 17;
                rng_state ^= rng_state << 5;
                const r1 = @as(i32, @intCast(rng_state & 0xFFFF)) - 32768;
                rng_state ^= rng_state << 13;
                rng_state ^= rng_state >> 17;
                rng_state ^= rng_state << 5;
                const r2 = @as(i32, @intCast(rng_state & 0xFFFF)) - 32768;
                // Scale to about +/-128 in 16-bit domain (1 LSB at 8-bit step)
                f += (r1 - r2) >> 8;

                // Signed i16 to unsigned u8 with bias
                const u16v: u16 = @as(u16, @bitCast(@as(i16, @intCast(f)))) ^ 0x8000;
                narrow[i] = @as(u8, @intCast(u16v >> 8));
                prev = s1;
            }
            try mmw.writeMmrawU8(out, rate, looped, narrow);
        }
    }
}

fn usage() !void {
    const stderr = std.io.getStdErr().writer();
    try stderr.print("Usage: mmutil-zig input.wav -o output.mmraw [--rate 16000] [--bps 8|16] [--loop]\n", .{});
    try stderr.print("       mmutil-zig input.mod --mod -o output.bin (create soundbank from MOD)\n", .{});
    try stderr.print("       mmutil-zig input.xm --xm -o output.bin (create soundbank from XM)\n", .{});
    try stderr.print("       mmutil-zig input.xm --mas -o module.mas (create MAS from XM)\n", .{});
    //try stderr.print("       mmutil-zig input.xm --msl -o soundbank.bin (create MSL soundbank from XM)\n", .{});
    return error.InvalidArgument;
}
