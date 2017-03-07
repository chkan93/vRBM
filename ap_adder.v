
`ifndef ap_adder
`define ap_adder


// #BIT_CHANGE
module ap_adder (input signed[67:0] x,
                 input signed[67:0] y,
                 output reg signed[67:0] z);

wire signed[67:0] tmp;
wire negO,posO;
assign tmp = y + x;
assign posO = (!y[67]) & (!x[67]) & (tmp[67]);
assign negO = (y[67]) & (x[67]) & (!tmp[67]);

always @ ( * ) begin
  if (negO) begin
    z <= $signed(68'b1000_0000_0000_0000__0000_0000_0000_0000__0000_0000_0000_0000__0000_0000_0000_0000__0000);
  end else if(posO) begin
    z <= 68'b0111_1111_1111_1111__1111_1111_1111_1111__1111_1111_1111_1111__1111_1111_1111_1111_1111;
  end else begin
    z <= tmp;
  end
end

endmodule

`endif