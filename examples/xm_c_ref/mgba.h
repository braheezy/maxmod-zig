#pragma once
#include <stdarg.h>
#include <stdbool.h>
#include <stdio.h>

#ifdef __cplusplus
extern "C" {
#endif

// mGBA debug log levels
enum mGBADebugLevel {
    MGBA_LOG_FATAL = 0,
    MGBA_LOG_ERROR = 1,
    MGBA_LOG_WARN  = 2,
    MGBA_LOG_INFO  = 3,
    MGBA_LOG_DEBUG = 4,
};

int mgba_open(void);
bool mgba_printf_level(enum mGBADebugLevel level, const char *fmt, ...);
static inline bool mgba_printf(const char *fmt, ...) {
    va_list ap;
    va_start(ap, fmt);
    // Forward to level INFO by default
    bool ok;
    {
        char buf[256];
        // We can't call mgba_printf_level with va_list directly without a v-variant.
        // So do the vsnprintf here and call the raw writer.
        extern bool mgba_write(enum mGBADebugLevel level, const char *str);
        vsnprintf(buf, sizeof(buf), fmt, ap);
        ok = mgba_write(MGBA_LOG_INFO, buf);
    }
    va_end(ap);
    return ok;
}

#ifdef __cplusplus
}
#endif
