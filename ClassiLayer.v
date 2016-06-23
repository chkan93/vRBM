`ifndef ClassiLayer
`define ClassiLayer


`ifndef  TEST_BENCH
 `include "config.v"
     // synopsys translate_off
 `include "sigmoid.v"
 `include "RandomGenerator.v"
 `include "ap_adder.v"
 `include "i_ap_adder.v"  
     // synopsys translate_on
`else
    // synopsys translate_off
 `include "../sigmoid.v"
 `include "../RandomGenerator.v"
 `include "../ap_adder.v"
 `include "../i_ap_adder.v"  
    // synopsys translate_on
`endif

`define bit_12_16(b) {b[11],b[11],b[11],b[11],b}


module ClassiLayer 
            #(parameter integer bitlength = 16,
              parameter integer w_bitlength = 12,
						  parameter integer sigmoid_bitlength = 8,
						  parameter integer general_input_dim = 15, // 784,441
						  parameter integer sparse_input_dim = 8, //64
						  parameter integer output_dim = 5, //441,10
						  parameter  Inf = 16'b0111_1111_1111_1111,
						  parameter weight_path = "../build/data/Hweight15x5.txt",  // load a different weight for sparse case 64x441
						  parameter bias_path = "../build/data/Hbias1x5.txt",
						  parameter seed_path = "../build/data/seed1x10.txt",
              parameter ord_path = "../build/data/order/example/c_adder_ord_example.txt",
						  parameter integer adder_num  = 28,
						  parameter [7:0] SeedData = 32,
						  parameter integer id = 0
						  )
   (input reset,
    input rand_reset,
    input clock,
    input data_valid,
    input wire [`PORT_2D(general_input_dim, output_dim, w_bitlength)] Weight,
    input wire [`PORT_1D(output_dim, w_bitlength)] Bias,
    input wire [`PORT_1D(output_dim, 1)] Switch,
    input wire [`PORT_1D(general_input_dim, 1)] InputData,
    output reg [`PORT_1D(output_dim, 1)] OutputData,
    output reg finish
    );




`ifndef SPARSE
   localparam input_dim = general_input_dim;
`else
   localparam input_dim = sparse_input_dim;
`endif

   reg [9:0] 	     cursor, adding_cursor;
   reg [9:0] 	     i,j,k;
   reg mask;

   wire [sigmoid_bitlength-1:0] 	     RandomData;
   wire [sigmoid_bitlength-1:0] 	     SigmoidOutput;

   wire [w_bitlength-1:0] current_weight, current_bias;


   reg [bitlength-1:0] Temp;
   wire signed [bitlength-1:0] Adder_Input_Temp_Exact[adder_num-1:0];
   wire signed [bitlength-1:0] Adder_Input_Temp_Approximate[adder_num-1:0];
   wire signed [bitlength-1:0] Next_Temp;
   sigmoid #(bitlength,sigmoid_bitlength) sg(Temp, SigmoidOutput);
   RandomGenerator  #(sigmoid_bitlength) rnd(rand_reset, clock, SeedData, RandomData);



	 ap_adder #(bitlength, Inf) adder_only(
                            `bit_12_16(current_weight) & {16{InputData[adding_cursor] & (~Switch[cursor])}},
                            Temp & {16{~Switch[cursor]}},
                            Adder_Input_Temp_Exact[adder_num-1]);

   i_ap_adder iadder_only(
                            `bit_12_16(current_weight) & {16{InputData[adding_cursor] & Switch[cursor]}},
                            Temp & {16{Switch[cursor]}},
                            Adder_Input_Temp_Approximate[adder_num-1]);

   assign Next_Temp = Adder_Input_Temp_Exact[adder_num-1] | Adder_Input_Temp_Approximate[adder_num-1];

   assign current_bias = `GET_1D(Bias, w_bitlength, cursor);
   assign current_weight = `GET_2D(Weight, output_dim, w_bitlength, adding_cursor, cursor);


   always @ ( posedge clock or posedge reset) begin
      if(reset) begin
         finish = 0;
         cursor = 0;
         adding_cursor = 0;
         Temp = 0;
         mask = 0;
      end else begin
         if (data_valid) begin
            if (cursor == output_dim) begin
               finish = 1;
            end else begin
               finish = 0;
               if (adding_cursor == input_dim) begin
		              // $display("%0d,%0d", id, RandomData); //#important for exporting random number
		              // $display("%0d: %0d => %0d >< %0d", id,$signed(Temp) ,SigmoidOutput, RandomData);
		              `GET_1D(OutputData, 1, cursor) <= SigmoidOutput > RandomData;
                  adding_cursor = 0;
                  mask = 0;
                  cursor = cursor + 1;
               end else begin
                  if (adding_cursor == 0 && mask == 0) begin
                     Temp =  `bit_12_16(current_bias);
                  end else begin
                     Temp =  Next_Temp;
                  end
                  adding_cursor = adding_cursor + adder_num & {10{mask}};
                  mask = 1;
               end
            end
         end
      end
   end
endmodule


`endif