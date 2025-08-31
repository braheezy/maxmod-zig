#include "mgba.h"
#include <stdio.h>
#include <gba_base.h>
#include <gba_systemcalls.h>

#define REG_DEBUG_ENABLE *(volatile unsigned short*)0x4FFF780
#define REG_DEBUG_FLAGS  *(volatile unsigned short*)0x4FFF700
#define REG_DEBUG_STRING ((volatile char*)0x4FFF600)

int mgba_open(void) {
    REG_DEBUG_ENABLE = 0xC0DE;
    return REG_DEBUG_ENABLE == 0x1DEA; // mGBA sets this after enabling
}

bool mgba_write(enum mGBADebugLevel level, const char *str) {
    if (REG_DEBUG_ENABLE != 0x1DEA) return false;
    REG_DEBUG_FLAGS = (unsigned short)level | 0x100;
    const char *p = str;
    volatile char *dst = REG_DEBUG_STRING;
    while (*p) *dst++ = *p++;
    *dst = '\0';
    return true;
}

bool mgba_printf_level(enum mGBADebugLevel level, const char *fmt, ...) {
    if (REG_DEBUG_ENABLE != 0x1DEA) return false;
    char buf[256];
    va_list ap;
    va_start(ap, fmt);
    vsnprintf(buf, sizeof(buf), fmt, ap);
    va_end(ap);
    return mgba_write(level, buf);
}
