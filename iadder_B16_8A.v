/**************************************************************************
 *  16bit adder                                                            *
 *  Written by: S. H. Kang                                                *
 *  Last modified: Dec 16, 2010                                           *
 **************************************************************************/
`ifndef i_ap_adder
`define i_ap_adder
module i_ap_adder (A, B, SUM);

input   [15:0]  A, B;
output  [15:0]  SUM;

wire [8:0] SL = A[7:0] + B[7:0];
wire [8:0] SH = A[15:8] + B[15:8] + A[0];



assign SUM  = {SH[7:0],SL[7:0]};

endmodule

`endif
