`ifndef RBMLayer
`define RBMLayer


`ifndef  TEST_BENCH
 `include "config.v"
    // synopsys translate_off
 `include "sigmoid.v"
 `include "RandomGenerator.v"
 `include "ap_adder.v"
 // `include "i_ap_adder.v"
 `include "iadder_B16_ETAIIM.v"
   // synopsys translate_on
`else
    // synopsys translate_off
 `include "../sigmoid.v"
 `include "../RandomGenerator.v"
 `include "../ap_adder.v"
 // `include "../i_ap_adder.v"
 `include "../iadder_B16_ETAIIM.v"
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
    output reg hidden, output finish
    );


    reg [15:0] temp;
    wire [15:0] activate_temp, temp_exact, temp_approximate, next_temp, use_iadder, pixel_mask;
    wire [7:0] SigmoidOutput, RandomData;
    wire result;
    RandomGenerator   rnd(reset, clock, 8'b01111100, RandomData);
    sigmoid   sg(activate_temp, SigmoidOutput);

    assign finish = (pixel_id == 785);
    assign activate_temp = temp & {16{finish}} ;
    assign result = SigmoidOutput > RandomData;
    assign next_temp = temp_exact | temp_approximate;
    assign use_iadder = {16{adder_type}};
    assign pixel_mask = {16{pixel}};
    ap_adder  adder_only(temp & (~use_iadder), (~use_iadder) & Value & pixel_mask, temp_exact);
    i_ap_adder iadder_only(temp & use_iadder,use_iadder & Value & pixel_mask, temp_approximate);

    always @(posedge clock) begin
      if (finish) begin
        hidden = result;
        temp = 0;
      end else begin
        temp = next_temp;
      end
    end

endmodule

`endif
