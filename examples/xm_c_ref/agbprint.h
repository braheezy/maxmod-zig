#pragma once
#include <stdarg.h>
#include <stddef.h>
#include <stdbool.h>

#ifdef __cplusplus
extern "C" {
#endif

void agb_print_init(void);
void agb_print_flush(void);
void agb_print_write(const char *s);
void agb_printf(const char *fmt, ...);

#ifdef __cplusplus
}
#endif
