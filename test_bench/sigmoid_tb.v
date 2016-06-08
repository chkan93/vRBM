`define TEST_BENCH
`include "../config.v"
`include "../sigmoid.v"

module test_sigmoid;
  reg signed [11:0] sum;
  wire[7:0] s;
  sigmoid sigmoidins(sum, s);
  reg[7:0] i;
  initial
  begin

    #10 sum= 2047;
    for(i=1;i<4096;i=i+1)begin
     #10 sum=sum-1;
     $display("i = %d, output is: %d",sum, s);
    end
  end
endmodule
