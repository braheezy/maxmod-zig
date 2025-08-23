# Maxmod-Zig

Pure Zig port of Maxmod (GBA/NDS audio library) and mmutil (audio conversion tool).

## Overview

This project ports the Maxmod audio library from C to Zig, maintaining compatibility with the original API while leveraging Zig's safety features and modern tooling.

## Strategy Shift: Translate‑C for XM/MAS

We changed tactics for XM and MAS support:

- Use `zig translate-c` generated Zig to call the original mmutil C for XM loading and MAS writing.
- Keep our existing Zig implementations for WAV→.mmraw and MOD→soundbank intact (do not replace MOD tooling).
- Goal: produce MAS files that are byte‑identical to the reference C mmutil output.

What this means practically:

- The host tool `mmutil-zig` acts as a thin Zig CLI wrapper that invokes the translated C routines:
  - `Load_XM()` from mmutil’s `xm.c`
  - `Write_MAS()` from mmutil’s `mas.c`
  - File I/O (`files.c`) and helpers (`simple.c`) are also translated and linked.
- A small Zig shim (`src/mmutil/tc/shim.zig`) exports globals (`MAS_FILESIZE`, `target_system`) expected by the C and selects the GBA path.
- Runtime (GBA) stays in Zig; only the host conversion path for XM→MAS is using translate‑C.

## Structure

- **`src/maxmod_gba/`** - Zig implementation of Maxmod for GBA
- **`src/mmutil/`** - Zig port of mmutil (WAV→.mmraw, MOD→soundbank)
- **`examples/`** - Demo ROMs (SFX, MOD, XM playback)
- **`maxmod/`** - Original C source (reference only)
- **`mmutil/`** - Original C source (reference only)

## Build

```bash
# Build SFX demo
zig build sfx

# Build MOD demo
zig build mod

# Build XM demo (stub)
zig build xm

# Build all
zig build
```

### mmutil‑zig translate‑C usage

- XM→MAS (using translated C):
  - `zig build run -- input.xm --mas -o soundbank.bin`
  - or `zig build run -- input.xm --xm -m -o soundbank.bin`
- WAV→.mmraw (Zig path):
  - `zig build run -- input.wav -o out.mmraw --rate 16000 --bps 8`
- MOD→soundbank (Zig path):
  - `zig build run -- input.mod --mod -o soundbank.bin`

## Status

- ✅ SFX playback (.mmraw files)
- ✅ MOD playback with soundbank generation
- 🔄 XM playback (stub only)
- ✅ mmutil-zig tool (WAV→.mmraw, MOD→soundbank)

The C sources in root directories are kept for reference and comparison during development.

## XM Porting Guide

### Phase 1: Independent Foundation Work (Can be done in parallel)

#### Stream A: XM Parser (`src/mmutil/xm_processor.zig`)
- [x] (Kept) Zig parser for experimentation and reference
- [x] Translate‑C path preferred for production XM→MAS via original C

#### Stream B: Build System Updates
- [x] **XM→Soundbank (translate‑C)** - Wire `mmutil-zig` to translated C
- [x] **Build Integration** - `build.zig` imports `tc_*` modules and shim
- [ ] **Example Updates** - Update XM demo to exercise real MAS output

#### Stream C: Runtime Foundation (`src/maxmod_gba/`)
- [x] **XM Loader (Zig)** - Keep existing Zig runtime work
- [ ] **Mode Flags** - Add XM mode support to player
- [ ] **Basic Playback** - Get XM modules playing without effects

### Phase 2: Integration & Advanced Features (Sequential)

#### Integration Tasks
- [ ] **Connect Parser to Loader** - Wire XM processor to runtime
- [ ] **Soundbank Integration** - Load XM samples into player
- [ ] **Pattern Playback** - Basic note/instrument playback

