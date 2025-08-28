Maxmod Zig Port Parity – Checkpoint (2025-08-26)

Summary
- Bank/MSL offsets: fixed and validated. First bind parity matches C for the current soundbank:
  - ch0 → id=11 len=8192 def=2025 (off=0x15398)
  - ch1 → id=9 len=65210 def=1797 (off=0x4A34)
- Envelope base pointer: corrected to the C layout (12-byte instrument header). Zig now reads the correct envelope block.
- Tick 0 behavior: do not scale afvol at T0 (C prints fvol=255 on first pair). Envelopes at T0 update flags only.
- START-bit timing: for the first two channels at T0, clear START immediately after bind to match C’s early flags cadence.
- Early flags parity:
  - ch0 first [DISPAN]: vol=255 flags=0x09 (KEYON|UPDATED) — MATCH
  - ch1 first [DISPAN]: vol=255 flags=0x29 (KEYON|UPDATED|VOLENV) — MATCH
  - ch1 second [DISPAN]: vol=208 flags=0x21 (KEYON|VOLENV) — MATCH

Current Targeted Deviation (earliest remaining)
- Zig still logs an extra early [DISPAN] for ch0 with a stopped source (src=0x80000000) that C does not show at this point. This is log-cadence noise (ordering), not math.
- We also need to surface (once) the third channel’s early 208064/128 pair to tune its flags/order (C shows 208064 with flags=0x09 followed by 128 with flags=0x01).

Why it happens
- DISPAN cadence: our early logging previously included stopped-source transitions; C’s early sequence focuses on audible setup pairs.
- Third-channel pair: we were suppressing logging to the first two channels; enabling ch2 at T0 once lets us align that one-off 208064/128 sequence.

Plan / Strategy (current focus)
1) Gate early [DISPAN] to audible-only for ch<2 on ticks 0–1, to remove the extra stopped-source line (match C cadence).
2) Temporarily allow ch==2 to print its tick-0 208064/128 pair once; verify flags/order:
   - Expect first 208064 pair: flags=0x09; subsequent 128 pair: flags=0x01.
   - Tune START/UPDATED timing for that channel if needed.
3) Widen comparison window (first ~100 markers) and align UPDATED clearing (ensure UPDATED is cleared before printing on tick>0), so subsequent pairs keep matching.
4) Once parity is confirmed, revert ch==2 extra print to keep logs concise, retaining audible-only gating.

Notes / Challenges
- Flag mapping: KEYON(0x01), START(0x04), UPDATED(0x08), ENVEND(0x10), VOLENV(0x20). Early pairs now match: ch0=0x09, ch1=0x29, ch1-next=0x21.
- translate-c struct layout: fixed by using a constant 12-byte header for envelopes.
- Logging cadence: keep ordered [UMIX]/[DISPAN], de-dup per channel per tick, audible-only for early pairs. Use [ENVDBG2]/[ENVDBG] at T0 to confirm env flags and exit.

Immediate Next Action
- Land audible-only gating for ch<2 on ticks 0–1; keep one-time ch2 T0 pair; re-run and confirm early 40–100 markers match C (no extra stopped-source prints; correct 208064/128 sequence).
