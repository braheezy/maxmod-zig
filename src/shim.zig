pub const MIXCH_GBA_SRC_STOPPED = 1 << ((@sizeOf(usize) * 8) - 1);

// Very simple bump allocator for tiny needs (calloc/free minimal)
var heap: [4096]u8 = undefined;
var heap_off: usize = 0;

pub fn calloc(nmemb: usize, size: usize) ?*anyopaque {
    const bytes = nmemb * size;
    if (heap_off + bytes > heap.len) return null;
    const ptr = &heap[heap_off];
    heap_off += bytes;
    return ptr;
}
