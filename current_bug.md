# Current Goals & Struggles (MAS Port – Stream C)

## Goals
1. Generate a MAS soundbank from `bad_apple.xm` using our **Zig** mmutil implementation.
2. Ensure the produced `bad_apple_zig.mas` is **byte-identical** to the reference file produced by the **original C mmutil** (`bad_apple_ref.mas`).
3. Integrate this golden-file comparison into the build pipeline so regressions are caught automatically.

## Current Status
* **Stream A (XM parser) and Stream B (MAS runtime loader)** are complete.
* The Zig MAS writer successfully produces MAS files for simpler modules but fails on `bad_apple.xm` with `UnexpectedEof` during parsing.
* Reference MAS (`bad_apple_ref.mas`) already generated via original C tool.

## Struggles / Open Issues
1. **UnexpectedEof in `parseXmFile`**
   * Occurs while parsing instrument section of `bad_apple.xm`.
   * Likely due to incorrect offset advancement between instrument header and its sample headers (`inst_headstart + inst_size` handling).
2. **Memory leak report from GeneralPurposeAllocator** when the parse fails – secondary symptom of early return.
3. Need to align `parseXmInstrument` logic exactly with C’s `Load_XM_Instrument`:
   * Header size and relocation (`file_seek_read( inst_headstart+inst_size )`).
   * Correct handling when `nsamples == 0`.
4. After parser is fixed, run `cmp` to verify bit-identity and update build script to automate the comparison.

## Next Steps
- Audit `parseXmInstrument` offset math; set `offset = inst_headstart + inst_size` after reading header.
- Rebuild and regenerate Zig MAS.
- Run `cmp bad_apple_ref.mas bad_apple_zig.mas`.
- If identical, add golden-test step to `build.zig`; otherwise iterate on discrepancies (envelope flags, sample header size, endianness).

