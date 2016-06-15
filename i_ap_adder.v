module i_ap_adder #(parameter integer bitlength = 16, parameter Inf=16'b0111_1111_1111_1111)
                (input signed[bitlength-1:0] x,
                 input signed[bitlength-1:0] y,
                 output reg signed[bitlength-1:0] z);

wire signed[bitlength-1:0] tmp;
wire negO,posO;
assign tmp = y + x;
assign posO = (!y[bitlength-1]) & (!x[bitlength-1]) & (tmp[bitlength-1]);
assign negO = (y[bitlength-1]) & (x[bitlength-1]) & (!tmp[bitlength-1]);

always @ ( * ) begin
  if (negO) begin
    z <= $signed(-Inf);
  end else if(posO) begin
    z <= Inf;
  end else begin
    z <= tmp;
  end
end

// always @ ( x or y ) begin
//   // z <= y + x;
//   // $display("x = %d, y = %d, x + y = %d", x,y,z);
//   if (x > 0 && y > 0 && (y+x) <= 0) begin
//         z <= Inf;
//       end
//   else if (y < 0 && x < 0 && (y+x) >= 0) begin
//         z <= $signed(-Inf);
//       end
//   else
//         z <= y + z;
// end
endmodule
