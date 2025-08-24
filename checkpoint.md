# XM Player on GBA – Checkpoint

Goal: Get an XM module playing on GBA from a Zig-compiled ROM using the translated Maxmod core (MAS runtime) and a MAS soundbank produced by the translated mmutil.

## Current Status (Observed)

- ROM boots, main loop runs (visible dots, repeated pre-/post-mix logs).
- MAS header is detected and parsed from the embedded bank:
  - Logged: `ord=31 inst=11 samp=12 patt=31` (sane counts)
- Layer/core state after `mmPlayModule`:
  - `flags=0xE` (XM flag set), `speed=6`, `bpm` reported as 125/137 in different runs
  - `isplaying=0`, `row=0`, `tick=0`, `position=0` and never advances
- Mixer channel 0 remains disabled: `src=0x80000000 vol=0 pan=128 freq=0`
- Our C-like driver loop (per pre-mix) that calls `mmReadPattern` and then updates each channel via `mmUpdateChannel_TN` still shows no advancement; we never see the one-time `[ADV]` log.
- One-time seeding attempt:
  - We set core globals (mpp_channels, mpp_nchannels, mm_num_mch, mm_num_ach, mm_ch_mask, mpp_layerp) akin to C’s `mmInit`.
  - We populated `songadr` and `patttable` from the header’s `tables()` section.
  - We set `pattread_p = header_base + patttable[chosen_pattern]` (pattern chosen from order table).
  - `[SEED] ok=0 row=0 pos=0` – `mmReadPattern` returned 0 (parse failed), so the reader is still pointed at the wrong address.

## Root Cause Hypotheses

1. **Pattern offset base mismatch**
   - MAS `patttable` offsets might not be relative to the `mm_mas_head` address we’re passing.
   - In some MAS layouts, offsets can be relative to a payload base (e.g., header+4 for size prefix, or header+8 when wrapped). Our current base uses `header_base + off`.

2. **Core init gaps (mmInit equivalence)**
   - Although we set the obvious globals, the original C `mmInit` may set additional tables/variables that affect `mmReadPattern` (e.g., function pointers, additional per-layer fields).
   - However, the strongest signal is the pattern base mismatch, because header counts and tempo/flags are being read correctly.

## Files/Areas Touched

- `src/maxmod_gba/xm_core_adapter.zig`
  - Added mmInit-like setup (globals, resetchannels).
  - Bound `songadr`, `patttable`, set `pattread_p` and seeded `mmReadPattern`.
  - Implemented C-like per-frame driver: `mmReadPattern` + loop of `mmUpdateChannel_TN`.
  - Extensive diagnostics: layer pointers, header fields, seed/advancement, pre-/post-mix markers.
- `src/maxmod_gba/lib.zig`
  - Robust MAS header selection for MAS-single flow, pre-/post-mix logging.
- `src/maxmod_gba/maxmod_core_shim.zig`, `src/maxmod_gba/mixer_asm.zig`, `examples/xm/main.zig`
  - Minor tweaks and instrumentation.

## Why We’re Stuck

- The core never advances because the pattern read never succeeds. The module header is valid, so the next critical variable is the **exact byte address** where the first pattern begins.

## Strategy to Fix

1. **Robustly find the correct pattern base**
   - Compute two specific candidate addresses for `pattread_p` and test them in order:
     - `patt_addr_0 = header_base + patttable[chosen]`
     - `patt_addr_4 = header_base + 4 + patttable[chosen]` (accounts for a size prefix when MAS is embedded)
   - Optionally also test `patt_addr_8 = header_base + 8 + off` if needed (accounts for additional reserved bytes) – only if the first two fail.
   - For each candidate, sanity-check a few bytes before calling `mmReadPattern`:
     - Log `[PROBE] base=+N off=0xXXXX hdr=0xAABBCCDD` where `hdr` is the u32 at pattern start.
     - Immediately invoke `mmReadPattern` and log `[SEED] ok=.. base=+N`.
   - Stop at the first candidate where `ok=1`. Keep that base for runtime.

2. **Keep C-like driver path active**
   - In `preMixUpdate`, continue to call `mmReadPattern` then iterate `mmUpdateChannel_TN` across all channels.
   - If we see any advancement (`ok=1`), one-time log `[ADV] read=1 row=.. pos=..`.

3. **Guardrails**
   - If all bases fail (`SEED ok=0`), dump a short hex slice of `(patt_addr, patt_addr+16)` to the log and re-check `patttable[0]` and `order[0]` to confirm the chosen indexes are sensible.
   - Confirm the `patttable` pointer and `songadr` are valid by logging them once as addresses: `songadr=0x.. patttable=0x..`.

4. **Success Criteria**
   - `[SEED] ok=1` appears.
   - Subsequent `[XM STATE]` shows `play=1` and row/tick advancing.
   - `[XM TICK]` shows `active=1` with non-zero `freq/vol` on some channel(s).

## Testing Plan

- Build and run:
  - `zig build xm -- bad_apple.xm`
- Inspect `out.log` for:
  - `[PROBE]` and `[SEED]` lines including base identifiers
  - A successful seed (`ok=1`)
  - `[ADV]` line and advancing state on subsequent `[XM STATE]`/`[XM TICK]`

## Contingency (if pattern still won’t read)

- Fall back to using the translated core’s internal accessor to resolve a pattern pointer (`mmReadPattern` consumes `layer.pattread_p`; if there’s an index indirection we missed, consult `mmReadPattern`’s translation and set required layer fields beyond `pattread_p`).
- If necessary, read and log `patttable[entry]` via the core’s helper `mmGetPattern(layer, entry)` equivalent (in translation, `mpp_GetPattern` logic appears as `return base + layer.*.patttable[entry];`). Use that to seed the correct address.

## Summary

- We’ve reduced the problem to a single missing piece: the **exact pattern pointer base**. Header is parsed, core wired, per-frame driver is running; the pattern reader is the blocker. The proposed probe-and-seed sequence should unstick `mmReadPattern`, after which channels should activate and audio should be produced.
