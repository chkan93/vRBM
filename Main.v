`ifndef  TEST_BENCH
	`include "config.v"
  `include "RBMLayer.v"
  `include "ClassifyLayer.v"
`else
  `include "../RBMLayer.v"
  `include "../ClassifyLayer.v"
`endif

`ifndef Main
`define Main


module Main #(
  parameter  input_bitlength = 12,
  parameter  sigmoid_bitlength = 8,
  parameter  output_bitlength = 8,
  parameter  in_dim = 15,
  parameter  h_dim = 5,
  parameter  out_dim = 2,
	parameter seed_path="./data/seed1x5.txt"
)(
  input clock,
	input reset,
  input wire[`PORT_1D(in_dim, input_bitlength)] ImageI,
  input wire[`PORT_2D(in_dim, h_dim, input_bitlength)] H_WeightI,
  input wire[`PORT_1D(h_dim, input_bitlength)] H_BiasI,
  input wire[`PORT_2D(h_dim, out_dim, input_bitlength)] C_WeightI,
	input wire[`PORT_1D(out_dim,  input_bitlength)] C_BiasI,
  output [`PORT_1D(out_dim, output_bitlength)] Output
  );


wire [`PORT_1D(h_dim, input_bitlength)] H_Output;
RBMLayer #(input_bitlength,
          sigmoid_bitlength,
          input_bitlength, in_dim, h_dim, seed_path)
          rbm(clock, reset, ImageI, H_WeightI, H_BiasI, H_Output);



ClassifyLayer #(input_bitlength,
         	      output_bitlength,
                h_dim,
         	      out_dim)
                cl(H_Output, C_WeightI, C_BiasI, Output);

endmodule

`endif
