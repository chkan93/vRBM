`define TEST_BENCH
`include "../config.v"
`include "../ap_adder.v"
`include "../sigmoid.v"

module ap_adder_tb;

reg signed[11:0] x[2:0];
reg signed[11:0] y[2:0];
wire signed[11:0] z[2:0];
reg signed[11:0] result[2:0];
wire [7:0] sgout;

ap_adder adder1(x[0],y[0],z[0]);
ap_adder adder2(x[1],y[1],z[1]);
ap_adder adder3(x[2],y[2],z[2]);
sigmoid sg(z[0], sgout);
initial begin
  #20 $finish;
end

always  begin
  $display("12 bits");
  x[0] <= 2047;
  y[0] <= 3;
  result[0] = z[0];
  $display("2047 + 3 =%d, sigmoid(2047+3)=%b", result[0], sgout);

  x[1] <= 10;
  y[1] <= 100;
  $display("10 + 100 =%d", z[1]);

  x[2] <= -1000;
  y[2] <= -1100;
  $display("-1000 + -1100 =%d", z[2]);
  #10;
end

endmodule
