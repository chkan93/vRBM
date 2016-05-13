`define TEST_BENCH
`include "../config.v"
`include "../Main.v"


module test_Main
#(
  parameter  input_bitlength = 12,
  parameter  sigmoid_bitlength = 8,
  parameter  output_bitlength = 8,
  parameter  in_dim = 15,
  parameter  h_dim = 5,
  parameter  out_dim = 2
);

reg clock, reset;
reg[`PORT_1D(in_dim, input_bitlength)] ImageI;
reg[`PORT_2D(in_dim, h_dim, input_bitlength)] H_WeightI;
reg[`PORT_1D(h_dim, input_bitlength)] H_BiasI;
reg[`PORT_2D(h_dim, out_dim, input_bitlength)] C_WeightI;
reg[`PORT_1D(out_dim,  input_bitlength)] C_BiasI;
reg[`PORT_1D(out_dim, output_bitlength)] Output;


initial begin
  reset = 0;
  $readmemh("./data/Cbias1x2.txt", C_BiasI);
  $readmemh("./data/Cweight5x2.txt", C_WeightI);
  $readmemh("./data/Hbias1x5.txt", H_BiasI);
  $readmemh("./data/Hweight15x5.txt", H_WeightI);
  $readmemh("./data/image1x15.txt", ImageI);
end

Main #(input_bitlength, sigmoid_bitlength, output_bitlength, in_dim, h_dim, out_dim)
m(clock, reset, ImageI, H_WeightI, H_BiasI, C_WeightI, C_BiasI, Output);

integer clock_period = 10;
always begin
  clock = !clock;
  //$monitor here
#clock_period;
end

endmodule
