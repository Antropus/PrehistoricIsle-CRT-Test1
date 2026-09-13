CRT TEST 06 - CLEAN RESTORE + KORTEK TIMING

This package is specifically for your CURRENT fork, which contains prior test changes.
Replace ALL FIVE files below in GitHub:

  prehisle.sv
  sys/arcade_video.v
  sys/sys_top.v
  sys/mcp23009.sv
  rtl/video_timing.v

The first four files are byte-for-byte originals from the PrehistoricIsle-main.zip you uploaded.
Only rtl/video_timing.v differs from your original source, and only in HSYNC/VSYNC timing.

Initial core settings:
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
