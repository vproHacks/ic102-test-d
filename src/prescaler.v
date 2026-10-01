/*
 * Copyright (c) 2026 The PWM dimmer team
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

// Divides the clock by 4: tick is high for one clock cycle in every four.
module prescaler (
    input  wire clk,
    input  wire rst_n,
    output wire tick
);

  reg [1:0] n;

  always @(posedge clk) begin
    if (!rst_n)
      n <= 2'd0;
    else
      n <= n + 2'd1;
  end

  assign tick = (n == 2'd3);

endmodule
