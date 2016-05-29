`define TEST_BENCH
`include "../config.v"
`include "../MatrixMul.v"


/*
The correct result is:
m =
     4     5
     7     8
    10    11
    13    14
n =
     5     6     7
     8     9    10
ans =
    60    69    78
    99   114   129
   138   159   180
   177   204   231
*/

module test_MatrixMul
  #(parameter M1_D1 = 15,parameter M1_D2 = 15, parameter  M2_D2 = 15, parameter  bitlength = 8);



integer A_V`DIM_2D(M1_D1, M1_D2);
integer B_V`DIM_2D(M1_D2, M2_D2);
integer C_V`DIM_2D(M1_D1, M2_D2);
integer ci,cj,ck;


wire[bitlength-1:0] A`DIM_2D(M1_D1, M1_D2);
wire[bitlength-1:0] B`DIM_2D(M1_D2, M2_D2);
wire[bitlength-1:0] C`DIM_2D(M1_D1, M2_D2);

wire[`PORT_2D(M1_D1,M1_D2,bitlength)] AI;
wire[`PORT_2D(M1_D2,M2_D2,bitlength)] BI;
wire[`PORT_2D(M1_D1,M2_D2,bitlength)] CO;


initial begin
/*
Calculating the ground truth
*/
for(ci=0; ci<M1_D1; ci=ci+1)
   for(cj=0; cj<M1_D2; cj=cj+1)
      A_V[ci][cj] = ci*2 + cj;

for(ci=0; ci<M1_D2; ci=ci+1)
    for(cj=0; cj<M2_D2; cj=cj+1)
      B_V[ci][cj] = ci*2 + cj + 1;

for(ci=0; ci<M1_D1; ci=ci+1)
    for(cj=0; cj<M2_D2; cj=cj+1)
      begin
        C_V[ci][cj] = 0;
        for(ck=0; ck<M1_D2; ck = ck+1)
          C_V[ci][cj] = C_V[ci][cj] + A_V[ci][ck]*B_V[ck][cj];
      end
end


genvar i,j;
generate
for(i=0; i<M1_D1; i=i+1)
   for(j=0; j<M1_D2; j=j+1)
      assign A[i][j] = i*2 + j;


for(i=0; i<M1_D2; i=i+1)
   for(j=0; j<M2_D2; j=j+1)
       assign B[i][j] = i*2 + j + 1;
endgenerate


`DEFINE_PACK_VAR;
`PACK_2D_ARRAY(M1_D1,M1_D2,bitlength, A, AI)
`PACK_2D_ARRAY(M1_D2,M2_D2,bitlength, B, BI)
`UNPACK_2D_ARRAY(M1_D1, M2_D2, bitlength, CO, C)

MatrixMul #(bitlength, M1_D1, M1_D2, M2_D2) mm(AI,BI,CO);
integer success = 1;

always  begin
  success = 1;

  for(ci=0; ci<M1_D1; ci=ci+1)
      for(cj=0; cj<M2_D2; cj=cj+1)
        begin
          $display("C[%d][%d] = %d, C_V[%d][%d] = %d\n", ci, cj, C[ci][cj], ci, cj, C_V[ci][cj]);
          if (C[ci][cj] !== C_V[ci][cj]) begin

          success = 0;
          end
        end

  if (success == 1)
      $display("The result is corrected! :)\n");
  else
      $display("The result is wrong :(\n");
  #5;
end

initial begin
  #10 $finish;
end


endmodule
