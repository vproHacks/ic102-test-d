/*
 * Copyright (c) 2026 UofT ASIC Team
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

// An 8-bit counter for IC102-D, Lab 03.
//
//   ui_in[0]  EN    count by one on each rising clock edge while high
//   ui_in[1]  LOAD  load the value on uio_in at the next rising edge (LOAD wins over EN)
//   ui_in[2]  DOWN  count down instead of up
//   uo_out    the count
//   uio_in    the value LOAD loads; all eight uio pins are inputs
//   rst_n     low resets the count to 0 at the next rising edge
//
// Rename the module to tt_um_<your GitHub username>_counter (Part 1).
module tt_um_vprohacks_counter (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

  wire en   = ui_in[0];
  wire load = ui_in[1];
  wire down = ui_in[2];

  reg [7:0] count;

  always @(posedge clk) begin
    if (!rst_n)
      count <= 8'd0;
    else if (load)
      count <= uio_in;
    else if (en)
      count <= down ? count - 8'd1 : count + 8'd1;
  end

  assign uo_out  = count;
  assign uio_out = 8'd0;
  assign uio_oe  = 8'd0;

  // List all unused inputs to prevent warnings
  wire _unused = &{ena, ui_in[7:3], 1'b0};

endmodule
