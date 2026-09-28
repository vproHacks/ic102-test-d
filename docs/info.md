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

## How to test

Set `ui_in` and watch the LED.

## External hardware

List external hardware used in your project (e.g. PMOD, LED display, etc), if any
