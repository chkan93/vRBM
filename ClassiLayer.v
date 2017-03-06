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

`define bit_12_16(b) {b[11],b[11],b[11],b[11],b}

module ClassiLayer
   (input reset,
    input clock, // put a clock here
    input [11:0] Value,
    input [8:0] hidden_id,
    input pixel,
    output result, output finish
    );


    reg [15:0] temp;
    wire [15:0] activate_temp, temp_exact, temp_approximate, next_temp, pixel_mask, Value_after_mask, zero_mask;
    wire [7:0] SigmoidOutput, RandomData;
    assign zero_mask = {16{hidden_id == 0}};
    // wire result;
    RandomGenerator   rnd(reset, clock,  8'b00111111 , RandomData);
    sigmoid   sg(activate_temp, SigmoidOutput);

    assign finish = (hidden_id == 442);
    assign activate_temp = next_temp & {16{hidden_id > 430}} ;
    assign result = SigmoidOutput > RandomData;
    assign pixel_mask = {16{pixel}};
    assign Value_after_mask = `bit_12_16(Value) & pixel_mask;
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
              $display("%0d => %0d >< %0d => %0d", $signed(temp),
                         SigmoidOutput, RandomData, result);


              // $display("CLASS: %0d", RandomData);  // #important, random number dumping!
          end
        end
    end

endmodule


`endif
