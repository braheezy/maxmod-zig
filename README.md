# maxmod-zig

This is a WIP port of the MaxMod audio library to Zig for Game Boy Advance development.

> [!WARNING]
> XM playback works, but there is a terrible bug that makes playback bad for most files so you probably don't want to use this unless you want to fix it!!

## Usage

### Building

```bash
# Build the library
zig build

# Build and run SFX example with custom WAV
zig build xm -- your_audio.xm
```

### In Your Project

TBD. See [`examples`](./examples/) for now.

## Showcase

**XM**
