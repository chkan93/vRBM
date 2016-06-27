/**************************************************************************
 *  16bit adder                                                            *
 *  Written by: S. H. Kang                                                *
 *  Last modified: Dec 16, 2010                                           *
 **************************************************************************/
`ifndef i_ap_adder
`define i_ap_adder
module iadder_B16_ZHU4 (A, B, SUM);

input          clk;
input          rst;
input   [15:0]  A, B;
output  [15:0]  SUM;


wire    [3:0]  ASUM = A[15:12] + B[15:12];
wire    [11:0]  ISUM;

wire    [11:0]  G, P;

assign  P[0] = A[0] && B[0];
assign  P[1] = A[1] && B[1];
assign  P[2] = A[2] && B[2];
assign  P[3] = A[3] && B[3];
assign  P[4] = A[4] && B[4];
assign  P[5] = A[5] && B[5];
assign  P[6] = A[6] && B[6];
assign  P[7] = A[7] && B[7];
assign  P[8] = A[8] && B[8];
assign  P[9] = A[9] && B[9];
assign  P[10] = A[10] && B[10];
assign  P[11] = A[11] && B[11];

assign  G[0] = A[0] || B[0];
assign  G[1] = A[1] || B[1];
assign  G[2] = A[2] || B[2];
assign  G[3] = A[3] || B[3];
assign  G[4] = A[4] || B[4];
assign  G[5] = A[5] || B[5];
assign  G[6] = A[6] || B[6];
assign  G[7] = A[7] || B[7];
assign  G[8] = A[8] || B[8];
assign  G[9] = A[9] || B[9];
assign  G[10] = A[10] || B[10];
assign  G[11] = A[11] || B[11];

assign ISUM[11] =G[11];
assign ISUM[10] =P[11] || P[10] ? 1'b1 : G[10];
assign ISUM[9] = P[11] || P[10] || P[9] ? 1'b1 : G[9];
assign ISUM[8] = P[11] || P[10] || P[9] || P[8] ? 1'b1 : G[8];
assign ISUM[7] = P[11] || P[10] || P[9] || P[8] || P[7] ? 1'b1 : G[7];
assign ISUM[6] = P[11] || P[10] || P[9] || P[8] || P[7] || P[6] ? 1'b1 : G[6];
assign ISUM[5] = P[11] || P[10] || P[9] || P[8] || P[7] || P[6] || P[5] ? 1'b1 : G[5];
assign ISUM[4] = P[11] || P[10] || P[9] || P[8] || P[7] || P[6] || P[5] || P[4] ? 1'b1 : G[4];
assign ISUM[3] = P[11] || P[10] || P[9] || P[8] || P[7] || P[6] || P[5] || P[4] || P[3] ? 1'b1 : G[3];
assign ISUM[2] = P[11] || P[10] || P[9] || P[8] || P[7] || P[6] || P[5] || P[4] || P[3] || P[2] ? 1'b1 : G[2];
assign ISUM[1] = P[11] || P[10] || P[9] || P[8] || P[7] || P[6] || P[5] || P[4] || P[3] || P[2] || P[1] ? 1'b1 : G[1];
assign ISUM[0] = P[11] || P[10] || P[9] || P[8] || P[7] || P[6] || P[5] || P[4] || P[3] || P[2] || P[1] || P[0] ? 1'b1 : G[0];

assign SUM    = {ASUM, ISUM};
endmodule
`endif