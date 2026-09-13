CRT TEST 09 - PIXEL ENABLE / CLOCK-DOMAIN CLEANUP

BASELINE:
All included files come from the user's original clean PrehistoricIsle-main.zip.
Only prehisle.sv is functionally modified.

CHANGE:
The 6 MHz pixel pulse is no longer used as a fabric clock for video_timing or blanking delay.
Instead:
  - video_timing runs on clk_sys (72 MHz)
  - clk_6M is used only as the clk_pix clock-enable
  - hbl_delay/vbl_delay are updated on clk_sys only when clk_6M is asserted

WHY:
Known-working MiSTer arcade cores keep video logic in a stable master clock domain and use a pixel-enable pulse.
Prehistoric Isle was using the one-cycle clk_6M enable pulse as both a clock and an enable in different parts of the video path.
This test removes that derived/gated-clock boundary without changing HTOTAL, VTOTAL, refresh, sync widths, rendering, audio, CPU timing, or arcade_video.

EXPECTED LCD INFO (NTSC):
256x224 / 15.63 kHz / ~59.2 Hz

TEST SETTINGS:
Video Mode: NTSC
Refresh Rate: NTSC
Scandoubler Fx: None
Force Scandoubler: Off
H/V position and width adjustments: 0
vga_scaler=0
forced_scandoubler=0
composite_sync=0
