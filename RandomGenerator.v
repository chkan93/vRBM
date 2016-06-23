`ifndef  TEST_BENCH
	`include "config.v"
`endif

`ifndef RandomGenerator
`define RandomGenerator

module RandomGenerator
	(
		input reset,
		input clk,
		input [7: 0]	seed,
		output [7: 0] dataOut
		);
	reg [7: 0] shiftReg;
	wire shiftIn, xorOut, zeroDetector;

	assign xorOut = shiftReg[`R_1] ^ shiftReg[`R_2] ^ shiftReg[`R_3] ^ shiftReg[`R_4];
	assign zeroDetector = ~(|(shiftReg[7: 0])); // all together, avoid fall into all zero case and stuck!
	assign shiftIn = xorOut ^ zeroDetector;
	assign dataOut = shiftReg;

	always @(posedge clk or posedge reset) begin
	   if (reset == 1'b1)
	     shiftReg <= seed;
	   else
	     shiftReg <= {shiftReg[6: 0], shiftIn};
	end

endmodule
`endif

