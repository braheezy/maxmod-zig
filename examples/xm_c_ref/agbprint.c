#include "agbprint.h"
#include <stdio.h>
#include <stdarg.h>
#include <stdint.h>

// Mirrors zig gba.debug
typedef struct __attribute__((packed)) {
    uint16_t request;
    uint16_t bank;
    uint16_t get;
    uint16_t put;
} PrintContext;

#define AGB_PRINT_PROTECT (*(volatile uint16_t*)0x09FE2FFE)
#define AGB_PRINT_CONTEXT (*(volatile PrintContext*)0x09FE20F8)
#define AGB_PRINT_BUFFER  ((volatile uint16_t*)0x09FD0000)
#define AGB_BUFFER_SIZE   0x100

static inline void agb_lock(void) { AGB_PRINT_PROTECT = 0x20; }
static inline void agb_unlock(void) { AGB_PRINT_PROTECT = 0x00; }
static inline void agb_print_char(uint8_t c) {
    uint16_t data = AGB_PRINT_BUFFER[AGB_PRINT_CONTEXT.put >> 1];
    if (AGB_PRINT_CONTEXT.put & 1) {
        data = ((uint16_t)c << 8) | (data & 0x00FF);
    } else {
        data = (data & 0xFF00) | c;
    }
    AGB_PRINT_BUFFER[AGB_PRINT_CONTEXT.put >> 1] = data;
    AGB_PRINT_CONTEXT.put += 1;
}

void agb_print_init(void) {
    AGB_PRINT_PROTECT = 0x00;
    AGB_PRINT_CONTEXT.request = 0x00;
    AGB_PRINT_CONTEXT.get = 0x00;
    AGB_PRINT_CONTEXT.put = 0x00;
    AGB_PRINT_CONTEXT.bank = 0xFD;
    AGB_PRINT_PROTECT = 0x00;
}

void agb_print_flush(void) {
    // SWI 0xFA
    __asm__ volatile("swi 0xFA");
}

void agb_print_write(const char *s) {
    agb_lock();
    while (*s) {
        agb_print_char((uint8_t)*s++);
    }
    agb_unlock();
    agb_print_flush();
}

void agb_printf(const char *fmt, ...) {
    char buf[256];
    va_list ap;
    va_start(ap, fmt);
    vsnprintf(buf, sizeof(buf), fmt, ap);
    va_end(ap);
    agb_print_write(buf);
}
