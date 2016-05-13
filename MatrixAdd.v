`ifndef  TEST_BENCH
	`include "config.v"
`endif


`ifndef  MatrixAdd
`define MatrixAdd

module MatrixAdd
#(parameter bitlength = 8, parameter H = 3, parameter  W = 4)
	(
  input wire[`PORT_2D(H, W, bitlength)] AI,
  input wire[`PORT_2D(H, W, bitlength)] BI,
  output wire[`PORT_2D(H, W, bitlength)] CO
  );
/* Matrix Multiplication Unit, the dimensions of A,B,C should
be defined in the config.v*/
  wire[bitlength-1:0] A[1:H][1:W];
  wire[bitlength-1:0] B[1:H][1:W];
  wire[bitlength-1:0] C[1:H][1:W];


//Initialization
`DEFINE_PACK_VAR;
`UNPACK_2D_ARRAY(H, W, bitlength, AI, A)
`UNPACK_2D_ARRAY(H, W, bitlength, BI, B)
`PACK_2D_ARRAY(H, W, bitlength, C, CO)


// Computing
genvar i,j,k;
generate
   for(i=1; i<=H; i=i+1)
      for(j=1; j<=W; j=j+1)
          assign C[i][j] =  A[i][j] + B[i][j];
endgenerate

endmodule

`endif
