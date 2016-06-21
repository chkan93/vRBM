`include "../iadder_B16_ETAIIM.v"

module test_iadder ();

reg signed[15:0] A,B;
wire signed[15:0] C;
initial begin
  A = 0;
  B = 0;
end

i_ap_adder adder(A,B,C);
integer i;
always begin
$display("%0d + %0d => %0d, %0b",A,B,C, C == (A+B));
     A = A + 1;
     B = B + 2;
#10;
end

initial begin
  #10000 $finish;
end

endmodule // dsd
