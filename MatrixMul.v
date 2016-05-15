`ifndef  TEST_BENCH
	`include "config.v"
`endif

`ifndef  MatrixMul
`define MatrixMul


module MatrixMul
#(parameter bitlength = 8, parameter M1_D1 = 3, parameter  M1_D2 = 4, parameter  M2_D2 = 2)
	(
  input wire[`PORT_2D(M1_D1, M1_D2, bitlength)] AI,
  input wire[`PORT_2D(M1_D2, M2_D2, bitlength)] BI,
	//input wire     [7:0] array [0:3],
  output wire[`PORT_2D(M1_D1, M2_D2, bitlength)] CO
  );
/* Matrix Multiplication Unit, the dimensions of A,B,C should
be defined in the config.v*/
  wire[bitlength-1:0] A`DIM_2D(M1_D1, M1_D2);
  wire[bitlength-1:0] B`DIM_2D(M1_D2, M2_D2);
  wire[bitlength-1:0] C`DIM_3D(M1_D2, M1_D1, M2_D2);


//Initialization
`DEFINE_PACK_VAR;
`UNPACK_2D_ARRAY(M1_D1, M1_D2, bitlength, AI, A)
`UNPACK_2D_ARRAY(M1_D2, M2_D2, bitlength, BI, B)
`PACK_2D_ARRAY(M1_D1, M2_D2, bitlength, C[M1_D2-1], CO)


// Computing
genvar i,j,k;
generate
   for(i=0; i<M1_D1; i=i+1)
      for(j=0; j<M2_D2; j=j+1)
				begin
					for(k=0; k<M1_D2; k=k+1)
						begin
						if (k == 0)
							assign C[k][i][j] = A[i][k]*B[k][j];
						else
							assign C[k][i][j] = C[k-1][i][j] + A[i][k]*B[k][j];
						end
				end
endgenerate

endmodule
`endif
