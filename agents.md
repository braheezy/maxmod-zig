This project is an attempt to port the C Maxmod/mmutil GBA sound library to Zig. We are focused on getting XM playback to be perfect and match the C reference. The strategy was to run the `zig translate-c` command on all required C files to meet this object. Those are the files in `src/` and the files in there are strictly to be used. We have a minimal `examples/xm` client to run the XM in the library.

The goal is to always identically match the C. We have a working `examples/xm_c_ref/` where we can build and run the C code.

The strategy we employ is to add identical debug AGB prints to the C and Zig code at the same points in execution. We print important data about the playback. If the zig is different from the C at all, we investigate and fix the code causing this, resolving the discrepancy. The `maxmod` and `mmutil` source code is local and can be inspected to understand the semantics and intent. We are using bit-identical input data and have transpiled the same logic. We should be able to match the reference C data with 100% accuracy.

For the C:
- build: make -C examples/xm_c_ref clean && make -C examples/xm_c_ref all
- run : timeout 4.5 mgba examples/xm_c_ref/xm_cref.gba &> c.log
For the Zig:
- build: zig build xm
- run: timeout 4.5 mgba zig-out/bin/xm.gba &> zig.log

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

You must always ensure the zig builds with `zig build xm`.

This has nothing to do with the mmutil folder. We generated the soundbank using the c based mmutil, guaranteeing that our input data is bit identical. you should only be working on files the in `src/` directory

Never create new log files. Overwrite the previous c.log or zig.log.

## Current Bug
XM playback was completed, so I started removing debug AGB prints in the Zig. This revealed that if the either of the two debug prints in mpp_Update_ACHN_notest_disable_and_panning in mas.zig are removed, audio playback regresses

None of the alternate options helped. so it's definitely the timing of std.fmt.bufPrint and it only works for the exact number of fmt args being handled. If I remove a single format arg being printed, like print a smaller message, then the audio regresses.

This is bad. how can we not depend on such fragily buffer formatting to get our audio working? They are unrelated things. How does the C code achieve the correct timing without depending on such hacks?

Search for `artificialDelay` in the project for the hack in place. These hardcoded delays depending on string formatting only works for bad_apple.xm. When other XM files are played, they have audio errors like repeating notes, and some will intermittently not play at all.

## Debugging Strategy for Timing Issue

The `artificialDelay` hack using `std.fmt.bufPrint` is masking a fundamental timing problem in the Zig implementation. The issue is that debug prints with string formatting affect execution timing, making it impossible to debug the real problem.

### Root Cause
- **Zig implementation runs faster** than the C reference
- **Debug prints with string formatting add timing delays** that mask the issue
- **Removing debug prints reveals audio artifacts** because the timing is wrong
- **The C version works without explicit delays** due to natural compilation characteristics

### Debugging Approach
Instead of using debug prints in timing-critical audio code, implement state capture that elevates data to a less critical call stack level:

1. **Capture state in hot audio loop** using a pre-allocated buffer
2. **Dump state at frame boundary** (outside timing-critical path)
3. **Compare state traces** between C and Zig to find divergence points
4. **Fix the underlying timing issue** rather than masking it

### Implementation Strategy
- Use `captureState()` calls in place of `artificialDelay()`
- Dump state buffer at end of `mpp_Update_ACHN_notest` (frame boundary)
- Add equivalent state capture to C reference for comparison
- Compare state dumps to identify where Zig execution diverges from C

### Why This Works
- **No timing impact** in critical audio path
- **Still debuggable** - we can see execution state
- **Identifies real problem** - timing differences become visible
- **Portable solution** - works across different XM files and optimization levels
