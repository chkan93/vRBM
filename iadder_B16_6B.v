/**************************************************************************
 *  16bit adder                                                            *
 *  Written by: S. H. Kang                                                *
 *  Last modified: Dec 16, 2010                                           *
 **************************************************************************/
`ifndef i_ap_adder
`define i_ap_adder
module iadder_B16_6B ( A, B, SUM);

input   [15:0]  A, B;
output  [15:0]  SUM;


wire [6:0] S0 = A[5:0] + B[5:0];
wire [6:0] S3 = A[8:3] + B[8:3] + A[0];
wire [6:0] S6 = A[11:6] + B[11:6] + A[3];
wire [6:0] S9 = A[14:9] + B[14:9] + A[6];
wire [4:0] S12 = A[15:12] + B[15:12] + A[9];

assign  SUM = {S12[3],S9[5:3],S6[5:3],S3[5:3],S0[5:0]}; //   3,3,3,6

endmodule

`endif