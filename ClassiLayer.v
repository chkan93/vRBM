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
   (input reset,
    input clock, // put a clock here
    input [11:0] Value,
    input [8:0] hidden_id,
    input pixel,
    output reg spike, output finish
    );


    reg [15:0] temp;
    wire [15:0] activate_temp, temp_exact, temp_approximate, next_temp, pixel_mask;
    wire [7:0] SigmoidOutput, RandomData;
    wire result;
    RandomGenerator   rnd(reset, clock,  8'b00111111 , RandomData);
    sigmoid   sg(activate_temp, SigmoidOutput);
    assign finish = (hidden_id == 442);
    assign activate_temp = temp & {16{finish}} ;
    assign result = SigmoidOutput > RandomData;
    assign next_temp = temp_exact | temp_approximate;
    assign pixel_mask = {16{pixel}};
    ap_adder  adder_only(temp, Value & pixel_mask, temp_exact);
    i_ap_adder iadder_only(temp, Value & pixel_mask, temp_approximate);

    always @(posedge clock) begin
      if (finish) begin
        spike = result;
        temp = 0;
      end else begin
        temp = next_temp;
      end
    end

endmodule


`endif
