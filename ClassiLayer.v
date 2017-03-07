`ifndef ClassiLayer
`define ClassiLayer


`ifndef  TEST_BENCH
 `include "config.v"
     // synopsys translate_off
 `include "sigmoid.v"
 `include "RandomGenerator.v"
 `include "ap_adder.v"
     // synopsys translate_on
`else
    // synopsys translate_off
 `include "../sigmoid.v"
 `include "../RandomGenerator.v"
 `include "../ap_adder.v"
    // synopsys translate_on
`endif


`define bit_64_68(b) {b[63],b[63],b[63],b[63],b}  // #BIT_CHANGE

module ClassiLayer
   (input reset,
    input clock, // put a clock here
    input [63:0] Value,  // #BIT_CHANGE
    input [8:0] hidden_id,
    input pixel,
    output result, output finish
    );


    reg [67:0] temp;  // #BIT_CHANGE
    wire [67:0] activate_temp, next_temp, pixel_mask, Value_after_mask, zero_mask;  // #BIT_CHANGE
    wire [59:0] SigmoidOutput, RandomData;  // #BIT_CHANGE
    assign zero_mask = {68{hidden_id == 0}};  // #BIT_CHANGE
    // wire result;
    RandomGenerator   rnd(reset, hidden_id > 430,  `SEED_CLASSI , RandomData);
    sigmoid   sg(activate_temp, SigmoidOutput);
 
    assign finish = (hidden_id == 442); 
    assign activate_temp = next_temp & {68{hidden_id > 430}} ;  // #BIT_CHANGE
    assign result = SigmoidOutput > RandomData;
    assign pixel_mask = {68{pixel}};  // #BIT_CHANGE
    assign Value_after_mask = `bit_64_68(Value) & pixel_mask; // #BIT_CHANGE

    ap_adder  adder_only(temp, Value_after_mask, next_temp);

    always @(posedge clock or posedge reset) begin
      if (reset)
        temp = 0;
      else
        if (finish) begin
          // spike = result;
          temp = 0;
        end else begin
          temp = (next_temp & (~zero_mask)) | (zero_mask & Value_after_mask);
          if(hidden_id == 441) begin
          // $display("CLASS: %0d => %0d >< %0d => %0d", $signed(temp), SigmoidOutput, RandomData, result);
           $display("CLASS: %0d", RandomData);  // #important, random number dumping!
          end

        end
    end

endmodule


`endif