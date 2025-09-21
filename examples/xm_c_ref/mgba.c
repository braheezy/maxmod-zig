#include <stdint.h>
#include <stdbool.h>
#include <string.h>
#include "mgba.h"

#define REG_DEBUG_ENABLE   (*(volatile uint16_t*)0x4FFF780)
#define REG_DEBUG_FLAGS    (*(volatile uint16_t*)0x4FFF700)
#define REG_DEBUG_STRING   ((volatile char*)0x4FFF600)

int mgba_open(void) {
    REG_DEBUG_ENABLE = 0xC0DE;
    return 1;
}

bool mgba_write(enum mGBADebugLevel level, const char *str) {
    if (!str) return false;
    // Copy string to debug buffer (truncate to 252 chars for safety)
    size_t len = strlen(str);
    if (len > 252) len = 252;
    for (size_t i = 0; i < len; ++i) {
        REG_DEBUG_STRING[i] = str[i];
    }
    REG_DEBUG_STRING[len] = '\0';
    // Trigger log with level in high byte, and bit0 set
    REG_DEBUG_FLAGS = (uint16_t)((level << 8) | 0x01);
    return true;
}

