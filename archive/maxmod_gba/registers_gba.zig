pub const REG_BASE: usize = 0x04000000;

fn regPtr(comptime T: type, offset: usize) *volatile T {
    return @ptrFromInt(REG_BASE + offset);
}

pub const REG_SOUNDCNT_X = regPtr(u16, 0x0084);
pub const REG_SOUNDCNT_H = regPtr(u16, 0x0082);
pub const REG_SOUNDCNT_L = regPtr(u16, 0x0080);
pub const REG_SNDBIAS = regPtr(u16, 0x0088);
// DMA0
pub const REG_DMA0SAD = regPtr(u32, 0x00B0);
pub const REG_DMA0DAD = regPtr(u32, 0x00B4);
pub const REG_DMA0CNT_L = regPtr(u16, 0x00B8);
pub const REG_DMA0CNT_H = regPtr(u16, 0x00BA);
pub const REG_DMA0CNT = regPtr(u32, 0x00B8);
// DMA1
pub const REG_DMA1SAD = regPtr(u32, 0x00BC);
pub const REG_DMA1DAD = regPtr(u32, 0x00C0);
pub const REG_DMA1CNT_L = regPtr(u16, 0x00C4);
pub const REG_DMA1CNT_H = regPtr(u16, 0x00C6);
// 32-bit view of DMA1 CNT (length + control). Useful to fully disable.
pub const REG_DMA1CNT = regPtr(u32, 0x00C4);
// DMA2
pub const REG_DMA2SAD = regPtr(u32, 0x00C8);
pub const REG_DMA2DAD = regPtr(u32, 0x00CC);
pub const REG_DMA2CNT_L = regPtr(u16, 0x00D0);
pub const REG_DMA2CNT_H = regPtr(u16, 0x00D2);
pub const REG_DMA2CNT = regPtr(u32, 0x00D0);
// DMA3
pub const REG_DMA3SAD = regPtr(u32, 0x00D4);
pub const REG_DMA3DAD = regPtr(u32, 0x00D8);
pub const REG_DMA3CNT_L = regPtr(u16, 0x00DC);
pub const REG_DMA3CNT_H = regPtr(u16, 0x00DE);
pub const REG_DMA3CNT = regPtr(u32, 0x00DC);
pub const REG_TM0CNT_L = regPtr(u16, 0x0100);
pub const REG_TM0CNT_H = regPtr(u16, 0x0102);
pub const REG_TM1CNT_L = regPtr(u16, 0x0104);
pub const REG_TM1CNT_H = regPtr(u16, 0x0106);
pub const REG_IE = regPtr(u16, 0x0200);
pub const REG_IF = regPtr(u16, 0x0202);
pub const REG_IME = regPtr(u16, 0x0208);

pub const FIFO_A: usize = 0x040000A0;

pub const DISPCNT = regPtr(u16, 0x0000);

// Bits
pub const SOUNDCNT_X_ENABLE: u16 = 0x0080;
pub const SOUNDCNT_H_DMG100: u16 = 0x0077; // DMG volumes to 100%
pub const SOUNDCNT_H_FIFO_RESET_A: u16 = 0x0800; // pulse to reset FIFO A
// Direct Sound A: L+R enabled, 100% ratio, Timer0 (no reset bit)
pub const SOUNDCNT_H_DS_A_LR_TIMER0_100: u16 = 0x0B04;
// Note: For CPU-fed FIFO via Timer1, DS A still uses Timer0 internally, but
// we pace writes with Timer1 IRQ.

pub const DMA_ENABLE: u16 = 1 << 15;
pub const DMA_IRQ: u16 = 1 << 14;
pub const DMA_START_FIFO: u16 = 3 << 12;
pub const DMA_REPEAT: u16 = 1 << 9;
pub const DMA_32: u16 = 1 << 10;
pub const DMA_SRC_INC: u16 = 0 << 7;
pub const DMA_SRC_FIXED: u16 = 2 << 7;
pub const DMA_DEST_FIXED: u16 = 2 << 5;

pub const TM_ENABLE: u16 = 1 << 7;
pub const TM_IRQ: u16 = 1 << 6;

// Interrupt bits
pub const IE_VBLANK: u16 = 1 << 0;
pub const IE_HBLANK: u16 = 1 << 1;
pub const IE_VCOUNT: u16 = 1 << 2;
pub const IE_TM0: u16 = 1 << 3;
pub const IE_TM1: u16 = 1 << 4;
pub const IE_TM2: u16 = 1 << 5;
pub const IE_TM3: u16 = 1 << 6;
