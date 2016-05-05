`define TEST_BENCH
`include "../config.v"
`include "../sigmoid.v"




module test_sigmoid;
  reg[`SIGMOID_INPUT_BITN-1:0] sum;
  wire[`BITN-1:0] s;
  sigmoid sigmoidins(s,sum);
  reg[`BITN-1:0] i;
  initial
  begin
    $monitor($time,,
    "sum = %d s = %d",
    sum, s);
    #10 sum=12'h60;
    for(i=1;i<197;i=i+1)
     #10 sum=sum-1;

  end
endmodule
