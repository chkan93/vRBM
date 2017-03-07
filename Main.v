`ifndef Main
`define Main


`ifndef  TEST_BENCH
 `include "config.v"
     // synopsys translate_off
 `include "RBMLayer.v"
 `include "ClassiLayer.v"
     // synopsys translate_on
`else
    // synopsys translate_off
 `include "../RBMLayer.v"
 `include "../ClassiLayer.v"
     // synopsys translate_on
`endif



module Main
   (input reset,
    input clock,
    // input [11:0] Hbias,
    input [63:0] Hvalue,
    input [9:0] pixel_id,
    input pixel,
    input adder_type,
    input enable_hidden,
    input enable_classi,

    // input [11:0] Cbias,
    input [63:0] Cvalue,
    input [8:0] hidden_id,
    input hidden_pixel,
    output hidden, output  hidden_finish,
    output  spike, output finish
    );

    RBMLayer  rbm(reset, clock,Hvalue, pixel_id, pixel & enable_hidden, adder_type, hidden, hidden_finish);
    ClassiLayer classi(reset, clock , Cvalue, hidden_id, hidden_pixel & enable_classi, spike, finish);

endmodule


`endif
