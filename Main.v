`ifndef  TEST_BENCH
	`include "config.v"
  `include "RBMLayer.v"
`else
  `include "../RBMLayer.v"
`endif

`ifndef Main
`define Main


module Main #(
  parameter  input_bitlength = 12,
  parameter  sigmoid_bitlength = 8,
  parameter  output_bitlength = 12,
  parameter  in_dim = 15,
  parameter  h_dim = 5,
  parameter  out_dim = 2,
	parameter seed_path="./data/seed1x5.txt",
	parameter iteration_num = 100,
	parameter counter_bit_length = 10
)(
  input clock,
	input reset,
  input wire[`PORT_1D(in_dim, input_bitlength)] ImageI,
  input wire[`PORT_2D(in_dim, h_dim, input_bitlength)] H_WeightI,
  input wire[`PORT_1D(h_dim, input_bitlength)] H_BiasI,
  input wire[`PORT_2D(h_dim, out_dim, input_bitlength)] C_WeightI,
	input wire[`PORT_1D(out_dim,  input_bitlength)] C_BiasI,
  output [`PORT_1D(out_dim, output_bitlength)] Output,
	output [`PORT_1D(out_dim, output_bitlength)] Cumulation,
	output reg finish
  );


reg[output_bitlength-1:0] Result`DIM_1D(out_dim);
reg[counter_bit_length-1:0] icounter;

wire[output_bitlength-1:0] OutputVector`DIM_1D(out_dim);

`DEFINE_PACK_VAR;
`PACK_1D_ARRAY(out_dim, output_bitlength, Result, Cumulation)
`UNPACK_1D_ARRAY(out_dim, output_bitlength, Output, OutputVector)

wire [`PORT_1D(h_dim, input_bitlength)] H_Output;
RBMLayer #(input_bitlength,
          sigmoid_bitlength,
          input_bitlength, in_dim, h_dim, seed_path)
          rbm(clock, reset, ImageI, H_WeightI, H_BiasI, H_Output);



RBMLayer #(input_bitlength,
					sigmoid_bitlength,
					input_bitlength, h_dim, out_dim, seed_path)
					cl(clock, reset, H_Output, C_WeightI, C_BiasI, Output);


integer i,j;
always @ ( posedge clock ) begin
// accumulate the result, if it's not X.
	if (!reset) begin


		for(i = 0; i < out_dim; i=i+1) begin
			// $display("The OutputVector[%d] is %b",i, OutputVector[i]);
				if (OutputVector[i] > 0) begin
						// $display("Reach here");
						Result[i] = Result[i] + OutputVector[i];
				end
		end

		icounter = icounter + 1;
		if (icounter == iteration_num) begin
			 finish = 1;
		end
	end
end


always @(posedge reset) begin
// clear the accumulator here
	for (j = 0; j < out_dim; j=j+1)
		Result[j] = 0;
	icounter = 0;
	finish = 0;
end


endmodule

`endif
