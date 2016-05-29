`ifndef  TEST_BENCH
	`include "config.v"
  `include "MatrixMul.v"
  `include "MatrixAdd.v"
	`include "sigmoid.v"
`else
  `include "../MatrixMul.v"
  `include "../MatrixAdd.v"
	`include "../sigmoid.v"
`endif


`ifndef ClassifyLayer
`define ClassifyLayer

module ClassifyLayer#(
	parameter  input_bitlength = 12,
	parameter output_bitlength = 8,
	parameter  in_dim = 5,
	parameter  out_dim = 3
)(
  input wire[`PORT_1D(in_dim,  input_bitlength)] Input,
  input wire[`PORT_2D(in_dim, out_dim, input_bitlength)] WeightI,
	input wire[`PORT_1D(out_dim,  input_bitlength)] BiasI,
	output [`PORT_1D(out_dim, output_bitlength)] HoutputO
  );

	wire[`PORT_1D(out_dim, input_bitlength)] temp_mul;
  wire[`PORT_1D(out_dim, input_bitlength)] temp_add;

  MatrixMul #(input_bitlength, 1, in_dim, out_dim) mm(Input, WeightI, temp_mul); // V * W
  MatrixAdd #(input_bitlength, 1, out_dim) ma(temp_mul, BiasI, temp_add); // V * W + b
	wire[input_bitlength-1:0] temp`DIM_1D(out_dim);
	`DEFINE_PACK_VAR;
  `UNPACK_1D_ARRAY( out_dim, input_bitlength, temp_add, temp) //temp[i]

	wire[output_bitlength-1:0] sg_output`DIM_1D(out_dim);
	`PACK_1D_ARRAY( out_dim, output_bitlength, sg_output, HoutputO)

	genvar i;
  generate
    for(i=0;i<out_dim;i=i+1) begin
			sigmoid #(input_bitlength, output_bitlength) sg(temp[i], sg_output[i]);
    end
  endgenerate

endmodule

`endif
