CRT TEST 07 — NATIVE ANALOG SYNC PATH BYPASS

Purpose:
TEST 06 ruled out the Kortek timing-envelope hypothesis. TEST 07 isolates the
remaining structural possibility: the old MiSTer sys_top OSD/vga_out sync path.

This package is based on the exact original PrehistoricIsle-main.zip uploaded
in this conversation.

Replace ONLY:
  sys/sys_top.v
  rtl/video_timing.v

rtl/video_timing.v is restored byte-for-byte to ORIGINAL upstream timing.
sys/sys_top.v differs from original only at the final physical VGA HS/VS pin
assignments. In native RGBHV mode it routes normalized core HS/VS directly to
the VGA pins with active-low polarity.

RGB, rendering, sprites, layers, audio, controls, game logic and HDMI are NOT
bypassed or modified.

Test conditions:
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
