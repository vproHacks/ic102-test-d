<!---

This file is used to generate your project datasheet. Please fill in the information below and delete any unused
sections.

You can also include images in this folder and reference them in the markdown. Each image must be less than
512 kb in size, and the combined size of all images must be less than 1 MB.
-->

## How it works

The design adds two 8-bit numbers. The first, a, comes in on ui_in and the second, b, on uio_in, which
the design leaves as inputs. The sum goes out on uo_out, without the carry, so it wraps around at 256.

## How to test

Set a on ui_in and b on uio_in, and read the sum on uo_out. For example, a = 20 and b = 30 give 50.
The clock and reset aren't used.

## External hardware

List external hardware used in your project (e.g. PMOD, LED display, etc), if any
