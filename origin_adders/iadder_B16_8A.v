/**************************************************************************
 *  16bit adder                                                            *
 *  Written by: S. H. Kang                                                *
 *  Last modified: Dec 16, 2010                                           *
 **************************************************************************/

module iadder_B16_8A (clk, rst, A, B, SUM);

input          clk;
input          rst;
input   [15:0]  A, B;
output  [16:0]  SUM;
reg 	[16:0]  SUM;

wire [8:0] SL = A[7:0] + B[7:0];
wire [8:0] SH = A[15:8] + B[15:8] + A[0];

always @(posedge clk or posedge rst) begin
    if (rst) begin
        SUM    	<= 17'b0;
    end 
    else begin
        SUM    	<= {SH[8:0],SL[7:0]};
    end
end

endmodule

