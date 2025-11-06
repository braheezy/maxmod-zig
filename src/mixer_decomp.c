#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>

#define FIX_FRAC_BITS 12
#define MIXCH_GBA_SRC_STOPPED 0x80000000u
#define MAX_WORD_COUNT 528u
#define MAX_FRAME_COUNT (MAX_WORD_COUNT * 2u)
#define MAX_MIX_CHANNELS 32
#define FETCH_SIZE 384
#define FETCH_PADDING 16

#define MM_COMPARE_ARM 0

#if defined(__arm__) || defined(__thumb__)
#define IWRAM_CODE __attribute__((section(".iwram")))
#else
#define IWRAM_CODE
#endif

typedef struct mm_mixer_channel
{
    uint32_t src;
    uint32_t read;
    uint8_t vol;
    uint8_t pan;
    uint8_t unused0;
    uint8_t unused1;
    uint32_t freq;
} mm_mixer_channel;

extern int32_t *mm_mixbuffer;
extern mm_mixer_channel *mm_mix_channels;
extern mm_mixer_channel *mm_mixch_end;
extern uint32_t mm_mixlen;
extern uint32_t mm_ratescale;
extern uint16_t *mp_writepos;

__attribute__((aligned(4))) uint8_t mm_fetch[FETCH_SIZE + FETCH_PADDING];
__attribute__((aligned(4))) uint8_t mpm_nullsample[4] = {128, 128, 128, 128};

static inline int clamp_pcm8(int value)
{
    if (value < -128)
    {
        return -128;
    }
    if (value > 127)
    {
        return 127;
    }
    return value;
}

static inline uint32_t mix_step(uint32_t frequency)
{
    return (mm_ratescale * frequency) >> 14;
}

static inline uint32_t neutral_contribution(uint32_t volume)
{
    return volume ? (((uint32_t)128 * volume) >> 5) : 0;
}

static inline uint8_t *resolve_sample_data(uint32_t src)
{
    return (uint8_t *)(uintptr_t)src;
}

static inline uint32_t sample_length_from_data(const uint8_t *data)
{
    return ((const uint32_t *)data)[-3];
}

static inline int32_t loop_length_from_data(const uint8_t *data)
{
    return ((const int32_t *)data)[-2];
}

static void copy_mix_words(int32_t *dst, const int32_t *src, size_t count)
{
    for (size_t i = 0; i < count; ++i)
    {
        dst[i] = src[i];
    }
}

static void copy_channels(mm_mixer_channel *dst, const mm_mixer_channel *src, size_t count)
{
    for (size_t i = 0; i < count; ++i)
    {
        dst[i] = src[i];
    }
}

static void zero_u32(uint32_t *dst, size_t count)
{
    for (size_t i = 0; i < count; ++i)
    {
        dst[i] = 0;
    }
}

static void zero_i32(int32_t *dst, size_t count)
{
    for (size_t i = 0; i < count; ++i)
    {
        dst[i] = 0;
    }
}

// Optimized dual-sample helpers (match assembly macros)
static inline uint32_t read_dual_samples(const uint8_t *data, uint32_t *read_pos, uint32_t freq)
{
    uint32_t s0 = data[*read_pos >> FIX_FRAC_BITS];
    *read_pos += freq;
    uint32_t s1 = data[*read_pos >> FIX_FRAC_BITS];
    *read_pos += freq;
    return s0 | (s1 << 16);
}

static inline void mix_dual_mono(int32_t *frames, uint32_t idx, uint32_t dual_samples, uint32_t volume)
{
    // Extract and mix both samples
    uint32_t s0 = dual_samples & 0xFF;
    uint32_t s1 = (dual_samples >> 16) & 0xFF;
    frames[idx] += (int32_t)((s0 * volume) >> 5);
    frames[idx + 1] += (int32_t)((s1 * volume) >> 5);
}

