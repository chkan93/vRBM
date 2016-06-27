/**************************************************************************
 *  16bit adder                                                            *
 *  Written by: S. H. Kang                                                *
 *  Last modified: Dec 16, 2010                                           *
 **************************************************************************/

module iadder_B16_4B (clk, rst, A, B, SUM);

input          clk;
input          rst;
input   [15:0]  A, B;
output  [16:0]  SUM;
reg 	[16:0]  SUM;

wire [4:0] S0 = A[3:0] + B[3:0];
wire [4:0] S2 = A[5:2] + B[5:2] + A[0];// added noise
wire [4:0] S4 = A[7:4] + B[7:4] + A[2];
wire [4:0] S6 = A[9:6] + B[9:6] + A[4];
wire [4:0] S8 = A[11:8] + B[11:8] + A[6];
wire [4:0] S10 = A[13:10] + B[13:10] + A[8];
wire [4:0] S12 = A[15:12] + B[15:12] + A[10];

always @(posedge clk or posedge rst) begin
    if (rst) begin
        SUM    	<= 17'b0;
    end 
    else begin
        SUM    	<= {S12[4:2],S10[3:2],S8[3:2],S6[3:2],S4[3:2],S2[3:2],S0[3:0]};
    end
end

endmodule

