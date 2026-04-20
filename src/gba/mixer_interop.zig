// Zig replacements for assembly mixer functions
// These override weak symbols in mixer_asm.o via symbol interposition

// External symbols from mixer_asm.o
extern fn mpm_mix_complete() callconv(.naked) noreturn;
extern fn mpm_after_clear() callconv(.naked) noreturn;
extern fn mpm_aligned() callconv(.naked) noreturn;

/// mmMixer_ClearBuffer - Clear the mixing buffer before mixing
/// Called from mmMixerMix, branches back to mpm_after_clear
///
/// Entry: r0 = sample count
/// Clobbers: r0-r10
export fn mmMixer_ClearBuffer() linksection(".iwram") callconv(.naked) noreturn {
    asm volatile (thumb_to_arm_preamble ++
            // r0 = sample count on entry
            // r10 = remainder (samples & 7)
            // r2 = count of 32-byte blocks (samples >> 3)
            \\and     r10, r0, #7
            \\mov     r2, r0, lsr #3
            // Load mm_mixbuffer address into r0
            \\ldr     r0, =mm_mixbuffer
            \\ldr     r0, [r0]
            // Zero registers for stmia
            \\mov     r1, #0
            \\mov     r3, r1
            \\mov     r4, r1
            \\mov     r5, r1
            \\mov     r6, r1
            \\mov     r7, r1
            \\mov     r8, r1
            \\mov     r9, r1
            // Clear 32 bytes at a time
            \\cmp     r2, #0
            \\beq     2f
        \\1:
            \\stmia   r0!, {r1, r3-r9}
            \\subs    r2, r2, #1
            \\bne     1b
        \\2:
            // Clear remainder 4 bytes at a time
            \\cmp     r10, #0
            \\beq     3f
        \\1:
            \\str     r1, [r0], #4
            \\subs    r10, r10, #1
            \\bne     1b
        \\3:
            \\b       mpm_after_clear
    );
    unreachable;
}

/// mmMix_Skip - Skip mixing (volume is zero)
///
/// Register convention from mixer_asm.s:
///   r3 = rmixcc (mix count)
///   r7 = rread (read position)
///   r9 = rfreq (frequency)
///
/// Original assembly:
///   mul     r0, rmixcc, rfreq    // r0 = mix_count * frequency
///   add     rread, rread, r0     // read_position += r0
///   b       .mpm_mix_complete    // return to mixer
///
// Thumb->ARM mode switch preamble (4 bytes)
// Required because Zig compiles for Thumb but mixer must be ARM
const thumb_to_arm_preamble =
    \\.short 0x4778
    \\.short 0x46c0
    \\.arm
    \\
;

// External data from mixer_asm.o
extern var mm_fetch: [400]u8;

