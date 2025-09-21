# Maxmod Zig Port Progress Notes

## Project Focus
- Port the Maxmod/mmutil GBA audio stack from C to Zig and achieve byte-for-byte parity with the C reference for XM playback.
- Maintain a tight debug loop: build & run both the C reference (`examples/xm_c_ref/xm_cref.gba`) and the Zig ROM (`zig-out/bin/xm.gba`), capture mgba logs, locate the earliest divergence, fix the Zig side, and repeat.
- Never touch the `mmutil` folder; it only supplied the generated soundbanks.

## Build & Run Commands
- **C reference**
  - Build: `make -C examples/xm_c_ref clean && make -C examples/xm_c_ref all`
  - Run: `timeout 3 mgba examples/xm_c_ref/xm_cref.gba &> c.log`
- **Zig ROM**
  - Build (release): `zig build xm`
  - Build (debug instrumentation): `zig build xm -Dxmdebug`
  - Run: `timeout 3 mgba zig-out/bin/xm.gba &> zig.log`
- Always request escalated permissions for the mgba runs inside the CLI harness.
- Logs must be overwritten in place (`c.log`, `zig.log`, etc.).

## Debug scaffolding status
- Release builds contain **zero** debug side-effects; every capture helper bails when `xm_debug` is false, so normal playback timing matches the C loop.
- Debug builds (`-Dxmdebug`) emit 90-frame `[MXSUM]` mixer hashes plus `[MXCH]` dumps for the first three frames. Hashing normalises mixer sources relative to the MAS bank and preserves STOP markers, so C/Zig logs can be diffed frame-by-frame.
- The Zig main loop now gates each frame on `gba.display.naiveVSync()`, mirroring the C reference’s `VBlankIntrWait` cadence without relying on print overhead.

## Current Bug Hunt
- `bad_apple.xm` is aligned: release audio matches the C reference for the first 90 frames with identical mixer hashes.
- For `assets/zelda_3_-_fairy_theme.xm` the first mixer divergence is at **frame 105**. In the C build `mix_ch[0].src` drops to the STOP sentinel (`0x80000000`) while the Zig build keeps the live MAS address (`0x0800BD?`). `FRAMECHK` traces show both versions share the same read cursor through frame 104, but Zig never marks the channel stopped, so the mixer continues to read into the sample tail and creates the audible tick.
- Instrumentation now targets frames 100–110 (`[FRAMECHK]`, `[STOPDBG]`, `[BINDDBG]`) so we can trace the exact point where the Zig runtime fails to flip the STOP bit.

## Next Steps
1. **Trace the failing frame (105)**
   - Keep running both ROMs with `-Dxmdebug` and the narrowed logging window (frames 100–110).
   - Follow the call chain from `mm_gba.frame()` down through `mppProcessTick`, `mpp_Update_ACHN_notest_*`, and `mmMixerMix` and note where the Zig path diverges from the C variables (especially `mix_ch[0].src/read/vol`).
2. **Patch the Zig runtime**
   - Focus on the channel-stop path in `src/core/mas.zig`/`src/core/mas_arm.zig` and ensure the STOP sentinel is written exactly like the C mixer when `volume==0 && !KEYON` or when the mixer loop sees the sample end.
   - Keep all debug writes behind `xm_debug` guards; trim or relocate once the fix is verified.
3. **Validate**
   - Rebuild release (`zig build xm`), run the ROM, and confirm the hashes stay aligned through frame 110 with no audible tick.
   - Remove any temporary logging once parity is confirmed, then rerun on additional XM samples.

## Reminders
- Never rely on hidden formatting or capture work in release builds—check `xm_debug` before touching buffers.
- If the CLI shell reports unexpected filesystem changes or denied access (outside the known `/Users/michaelbraha/.cache/` warnings), stop and ask for guidance.
- Keep the mgba runtime under 3 seconds unless the user explicitly asks for longer captures.
