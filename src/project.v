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

  wire       tick;
  wire       led;
  wire [7:0] duty = ui_in;

  prescaler u_prescaler (.clk(clk), .rst_n(rst_n), .tick(tick));
  pwm       u_pwm       (.clk(clk), .rst_n(rst_n), .step(tick), .duty(duty), .out(led));

  assign uo_out  = {led, 7'b0};
  assign uio_out = 8'd0;
  assign uio_oe  = 8'd0;

  // List all unused inputs to prevent warnings
  wire _unused = &{ena, uio_in, 1'b0};

endmodule
