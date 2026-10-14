/*
 * Copyright (c) 2026 The PWM dimmer team
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

// Divides the clock: tick is high for one clock cycle in every DIV.
module prescaler #(
    parameter DIV = 4
) (
    input  wire clk,
    input  wire rst_n,
    output wire tick
);

  reg [7:0] n;

  always @(posedge clk) begin
    if (!rst_n || tick)
      n <= 8'd0;
    else
      n <= n + 8'd1;
  end

  assign tick = (n == DIV - 1);

endmodule
