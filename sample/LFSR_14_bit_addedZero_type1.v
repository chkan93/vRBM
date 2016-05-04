module LFSR_14_bit_addedZero_type1(reset, clk, seed, dataOut);
/*
this implementation is very simple, contains small bias
to avoid bias, a more complex implementation is needed, like 'Tkacik LFSR'.
*/


	input reset, clk;
	input [13: 0] seed;
	output [13: 0] dataOut;


	reg [13: 0] shiftReg;
	wire shiftIn;

	always @(posedge clk or posedge reset) begin
		if(reset)
			shiftReg <= seed;
		else
			shiftReg <= {shiftReg[12: 0], shiftIn};
	end


	wire xorOut;
	assign xorOut = shiftReg[13] ^ shiftReg[12] ^ shiftReg[11] ^ shiftReg[1];

	wire zeroDetector;
	assign zeroDetector = ~(|(shiftReg[12: 0])); // all together, avoid fall into all zero case and stuck!
	assign shiftIn = xorOut ^ zeroDetector;


	assign dataOut = shiftReg;
endmodule

// I like verilog 😘
