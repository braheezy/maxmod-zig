# maxmod-zig

This is a WIP port of the MaxMod audio library to Zig for Game Boy Advance development.

## Usage

### Building

```bash
# Build the library
zig build

# Build and run SFX example with custom WAV
zig build sfx -- your_audio.wav
```

### In Your Project

```zig
const maxmod = @import("maxmod_gba");

// Initialize audio system
maxmod.init();

// Play a sound effect
maxmod.playSound(sound_id);

// Play music
maxmod.startMusic(music_id);

// Update audio (call in main loop)
maxmod.update();
```
