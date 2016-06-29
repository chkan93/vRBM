`ifndef RBMLayer
`define RBMLayer


`ifndef  TEST_BENCH
 `include "config.v"
    // synopsys translate_off
 `include "sigmoid.v"
 `include "RandomGenerator.v"
 `include "ap_adder.v"
 // `include "i_ap_adder.v"
`include "iadder_B16_ZHU4.v" //KEY:ADDER_TYPE_CURRENT_FOLDER
   // synopsys translate_on
`else
    // synopsys translate_off
 `include "../sigmoid.v"
 `include "../RandomGenerator.v"
 `include "../ap_adder.v"
 // `include "../i_ap_adder.v"
`include "../iadder_B16_ZHU4.v" //KEY:ADDER_TYPE_PARENT_FOLDER
     // synopsys translate_on
`endif

`define bit_12_16(b) {b[11],b[11],b[11],b[11],b}

module RBMLayer
   (input reset,
    input clock,
    input [11:0] Value,
    input [9:0] pixel_id,
    input pixel,
    input adder_type,
    output result, output finish
    );


    reg [15:0] temp;
    wire [15:0] activate_temp, temp_exact, temp_approximate, next_temp, use_iadder, pixel_mask, zero_mask, Value_after_mask;
    wire [7:0] SigmoidOutput, RandomData;

    // wire result;
    RandomGenerator   rnd(reset, clock, 8'b01111100, RandomData);
    sigmoid   sg(activate_temp, SigmoidOutput);

    assign finish = (pixel_id == 785);
    assign zero_mask = {16{pixel_id == 0}};
    assign activate_temp = next_temp & {16{pixel_id > 780}} ;
    assign result = SigmoidOutput > RandomData;
    assign next_temp = temp_exact | temp_approximate;
    assign use_iadder = {16{adder_type}};
    assign pixel_mask = {16{pixel}};
    assign Value_after_mask = `bit_12_16(Value) & pixel_mask;
    ap_adder  adder_only(temp & (~use_iadder), (~use_iadder) & Value_after_mask, temp_exact);
    i_ap_adder iadder_only(temp & use_iadder,use_iadder & Value_after_mask, temp_approximate);

    always @(posedge clock or posedge reset) begin
      if (reset)
        temp = 0;
      else
        if (finish) begin
          temp = 0;
        end else begin
          temp = (next_temp & (~zero_mask)) | (zero_mask & Value_after_mask);
          // $display("(%0d) %0d => %0d >< %0d, Value = %d, pixel = %0d",pixel_id, temp, SigmoidOutput, RandomData, Value_after_mask, pixel);
          // if(pixel_id == 784) begin
          //   $display("%0d => %0d >< %0d => %0d", $signed(temp),
          //   SigmoidOutput, RandomData, result);
          // end
        end
    end

endmodule

`endif