/// mmMix_FetchSamples - Prefetch samples from ROM to IWRAM for faster mixing
/// This is a DMA-optimized copy that fetches samples in batches of 40, 24, and 4
///
/// Entry state:
///   r1 = sample count to fetch (in 20.12 fixed point)
///   r7 = rread (read position, 20.12 fixed point)
///   r10 = rsrc (sample source pointer in ROM)
///
/// Exit state:
///   r10 = rsrc -> mm_fetch buffer (with alignment offset)
///   r7 = rread with integer part cleared
///   Stack: {original_read_integer, original_rsrc} pushed
///
/// Branches to mmMix_CheckAlign when done
export fn mmMix_FetchSamples() linksection(".iwram") callconv(.naked) noreturn {
    asm volatile (thumb_to_arm_preamble ++
            // Save registers for fetch operation
            \\push    {r3-r12}
            // r0 = destination (mm_fetch)
            \\ldr     r0, =mm_fetch
            // r10 = source + read offset, aligned to 32 bits
            \\add     r10, r10, r7, lsr #12
            \\bic     r10, #0b11
            // r1 += 4 << 12 (safety threshold), then subtract 40 << 12
            \\add     r1, r1, #0x4000
            \\subs    r1, r1, #0x28000
            \\bcc     .exit_fetch_zig
            //
            // Large fetch loop: 40 samples (10 registers) at a time
            //
        \\.fetch_zig:
            \\ldmia   r10!, {r2-r9, r11, r14}
            \\stmia   r0!, {r2-r9, r11, r14}
            \\subs    r1, r1, #0x28000
            \\bcc     .exit_fetch_zig
            \\ldmia   r10!, {r2-r9, r11, r14}
            \\stmia   r0!, {r2-r9, r11, r14}
            \\subs    r1, r1, #0x28000
            \\bcc     .exit_fetch_zig
            \\ldmia   r10!, {r2-r9, r11, r14}
            \\stmia   r0!, {r2-r9, r11, r14}
            \\subs    r1, r1, #0x28000
            \\bcs     .fetch_zig
            //
        \\.exit_fetch_zig:
            // Medium fetch: adjust count and do 24 samples at a time
            // adds r1, #(40 << 12) - (24 << 12) = #0x10000
            \\adds    r1, r1, #0x10000
            \\bmi     .end_medfetch_zig
        \\.medfetch_zig:
            \\ldmia   r10!, {r2-r7}
            \\stmia   r0!, {r2-r7}
            \\subs    r1, r1, #0x18000
            \\bcc     .end_medfetch_zig
            \\ldmia   r10!, {r2-r7}
            \\stmia   r0!, {r2-r7}
            \\subs    r1, r1, #0x18000
            \\bcc     .end_medfetch_zig
            \\ldmia   r10!, {r2-r7}
            \\stmia   r0!, {r2-r7}
            \\subs    r1, r1, #0x18000
            \\bcs     .medfetch_zig
        \\.end_medfetch_zig:
            // Small fetch: 4 samples at a time
            // adds r1, #24 << 12 = #0x18000
            \\adds    r1, r1, #0x18000
            \\bmi     .end_fetch_zig
        \\.fetchsmall_zig:
            \\ldr     r2, [r10], #4
            \\str     r2, [r0], #4
            \\subs    r1, r1, #0x4000
            \\ble     .end_fetch_zig
            \\ldr     r2, [r10], #4
            \\str     r2, [r0], #4
            \\subs    r1, r1, #0x4000
            \\bgt     .fetchsmall_zig
        \\.end_fetch_zig:
            // Restore registers
            \\pop     {r3-r12}
            //
            // Set up rsrc to point to mm_fetch buffer
            //
            // r0 = rread >> 12 (get read integer)
            \\mov     r0, r7, lsr #12
            // Push {r0, rsrc} to save original read position and source
            \\push    {r0, r10}
            // Clear integer part of rread: rread &= 0xFFF
            \\bic     r7, r7, r0, lsl #12
            // r0 = alignment offset (low 2 bits of original read integer)
            \\and     r0, r0, #0b11
            // rsrc = mm_fetch + offset
            \\ldr     r10, =mm_fetch
            \\add     r10, r10, r0
            // Continue to alignment check
            \\b       mmMix_CheckAlign
    );
    unreachable;
}

/// mmMix_Dispatch - Determine mixing mode based on volume values
/// Branches to appropriate mixing routine based on L/R volume comparison
///
/// Register inputs:
///   r5 = rvolL  (left volume)
///   r6 = rvolR  (right volume)
///
/// Dispatch logic:
///   - If rvolL == rvolR: center mixing (or skip if both zero)
///   - If rvolL == 0: right-only mixing
///   - If rvolR == 0: left-only mixing
///   - Otherwise: arbitrary panning
export fn mmMix_Dispatch() linksection(".iwram") callconv(.naked) noreturn {
    asm volatile (thumb_to_arm_preamble ++
            // cmp rvolL, rvolR
            \\cmp     r5, r6
            \\beq     .dispatch_center_zig
            // cmp rvolL, #0 (left volume zero = right-only)
            \\cmp     r5, #0
            \\beq     mmMix_HardRight
            // cmp rvolR, #0 (right volume zero = left-only)
            \\cmp     r6, #0
            \\beq     mmMix_HardLeft
            // otherwise arbitrary panning
            \\b       mmMix_ArbPanning
        \\.dispatch_center_zig:
            // center mixing - check if volume is zero
            \\cmp     r5, #0
            \\bne     mmMix_CenteredPanning
            \\b       mmMix_Skip
    );
    unreachable;
}

