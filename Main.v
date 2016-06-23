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


`define iteration_num 30

module Main 
   (input reset,
    input clock,
    input data_valid,
    input wire [`PORT_2D(784, 441, 12)] HiddenWeight,
    input wire [`PORT_1D(441, 12)] HiddenBias,
    input wire [`PORT_1D(441, 1)] HiddenSwitch,
    input wire [`PORT_2D(441, 10, 12)] ClassiWeight,
    input wire [`PORT_1D(10, 12)] ClassiBias,
    input wire [`PORT_1D(10, 1)] ClassiSwitch,
    input wire [`PORT_1D(784, 1)] InputData,
    output reg [`PORT_1D(10, 12)] OutputData,
    output reg finish);




   wire        hidden_finish, internal_finish;
   reg 	       internal_reset;
   reg [9:0]  iteration_counter;
   wire [`PORT_1D(441, 1)] HiddenData;
   wire [`PORT_1D(10, 1)] OutputDataOneTime;


   RBMLayer hidden_layer(internal_reset, reset,  clock, data_valid, HiddenWeight, HiddenBias, HiddenSwitch, InputData , HiddenData, hidden_finish);


   ClassiLayer classify_layer(internal_reset, reset, clock, hidden_finish, ClassiWeight, ClassiBias, ClassiSwitch, HiddenData, OutputDataOneTime, internal_finish);


   reg[3:0] i;
   always @ (posedge clock or posedge reset) begin
      if (reset == 1'b1) begin
	 iteration_counter = 0;
	 internal_reset = 1;
	 OutputData = 0;
	 finish = 0;
      end else begin
	 if (iteration_counter < `iteration_num) begin
	    if (internal_reset) begin
               internal_reset = 0;
	    end else begin
               if(internal_finish) begin
		  // $display("EOT,%0d", iteration_counter);
		  for(i = 0; i<10; i=i+1) begin
        if (`GET_1D(OutputDataOneTime, 1, i) == 1)
	  `GET_1D(OutputData, 12, i) = `GET_1D(OutputData, 12, i) + 1;
		  end
		  iteration_counter = iteration_counter + 1;
		  internal_reset = 1;
               end
	    end
	 end else begin
	    if (iteration_counter > 0) begin
	       finish = 1;
	    end
	 end 
      end 
   end 
endmodule


`endif