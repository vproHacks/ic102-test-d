/*
 * Copyright (c) 2026 The PWM dimmer team
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

// Fade mode: on each step, level moves one count towards 255, then back down to 0, and so on.
module fade (
    input  wire       clk,
    input  wire       rst_n,
    input  wire       step,
    output reg  [7:0] level
);

  reg rising;

  always @(posedge clk) begin
    if (!rst_n) begin
      level  <= 8'd0;
      rising <= 1'b1;
    end else if (step) begin
      if (rising) begin
        if (level == 8'hFF) rising <= 1'b0;
        else level <= level + 8'd1;
      end else begin
        if (level == 8'h00) rising <= 1'b1;
        else level <= level - 8'd1;
      end

endmodule
