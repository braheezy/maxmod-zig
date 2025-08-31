# Simple GBA makefile using devkitARM and Maxmod
# Requires: devkitARM in PATH, mmutil soundbank at ../xm/soundbank.bin

# Tools
DEVKITPRO ?= /opt/devkitpro
DEVKITARM ?= $(DEVKITPRO)/devkitARM
PREFIX ?= $(DEVKITARM)/bin/arm-none-eabi
CC := $(PREFIX)-gcc
OBJCOPY := $(PREFIX)-objcopy

## Flags
GBAINC := $(DEVKITPRO)/libgba/include
GBALIB := $(DEVKITPRO)/libgba/lib
SPECS := -specs=gba.specs
CFLAGS := -mthumb -mcpu=arm7tdmi -O2 -ffreestanding -std=gnu11 -D__GBA__ -I$(GBAINC) -I$(DEVKITARM)/arm-none-eabi/include -I../../maxmod/include
LDFLAGS := $(SPECS) -L$(GBALIB)

# Use system's prebuilt libmm
MAXMODLIB := /opt/devkitpro/libgba/lib

## Sources
# Define DEBUG_LOG to enable logging to mGBA/AGBPrint
ifdef DEBUG
CFLAGS += -DDEBUG_LOG
endif

# Example sources
THUMB_SRCS := main.c mgba.c agbprint.c

# Build MSL soundbank (C mmutil) from bad_apple.xm and embed it.
MSL_BIN := soundbank.bin
SOUNDBANK_OBJ := soundbank.o
OBJS := $(THUMB_SRCS:.c=.o) $(SOUNDBANK_OBJ)

# Output
TARGET := xm_cref
BIN := $(TARGET).gba

all: $(BIN)

## Optional: regenerate MAS from XM (uncomment if needed)
# Auto-generate MSL soundbank from project root XM using C mmutil
$(MSL_BIN): ../../bad_apple.xm ../../mmutil/source/mmutil
	../../mmutil/source/mmutil ../../bad_apple.xm -o$(MSL_BIN) -h soundbank.h

../../mmutil/source/mmutil:
	$(MAKE) -C ../../mmutil/source


%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

$(SOUNDBANK_OBJ): $(MSL_BIN)
	$(OBJCOPY) -I binary -O elf32-littlearm -B arm \
	  --rename-section .data=.rodata,alloc,load,readonly,data,contents \
	  $(MSL_BIN) $@


$(BIN): $(OBJS)
	# Link against prebuilt libmm.a
	$(CC) $(LDFLAGS) $(OBJS) -L$(MAXMODLIB) -lmm -lgba -lc -lgcc -o $(TARGET).elf
	$(OBJCOPY) -O binary $(TARGET).elf $(BIN)
	gbafix $(BIN) -t"XM CREF" -cXMCF -m00 -r00

clean:
	rm -f $(OBJS) $(TARGET).elf $(BIN) $(TARGET).map

# Assembly rule (if any .s are added later)
%.o: %.s
	$(CC) $(CFLAGS) -c $< -o $@
