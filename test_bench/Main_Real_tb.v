`define TEST_BENCH
`include "../config.v"
`include "../Main.v"

`timescale 1s/1s

module test_Main
#(
  parameter  input_bitlength = 12,
  parameter  sigmoid_bitlength = 8,
  parameter  output_bitlength = 8,
  parameter  in_dim = 784,
  parameter  h_dim = 441,
  parameter  out_dim = 10,
  parameter  clock_period = 10
);

reg clock, reset;
wire[`PORT_1D(in_dim, input_bitlength)] ImageI;
wire[`PORT_2D(in_dim, h_dim, input_bitlength)] H_WeightI;
wire[`PORT_1D(h_dim, input_bitlength)] H_BiasI;
wire[`PORT_2D(h_dim, out_dim, input_bitlength)] C_WeightI;
wire[`PORT_1D(out_dim,  input_bitlength)] C_BiasI;
wire[`PORT_1D(out_dim, output_bitlength)] Output;



reg[input_bitlength-1:0] ImageIm`DIM_1D(in_dim);
wire[input_bitlength-1:0] H_WeightIm`DIM_2D(in_dim, h_dim);
reg[input_bitlength-1:0] H_BiasIm`DIM_1D(h_dim);
wire[input_bitlength-1:0] C_WeightIm`DIM_2D(h_dim, out_dim);
reg[input_bitlength-1:0] C_BiasIm`DIM_1D(out_dim);
wire[output_bitlength-1:0] Outputm`DIM_1D(out_dim);
reg[input_bitlength-1:0] C_WeightIm_1d`DIM_1D(h_dim*out_dim);
reg[input_bitlength-1:0] H_WeightIm_1d`DIM_1D(in_dim*h_dim);

`DEFINE_PACK_VAR;
`PACK_1D_ARRAY(in_dim, input_bitlength, ImageIm, ImageI)

`D1_TO_D2_ARRAY(in_dim, h_dim, H_WeightIm_1d, H_WeightIm)
`PACK_2D_ARRAY(in_dim, h_dim, input_bitlength, H_WeightIm, H_WeightI)
`D1_TO_D2_ARRAY(h_dim, out_dim, C_WeightIm_1d, C_WeightIm)
`PACK_2D_ARRAY(h_dim, out_dim, input_bitlength, C_WeightIm, C_WeightI)

`PACK_1D_ARRAY(h_dim, input_bitlength, H_BiasIm, H_BiasI)
`PACK_1D_ARRAY(out_dim, input_bitlength, C_BiasIm, C_BiasI)
`UNPACK_1D_ARRAY(out_dim, output_bitlength, Output, Outputm)

initial begin
  reset = 0;
  clock = 1;
  $readmemh("./data/mnist/verilog/mnist_rbm_model_cbias.txt", C_BiasIm);
  $readmemh("./data/model/verilog/mnist_rbm_model_cweight.txt", C_WeightIm_1d);
  $readmemh("./data/model/verilog/mnist_rbm_model_hbias.txt", H_BiasIm);
  $readmemh("./data/model/verilog/mnist_rbm_model_hweight.txt", H_WeightIm_1d);
  $readmemh("./data/mnist/verilog/mnist_testdata0.txt", ImageIm);
  $dumpfile ("./dumpFolder/Main_Real.vcd");
  $dumpvars;
  #100 $finish;
end

Main #(input_bitlength, sigmoid_bitlength, output_bitlength, in_dim, h_dim, out_dim, "./data/seed1x5.txt")
m(clock, reset, ImageI, H_WeightI, H_BiasI, C_WeightI, C_BiasI, Output);

`DEFINE_PRINTING_VAR;

always begin
  clock = !clock;
  `DISPLAY_1D_ARRAY(out_dim, "Output = ", Outputm);
  $display("Clock is %b",clock);
#clock_period;
end






endmodule
