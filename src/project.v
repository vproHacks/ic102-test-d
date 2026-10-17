/*
 * Copyright (c) 2026 The PWM dimmer team
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_ic102_dimmer (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

  // ui_in is the brightness, 0 (off) to 255, and uo_out[7] drives the LED.
  // uo_out[6:0] show the brightness's top hex digit on a seven-segment display.
  // With uio_in[0] high, the LED fades up and down by itself and ui_in is ignored.
  // uio_in[2:1] pick a preset brightness: 1 is 16, 2 is 64, 3 is 255; 0 means none.

  wire       tick;
  wire       led;
  wire [6:0] segments;
  wire [7:0] level;
  reg  [7:0] duty;

  always @(*) begin
    case (uio_in[2:1])
      2'd1: duty = 8'd16;
      2'd2: duty = 8'd64;
      2'd3: duty = 8'd255;
      default: duty = uio_in[0] ? level : ui_in;
    endcase
  end

  prescaler #(.DIV(4)) u_prescaler (.clk(clk), .rst_n(rst_n), .tick(tick));
  pwm       u_pwm       (.clk(clk), .rst_n(rst_n), .step(tick), .duty(duty), .out(led));
  fade      u_fade      (.clk(clk), .rst_n(rst_n), .step(tick), .level(level));
  seg7      u_seg7      (.digit(duty[7:4]), .segments(segments));

  assign uo_out  = {led, segments};
  assign uio_out = 8'd0;
  assign uio_oe  = 8'd0;

  // List all unused inputs to prevent warnings
  wire _unused = &{ena, uio_in[7:3], 1'b0};

endmodule
