This project is an attempt to port the C Maxmod/mmutil GBA sound library to Zig. We are focused on getting XM playback to be perfect and match the C reference. The strategy was to run the `zig translate-c` command on all required C files to meet this objective. Those are the files in `src/` and the files in there are strictly to be used. We have a minimal `examples/xm` client to run the XM in the library. After translation, all dead code was removed and some types and functions made more Zig-like.

The goal is to always identically match the C. We have a working `examples/xm_c_ref/` where we can build and run the C code. It links against the local maxmod C library source, allow us to instrument it.

The strategy we first employed is to add identical debug AGB prints to the C and Zig code at the same points in execution. We print important data about the playback. If the zig is different from the C at all, we investigate and fix the code causing this, resolving the discrepancy. The `maxmod` and `mmutil` source code is local and can be inspected to understand the semantics and intent. We are using bit-identical input data and have transpiled the same logic. We should be able to match the reference C data with 100% accuracy.

For the C:
- build: make -C examples/xm_c_ref clean && make -C examples/xm_c_ref all
- run : timeout 3 mgba examples/xm_c_ref/xm_cref.gba &> c.log
For the Zig:
- build: zig build xm
- run: timeout 3 mgba zig-out/bin/xm.gba &> zig.log

You are forbidden from running `git` commands. You do not need to capture build logs.

Your main task loop is thus the following:
- Build and run both C and Zig, getting new logs
- Review the logs, finding the earlier deviation
- Fix the deviation in the Zig code
- Build and run the Zig code to get a new log
- Review the log to verify the deviation is resolved. if not resolved, go back to fixing the zig code.
- Repeat

When running the commands given for building and running, literally run what I instructed. Do not add export variables. Do not put into a script. Run the commands as given and get the elevated sandbox permissions to run them.

The earlier the deviation found, the better. Solving these is of higher priority.

You must always ensure the zig builds with `zig build xm -Dxmdebug`.

This has nothing to do with the mmutil folder. We generated the soundbank using the c based mmutil, guaranteeing that our input data is bit identical. you should only be working on files the in `src/` directory

Never create new log files. Overwrite the previous c.log or zig.log.

## Current Bug
XM playback was completed, so I started removing debug AGB prints in the Zig. This revealed that if the either of the two debug prints in mpp_Update_ACHN_notest_disable_and_panning in mas.zig are removed, audio playback regresses

None of the alternate options helped. so it's definitely the timing of std.fmt.bufPrint and it only works for the exact number of fmt args being handled. If I remove a single format arg being printed, like print a smaller message, then the audio regresses.

This is bad. how can we not depend on such fragily buffer formatting to get our audio working? They are unrelated things. How does the C code achieve the correct timing without depending on such hacks?

## Debugging
there is a debug_state in shim that I've been populating and printing to verify the first frame. I traced through the functions and it all seems to match before the first call to mmMixerMix, a function in the compiled ASM object.

In the C, you can just add debug prints where needed.

In the zig, add a field to the debug state in the shim and set it, printing it later as needed to try to minimize the effect printing has on execution.

## Next Steps
After the recent fixes the Zig run now mirrors the C reference through the entire first tick
  of updateChannel_T0. The [T0E] captures on channels 0/1/9 have the same note/sample/flag state, the
  freshly added [VOL] dumps show identical inputs and clamped results, and the [SPV] mixer traces line up
  with the C log (ch 0/1 at fvol 255, ch 2 at 22). With T0 in sync, the next discrepancies will have to
  be beyond the first tick.

> Working to align the Zig/C playback traces uncovered
  that channel 0 in the Zig build is rebinding to the wrong
  sample address after the first tick—even though the STOP
  bit logic is now mirroring the C path. By instrumenting
  both sides I found the earliest divergence:

  - Zig [UMIX] stage=entry tick=3 … src=STOP type=0 while C
  still shows src=+0x153AC type=3 and keeps playing.
  - Digging deeper showed the Zig-generated sample pointer
  is bank_base + 0x15398 + 0x334, i.e. 0x320 bytes farther
  into the sample than the C code (bank_base + 0x15398 +
  0x84). That offset error explains the “garbage” audio—Zig
  is skipping an extra 0x320 bytes of sample data on every
  rebind.

  I added lightweight “BINDDBG” prints so we can compare the
  raw values in both binaries; the C log now needs matching
  prints so we can confirm its header/offset math. Once we
  see the C numbers it should be straightforward to adjust
  the Zig binding logic (likely just using the correct
  header size when computing hdr_addr/mix_ch.src).

  Next steps for you:

  1. Add a similar debug print in maxmod/source/core/
  mas.c (inside the sample_offset branch) to dump
  bank, sample_offset, sizeof(prefix) and the resulting
  mix_ch->src.
  2. Compare those lines with Zig’s [BINDDBG] entries to
  decide what the correct stride should be.
  3. Update the Zig pointer math accordingly (then drop the
  debug prints and rebuild both sides).
