
`ifndef ap_adder
`define ap_adder


module ap_adder (input signed[15:0] x,
                 input signed[15:0] y,
                 output reg signed[15:0] z);

wire signed[15:0] tmp;
wire negO,posO;
assign tmp = y + x;
assign posO = (!y[15]) & (!x[15]) & (tmp[15]);
assign negO = (y[15]) & (x[15]) & (!tmp[15]);

always @ ( * ) begin
  if (negO) begin
    z <= $signed(16'b1000_0000_0000_0000);
  end else if(posO) begin
    z <= 16'b0111_1111_1111_1111;
  end else begin
    z <= tmp;
  end
end

endmodule

`endif