/// mmMix_CheckAlign - Check buffer alignment and mix one sample if needed
/// If mix buffer (r8) is not word-aligned, mixes one sample to align it
/// Called before main mixing loops, branches to mpm_aligned
///
/// Register inputs:
///   r3 = rmixcc (mix count)
///   r5 = rvolL  (left volume)
///   r6 = rvolR  (right volume)
///   r7 = rread  (read position, 20.12 fixed point)
///   r8 = rmixb  (mix buffer pointer)
///   r9 = rfreq  (frequency increment)
///   r10 = rsrc  (sample source pointer)
///
/// Modifies: r0, r1, r2, r3, r7, r8 (if not aligned)
export fn mmMix_CheckAlign() linksection(".iwram") callconv(.naked) noreturn {
    asm volatile (thumb_to_arm_preamble ++
            // Test alignment of mix buffer (rmixb = r8)
            \\tst     r8, #0b11
            \\beq     mpm_aligned
            // Not aligned - mix one sample to align
            // ldrb rsampa, [rsrc, rread, lsr #12]
            \\ldrb    r0, [r10, r7, lsr #12]
            // add rread, rread, rfreq
            \\add     r7, r7, r9
            // mul rsampb, rsampa, rvolL
            \\mul     r2, r0, r5
            // ldrh rsamp1, [rmixb]
            \\ldrh    r1, [r8]
            // add rsamp1, rsamp1, rsampb, lsr #5
            \\add     r1, r1, r2, lsr #5
            // strh rsamp1, [rmixb], #4
            \\strh    r1, [r8], #4
            // mul rsampb, rsampa, rvolR
            \\mul     r2, r0, r6
            // ldrh rsamp1, [rmixb]
            \\ldrh    r1, [r8]
            // add rsamp1, rsamp1, rsampb, lsr #5
            \\add     r1, r1, r2, lsr #5
            // strh rsamp1, [rmixb], #2
            \\strh    r1, [r8], #2
            // sub rmixcc, rmixcc, #1
            \\sub     r3, r3, #1
            \\b       mpm_aligned
    );
    unreachable;
}

/// mmMix_Skip - Skip mixing (volume is zero)
/// Just advances read position without mixing.
export fn mmMix_Skip() linksection(".iwram") callconv(.naked) noreturn {
    asm volatile (thumb_to_arm_preamble ++
            \\mul     r0, r3, r9
            \\add     r7, r7, r0
            \\b       mpm_mix_complete
    );
    unreachable;
}

/// mmMix_Remainder - Mix remaining samples after unrolled loops
///
/// Register inputs:
///   r3 = rmixcc (mix count, must be > 0)
///   r5 = rvolL  (left volume)
///   r6 = rvolR  (right volume)
///   r7 = rread  (read position, 20.12 fixed point)
///   r8 = rmixb  (mix buffer pointer)
///   r9 = rfreq  (frequency increment)
///   r10 = rsrc  (sample source pointer)
///
/// Clobbers: r0, r1, r2, r3, r4, r7, r8, r11
export fn mmMix_Remainder() linksection(".iwram") callconv(.naked) noreturn {
    asm volatile (thumb_to_arm_preamble ++
        \\orr     r11, r5, r6, lsl #16
        \\.mix_remaining_zig:
        \\ldrb    r0, [r10, r7, lsr #12]
        \\add     r7, r7, r9
        \\mul     r4, r11, r0
        \\ldrh    r1, [r8]
        \\bic     r2, r4, #0xFF0000
        \\add     r1, r1, r2, lsr #5
        \\strh    r1, [r8], #2
        \\ldrh    r1, [r8, #2]
        \\add     r1, r1, r4, lsr #21
        \\strh    r1, [r8, #2]
        \\subs    r3, r3, #2
        \\blt     .end_mix_remaining_zig
        \\ldrb    r0, [r10, r7, lsr #12]
        \\add     r7, r7, r9
        \\mul     r4, r11, r0
        \\ldrh    r1, [r8]
        \\bic     r2, r4, #0xFF0000
        \\add     r1, r1, r2, lsr #5
        \\strh    r1, [r8], #4
        \\ldrh    r1, [r8]
        \\add     r1, r1, r4, lsr #21
        \\strh    r1, [r8], #2
        \\bgt     .mix_remaining_zig
        \\.end_mix_remaining_zig:
        \\b       mpm_mix_complete
    );
    unreachable;
}

/// mmMix_HardLeft - Mix hard-panned left channel
/// Calls mmMix_SingleChannel then handles remainder
///
/// Register inputs:
///   r3 = rmixcc (mix count)
///   r5 = rvolL  (left volume)
///   r7 = rread  (read position)
///   r8 = rmixb  (mix buffer pointer)
///   r9 = rfreq  (frequency increment)
///   r10 = rsrc  (sample source pointer)
export fn mmMix_HardLeft() linksection(".iwram") callconv(.naked) noreturn {
    asm volatile (thumb_to_arm_preamble ++
            \\bl      mmMix_SingleChannel
            \\bgt     mmMix_Remainder
            \\b       mpm_mix_complete
    );
    unreachable;
}

/// mmMix_HardRight - Mix hard-panned right channel
/// Swaps volume, offsets buffer, calls mmMix_SingleChannel, then restores and handles remainder
///
/// Register inputs:
///   r3 = rmixcc (mix count)
///   r5 = rvolL  (should be 0, will be overwritten)
///   r6 = rvolR  (right volume)
///   r7 = rread  (read position)
///   r8 = rmixb  (mix buffer pointer)
///   r9 = rfreq  (frequency increment)
///   r10 = rsrc  (sample source pointer)
export fn mmMix_HardRight() linksection(".iwram") callconv(.naked) noreturn {
    asm volatile (thumb_to_arm_preamble ++
            \\mov     r5, r6
            \\add     r8, r8, #4
            \\bl      mmMix_SingleChannel
            \\mov     r5, #0
            \\sub     r8, r8, #4
            \\bgt     mmMix_Remainder
            \\b       mpm_mix_complete
    );
    unreachable;
}

/// mmMix_ArbPanning - Mix with arbitrary L/R panning (most complex, slowest)
/// Processes 10 samples per loop iteration with independent L/R volume multiplication
///
/// Register inputs:
///   r3 = rmixcc (mix count)
///   r5 = rvolL  (left volume)
///   r6 = rvolR  (right volume)
///   r7 = rread  (read position, 20.12 fixed point)
///   r8 = rmixb  (mix buffer pointer)
///   r9 = rfreq  (frequency increment)
///   r10 = rsrc  (sample source pointer)
///
/// Uses: r0, r1, r2, r4, r11, r12, r14(lr) as scratch
/// Note: Splits sample 5's L/R processing across two buffer loads for efficiency
export fn mmMix_ArbPanning() linksection(".iwram") callconv(.naked) noreturn {
    asm volatile (thumb_to_arm_preamble ++
            \\subs    r3, r3, #10
            \\bmi     .mpmaa_10e_zig
        \\.mpmaa_10_zig:
            // Load 5 words from mix buffer
            \\ldmia   r8, {r1, r2, r4, r11, r14}
            // MIX_DB rvolL, rvolR, r1, r2, r0, r12 (samples 0-1)
            \\ldrb    r0, [r10, r7, lsr #12]
            \\add     r7, r7, r9
            \\ldrb    r12, [r10, r7, lsr #12]
            \\add     r7, r7, r9
            \\orr     r0, r0, r12, lsl #16
            \\mul     r12, r0, r5
            \\bic     r12, r12, #0x1F0000
            \\add     r1, r1, r12, lsr #5
            \\mul     r12, r0, r6
            \\bic     r12, r12, #0x1F0000
            \\add     r2, r2, r12, lsr #5
            // MIX_DB rvolL, rvolR, r4, r11, r0, r12 (samples 2-3)
            \\ldrb    r0, [r10, r7, lsr #12]
            \\add     r7, r7, r9
            \\ldrb    r12, [r10, r7, lsr #12]
            \\add     r7, r7, r9
            \\orr     r0, r0, r12, lsl #16
            \\mul     r12, r0, r5
            \\bic     r12, r12, #0x1F0000
            \\add     r4, r4, r12, lsr #5
            \\mul     r12, r0, r6
            \\bic     r12, r12, #0x1F0000
            \\add     r11, r11, r12, lsr #5
            // MIX_DB rvolL, rvolR, r14, 0, r0, r12 (samples 4-5, LEFT ONLY)
            // r0 preserved for completing right channel after next load
            \\ldrb    r0, [r10, r7, lsr #12]
            \\add     r7, r7, r9
            \\ldrb    r12, [r10, r7, lsr #12]
            \\add     r7, r7, r9
            \\orr     r0, r0, r12, lsl #16
            \\mul     r12, r0, r5
            \\bic     r12, r12, #0x1F0000
            \\add     r14, r14, r12, lsr #5
            // Store first 5 words
            \\stmia   r8!, {r1, r2, r4, r11, r14}
            // Load next 5 words
            \\ldmia   r8, {r1, r2, r4, r11, r14}
            // Complete samples 4-5 RIGHT channel (r0 still has sample pair)
            \\mul     r12, r0, r6
            \\bic     r12, r12, #0x1F0000
            \\add     r1, r1, r12, lsr #5
            // MIX_DB rvolL, rvolR, r2, r4, r0, r12 (samples 6-7)
            \\ldrb    r0, [r10, r7, lsr #12]
            \\add     r7, r7, r9
            \\ldrb    r12, [r10, r7, lsr #12]
            \\add     r7, r7, r9
            \\orr     r0, r0, r12, lsl #16
            \\mul     r12, r0, r5
            \\bic     r12, r12, #0x1F0000
            \\add     r2, r2, r12, lsr #5
            \\mul     r12, r0, r6
            \\bic     r12, r12, #0x1F0000
            \\add     r4, r4, r12, lsr #5
            // MIX_DB rvolL, rvolR, r11, r14, r0, r12 (samples 8-9)
            \\ldrb    r0, [r10, r7, lsr #12]
            \\add     r7, r7, r9
            \\ldrb    r12, [r10, r7, lsr #12]
            \\add     r7, r7, r9
            \\orr     r0, r0, r12, lsl #16
            \\mul     r12, r0, r5
            \\bic     r12, r12, #0x1F0000
            \\add     r11, r11, r12, lsr #5
            \\mul     r12, r0, r6
            \\bic     r12, r12, #0x1F0000
            \\add     r14, r14, r12, lsr #5
            // Store second 5 words
            \\stmia   r8!, {r1, r2, r4, r11, r14}
            // Loop control
            \\subs    r3, r3, #10
            \\bpl     .mpmaa_10_zig
        \\.mpmaa_10e_zig:
            \\adds    r3, r3, #10
            \\bgt     mmMix_Remainder
            \\b       mpm_mix_complete
    );
    unreachable;
}

/// mmMix_CenteredPanning - Mix center-panned audio (L=R volume)
/// Processes 6 samples per loop iteration, mixing same value to both L and R channels
///
/// Register inputs:
///   r3 = rmixcc (mix count)
///   r5 = rvolL  (volume, same as rvolR for centered)
///   r6 = rvolR  (volume, same as rvolL)
///   r7 = rread  (read position, 20.12 fixed point)
///   r8 = rmixb  (mix buffer pointer)
///   r9 = rfreq  (frequency increment)
///   r10 = rsrc  (sample source pointer)
///
/// Uses: r0, r1, r2, r4, r6, r11, r12, lr as scratch
/// Note: lr can be clobbered since we branch to mpm_mix_complete (don't return via bx lr)
export fn mmMix_CenteredPanning() linksection(".iwram") callconv(.naked) noreturn {
    asm volatile (thumb_to_arm_preamble ++
            // subs rmixcc, rmixcc, #6
            \\subs    r3, r3, #6
            \\bmi     .mpmac_6e_zig
        \\.mpmac_6_zig:
            // ldmia rmixb, {r1, r2, r4, r6, r11, r12}
            \\ldmia   r8, {r1, r2, r4, r6, r11, r12}
            // MIX_DC rvolL(r5), r1, r2, r0, lr - mix 2 samples to both channels
            \\ldrb    r0, [r10, r7, lsr #12]
            \\add     r7, r7, r9
            \\ldrb    r14, [r10, r7, lsr #12]
            \\add     r7, r7, r9
            \\orr     r0, r0, r14, lsl #16
            \\mul     r14, r0, r5
            \\bic     r14, r14, #0x1F0000
            \\add     r1, r1, r14, lsr #5
            \\add     r2, r2, r14, lsr #5
            // MIX_DC rvolL(r5), r4, r6, r0, lr
            \\ldrb    r0, [r10, r7, lsr #12]
            \\add     r7, r7, r9
            \\ldrb    r14, [r10, r7, lsr #12]
            \\add     r7, r7, r9
            \\orr     r0, r0, r14, lsl #16
            \\mul     r14, r0, r5
            \\bic     r14, r14, #0x1F0000
            \\add     r4, r4, r14, lsr #5
            \\add     r6, r6, r14, lsr #5
            // MIX_DC rvolL(r5), r11, r12, r0, lr
            \\ldrb    r0, [r10, r7, lsr #12]
            \\add     r7, r7, r9
            \\ldrb    r14, [r10, r7, lsr #12]
            \\add     r7, r7, r9
            \\orr     r0, r0, r14, lsl #16
            \\mul     r14, r0, r5
            \\bic     r14, r14, #0x1F0000
            \\add     r11, r11, r14, lsr #5
            \\add     r12, r12, r14, lsr #5
            // stmia rmixb!, {r1, r2, r4, r6, r11, r12}
            \\stmia   r8!, {r1, r2, r4, r6, r11, r12}
            // subs rmixcc, rmixcc, #6
            \\subs    r3, r3, #6
            \\bpl     .mpmac_6_zig
        \\.mpmac_6e_zig:
            // mov rvolR, rvolL (restore right volume = left volume)
            \\mov     r6, r5
            // adds rmixcc, rmixcc, #6
            \\adds    r3, r3, #6
            \\bgt     mmMix_Remainder
            \\b       mpm_mix_complete
    );
    unreachable;
}

/// mmMixer_PostProcess - Post-processing and function epilogue
/// Converts 11-bit mixed samples to 8-bit, clamps to [-128, 127], writes to output buffers
/// Called at end of mmMixerMix, handles register restore and return
///
/// Entry state:
///   r11 = rvolA (volume accumulator from mixing loop)
///   Stack: prcount (mix count), then saved r4-r11, lr
///
/// Register mapping (matching original ASM):
///   r0 = prmixl (mix buffer pointer)
///   r2 = prwritel (left write position)
///   r3 = prwriter (right write position)
///   r4 = prcount (sample count)
///   r5 = prsamp2 (processed sample low)
///   r6 = prsamp1 (loaded sample pair)
///   r7 = prsamp3 (processed sample high)
///   r11 = prvolL (left volume accumulator)
///   r12 = prvolR (right volume accumulator)
export fn mmMixer_PostProcess() linksection(".iwram") callconv(.naked) noreturn {
    asm volatile (thumb_to_arm_preamble ++
            // Load mm_mixbuffer -> r0
            \\ldr     r0, =mm_mixbuffer
            \\ldr     r0, [r0]
            // Load mp_writepos -> r2
            \\ldr     r2, =mp_writepos
            \\ldr     r2, [r2]
            // Load mm_mixlen, calculate right write position: r3 = r2 + (mm_mixlen << 1)
            \\ldr     r3, =mm_mixlen
            \\ldr     r3, [r3]
            \\add     r3, r2, r3, lsl #1
            // Pop prcount from stack -> r4
            \\ldmfd   sp!, {r4}
            // Calculate volume accumulators from r11 (rvolA)
            // prvolR (r12) = (rvolA >> 17) << 3
            \\mov     r12, r11, lsr #17
            \\mov     r12, r12, lsl #3
            // prvolL (r11) = ((rvolA << 16) >> 17) << 3
            \\mov     r11, r11, lsl #16
            \\mov     r11, r11, lsr #17
            \\mov     r11, r11, lsl #3
            // subs prcount, prcount, #1; ble .end
            \\subs    r4, r4, #1
            \\ble     .mpm_copy2_end_zig
        \\.mpm_copy2_zig:
            // *** LEFT OUTPUT ***
            // ldr prsamp1, [prmixl], #4 (get 2 mixed samples)
            \\ldr     r6, [r0], #4
            // sub prsamp2, prsamp1, prvolL (convert to signed)
            \\sub     r5, r6, r11
            // mov prsamp2, prsamp2, lsl #16 (mask low hword with sign extension)
            \\mov     r5, r5, lsl #16
            // movs prsamp2, prsamp2, asr #19 (convert 11-bit to 8-bit: asr #16+3)
            \\movs    r5, r5, asr #19
            // clamp to [-128, 127]
            \\cmp     r5, #-128
            \\movlt   r5, #-128
            \\cmp     r5, #127
            \\movgt   r5, #127
            // rsbs prsamp3, prvolL, prsamp1, lsr #16 (next sample, convert to signed)
            \\rsbs    r7, r11, r6, lsr #16
            // movs prsamp3, prsamp3, asr #3 (convert 11-bit to 8-bit)
            \\movs    r7, r7, asr #3
            // clamp
            \\cmp     r7, #-128
            \\movlt   r7, #-128
            \\cmp     r7, #127
            \\movgt   r7, #127
            // and prsamp2, prsamp2, #255; orr prsamp2, prsamp2, prsamp3, lsl #8
            \\and     r5, r5, #255
            \\orr     r5, r5, r7, lsl #8
            // strh prsamp2, [prwritel], #2
            \\strh    r5, [r2], #2
            // *** RIGHT OUTPUT ***
            // ldr prsamp1, [prmixl], #4
            \\ldr     r6, [r0], #4
            // sub prsamp2, prsamp1, prvolR
            \\sub     r5, r6, r12
            // mov prsamp2, prsamp2, lsl #16
            \\mov     r5, r5, lsl #16
            // movs prsamp2, prsamp2, asr #19
            \\movs    r5, r5, asr #19
            // clamp
            \\cmp     r5, #-128
            \\movlt   r5, #-128
            \\cmp     r5, #127
            \\movgt   r5, #127
            // rsbs prsamp3, prvolR, prsamp1, lsr #16
            \\rsbs    r7, r12, r6, lsr #16
            // movs prsamp3, prsamp3, asr #3
            \\movs    r7, r7, asr #3
            // clamp
            \\cmp     r7, #-128
            \\movlt   r7, #-128
            \\cmp     r7, #127
            \\movgt   r7, #127
            // and prsamp2, prsamp2, #255; orr prsamp2, prsamp2, prsamp3, lsl #8
            \\and     r5, r5, #255
            \\orr     r5, r5, r7, lsl #8
            // strh prsamp2, [prwriter], #2
            \\strh    r5, [r3], #2
            // subs prcount, prcount, #2; bgt .loop
            \\subs    r4, r4, #2
            \\bgt     .mpm_copy2_zig
        \\.mpm_copy2_end_zig:
            // Store new write position
            \\ldr     r0, =mp_writepos
            \\str     r2, [r0]
            // Restore registers and return
            \\ldmfd   sp!, {r4-r11, lr}
            \\bx      lr
    );
    unreachable;
}

/// mmMix_SingleChannel - Hard-panned single channel mixing (8 samples/loop)
/// Called via BL, returns via BX LR
///
/// Register inputs:
///   r3 = rmixcc (mix count)
///   r5 = rvolL  (volume - left OR right depending on caller)
///   r7 = rread  (read position, 20.12 fixed point)
///   r8 = rmixb  (mix buffer pointer)
///   r9 = rfreq  (frequency increment)
///   r10 = rsrc  (sample source pointer)
///   lr = return address
///
/// Returns: r3 = remaining count (may be negative), flags set
export fn mmMix_SingleChannel() linksection(".iwram") callconv(.naked) void {
    // MIX_DA expanded: read 2 samples, combine, multiply by volume, add to target
    // READ_D: ldrb s1; add rread,rfreq; ldrb s2; add rread,rfreq; orr s1,s1,s2,lsl#16
    // MIX_D:  mul tmp,samples,vol; bic tmp,tmp,#0x1F0000
    // MIX_DA: add target,target,tmp,lsr#5
    asm volatile (thumb_to_arm_preamble ++
        \\subs    r3, r3, #8
        \\bmi     .mpmah_8e_zig
        \\.mpmah_8_zig:
        // Load 3 words (use r1 and r11, skip r2)
        \\ldmia   r8, {r1, r2, r11}
        // MIX_DA rvolL(r5), rsamp1(r1), rsampa(r0), rsampb(r4)
        \\ldrb    r0, [r10, r7, lsr #12]
        \\add     r7, r7, r9
        \\ldrb    r4, [r10, r7, lsr #12]
        \\add     r7, r7, r9
        \\orr     r0, r0, r4, lsl #16
        \\mul     r4, r0, r5
        \\bic     r4, r4, #0x1F0000
        \\add     r1, r1, r4, lsr #5
        \\str     r1, [r8], #8
        // MIX_DA rvolL(r5), rsamp3(r11), rsampa(r0), rsampb(r4)
        \\ldrb    r0, [r10, r7, lsr #12]
        \\add     r7, r7, r9
        \\ldrb    r4, [r10, r7, lsr #12]
        \\add     r7, r7, r9
        \\orr     r0, r0, r4, lsl #16
        \\mul     r4, r0, r5
        \\bic     r4, r4, #0x1F0000
        \\add     r11, r11, r4, lsr #5
        \\str     r11, [r8], #8
        // Second batch of 4 samples
        \\ldmia   r8, {r1, r2, r11}
        // MIX_DA
        \\ldrb    r0, [r10, r7, lsr #12]
        \\add     r7, r7, r9
        \\ldrb    r4, [r10, r7, lsr #12]
        \\add     r7, r7, r9
        \\orr     r0, r0, r4, lsl #16
        \\mul     r4, r0, r5
        \\bic     r4, r4, #0x1F0000
        \\add     r1, r1, r4, lsr #5
        \\str     r1, [r8], #8
        // MIX_DA
        \\ldrb    r0, [r10, r7, lsr #12]
        \\add     r7, r7, r9
        \\ldrb    r4, [r10, r7, lsr #12]
        \\add     r7, r7, r9
        \\orr     r0, r0, r4, lsl #16
        \\mul     r4, r0, r5
        \\bic     r4, r4, #0x1F0000
        \\add     r11, r11, r4, lsr #5
        \\str     r11, [r8], #8
        \\subs    r3, r3, #8
        \\bpl     .mpmah_8_zig
        \\.mpmah_8e_zig:
        \\adds    r3, r3, #8
        \\bx      lr
    );
}
