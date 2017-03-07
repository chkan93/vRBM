`ifndef RBMLayer
`define RBMLayer


`ifndef  TEST_BENCH
 `include "config.v"
    // synopsys translate_off
 `include "sigmoid.v"
 `include "RandomGenerator.v"
 `include "ap_adder.v"
 // `include "i_ap_adder.v"
// `include "iadder_B16_8A.v" //KEY:ADDER_TYPE_CURRENT_FOLDER
   // synopsys translate_on
`else
    // synopsys translate_off
 `include "../sigmoid.v"
 `include "../RandomGenerator.v"
 `include "../ap_adder.v"
 // `include "../i_ap_adder.v"
// `include "../iadder_B16_8A.v" //KEY:ADDER_TYPE_PARENT_FOLDER
     // synopsys translate_on
`endif



`define bit_64_68(b) {b[63],b[63],b[63],b[63],b}  // #BIT_CHANGE

module RBMLayer
   (input reset,
    input clock,
    input [63:0] Value,  // #BIT_CHANGE
    input [9:0] pixel_id,
    input pixel,
    input adder_type,
    output result, output finish
    );


    reg [67:0] temp; // #BIT_CHANGE
    wire [67:0] activate_temp, next_temp, pixel_mask, zero_mask, Value_after_mask;  // #BIT_CHANGE
    wire [59:0] SigmoidOutput, RandomData;  // #BIT_CHANGE

    // wire result;
    RandomGenerator   rnd(reset, clock, `SEED_RBM, RandomData);
    sigmoid   sg(activate_temp, SigmoidOutput);

    assign finish = (pixel_id == 785);
    assign zero_mask = {68{pixel_id == 0}};  // #BIT_CHANGE
    assign activate_temp = next_temp & {68{pixel_id > 780}} ;  // #BIT_CHANGE
    assign result = SigmoidOutput > RandomData;
    // assign next_temp = temp_exact | temp_approximate;
    assign pixel_mask = {68{pixel}};  // #BIT_CHANGE
    assign Value_after_mask = `bit_64_68(Value) & pixel_mask;  // #BIT_CHANGE
    ap_adder  adder_only(temp , Value_after_mask, next_temp);

    always @(posedge clock or posedge reset) begin
      if (reset) begin 
        // $display("FINISH, set temp to zero");
        temp = 0;
      end else
        if (finish) begin
          // $display("FINISH, set temp to zero");
          temp = 0;
        end else begin
          temp = (next_temp & (~zero_mask)) | (zero_mask & Value_after_mask);

          if(pixel_id == 784) begin
            // $display("784: %0d => %0d >< %0d => %0d", $signed(temp), SigmoidOutput, RandomData, result);


           $display("RBM: %0d", RandomData);  // #important, random number dumping!
          end

        end
    end

endmodule

`endif
