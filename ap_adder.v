module ap_adder #(parameter integer bitlength = 12, parameter Inf=12'b0111_1111_1111)
                (input signed[bitlength-1:0] x,
                 input signed[bitlength-1:0] y,
                 output reg signed[bitlength-1:0] z);
always @ ( x or y ) begin
  z = y + x;
  // $display("x = %d, y = %d, x + y = %d", x,y,z);
  if (x > 0 && y > 0 && z <= 0) begin
        z = Inf;
      end
  else if (y < 0 && x < 0 && z >= 0) begin
        z = -Inf;
      end
end
endmodule
