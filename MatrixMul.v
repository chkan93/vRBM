`ifndef  TEST_BENCH
	`include "config.v"
`endif


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
  wire[bitlength-1:0] A[1:M1_D1][1:M1_D2];
  wire[bitlength-1:0] B[1:M1_D2][1:M2_D2];
  wire[bitlength-1:0] C[1:M1_D2][1:M1_D1][1:M2_D2];


//Initialization
`DEFINE_PACK_VAR;
`UNPACK_2D_ARRAY(M1_D1, M1_D2, bitlength, AI, A)
`UNPACK_2D_ARRAY(M1_D2, M2_D2, bitlength, BI, B)
`PACK_2D_ARRAY(M1_D1, M2_D2, bitlength, C[M1_D2], CO)


// Computing
genvar i,j,k;
generate
   for(i=1; i<=M1_D1; i=i+1)
      for(j=1; j<=M2_D2; j=j+1)
				begin

					for(k=1; k<=M1_D2; k=k+1)
						begin
						if (k == 1)
							assign C[k][i][j] = A[i][k]*B[k][j];
						else
							assign C[k][i][j] = C[k-1][i][j] + A[i][k]*B[k][j];
						end
				end
endgenerate

endmodule





// `ifndef  TEST_BENCH
// 	`include "config.v"
// `endif


// module MatrixMul
// #(parameter bitlength = 8, parameter M1_D1 = 3, parameter  M1_D2 = 4, parameter  M2_D2 = 2)
// 	(
//   input wire[`PORT_2D(M1_D1, M1_D2, bitlength)] AI,
//   input wire[`PORT_2D(M1_D2, M2_D2, bitlength)] BI,
// 	//input wire     [7:0] array [0:3],
//   output wire[`PORT_2D(M1_D1, M2_D2, bitlength)] CO
//   );
// /* Matrix Multiplication Unit, the dimensions of A,B,C should
// be defined in the config.v*/
//   wire[bitlength-1:0] A[1:M1_D1][1:M1_D2];
//   wire[bitlength-1:0] B[1:M1_D2][1:M2_D2];
//   wire[bitlength-1:0] C[1:M1_D1][1:M2_D2];
//
//
// //Initialization
// `DEFINE_PACK_VAR;
// `UNPACK_2D_ARRAY(M1_D1, M1_D2, bitlength, AI, A)
// `UNPACK_2D_ARRAY(M1_D2, M2_D2, bitlength, BI, B)
// `PACK_2D_ARRAY(M1_D1, M2_D2, bitlength, C, CO)
//
//
// // Computing
// genvar i,j,k;
// generate
//    for(i=1; i<=M1_D1; i=i+1)
//       for(j=1; j<=M2_D2; j=j+1)
// 				begin
// 					assign C[i][j] = A[i][1]*B[1][j] +  A[i][2]*B[2][j] + A[i][3]*B[3][j];
// 				end
// endgenerate
//
// endmodule