#### Advanced Features (Sequential)
- [ ] **XM Volume Commands** - Implement 0x10-0x9F range
- [ ] **Effect System** - Convert XM effects to Maxmod effects
- [ ] **Envelope Support** - Volume/panning/pitch envelopes
- [ ] **Frequency Modes** - Linear vs Amiga frequency handling

### Phase 3: Polish & Optimization
- [ ] **Performance Tuning** - Optimize XM-specific code paths
- [ ] **Memory Management** - Efficient XM data structures
- [ ] **Error Handling** - Robust XM file validation
- [ ] **Testing** - Comprehensive XM format coverage

### Key Differences from MOD:
- **Format**: Extended Module (XM) vs Protracker MOD
- **Channels**: Variable (1-32) vs fixed (4/6/8)
- **Effects**: XM-specific effect set vs MOD effects
- **Frequency**: Linear vs Amiga frequency mode
- **Instruments**: Multi-sample instruments vs single samples
- **Envelopes**: Volume/panning/pitch envelopes vs none

### Development Strategy:
1. **Start with Streams A, B, C in parallel** - These are independent and can be developed simultaneously
2. **Stream A (Parser) is highest priority** - Everything else depends on it
3. **Stream B (Build) enables testing** - Get XM files into the system early
4. **Stream C (Runtime) can be minimal initially** - Just enough to test parser output
5. **Phase 2 integration** happens after all Phase 1 streams are complete
6. **Advanced features** build incrementally on the foundation

## MAS Porting Guide

### Phase 1: Independent Foundation Work (Can be done in parallel)

#### Stream A: mmutil Writer (translate‑C)
- [x] Use translated `mas.c` directly via `Write_MAS()`
- [x] Use translated `files.c`/`simple.c` glue for I/O and helpers
- [x] CLI `-m/--mas` routes to translated path

#### Stream B: Runtime Loader (`src/maxmod_gba/mas.zig`)
- [x] Keep Zig runtime loader (no change)
- [x] Structs/headers mirrored in Zig as before

#### Stream C: Build System & Testing
- [x] **build.zig Updates** – Import `tc_*` modules and shim for host tool
- [ ] **Golden Files** – Compare against reference C mmutil output (byte‑identical)
- [ ] **Example Demo** – Add `examples/mas/` ROM that plays a converted song

### Phase 2: Integration & Compatibility (Sequential)
- [ ] **Connect Writer ↔ Loader** – End-to-end pipeline from input module → MAS → playback
- [ ] **Jingle Support** – Ensure MAS works for both main module and jingle layers
- [ ] **Compatibility Validation** – Byte-for-byte comparison with original C output where possible

### Phase 3: Optimization & Polish
- [ ] **Performance Tuning** – Optimize hot paths (pattern decoding, mixing hooks)
- [ ] **Memory Alignment** – Ensure word-aligned data structures for GBA IWRAM/EWRAM
- [ ] **Error Handling** – Robust validation of MAS files in tool & runtime
- [ ] **Documentation** – Update README/examples to cover MAS workflow

### Key References
- mmutil `source/mas.c`, `mas.h`
- maxmod `source/core/mas.c`, `core/mas.h`
- Existing Zig implementations for MOD & SFX as templates

### Development Strategy
1. **Translate‑C First for XM/MAS** – Use original C logic via generated Zig.
2. **Zig for MOD/SFX** – Keep existing Zig implementations unchanged.
3. **Golden Tests** – Verify byte‑identical MAS against reference C mmutil.
4. **Runtime Unchanged** – Continue Zig runtime development; MAS is an input format.
5. **Incremental Integration** – Land small, reviewable PRs per task.

### Byte‑Identical MAS Target
- Use only translated I/O (`files.c`) and MAS writer (`mas.c`) to avoid behavioral drift.
- Set `target_system = 0` (GBA) in the shim to match GBA header/loop semantics.
- Preserve alignment/padding (`BYTESMASHER` 0xBA) exactly as in C.
- Validate with golden diffs: `shasum` equality and `cmp -l` on mismatch.
