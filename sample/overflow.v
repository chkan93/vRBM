

module overflow();

reg signed[3:0] x = -4'b0111;
integer clockp = 10;

initial begin
  #100 $finish;
end

always begin
  $display("I am %b",x);
  x = x - 1;
  $display("I am %b", x);
#clockp;
end
endmodule


// check: verilog compare signed or unsigned?
