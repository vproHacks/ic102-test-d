/*
 * Copyright (c) 2026 The PWM dimmer team
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

// An 8-bit PWM. Each step moves the phase on by one, so a period is 256 steps long, and out is
// on for duty steps of each period.
module pwm (
    input  wire       clk,
    input  wire       rst_n,
    input  wire       step,
    input  wire [7:0] duty,
    output wire       out
);

  reg [7:0] phase;

  always @(posedge clk) begin
    if (!rst_n)
      phase <= 8'd0;
    else if (step)
      phase <= phase + 8'd1;
  end

  // On for duty steps of each period.
  assign out = (phase <= duty);

endmodule
