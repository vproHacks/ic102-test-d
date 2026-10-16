/*
 * Copyright (c) 2026 The PWM dimmer team
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

// Hex digit to seven segments, active high: segments[6:0] = {g, f, e, d, c, b, a}.
// The table itself is in seg7_table.v.
module seg7 (
    input  wire [3:0] digit,
    output wire [6:0] segments
);

  seg7_table u_table (.digit(digit), .segments(segments));

endmodule
