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
  parameter  out_dim = 2,
  parameter  clock_period = 10,
  parameter  runtime = 50
);

reg clock, reset;
wire[`PORT_1D(in_dim, input_bitlength)] ImageI;
wire[`PORT_2D(in_dim, h_dim, input_bitlength)] H_WeightI;
wire[`PORT_1D(h_dim, input_bitlength)] H_BiasI;
wire[`PORT_2D(h_dim, out_dim, input_bitlength)] C_WeightI;
wire[`PORT_1D(out_dim,  input_bitlength)] C_BiasI;
wire[`PORT_1D(out_dim, output_bitlength)] Output;



reg[input_bitlength-1:0] ImageIm`DIM_1D(in_dim);
reg[input_bitlength-1:0] H_WeightIm`DIM_2D(in_dim, h_dim);
reg[input_bitlength-1:0] H_BiasIm`DIM_1D(h_dim);
reg[input_bitlength-1:0] C_WeightIm`DIM_2D(h_dim, out_dim);
reg[input_bitlength-1:0] C_BiasIm`DIM_1D(out_dim);
wire[output_bitlength-1:0] Outputm`DIM_1D(out_dim);

`DEFINE_PACK_VAR;
`PACK_1D_ARRAY(in_dim, input_bitlength, ImageIm, ImageI)
`PACK_2D_ARRAY(in_dim, h_dim, input_bitlength, H_WeightIm, H_WeightI)
`PACK_1D_ARRAY(h_dim, input_bitlength, H_BiasIm, H_BiasI)
`PACK_2D_ARRAY(h_dim, out_dim, input_bitlength, C_WeightIm, C_WeightI)
`PACK_1D_ARRAY(out_dim, input_bitlength, C_BiasIm, C_BiasI)
`UNPACK_1D_ARRAY(out_dim, input_bitlength, Output, Outputm)

initial begin
  reset = 0;
  $readmemh("./data/Cbias1x2.txt", C_BiasIm);
  $readmemh("./data/Cweight5x2.txt", C_WeightIm);
  $readmemh("./data/Hbias1x5.txt", H_BiasIm);
  $readmemh("./data/Hweight15x5.txt", H_WeightIm);
  $readmemh("./data/image1x15.txt", ImageIm);
end

Main #(input_bitlength, sigmoid_bitlength, output_bitlength, in_dim, h_dim, out_dim)
m(clock, reset, ImageI, H_WeightI, H_BiasI, C_WeightI, C_BiasI, Output);

`DEFINE_PRINTING_VAR;

always begin
  clock = !clock;
  `DISPLAY_1D_ARRAY(out_dim, "Output = ", Outputm);

#clock_period;
end



initial  begin
  // $monitor("%d", $time);
  `DISPLAY_1D_ARRAY(in_dim, "Image = ", ImageIm);
  `DISPLAY_1D_ARRAY(h_dim, "H_Bias = ", H_BiasIm);
  #runtime $finish;
end



endmodule
