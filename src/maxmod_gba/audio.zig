const regs = @import("registers_gba.zig");

const FIFO_A_U32_PTR: *volatile u32 = @ptrFromInt(regs.FIFO_A);

pub const mix_rate_hz: u32 = 16000; // fixed for minimal path

pub fn init() void {
    // Enable master sound only; do not enable DS A yet
    regs.REG_SOUNDCNT_X.* = regs.SOUNDCNT_X_ENABLE;
    regs.REG_SNDBIAS.* = 0x0200; // mid bias

    // Hard-disable ALL DMA channels and clear their regs to avoid unintended FIFO-triggered DMA
    regs.REG_DMA0CNT.* = 0;
    regs.REG_DMA0SAD.* = 0;
    regs.REG_DMA0DAD.* = 0;
    regs.REG_DMA1CNT.* = 0;
    regs.REG_DMA1SAD.* = 0;
    regs.REG_DMA1DAD.* = 0;
    regs.REG_DMA2CNT.* = 0;
    regs.REG_DMA2SAD.* = 0;
    regs.REG_DMA2DAD.* = 0;
    regs.REG_DMA3CNT.* = 0;
    regs.REG_DMA3SAD.* = 0;
    regs.REG_DMA3DAD.* = 0;

    // Ensure Timer1 is stopped and its IRQ is cleared until playback starts
    regs.REG_TM1CNT_H.* &= ~regs.TM_ENABLE;
    // Mask Timer1 IRQ until we intentionally enable it
    regs.REG_IE.* &= ~regs.IE_TM1;

    // Do not enable Direct Sound A or DMA here; that occurs when playback starts
}

pub fn stopDma() void {
    regs.REG_DMA1CNT_H.* &= ~regs.DMA_ENABLE;
}

pub fn silenceAllDma() void {
    // Fully clear and disable all DMA channels (0-3)
    regs.REG_DMA0CNT.* = 0;
    regs.REG_DMA0SAD.* = 0;
    regs.REG_DMA0DAD.* = 0;
    regs.REG_DMA1CNT.* = 0;
    regs.REG_DMA1SAD.* = 0;
    regs.REG_DMA1DAD.* = 0;
    regs.REG_DMA2CNT.* = 0;
    regs.REG_DMA2SAD.* = 0;
    regs.REG_DMA2DAD.* = 0;
    regs.REG_DMA3CNT.* = 0;
    regs.REG_DMA3SAD.* = 0;
    regs.REG_DMA3DAD.* = 0;
}

pub fn setTimer0(sample_rate_hz: u32) void {
    // Set Timer0 reload for desired sample rate based on 16.78 MHz base clock
    // Use 1:1 prescaler and exact divider. If the rate does not divide evenly,
    // round to nearest to minimize drift.
    const base: u32 = 16_777_216;
    var reload_calc: i32 = @intCast(0x10000 - @as(i32, @intCast((base + sample_rate_hz / 2) / sample_rate_hz)));
    if (reload_calc < 0) reload_calc = 0;
    const reload: u16 = @intCast(@as(u32, @intCast(reload_calc)) & 0xFFFF);
    regs.REG_TM0CNT_L.* = reload;
    regs.REG_TM0CNT_H.* = regs.TM_ENABLE; // prescaler 1x
}

pub fn pulseFifoResetA() void {
    // Reapply DS A/B config with reset bit to generate a reset pulse (use same value as C version)
    regs.REG_SOUNDCNT_H.* = 0x9A0C | 0x0800; // 0x9A0C + FIFO reset bit
    regs.REG_SOUNDCNT_H.* = 0x9A0C; // restore normal DS A/B config
}

// Timer1 is not used in the current DMA-fed path
