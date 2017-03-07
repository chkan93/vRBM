`ifndef  TEST_BENCH
	`include "config.v"
`endif

`ifndef RandomGenerator
`define RandomGenerator

module RandomGenerator
	(
		input reset,
		input clk,
		input [59: 0]	seed,
		output [59: 0] dataOut
		);
	reg [59: 0] shiftReg;
	wire shiftIn, xorOut, zeroDetector;

	assign xorOut = shiftReg[`R_1] ^ shiftReg[`R_2];


	assign zeroDetector = ~(|(shiftReg[59: 0])); // all together, avoid fall into all zero case and stuck!
	assign shiftIn = xorOut ^ zeroDetector;
	assign dataOut = shiftReg;

	always @(posedge clk or posedge reset) begin
	   if (reset == 1'b1)
	     shiftReg <= seed;
	   else
	     shiftReg <= {shiftReg[58: 0], shiftIn};
	end

endmodule
`endif
