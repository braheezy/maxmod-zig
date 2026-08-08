// Maxmod + libgba
#include <maxmod.h>
#include <gba_base.h>
#include <gba_video.h>
#include <gba_systemcalls.h>
#include "mgba.h"
#include "agbprint.h"
#include <stdio.h>
#include <stdarg.h>

static void agb_printv(const char *fmt, ...) {
    va_list args;
    va_start(args, fmt);
    agb_printf(fmt, args);
    va_end(args);
}

#include <gba_interrupt.h>
#include <maxmod.h>
// soundbank.s is assembled separately and provides `soundbank_bin` symbol

#define VERBOSE_LOG 0

// Override maxmod's internal debug function at link time (enable logs)
void mm_dbgf(const char *fmt, ...) __attribute__((weak));
void mm_dbgf(const char *fmt, ...) {
    if (fmt[0] == '[') {
        bool allow = false;
        switch (fmt[1]) {
            case 'B':
                // [BINDDBG]
                if (fmt[2] == 'I' && fmt[3] == 'N')
                    allow = true;
                break;
            case 'M':
                // [MIX] or [mm...]; let both through.
                allow = true;
                break;
            case 'S':
                // [SPV] or [STOPCHK]
                if (fmt[2] == 'T' && fmt[3] == 'O' && fmt[4] == 'P')
                    allow = true;
                break;
            case 'V':
                // [VOL]
                allow = (fmt[2] == 'O' && fmt[3] == 'L');
                break;
            case 'T':
                // [T0E]
                allow = (fmt[2] == '0' && fmt[3] == 'E');
                break;
            case 'U':
                // [UPD] / [UMIX]
                if (fmt[2] == 'P' && fmt[3] == 'D')
                    allow = true;
                break;
            case 'P':
                // [PANCHK]
                break;
            case 'A':
                // [DAP]
                allow = (fmt[2] == 'P');
                break;
            default:
                break;
        }
        if (!allow) return;
    }
    va_list args;
    va_start(args, fmt);
    agb_printf(fmt, args);
    va_end(args);
}

// Use mmInitDefault() for a canonical setup matching mmutil test ROMs
#define CHANNELS 32

// Exported by Maxmod runtime
extern mm_word mm_mixlen;
extern mm_word mmGetModuleCount(void);

int main(void) {
    // Basic GBA init + hook Maxmod vblank handler, enable mGBA logger
    irqInit();
    irqSet(IRQ_VBLANK, mmVBlank);
    irqEnable(IRQ_VBLANK);
    // ALWAYS enable debug backends for comparison
    mgba_open();
    agb_print_init();
    agb_printv("[STOP] value=0x%08x\n", 0x80000000);

    REG_DISPCNT = MODE_3 | BG2_ON;

    // Ensure BIOS sound bias is enabled (raw register)
    *((volatile u16*)0x04000088) = 0x200;

    // Use real MSL soundbank embedded as binary (produced by C mmutil)
    extern const unsigned char _binary_soundbank_bin_start[];
    extern const unsigned char _binary_soundbank_bin_end[];
    const unsigned char* sb = _binary_soundbank_bin_start;
    const unsigned bank_len = (unsigned)((uintptr_t)&_binary_soundbank_bin_end - (uintptr_t)_binary_soundbank_bin_start);
    agb_printv("[main] soundbank=0x%08x len=%u\n", (unsigned)(uintptr_t)sb, bank_len);

    // Initialize Maxmod with defaults (match Zig logs)
    mgba_printf("[main] mmInitDefault() starting with bank_len=%u\n", bank_len);
    mmInitDefault((mm_addr)sb, CHANNELS);
    mgba_printf("[main] mmInitDefault() done; mm_mixlen=%u\n", (unsigned)mm_mixlen);

    // Ensure sane defaults in case the soundbank header was empty
    mmSetModuleVolume(0x400);
    mmSetEffectsVolume(0x400);
    mgba_printf("[main] volumes set: module=0x%x effects=0x%x\n", 0x400, 0x400);
    // Do not override module tempo/pitch unless needed

    // Module count and start (match Zig logs)
    mgba_printf("[main] module_count=1 (hardcoded, mmGetModuleCount not available)\n");
    mgba_printf("[main] mmStart(0, MM_PLAY_LOOP)\n");
    mmStart(0, MM_PLAY_LOOP);
    mgba_printf("[main] mmStart() called\n");

    // Use tempo/pitch from MAS header (don't override)

    // Simple visual heartbeat: toggle first pixel color
    volatile u16 *vid = (u16*)0x06000000;
    u16 col = 0x7FFF; // white BGR15
    unsigned frame_count = 0;

    while (1) {
        mmFrame();
        *vid = col;
        col ^= 0x7FFF; // toggle
        VBlankIntrWait();
        frame_count += 1;
    }
}