static IWRAM_CODE void mmMixerMix_impl(uint32_t sample_count)
{
    if (sample_count == 0)
    {
        return;
    }

    uint32_t frame_count = sample_count;
    if (frame_count > MAX_FRAME_COUNT)
    {
        frame_count = MAX_FRAME_COUNT;
    }

    const uint32_t padded_frames = (frame_count + 1u) & ~1u;
    const uint32_t words_per_channel = padded_frames >> 1;
    const uint32_t total_words = words_per_channel * 2u;

    uint32_t *mix_words = (uint32_t *)mm_mixbuffer;
    zero_u32(mix_words, total_words);

    static int32_t left_frames[MAX_FRAME_COUNT];
    static int32_t right_frames[MAX_FRAME_COUNT];

    zero_i32(left_frames, padded_frames);
    zero_i32(right_frames, padded_frames);

    uint32_t total_left_volume = 0;
    uint32_t total_right_volume = 0;

    for (mm_mixer_channel *channel = mm_mix_channels; channel < mm_mixch_end; ++channel)
    {
        uint32_t src = channel->src;
        if ((src & MIXCH_GBA_SRC_STOPPED) != 0)
        {
            continue;
        }

        uint32_t frequency = channel->freq;
        if (frequency == 0)
        {
            continue;
        }

        uint32_t step = mix_step(frequency);
        if (step == 0)
        {
            continue;
        }

        uint8_t *sample_data = resolve_sample_data(src);
        uint32_t sample_length = sample_length_from_data(sample_data);
        int32_t loop_length = loop_length_from_data(sample_data);
        uint32_t sample_length_fp = sample_length << FIX_FRAC_BITS;
        uint32_t loop_length_fp = 0;

        uint32_t pan = channel->pan;
        uint32_t volume = channel->vol;

        uint32_t left_volume = ((256u - pan) * volume) >> 8;
        uint32_t right_volume = (pan * volume) >> 8;

        total_left_volume += left_volume;
        total_right_volume += right_volume;

        uint32_t neutral_left = neutral_contribution(left_volume);
        uint32_t neutral_right = neutral_contribution(right_volume);

        uint32_t read_position = channel->read;

        if (sample_length_fp == 0)
        {
            channel->src = MIXCH_GBA_SRC_STOPPED;
            channel->read = 0;
            continue;
        }

        if (loop_length > 0 && (uint32_t)loop_length <= sample_length)
        {
            loop_length_fp = (uint32_t)loop_length << FIX_FRAC_BITS;
        }

        uint32_t frame_index = 0;

        // Determine mixing path based on volume configuration
        bool is_centered = (left_volume == right_volume);
        bool is_mono = (left_volume == 0 || right_volume == 0);

        // Main mixing loop with loop wrapping support
        while (frame_index < frame_count)
        {
            // Handle loop wrapping at the start of each iteration
            if (read_position >= sample_length_fp)
            {
                if (loop_length_fp == 0)
                {
                    channel->src = MIXCH_GBA_SRC_STOPPED;
                    read_position = 0;
                    break;
                }
                do
                {
                    read_position -= loop_length_fp;
                } while (read_position >= sample_length_fp);
            }

            // Calculate how many frames we can safely process before hitting sample end
            uint32_t remaining_samples_fp = sample_length_fp - read_position;
            uint32_t frames_until_end = (remaining_samples_fp + step - 1) / step;
            uint32_t frames_available = frame_count - frame_index;
            uint32_t frames_to_mix = (frames_until_end < frames_available) ? frames_until_end : frames_available;

            // Fast path: process pairs of samples when we have at least 8 frames available
            while (frames_to_mix >= 8)
            {
                // Process 8 samples (4 dual reads) without boundary checks
                for (uint32_t i = 0; i < 4; i++)
                {
                    uint32_t dual_samples = read_dual_samples(sample_data, &read_position, step);
                    uint32_t fidx = frame_index;

                    if (is_centered && left_volume > 0)
                    {
                        mix_dual_mono(left_frames, fidx, dual_samples, left_volume);
                        mix_dual_mono(right_frames, fidx, dual_samples, left_volume);
                    }
                    else if (left_volume > 0 && right_volume > 0)
                    {
                        mix_dual_mono(left_frames, fidx, dual_samples, left_volume);
                        mix_dual_mono(right_frames, fidx, dual_samples, right_volume);
                    }
                    else if (left_volume > 0)
                    {
                        mix_dual_mono(left_frames, fidx, dual_samples, left_volume);
                    }
                    else if (right_volume > 0)
                    {
                        mix_dual_mono(right_frames, fidx, dual_samples, right_volume);
                    }

                    frame_index += 2;
                }

                frames_to_mix -= 8;
                frames_available -= 8;
            }

            // Slow path: process remaining samples one at a time
            while (frames_to_mix > 0)
            {
                uint32_t sample_offset = read_position >> FIX_FRAC_BITS;
                uint8_t sample_value = sample_data[sample_offset];

                if (left_volume)
                {
                    left_frames[frame_index] += (int32_t)(((uint32_t)sample_value * left_volume) >> 5);
                }
                if (right_volume)
                {
                    right_frames[frame_index] += (int32_t)(((uint32_t)sample_value * right_volume) >> 5);
                }

                read_position += step;
                ++frame_index;
                --frames_to_mix;
            }
        }

        channel->read = read_position;
        if (loop_length_fp == 0 && frame_index < frame_count)
        {
            const uint32_t remaining = frame_count - frame_index;
            if (left_volume)
            {
                for (uint32_t i = 0; i < remaining; ++i)
                {
                    left_frames[frame_index + i] += (int32_t)neutral_left;
                }
            }
            if (right_volume)
            {
                for (uint32_t i = 0; i < remaining; ++i)
                {
                    right_frames[frame_index + i] += (int32_t)neutral_right;
                }
            }
        }
    }

    uint32_t frames_to_output = frame_count;
    if (frames_to_output > mm_mixlen)
    {
        frames_to_output = mm_mixlen;
    }

    uint32_t padded_output_frames = (frames_to_output + 1u) & ~1u;
    if (padded_output_frames > padded_frames)
    {
        padded_output_frames = padded_frames;
    }

    uint32_t words_to_output = padded_output_frames >> 1;

    int32_t prvol_left = (int32_t)((total_left_volume >> 1) << 3);
    int32_t prvol_right = (int32_t)((total_right_volume >> 1) << 3);

    uint16_t *left_cursor = mp_writepos;
    uint16_t *right_cursor = mp_writepos + mm_mixlen;

    for (uint32_t pair = 0; pair < words_to_output; ++pair)
    {
        uint32_t frame0 = pair << 1;
        uint32_t frame1 = frame0 + 1;
        if (frame0 >= padded_frames)
        {
            frame0 = padded_frames - 1;
        }
        if (frame1 >= padded_frames)
        {
            frame1 = (padded_frames > 0) ? padded_frames - 1 : frame0;
        }

        int32_t left0 = (int32_t)(left_frames[frame0] - (int32_t)prvol_left) >> 3;
        int32_t left1 = (int32_t)(left_frames[frame1] - (int32_t)prvol_left) >> 3;
        int32_t right0 = (int32_t)(right_frames[frame0] - (int32_t)prvol_right) >> 3;
        int32_t right1 = (int32_t)(right_frames[frame1] - (int32_t)prvol_right) >> 3;

        uint8_t left_byte0 = (uint8_t)clamp_pcm8(left0);
        uint8_t left_byte1 = (uint8_t)clamp_pcm8(left1);
        uint8_t right_byte0 = (uint8_t)clamp_pcm8(right0);
        uint8_t right_byte1 = (uint8_t)clamp_pcm8(right1);

        *left_cursor++ = (uint16_t)(left_byte0 | ((uint16_t)left_byte1 << 8));
        *right_cursor++ = (uint16_t)(right_byte0 | ((uint16_t)right_byte1 << 8));

        const uint32_t left_word_index = pair << 1;
        mix_words[left_word_index] =
            ((uint32_t)(left_frames[frame1] & 0xFFFF) << 16) |
            (uint32_t)(left_frames[frame0] & 0xFFFF);
        mix_words[left_word_index + 1] =
            ((uint32_t)(right_frames[frame1] & 0xFFFF) << 16) |
            (uint32_t)(right_frames[frame0] & 0xFFFF);
    }

    mp_writepos = left_cursor;
}

IWRAM_CODE void mmMixerMix(uint32_t sample_count)
{

    mmMixerMix_impl(sample_count);
}
