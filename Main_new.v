`ifndef  TEST_BENCH
	`include "config.v"
  `include "RBMLayer_new.v"
`else
  `include "../RBMLayer_new.v"
`endif


module Main_new #(parameter integer bitlength = 12,
                  parameter integer sigmoid_bitlength = 8,
                  parameter integer general_input_dim = 15,
                  parameter integer sparse_input_dim = 64,
                  parameter integer hidden_dim = 5,
                  parameter integer output_dim = 2,
                  parameter  Inf = 12'b0111_1111_1111,
                  parameter h_weight_path = "../build/data/Hweight15x5.txt",  // load a different weight for sparse case 64x441
                  parameter h_bias_path = "../build/data/Hbias1x5.txt",
                  parameter h_seed_path = "../build/data/Hseed1x5.txt",
                  parameter c_weight_path = "../build/data/Cweight5x2.txt",  // load a different weight for sparse case 64x441
                  parameter c_bias_path = "../build/data/Cbias1x2.txt",
                  parameter c_seed_path = "../build/data/Cseed1x2.txt",
                  parameter hidden_adder_group_num = 1,
                  parameter cl_adder_group_num = 1,
                  parameter iteration_num = 100
                  )
                  (input reset,
                   input clock,
                   input data_valid,
                   input wire signed[`PORT_1D(input_dim, bitlength)] InputData,
                   output reg signed[`PORT_1D(output_dim, bitlength)] OutputData,
                   output reg finish);


`ifndef SPARSE
localparam input_dim = general_input_dim;
`else
localparam input_dim = sparse_input_dim;
`endif


wire hidden_finish, internal_finish;
reg internal_reset;
reg [31:0] iteration_counter;
wire [`PORT_1D(hidden_dim, bitlength)] HiddenData;
wire [`PORT_1D(output_dim, bitlength)] OutputDataOneTime;
wire [bitlength-1:0] SelfAddOutput`DIM_1D(output_dim);


RBMLayer_new #(bitlength, sigmoid_bitlength, general_input_dim, sparse_input_dim,
               hidden_dim, Inf, h_weight_path, h_bias_path, h_seed_path,
               hidden_adder_group_num) hidden_layer(internal_reset, clock, data_valid, InputData , HiddenData, hidden_finish);
RBMLayer_new #(bitlength, sigmoid_bitlength, hidden_dim, hidden_dim,
               output_dim, Inf, c_weight_path, c_bias_path, c_seed_path,
               cl_adder_group_num) classify_layer(internal_reset, clock, hidden_finish, HiddenData, OutputDataOneTime, internal_finish);

genvar g;
generate
for (g = 0; g < output_dim; g=g+1) begin
  ap_adder #(bitlength, Inf) adder(`GET_1D(OutputDataOneTime, bitlength, g), `GET_1D(OutputData, bitlength, g), SelfAddOutput[g]);
end
endgenerate


always @(posedge reset) begin
  iteration_counter = 0;
  internal_reset = 1;
  OutputData = 0;
end

always @(negedge reset) begin
  internal_reset = 0;
end

integer i = 0;
always @ (posedge clock) begin
  if (iteration_counter < iteration_num) begin
      if (internal_reset) begin
        internal_reset = 0;
      end else begin
        if(internal_finish) begin
          //do the self addition here
          for(i = 0; i<output_dim; i=i+1) begin
            `GET_1D(OutputData, bitlength, i) = SelfAddOutput[i];
          end
          iteration_counter = iteration_counter + 1;
          internal_reset = 1;
        end else begin
          // just wait here
        end
      end
  end else begin
      finish = 1;
  end
end



endmodule
