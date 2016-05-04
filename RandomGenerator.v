`include "config.v"

module RandomGenerator(reset, clk, seed, dataOut);
/*
this implementation is very simple, contains small bias
to avoid bias, a more complex implementation is needed, like 'Tkacik LFSR'.
*/


	input reset, clk;
	input [`BITN-1: 0] seed;
	output [`BITN-1: 0] dataOut;


	reg [`BITN-1: 0] shiftReg;
	wire shiftIn;

	always @(posedge clk or posedge reset) begin
		if(reset)
			shiftReg <= seed;
		else
			shiftReg <= {shiftReg[`BITN-2: 0], shiftIn};
	end


	wire xorOut;
	assign xorOut = shiftReg[`R_1] ^ shiftReg[`R_2] ^ shiftReg[`R_3] ^ shiftReg[`R_4];

	wire zeroDetector;
	assign zeroDetector = ~(|(shiftReg[`BITN-1: 0])); // all together, avoid fall into all zero case and stuck!
	assign shiftIn = xorOut ^ zeroDetector;


	assign dataOut = shiftReg;
endmodule

// I like verilog ??
