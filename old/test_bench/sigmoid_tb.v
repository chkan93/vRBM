`define TEST_BENCH
`include "../config.v"
`include "../sigmoid.v"




module test_sigmoid;
  reg signed[11:0] sum;
  wire[7:0] s;
  sigmoid  #(12, 8) sigmoidins(sum, s);
  reg[7:0] i;
  initial
  begin
    $monitor($time,,
    "sum = %0d s = %0d",
    sum, s);
    #10 sum=-2048;
    for(i=0;i<4196;i=i+1)
     #10 sum=sum+1;

    #41960 $finish;
  end
endmodule
