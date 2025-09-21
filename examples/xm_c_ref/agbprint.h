#pragma once
#include <stdarg.h>

// Simple AGBPrint shim that forwards to mGBA logger
void agb_print_init(void);
void agb_printf(const char *fmt, va_list args);

