.section .rodata
.align 4
.global soundbank_bin
.global soundbank_bin_end
.global soundbank_bin_size

soundbank_bin:
    .incbin "soundbank.bin"
soundbank_bin_end:

soundbank_bin_size = soundbank_bin_end - soundbank_bin
