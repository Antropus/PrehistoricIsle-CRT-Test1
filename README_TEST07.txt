CRT TEST 07 — 256x240-STYLE / ~60 Hz OUTPUT
================================================

WHY THIS TEST
The user's original Radeon + CRT Emudriver installation contains a per-game
MAME setting proving that Prehistoric Isle in 1930 worked on this exact
Kortek KT-2914F at:

    resolution0 256x240@60

This test targets that known-good display family instead of continuing to
guess sync widths.

WHAT CHANGES
- Horizontal total remains 384 clocks at 6 MHz (15.625 kHz).
- Vertical total becomes 262 lines.
- Resulting refresh is 59.637 Hz.
- External active video window is 240 lines (8..247).
- Game picture remains 224 lines (17..240), centered inside that 240-line
  active window with black border lines.
- External VSYNC is 3 lines, with a 3-line front porch and 16-line back porch.
- The game's original VBlank boundaries remain 241 -> 17, so the 224-line
  game window and VBlank-triggered logic are preserved as closely as possible.

IMPORTANT LIMITATION
A true 256x240@60 output with the core's fixed 6.000 MHz pixel clock and
384-pixel horizontal total would require a non-integer vertical total.
262 lines gives 59.637 Hz, which is the closest clean 15.625 kHz 240p-style
raster without changing the core pixel clock.

CLEAN RESTORE
This ZIP also contains clean original copies of:
    sys/arcade_video.v
    sys/sys_top.v
    sys/mcp23009.sv

So replacing all five included files removes prior TEST 01-06 experiments.
Only prehisle.sv and rtl/video_timing.v contain TEST 07 changes.

REPLACE THESE FILES
    prehisle.sv
    rtl/video_timing.v
    sys/arcade_video.v
    sys/sys_top.v
    sys/mcp23009.sv

FIRST CRT TEST
Core:
    Refresh Rate: NTSC
    H-sync Pos Adj: 0
    V-sync Pos Adj: 0
    H-sync Width Adj: 0
    V-sync Width Adj: 0

MiSTer.ini:
    vga_scaler=0
    forced_scandoubler=0
    composite_sync=0
    direct_video=0

EXPECTED LCD INFORMATION
Approximately:
    256x240-style active raster
    15.63 kHz
    59.6 Hz

The game image itself remains 256x224 centered within the 240-line output.
