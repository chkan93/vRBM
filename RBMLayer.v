`ifndef  TEST_BENCH
	`include "config.v"
  `include "sigmoid.v"
  `include "RandomGenerator.v"
  `include "ap_adder.v"
`else
  `include "../sigmoid.v"
  `include "../RandomGenerator.v"
  `include "../ap_adder.v"
`endif

module RBMLayer 				#(parameter integer bitlength = 12,
                              parameter integer sigmoid_bitlength = 8,
                              parameter integer general_input_dim = 15, // 784,441
                              parameter integer sparse_input_dim = 8, //64
                              parameter integer output_dim = 5, //441,10
                              parameter  Inf = 12'b0111_1111_1111,
                              parameter weight_path = "../build/data/Hweight15x5.txt",  // load a different weight for sparse case 64x441
                              parameter bias_path = "../build/data/Hbias1x5.txt",
                              parameter seed_path = "../build/data/seed1x10.txt",
															parameter integer adder_group_num  = 1
                              )
                              (input reset,
															 input rand_reset,
                               input clock,
															 input data_valid,
                               input wire [`PORT_1D(general_input_dim, bitlength)] InputData,
                               output reg [`PORT_1D(output_dim, bitlength)] OutputData,
                               output reg finish
                               );

localparam  temp_dim = adder_group_num;
`ifndef SPARSE
localparam input_dim = general_input_dim;
`else
localparam input_dim = sparse_input_dim;
`endif


initial begin
`ReadMem(weight_path, Weight);
`ReadMem(bias_path, Bias);
`ReadMem(seed_path, SeedData);
end




reg signed[bitlength-1:0] Weight`DIM_2D(input_dim, output_dim);
reg signed[bitlength-1:0] Bias`DIM_1D(output_dim);
wire signed[bitlength-1:0] Add_Group_Temp_Result`DIM_2D(temp_dim, input_dim);
reg  signed[bitlength-1:0] Add_Group_Input`DIM_2D(temp_dim, input_dim+1);
reg  [31:0] cursor;
integer i = 0, j = 0, k = 0;
genvar g,h;
reg [sigmoid_bitlength-1:0] SeedData`DIM_1D(temp_dim);
wire [sigmoid_bitlength-1:0] RandomData`DIM_1D(temp_dim);
wire [sigmoid_bitlength-1:0] SigmoidOutput`DIM_1D(temp_dim);


generate
for(g = 0; g< temp_dim; g=g+1) begin
	sigmoid #(bitlength,sigmoid_bitlength) sg(Add_Group_Temp_Result[g][input_dim-1], SigmoidOutput[g]); //
	RandomGenerator  #(sigmoid_bitlength) rnd(rand_reset, clock, SeedData[g], RandomData[g]);
	for(h = 0; h<input_dim; h=h+1) begin
			if (h == 0)
				ap_adder #(bitlength, Inf) adder(Add_Group_Input[g][h], Add_Group_Input[g][h+1], Add_Group_Temp_Result[g][h]);
			else
				ap_adder #(bitlength, Inf) adder(Add_Group_Temp_Result[g][h-1], Add_Group_Input[g][h+1], Add_Group_Temp_Result[g][h]);
	end
end
endgenerate


always @(posedge reset) begin
  finish = 0;
	cursor = 0;
  for(i = 0; i < temp_dim; i=i+1)
		for(j = 0; j < input_dim + 1; j=j+1) begin
				Add_Group_Input[i][j] = 0;
		end
  OutputData = 0;
	//reset has nothing to do with random number generator
end
always @ ( posedge clock ) begin
	if (data_valid && !reset) begin
		// $display("reach here"); yes, reach here
		$display("cursor = %0d", cursor);
		if (cursor < output_dim) begin
			for(i = 0; i< temp_dim; i=i+1) begin
				Add_Group_Input[i][0] <= Bias[cursor];
				for(j = 1; j< input_dim+1; j=j+1) begin
					if (`GET_1D(InputData, bitlength, j-1)) // problem here, if sparse, need to use an expression other than "j-1"
						Add_Group_Input[i][j] <= Weight[j][cursor];
						else
						Add_Group_Input[i][j] <= 0;
					end

					$display("RandomData[%0d] = %0d",i,RandomData[i]);
					if(SigmoidOutput[i] > RandomData[i])
					`GET_1D(OutputData, bitlength, cursor) = 1;
					cursor = cursor + 1;
			end
		end

		if (cursor == output_dim) begin
			// $finish;
			finish = 1;
		end else begin
			finish = 0;
		end
	end
end
endmodule
