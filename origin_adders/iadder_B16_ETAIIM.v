/**************************************************************************
 *  16bit adder                                                            *
 *  Written by: S. H. Kang                                                *
 *  Last modified: Dec 16, 2010                                           *
 **************************************************************************/
`ifndef i_ap_adder
`define i_ap_adder

module i_ap_adder (A, B, SUM);

// input          clk;
// input          rst;
input   [15:0]  A, B;
output  [15:0]  SUM;
// reg 	[16:0]  SUM;

wire [8:0]  SL = A[7:0] + B[7:0];
wire [12:0] SH = A[15:4] + B[15:4] + A[0]; // JC 160410: noise



assign  SUM = {SH[11:4],SL[7:0]};


endmodule

`endif
