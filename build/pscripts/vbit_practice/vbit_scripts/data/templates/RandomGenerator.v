`ifndef  TEST_BENCH
	`include "config.v"
`endif

`ifndef RandomGenerator
`define RandomGenerator

module RandomGenerator
	(
		input reset,
		input clk,
		input [__bitlm1__: 0]	seed,
		output [__bitlm1__: 0] dataOut
		);
	reg [__bitlm1__: 0] shiftReg;
	wire shiftIn, xorOut, zeroDetector;
	assign xorOut = __TODO__;


	assign zeroDetector = ~(|(shiftReg[__bitlm1__: 0])); // all together, avoid fall into all zero case and stuck!
	assign shiftIn = xorOut ^ zeroDetector;
	assign dataOut = shiftReg;

	always @(posedge clk or posedge reset) begin
	   if (reset == 1'b1)
	     shiftReg <= seed;
	   else
	     shiftReg <= {shiftReg[__bitlm1__-1: 0], shiftIn};
	end

endmodule
`endif
