<!---

This file is used to generate your project datasheet. Please fill in the information below and delete any unused
sections.

You can also include images in this folder and reference them in the markdown. Each image must be less than
512 kb in size, and the combined size of all images must be less than 1 MB.
-->

## How it works

The design is an LED dimmer. A prescaler divides the clock by four, and an 8-bit PWM
turns the LED on `uo_out[7]` on for `ui_in` of every 256 steps, so `ui_in` sets the
brightness from 0 (off) to 255.

The top hex digit of the brightness is shown on a seven-segment display on
`uo_out[6:0]` (segments a to g).

With `uio_in[0]` high the LED fades up and down by itself, one count per step, and
`ui_in` is ignored.

| Pin | Use |
|---|---|
| `ui_in[7:0]` | Brightness |
| `uo_out[7]` | LED |
| `uo_out[6:0]` | Seven-segment display |
| `uio_in[0]` | Fade mode |
| `uio_in[2:1]` | Preset brightness |

## How to test

Connect an LED to `uo_out[7]` and set `ui_in` to the brightness you want; the
display shows its top hex digit. Set `uio_in[0]` to watch the LED fade.

## External hardware

List external hardware used in your project (e.g. PMOD, LED display, etc), if any
