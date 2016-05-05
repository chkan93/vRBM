`ifndef  TEST_BENCH
	`include "config.v"
`endif


module RandomGenerator(reset, clk, seed, dataOut);
/*
this implementation is very simple, contains small bias
to avoid bias, a more complex implementation is needed, like 'Tkacik LFSR'.
*/

	input reset, clk;
	input [`BITN-1: 0] seed;
	output  [`BITN-1: 0] dataOut;
	reg [`BITN-1: 0] shiftReg = 0;
	wire shiftIn, xorOut, zeroDetector;
	reg start = 1;

	assign xorOut = shiftReg[`R_1] ^ shiftReg[`R_2] ^ shiftReg[`R_3] ^ shiftReg[`R_4];
	assign zeroDetector = ~(|(shiftReg[`BITN-1: 0])); // all together, avoid fall into all zero case and stuck!
	assign shiftIn = xorOut ^ zeroDetector;
	assign dataOut = shiftReg;

	// initial begin
	// 	$display("[Before Initial RandomGenerator.shiftReg = %d]", shiftReg); // ok
	// 	$display("[Before Initial RandomGenerator.shiftIn = %d]", shiftIn);
	// 	$display("[Before Initial RandomGenerator.zeroDetector = %d]", zeroDetector);
	// 	$display("[Before Initial RandomGenerator.xorOut = %d]", xorOut);
	// 	// shiftReg = `BITN'b0000010;
	// 	$display("[After Initial RandomGenerator.shiftReg = %d]", shiftReg); // ok
	// 	$display("[After Initial RandomGenerator.shiftIn = %d]", shiftIn);
	// 	$display("[After Initial RandomGenerator.zeroDetector = %d]", zeroDetector);
	// 	$display("[After Initial RandomGenerator.xorOut = %d]", xorOut);
	// end


	always @(posedge clk or posedge reset) begin
		// $display("[RandomGenerator.reset = %d]",reset);  // ok
		// $display("[RandomGenerator.shiftReg = %d]", shiftReg); // ok
		if(reset || start)
			begin
				start = 0;
				// $display("[RandomGenerator.shiftReg = seed]"); // ok
				shiftReg <= seed;
			end
		else
			begin
				// $display("[RandomGenerator.shiftIn = %d]", shiftIn); // problem! shiftIn = x
				// $display("[RandomGenerator.shiftReg[`BITN-2: 0] = %d]", shiftReg[`BITN-2: 0]); // ok
				// $display("[RandomGenerator.shiftReg = %d]",{shiftReg[`BITN-2: 0], shiftIn}); // ok
				shiftReg <= {shiftReg[`BITN-2: 0], shiftIn};
			end
	end




endmodule
