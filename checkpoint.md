# XM Playback Debug Checkpoint (xm-port)

## Goal
Get XM playback in the Zig-compiled GBA ROM (xm-port) to match the original C reference both numerically (logs) and audibly. The output must be stable, non-distorted music with correct pitch, volume, looping, and panning.

## Current Status
- Sample selection at note start now mirrors the C reference:
  - Fixed bitfield packing for instrument notemap (15-bit offset + 1-bit invalid).
  - `mmChannelStartACHN` uses the same mapping logic as C. Ch0 now picks sample=12 at T0 (matches C).
- Frequency path now matches C translate-c numerics:
  - UMIX `set_pitch` shows period/freq pairs like 87480/10787, 65536/7189, 208064/6887 (aligned with C).
- Sample binding now mirrors C exactly:
  - Always resolve `mm_mas_sample_info` via `mpp_SamplePointer(layer, sample_id)` and then take platform header via `sample.data()`.
  - [BIND] dumps show consistent positive lengths and reasonable default frequencies.
- Despite numeric/log improvements, audio remains wrong (squeaks/screeches). This points to issues after binding: sample format, loop mode/loop boundaries, or mixer interpretation.

## Evidence/Logs
- Matching points:
  - `[UMIX] ch=0 ... sample=12` (Zig == C)
  - `[UMIX] set_pitch period=87480 freq=10787 ...` (Zig == C)
- Binding (now consistent):
  - Example: `"[BIND] ch=0 id=11 src=... def_freq=33545 len=753983"` (length positive; stable per rebinds)

## Challenges Encountered
1. Bitfield drift in translated structs:
   - `note_map_offset` and `is_note_map_invalid` share a 16-bit field in C. Treating them as separate `mm_hword` members broke mapping.
   - Lesson: when translate-c demotes bitfields, reconstruct packed access manually.
2. MSL addressing and table indexing:
   - Recomputing offsets to sample headers deviated from runtime’s `mpp_SamplePointer` semantics (layer-relative pointers and 1/0-based differences).
   - Lesson: rely on core helpers (`mpp_SamplePointer`) and `sample.data()` rather than DIY table math in runtime.
3. Logging alignment and formatting pitfalls:
   - Printing large ints with wrong specifiers caused build failures; hex/decimal formatting must match value widths and types.
4. Environment flakiness:
   - mGBA runs can be finicky; ensure short timeouts and clear logs to avoid truncation.

## Next Steps (Highest Priority)
1. Verify sample format and loop handling at bind-time and in the mixer:
   - Dump once per channel on first bind: `format`, `repeat_mode`, `loop_length`, and loop start (if applicable) from `mm_mas_gba_sample`.
   - Add guarded logs when `read` wraps to loop boundary (forward/ping-pong), including direction and new `read`.
   - Confirm mixer interprets samples as signed 8-bit and applies loop boundaries correctly.
2. Validate panning/volume envelopes:
   - Confirm `MCAF_VOLENV` is set/cleared same as C based on `env_flags`.
   - Log `[DISPAN]` values and check that vol/pan writes match C for first rows/ticks.
3. Confirm per-sample default playback rate usage:
   - Ensure `default_frequency` is used only where C does (e.g., period==0 XM path) and not overriding computed pitch.
4. End-to-end numerical compare:
   - Diff key lines for the first few frames: `[UMIX]`, `[set_pitch]`, `[DISPAN]`, `[PREMIX]/[POSTMIX]` (Zig vs C) to spot the first divergence after binding.

## Nice-to-Have (After Core Fix)
- Implement a tiny attack ramp at key-on to reduce clicks (optional; should not be needed if format/loops are correct).
- Sanity assertions (guarded) on buffer bounds and loop indices to catch runaway read pointers during development.

## Lessons Learned
- Always reconstruct C bitfields when translate-c exposes plain fields; do not assume independent storage.
- Favor the original core’s accessors (`mpp_SamplePointer`, `sample.data()`) to avoid base/index drift.
- Align debug output formats exactly to ease log diffing and avoid print-induced build failures.
- Fix basics (sample/map/period) before chasing mixer artifacts.

## How to Run (mGBA) and Compare Logs
- Run Zig xm-port and C reference for 6 seconds and capture logs:
  - Zig: `timeout 6 mgba zig-out/bin/xm-port.gba &> zig_port.log`
  - C:   `timeout 6 mgba examples/xm_c_ref/xm_cref.gba &> c_ref.log`
- Compare critical markers to find first divergence:
  - `grep -n "\[UMIX\]\|\[BIND\]\|\[MAPDBG\]\|\[set_pitch\]\|\[DISPAN\]" zig_port.log c_ref.log`
- Focus on the earliest differing line; fix upstream of that point.

## Definition of Done for This Phase
- For the first 10 frames, `[UMIX]`, `[BIND]`, `[set_pitch]`, and `[DISPAN]` match the C log semantics.
- Audio is stable and recognizable; no screeches/squeaks; loops behave correctly.
