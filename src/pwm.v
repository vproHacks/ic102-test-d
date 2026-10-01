/*
 * Copyright (c) 2026 The PWM dimmer team
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

// An 8-bit PWM. Each step advances the phase by one, so a period is 256 steps, and out is high
// for the first duty steps of each period: duty 0 is always off, and 255 is on for 255 of 256.
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

  // High while the phase is below the duty.
  assign out = (phase < duty);

endmodule
