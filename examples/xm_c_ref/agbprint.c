// Minimal AGBPrint implementation matching ZigGBA
#include "agbprint.h"
#include <stdarg.h>
#include <stdio.h>
#include <stdint.h>

typedef struct __attribute__((packed)) {
    uint16_t request;
    uint16_t bank;
    uint16_t get;
    uint16_t put;
} AgbPrintContext;

#define AGB_PRINT_PROTECT (*(volatile uint16_t*)0x09FE2FFE)
#define AGB_PRINT_CONTEXT (*(volatile AgbPrintContext*)0x09FE20F8)
#define AGB_PRINT_BUFFER  ((volatile uint16_t*)0x09FD0000)

static inline void agb_lock(void) { AGB_PRINT_PROTECT = 0x20; }
static inline void agb_unlock(void) { AGB_PRINT_PROTECT = 0x00; }
static inline void agb_flush(void) {
    // SWI 0xFA (AGB_PRINT)
    __asm__ volatile("svc 0xFA" ::: "memory");
}

void agb_print_init(void) {
    AGB_PRINT_PROTECT = 0x00;
    AGB_PRINT_CONTEXT.request = 0x00;
    AGB_PRINT_CONTEXT.get = 0x00;
    AGB_PRINT_CONTEXT.put = 0x00;
    AGB_PRINT_CONTEXT.bank = 0xFD;
    AGB_PRINT_PROTECT = 0x00;
}

static inline void agb_put_char(uint8_t c) {
    uint16_t put = AGB_PRINT_CONTEXT.put;
    uint16_t data = AGB_PRINT_BUFFER[put >> 1];
    if (put & 1) {
        data = ((uint16_t)c << 8) | (data & 0x00FF);
    } else {
        data = (data & 0xFF00) | c;
    }
    AGB_PRINT_BUFFER[put >> 1] = data;
    AGB_PRINT_CONTEXT.put = put + 1;
}

void agb_printf(const char *fmt, va_list args) {
    char buf[256];
    vsnprintf(buf, sizeof(buf), fmt, args);
    agb_lock();
    for (const char *p = buf; *p; ++p) {
        agb_put_char((uint8_t)*p);
    }
    agb_unlock();
    agb_flush();
}
