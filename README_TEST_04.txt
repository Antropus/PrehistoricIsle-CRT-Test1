CRT TEST 04
===========
Replace exactly these three files in the fork:
  prehisle.sv
  sys/arcade_video.v
  rtl/video_timing.v

prehisle.sv and sys/arcade_video.v are restored from the user's original uploaded upstream source ZIP.
The ONLY experimental change is rtl/video_timing.v:
  - horizontal timing remains 384 clocks / 6.000 MHz
  - vertical total is forced to 260 lines
  - VSYNC is 6 lines
  - resulting refresh is ~60.096 Hz

Do not change INI or monitor settings for this test.
