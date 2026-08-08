# Simple GBA makefile using devkitARM and Maxmod
# Requires: devkitARM in PATH, mmutil soundbank at ../xm/soundbank.bin

# Tools
DEVKITPRO ?= /opt/devkitpro
DEVKITARM ?= $(DEVKITPRO)/devkitARM
PREFIX ?= $(DEVKITARM)/bin/arm-none-eabi
CC := $(PREFIX)-gcc
OBJCOPY := $(PREFIX)-objcopy
GBAFIX := $(DEVKITPRO)/tools/bin/gbafix

## Flags
GBAINC := $(DEVKITPRO)/libgba/include
GBALIB := $(DEVKITPRO)/libgba/lib
SPECS := -specs=gba.specs
CFLAGS := -mthumb -mcpu=arm7tdmi -O2 -ffreestanding -std=gnu11 -D__GBA__ -I$(GBAINC) -I$(DEVKITARM)/arm-none-eabi/include -I../../maxmod/include
LDFLAGS := $(SPECS) -L$(GBALIB)

# Use devkitPro's C Maxmod reference library.
MAXMODLIB ?= $(GBALIB)

## Sources
# Define DEBUG_LOG to enable logging to mGBA/AGBPrint
ifdef DEBUG
CFLAGS += -DDEBUG_LOG -g
endif

# Example sources
THUMB_SRCS := main.c mgba.c agbprint.c

# Embed the same generated MSL soundbank used by the Zig XM example.
MSL_BIN := soundbank.bin
SOUNDBANK_SOURCE ?= ../xm/soundbank.bin
SOUNDBANK_OBJ := soundbank.o
OBJS := $(THUMB_SRCS:.c=.o) $(SOUNDBANK_OBJ)

# Output
TARGET ?= xm_cref
BIN := $(TARGET).gba

all: $(BIN)

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

$(MSL_BIN): $(SOUNDBANK_SOURCE)
	cp $< $@

$(SOUNDBANK_OBJ): $(MSL_BIN)
	$(OBJCOPY) -I binary -O elf32-littlearm -B arm \
	  --rename-section .data=.rodata,alloc,load,readonly,data,contents \
	  $(MSL_BIN) $@


$(BIN): $(OBJS) $(MAXMODLIB)/libmm.a
	# Link against local maxmod libmm.a first
	$(CC) $(SPECS) $(OBJS) -L$(MAXMODLIB) -lmm -L$(GBALIB) -lgba -lc -lgcc -o $(TARGET).elf
	$(OBJCOPY) -O binary $(TARGET).elf $(BIN)
	$(GBAFIX) $(BIN) -t"XM CREF" -cXMCF -m00 -r00

clean:
	rm -f $(OBJS) $(TARGET).elf $(BIN) $(TARGET).map

# Assembly rule (if any .s are added later)
%.o: %.s
	$(CC) $(CFLAGS) -c $< -o $@
