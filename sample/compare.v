

module compare();

reg signed[3:0] x = 7;
reg signed[3:0] y = -5;
reg signed[3:0] z = 4'b1000;

integer clockp = 10;

initial begin
  #20 $finish;
end

always begin
  if (x > y)
    $display("x > y!");
  if (x > z)
    $display("x > z!");
  if (y > z)
    $display("y > z!");

$display("=========================");
#clockp;
end
endmodule


// check: verilog compare signed or unsigned?
