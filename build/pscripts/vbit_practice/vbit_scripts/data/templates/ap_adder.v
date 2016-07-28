
`ifndef ap_adder
`define ap_adder


module ap_adder (input signed[__bitlapm1__:0] x,
                 input signed[__bitlapm1__:0] y,
                 output reg signed[__bitlapm1__:0] z);

wire signed[__bitlapm1__:0] tmp;
wire negO,posO;
assign tmp = y + x;
assign posO = (!y[__bitlm1__]) & (!x[__bitlm1__]) & (tmp[__bitlm1__]);
assign negO = (y[__bitlm1__]) & (x[__bitlm1__]) & (!tmp[__bitlm1__]);

always @ ( * ) begin
  if (negO) begin
    z <= $signed(__min__); //64'b1000_0000_0000_0000__0000_0000_0000_0000__0000_0000_0000_0000__0000_0000_0000_0000
  end else if(posO) begin
    z <= __max__;
    //64'b0111_1111_1111_1111__1111_1111_1111_1111__1111_1111_1111_1111__1111_1111_1111_1111
  end else begin
    z <= tmp;
  end
end

endmodule

`endif