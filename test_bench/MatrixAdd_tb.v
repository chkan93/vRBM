`define TEST_BENCH
`include "../config.v"
`include "../MatrixAdd.v"




module test_MatrixAdd #(parameter bitlength = 8, parameter  W = 7);



integer A_V`DIM_2D(W,W);
integer B_V`DIM_2D(W,W);
integer C_V`DIM_2D(W,W);
integer ci,cj,ck;


wire[bitlength-1:0] A`DIM_2D(W,W);
wire[bitlength-1:0] B`DIM_2D(W,W);
wire[bitlength-1:0] C`DIM_2D(W,W);

wire[`PORT_2D(W,W,bitlength)] AI;
wire[`PORT_2D(W,W,bitlength)] BI;
wire[`PORT_2D(W,W,bitlength)] CO;


initial begin
/*
Calculating the ground truth
*/
for(ci=0; ci<W; ci=ci+1)
   for(cj=0; cj<W; cj=cj+1)
      A_V[ci][cj] = ci*2 + cj;

for(ci=0; ci<W; ci=ci+1)
    for(cj=0; cj<W; cj=cj+1)
      B_V[ci][cj] = ci*2 + cj + 1;

for(ci=0; ci<W; ci=ci+1)
    for(cj=0; cj<W; cj=cj+1)
      C_V[ci][cj] = A_V[ci][cj] + B_V[ci][cj];
end


genvar i,j;
generate
for(i=0; i<W; i=i+1)
   for(j=0; j<W; j=j+1)
      assign A[i][j] = i*2 + j;


for(i=0; i<W; i=i+1)
   for(j=0; j<W; j=j+1)
       assign B[i][j] = i*2 + j + 1;
endgenerate


`DEFINE_PACK_VAR;
`PACK_2D_ARRAY(W,W,bitlength, A, AI)
`PACK_2D_ARRAY(W,W,bitlength, B, BI)
`UNPACK_2D_ARRAY(W, W, bitlength, CO, C)

MatrixAdd #(bitlength,W,W) madd(AI,BI,CO);
integer success = 1;

always  begin
  success = 1;

  for(ci=0; ci<W; ci=ci+1)
      for(cj=0; cj<W; cj=cj+1)
      begin
        // $display("C[%d][%d] = %d, C_V[%d][%d] = %d\n", ci, cj, C[ci][cj], ci, cj, C_V[ci][cj]);
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
