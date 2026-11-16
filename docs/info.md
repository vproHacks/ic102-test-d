<!---

This file is used to generate your project datasheet. Please fill in the information below and delete any unused
sections.

You can also include images in this folder and reference them in the markdown. Each image must be less than
512 kb in size, and the combined size of all images must be less than 1 MB.
-->

## How it works

An 8-bit counter. While EN (ui_in[0]) is high it counts by one on each rising clock edge, up, or
down when DOWN (ui_in[2]) is high. LOAD (ui_in[1]) loads the value on uio_in at the next rising
edge, and wins over EN. rst_n low resets the count to 0. The count is on uo_out.

## How to test

Reset, then hold EN high and watch uo_out count up once per clock. Put a value on uio_in and raise
LOAD for one clock to load it. Raise DOWN to count down.

## External hardware

List external hardware used in your project (e.g. PMOD, LED display, etc), if any
