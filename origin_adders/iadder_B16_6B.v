/**************************************************************************
 *  16bit adder                                                            *
 *  Written by: S. H. Kang                                                *
 *  Last modified: Dec 16, 2010                                           *
 **************************************************************************/

module iadder_B16_6B (clk, rst, A, B, SUM);

input          clk;
input          rst;
input   [15:0]  A, B;
output  [16:0]  SUM;
reg 	[16:0]  SUM;

wire [6:0] S0 = A[5:0] + B[5:0];
wire [6:0] S3 = A[8:3] + B[8:3] + A[0];
wire [6:0] S6 = A[11:6] + B[11:6] + A[3];
wire [6:0] S9 = A[14:9] + B[14:9] + A[6];
wire [4:0] S12 = A[15:12] + B[15:12] + A[9];

always @(posedge clk or posedge rst) begin
    if (rst) begin
        SUM    	<= 17'b0;
    end 
    else begin
        SUM    	<= {S12[4:3],S9[5:3],S6[5:3],S3[5:3],S0[5:0]};
    end
end

endmodule

