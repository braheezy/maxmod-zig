This project is an attempt to port the C Maxmod/mmutil GBA sound library to Zig. We are focused on getting XM playback to be perfect and match the C reference. The strategy was to run the `zig translate-c` command on all required C files to meet this object. Those are the files in `src/port/` and the files in there are strictly to be used. We have a minimal `examples/xm_port` client to run the XM in the library.

The goal is to always identically match the C. We have a working `examples/xm_c_ref/` where we can build and run the C code.

The strategy we employ is to add identical debug AGB prints to the C and Zig code at the same points in execution. We print important data about the playback. If the zig is different from the C at all, we investigate and fix the code causing this, resolving the discrepancy. The `maxmod` and `mmutil` source code is local and can be inspected to understand the semantics and intent. We are using bit-identical input data and have transpiled the same logic. We should be able to match the reference C data with 100% accuracy.

For the C:
- build: make -C example/xm_c_ref clean && make -C example/xm_c_ref all
- run : timeout 4.5 mgba examples/xm_c_ref/xm_cref.gba &> c.log
- note: The prints in the C seem to slow it down so in the same amount of wall time, the C advances though less audio and less processing than the zig. this means you need to timeout longer on the C to get to the same place in playback. maybe there is another counter of sorts to use instead of guessing with time.
For the Zig:
- build: zig build xm-port
- run: timeout 3.5 mgba zig-out/bin/xm-port.gba &> zig.log

You are forbidden from running `git` commands. You do not need to capture build logs.

Your main task loop is thus the following:
- Build and run both C and Zig, getting new logs
- Review the logs, finding the earlier deviation
- Fix the deviation in the Zig code
- Build and run the Zig code to get a new log
- Review the log to verify the deviation is resolved. if not resolved, go back to fixing the zig code.
- Repeat

Ask permission to run commands in the sandbox using the codex prompt. When running the commands given for building and running, literally run what I instructed. Do not add export variables. Do not put into a script. Run the commands as given and get the elevated sandbox permissions to run them.

The earlier the deviation found, the better. Solving these is of higher priority.

You must always ensure the zig builds with `zig build xm-port`.

This has nothing to do with the mmutil folder. We generated the soundbank using the c based mmutil, guaranteeing that our input data is bit identical. you should only be working on files the in `src/port/` directory

Never create new log files. Overwrite the previous c.log or zig.log.
