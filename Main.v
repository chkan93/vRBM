`ifndef  TEST_BENCH
 `include "config.v"
// `include "RBMLayer.v"
`else
// `include "../RBMLayer.v"
`endif


module Main #(parameter integer bitlength = 12,
              parameter integer sigmoid_bitlength = 8,
              parameter integer general_input_dim = 784,
              parameter integer sparse_input_dim = 64,
              parameter integer hidden_dim = 441,
              parameter integer output_dim = 10,
              parameter  Inf = 12'b0111_1111_1111,
              parameter h_weight_path = "../build/data/Hweight4x3.txt",
              parameter h_bias_path = "../build/data/Hbias1x3.txt",
              parameter h_seed_path = "../build/data/Hseed1x3.txt",
              parameter c_weight_path = "../build/data/Cweight3x2.txt",
              parameter c_bias_path = "../build/data/Cbias1x2.txt",
              parameter c_seed_path = "../build/data/Cseed1x2.txt",
              parameter hidden_adder_group_num = 1,
              parameter cl_adder_group_num = 1,
              parameter iteration_num = 100
              )
   (input reset,
    input clock,
    input data_valid,
    input wire signed[`PORT_1D(general_input_dim, 1)] InputData,
    output reg signed[`PORT_1D(output_dim, bitlength)] OutputData,
    output reg finish);


`ifndef SPARSE
   localparam input_dim = general_input_dim;
`else
   localparam input_dim = sparse_input_dim;
`endif


   wire        hidden_finish, internal_finish;
   reg 	       internal_reset;
   reg [31:0]  iteration_counter;
   wire [`PORT_1D(hidden_dim, 1)] HiddenData;
   wire [`PORT_1D(output_dim, 1)] OutputDataOneTime;
  //  wire [bitlength-1:0] 		  SelfAddOutput`DIM_1D(output_dim);


   RBMLayer #(bitlength, sigmoid_bitlength, general_input_dim, sparse_input_dim,
              hidden_dim, Inf, h_weight_path, h_bias_path, h_seed_path,
              hidden_adder_group_num, 1) hidden_layer(internal_reset, reset,  clock, data_valid, InputData , HiddenData, hidden_finish);
   RBMLayer #(bitlength, sigmoid_bitlength, hidden_dim, hidden_dim,
              output_dim, Inf, c_weight_path, c_bias_path, c_seed_path,
              cl_adder_group_num, 2) classify_layer(internal_reset, reset, clock, hidden_finish, HiddenData, OutputDataOneTime, internal_finish);

  //  genvar 				  g;
  //  generate
  //     for (g = 0; g < output_dim; g=g+1) begin : accumulation_group
	//  ap_adder #(bitlength, Inf) adder(`GET_1D(OutputDataOneTime, bitlength, g), `GET_1D(OutputData, bitlength, g), SelfAddOutput[g]);
  //     end
  //  endgenerate

   reg[3:0] i;
   always @ (posedge clock or posedge reset) begin
      if (reset == 1'b1) begin
	 iteration_counter = 0;
	 internal_reset = 1;
	 OutputData = 0;
	 finish = 0;
      end else begin
	 if (iteration_counter < iteration_num) begin
	    if (internal_reset) begin
               internal_reset = 0;
	    end else begin
               if(internal_finish) begin
		  for(i = 0; i<output_dim; i=i+1) begin
        if (`GET_1D(OutputDataOneTime, 1, i) == 1)
		     `GET_1D(OutputData, bitlength, i) = `GET_1D(OutputData, bitlength, i) + 1;
		  end
		  iteration_counter = iteration_counter + 1;
		  internal_reset = 1;
               end
	    end
	 end else begin
	    if (iteration_counter > 0) begin
	       finish = 1;
	    end
	 end // else: !if(iteration_counter < iteration_num)
      end // else: !if(reset == 1b'1)
   end // always @ (posedge clock or posedge reset)
endmodule
