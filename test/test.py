# SPDX-FileCopyrightText: 2026 UofT ASIC Team
# SPDX-License-Identifier: Apache-2.0
#
# The cocotb test for IC102-D's Lab 03 counter. Copy it over your repository's test/test.py.
#
# It drives and reads only the pins (ui_in, uio_in, uo_out, clk, rst_n), never a signal inside
# the design, because the gl_test job runs this same file on the gate-level netlist, where the
# design's internal names are gone. For the same reason it changes inputs and reads outputs on
# the falling edge of the clock, half a period away from the rising edge where the counter
# changes.

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles, FallingEdge

# The bits of ui_in, as in the comment at the top of counter.v.
EN = 0b001
LOAD = 0b010
DOWN = 0b100


async def start(dut):
    """Start a 10 MHz clock, hold reset for five cycles, and return on a falling edge."""
    cocotb.start_soon(Clock(dut.clk, 100, unit="ns").start())
    dut.ena.value = 1
    dut.ui_in.value = 0
    dut.uio_in.value = 0
    dut.rst_n.value = 0
    await ClockCycles(dut.clk, 5)
    dut.rst_n.value = 1
    await FallingEdge(dut.clk)


async def cycles(dut, n):
    """Let n rising edges go by, and return on the falling edge after the last one."""
    for _ in range(n):
        await FallingEdge(dut.clk)


@cocotb.test()
async def test_reset(dut):
    await start(dut)
    assert dut.uo_out.value == 0, f"after reset uo_out is {dut.uo_out.value}, expected 0"


@cocotb.test()
async def test_count_up(dut):
    await start(dut)
    dut.ui_in.value = EN
    await cycles(dut, 10)
    assert dut.uo_out.value == 10, f"after 10 cycles with EN high uo_out is {dut.uo_out.value}, expected 10"


# Part 2: add a test of LOAD here.
@cocotb.test()
async def test_load(dut):
    await start(dut)
    dut.uio_in.value = 0x5A
    dut.ui_in.value = LOAD
    await cycles(dut, 1)
    assert dut.uo_out.value == 0x5A, f"after LOAD with uio_in = 0x5A, uo_out is {dut.uo_out.value}, expected 0x5A"
