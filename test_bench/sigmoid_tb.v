`define TEST_BENCH
`include "../config.v"
`include "../sigmoid.v"

module test_sigmoid;
  reg signed [15:0] sum;
  wire[7:0] s;
  sigmoid sigmoidins(sum, s);
  integer i;
  initial
  begin

    #10 sum= 2047;
    for(i=1;i<4096;i=i+1)begin
     #10 sum=sum-1;
     $display("i = %-d, (%0d/256 = %f)  output is: %0d",sum+1,sum+1, $bitstoreal((sum+1)/256), s);
    end
  end
endmodule
