# SPDX-FileCopyrightText: 2026 The PWM dimmer team
# SPDX-License-Identifier: Apache-2.0

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles, FallingEdge

DIV = 4               # the prescaler divides the clock by 4
PERIOD = 256 * DIV    # clock cycles in one PWM period

# segments[6:0] = {g, f, e, d, c, b, a} for the digits 0 to F
DIGITS = [0b0111111, 0b0000110, 0b1011011, 0b1001111, 0b1100110, 0b1101101, 0b1111101, 0b0000111,
          0b1111111, 0b1101111, 0b1110111, 0b1111100, 0b0111001, 0b1011110, 0b1111001, 0b1110001]


async def start(dut, duty=0, mode=0):
    """Start a 10 MHz clock and reset the design, with ui_in = duty and uio_in = mode."""
    cocotb.start_soon(Clock(dut.clk, 100, unit="ns").start())
    dut.ena.value = 1
    dut.ui_in.value = duty
    dut.uio_in.value = mode
    dut.rst_n.value = 0
    await ClockCycles(dut.clk, 5)
    dut.rst_n.value = 1
    await FallingEdge(dut.clk)


def led(dut):
    return (int(dut.uo_out.value) >> 7) & 1


async def on_cycles(dut, cycles):
    """Count the cycles the LED is on, sampling on each falling edge."""
    n = 0
    for _ in range(cycles):
        n += led(dut)
        await FallingEdge(dut.clk)
    return n


@cocotb.test()
async def test_duty_0_is_off(dut):
    await start(dut, duty=0)
    n = await on_cycles(dut, 2 * PERIOD)
    assert n == 0, f"with duty 0 the LED was on for {n} of {2 * PERIOD} cycles, expected 0"


@cocotb.test()
async def test_duty_64_is_a_quarter(dut):
    await start(dut, duty=64)
    n = await on_cycles(dut, PERIOD)
    assert n == 64 * DIV, f"with duty 64 the LED was on for {n} of {PERIOD} cycles, expected {64 * DIV}"


@cocotb.test()
async def test_duty_255(dut):
    await start(dut, duty=255)
    n = await on_cycles(dut, PERIOD)
    assert n == 255 * DIV, f"with duty 255 the LED was on for {n} of {PERIOD} cycles, expected {255 * DIV}"


@cocotb.test()
async def test_segments_show_the_top_digit(dut):
    await start(dut)
    for digit in range(16):
        dut.ui_in.value = digit << 4
        await FallingEdge(dut.clk)
        segments = int(dut.uo_out.value) & 0x7F
        assert segments == DIGITS[digit], f"digit {digit:X}: segments {segments:07b}, expected {DIGITS[digit]:07b}"


@cocotb.test()
async def test_fade_rises(dut):
    await start(dut, duty=0, mode=0b001)
    await ClockCycles(dut.clk, 100 * DIV, rising=False)
    segments = int(dut.uo_out.value) & 0x7F
    assert segments == DIGITS[6], f"after 100 steps of fade mode the display shows {segments:07b}, expected {DIGITS[6]:07b} (6)"


@cocotb.test()
async def test_presets(dut):
    await start(dut, duty=0)
    for preset, duty in [(1, 16), (2, 64), (3, 255)]:
        dut.uio_in.value = preset << 1
        await FallingEdge(dut.clk)
        segments = int(dut.uo_out.value) & 0x7F
        assert segments == DIGITS[duty >> 4], f"preset {preset}: segments {segments:07b}, expected {DIGITS[duty >> 4]:07b}"


@cocotb.test()
async def test_uio_pins_are_inputs(dut):
    await start(dut)
    assert dut.uio_oe.value == 0, f"uio_oe is {dut.uio_oe.value}, expected all inputs (0)"
