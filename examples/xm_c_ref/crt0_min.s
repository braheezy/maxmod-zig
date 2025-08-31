.syntax unified
.cpu arm7tdmi
.arm
.global _start
.extern main
_start:
    ldr sp, =0x03007F00
    bl main
1:  b 1b
