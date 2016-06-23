`ifndef RBMLayer
`define RBMLayer


`ifndef  TEST_BENCH
 `include "config.v"
    // synopsys translate_off
 `include "sigmoid.v"
 `include "RandomGenerator.v"
 `include "ap_adder.v"
 `include "i_ap_adder.v"  //approximate adder
   // synopsys translate_on
`else
    // synopsys translate_off
 `include "../sigmoid.v"
 `include "../RandomGenerator.v"
 `include "../ap_adder.v"
 `include "../i_ap_adder.v"  //approximate adder
     // synopsys translate_on
`endif

`define bit_12_16(b) {b[11],b[11],b[11],b[11],b}




module RBMLayer 
   (input reset,
    input rand_reset,
    input clock,
    input data_valid,
    input wire [`PORT_2D(784, 441, 12)] Weight,
    input wire [`PORT_1D(441, 12)] Bias,
    input wire [`PORT_1D(441, 1)] Switch,
    input wire [`PORT_1D(784, 1)] InputData,
    output reg [`PORT_1D(441, 1)] OutputData,
    output reg finish
    );




   reg [9:0] 	     cursor, adding_cursor;
   reg [9:0] 	     i,j,k;
   reg mask;

   wire [7:0] 	     RandomData;
   wire [7:0] 	     SigmoidOutput;

   wire [11:0] current_weight, current_bias;


   reg [15:0] Temp;
   wire signed [15:0] Adder_Input_Temp_Exact;
   wire signed [15:0] Adder_Input_Temp_Approximate;
   wire signed [15:0] Next_Temp;
   sigmoid   sg(Temp, SigmoidOutput);
   RandomGenerator   rnd(rand_reset, clock, 8'b01111100, RandomData);



	 ap_adder  adder_only(
                            `bit_12_16(current_weight) & {16{InputData[adding_cursor] & (~Switch[cursor])}},
                            Temp & {16{~Switch[cursor]}},
                            Adder_Input_Temp_Exact);

   i_ap_adder iadder_only(
                            `bit_12_16(current_weight) & {16{InputData[adding_cursor] & Switch[cursor]}},
                            Temp & {16{Switch[cursor]}},
                            Adder_Input_Temp_Approximate);

   assign Next_Temp = Adder_Input_Temp_Exact | Adder_Input_Temp_Approximate;

   assign current_bias = `GET_1D(Bias, 12, cursor);
   assign current_weight = `GET_2D(Weight, 441, 12, adding_cursor, cursor);


   always @ ( posedge clock or posedge reset) begin
      if(reset) begin
         finish = 0;
         cursor = 0;
         adding_cursor = 0;
         Temp = 0;
         mask = 0;
      end else begin
         if (data_valid) begin
            if (cursor == 441) begin
               finish = 1;
            end else begin
               finish = 0;
               if (adding_cursor == 784) begin
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
                  adding_cursor = adding_cursor + 1 & {10{mask}};
                  mask = 1;
               end
            end
         end
      end
   end
endmodule

`endif