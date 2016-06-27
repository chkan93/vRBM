/**************************************************************************
 *  16bit adder                                                            *
 *  Written by: S. H. Kang                                                *
 *  Last modified: Dec 16, 2010                                           *
 **************************************************************************/

module iadder_B16_ZHU (clk, rst, A, B, SUM);

input          clk;
input          rst;
input   [15:0]  A, B;
output  [16:0]  SUM;
reg 	[16:0]  SUM;

wire    [8:0]  ASUM = A[15:8] + B[15:8];
wire    [7:0]  ISUM;

wire    [7:0]  G, P;

assign  P[0] = A[0] && B[0];
assign  P[1] = A[1] && B[1];
assign  P[2] = A[2] && B[2];
assign  P[3] = A[3] && B[3];
assign  P[4] = A[4] && B[4];
assign  P[5] = A[5] && B[5];
assign  P[6] = A[6] && B[6];
assign  P[7] = A[7] && B[7];

assign  G[0] = A[0] || B[0];
assign  G[1] = A[1] || B[1];
assign  G[2] = A[2] || B[2];
assign  G[3] = A[3] || B[3];
assign  G[4] = A[4] || B[4];
assign  G[5] = A[5] || B[5];
assign  G[6] = A[6] || B[6];
assign  G[7] = A[7] || B[7];

assign ISUM[7] = G[7];
assign ISUM[6] = P[7] || P[6] ? 1'b1 : G[6];
assign ISUM[5] = P[7] || P[6] || P[5] ? 1'b1 : G[5];
assign ISUM[4] = P[7] || P[6] || P[5] || P[4] ? 1'b1 : G[4];
assign ISUM[3] = P[7] || P[6] || P[5] || P[4] || P[3] ? 1'b1 : G[3];
assign ISUM[2] = P[7] || P[6] || P[5] || P[4] || P[3] || P[2] ? 1'b1 : G[2];
assign ISUM[1] = P[7] || P[6] || P[5] || P[4] || P[3] || P[2] || P[1] ? 1'b1 : G[1];
assign ISUM[0] = P[7] || P[6] || P[5] || P[4] || P[3] || P[2] || P[1] || P[0] ? 1'b1 : G[0];

always @(posedge clk or posedge rst) begin
    if (rst) begin
        SUM    	<= 17'b0;
    end 
    else begin
        SUM    	<= {ASUM, ISUM};
    end
end

endmodule
