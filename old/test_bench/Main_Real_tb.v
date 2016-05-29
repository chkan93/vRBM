`define TEST_BENCH
`include "../config.v"
`include "../Main.v"

`timescale 1s/1s

module test_Real_Main
#(
  parameter  input_bitlength = 12,
  parameter  sigmoid_bitlength = 8,
  parameter  output_bitlength = 12,
  parameter  in_dim = 784, //784
  parameter  h_dim = 441,  //441
  parameter  out_dim = 10, //10
  parameter  clock_period = 10
);

reg clock, reset;
wire[`PORT_1D(in_dim, input_bitlength)] ImageI;
wire[`PORT_2D(in_dim, h_dim, input_bitlength)] H_WeightI;
wire[`PORT_1D(h_dim, input_bitlength)] H_BiasI;
wire[`PORT_2D(h_dim, out_dim, input_bitlength)] C_WeightI;
wire[`PORT_1D(out_dim,  input_bitlength)] C_BiasI;
wire[`PORT_1D(out_dim, output_bitlength)] Output;


wire finish;


reg[input_bitlength-1:0] ImageIm`DIM_1D(in_dim);
wire[input_bitlength-1:0] H_WeightIm`DIM_2D(in_dim, h_dim);
reg[input_bitlength-1:0] H_BiasIm`DIM_1D(h_dim);
wire[input_bitlength-1:0] C_WeightIm`DIM_2D(h_dim, out_dim);
reg[input_bitlength-1:0] C_BiasIm`DIM_1D(out_dim);
wire[output_bitlength-1:0] Outputm`DIM_1D(out_dim);
reg[input_bitlength-1:0] C_WeightIm_1d`DIM_1D(h_dim*out_dim);
reg[input_bitlength-1:0] H_WeightIm_1d`DIM_1D(in_dim*h_dim);



wire[`PORT_1D(out_dim, output_bitlength)] ResultO;
wire[output_bitlength-1:0] Result`DIM_1D(out_dim);


`DEFINE_PACK_VAR;
`PACK_1D_ARRAY(in_dim, input_bitlength, ImageIm, ImageI)

`D1_TO_D2_ARRAY(in_dim, h_dim, H_WeightIm_1d, H_WeightIm)
`PACK_2D_ARRAY(in_dim, h_dim, input_bitlength, H_WeightIm, H_WeightI)
`D1_TO_D2_ARRAY(h_dim, out_dim, C_WeightIm_1d, C_WeightIm)
`PACK_2D_ARRAY(h_dim, out_dim, input_bitlength, C_WeightIm, C_WeightI)

`PACK_1D_ARRAY(h_dim, input_bitlength, H_BiasIm, H_BiasI)
`PACK_1D_ARRAY(out_dim, input_bitlength, C_BiasIm, C_BiasI)
`UNPACK_1D_ARRAY(out_dim, output_bitlength, Output, Outputm)
`UNPACK_1D_ARRAY(out_dim, output_bitlength, ResultO, Result)
// I should have a naming convention here, sorry.

`DEFINE_READMEM_VAR;
integer start = 0;
initial begin
  reset = 0;
  #10 reset = 1;
  #20 reset = 0;
  #20 start = 1;
  clock = 1;

  `ReadMem("./data/mnist/verilog/mnist_rbm_model_cbias.txt", C_BiasIm);
  `ReadMem("./data/model/verilog/mnist_rbm_model_cweight.txt", C_WeightIm_1d);
  `ReadMem("./data/model/verilog/mnist_rbm_model_hbias.txt", H_BiasIm);
  `ReadMem("./data/model/verilog/mnist_rbm_model_hweight.txt", H_WeightIm_1d);
  `ReadMem("./data/mnist/verilog/mnist_testdata0.txt", ImageIm);
  $dumpfile ("./dumpFolder/Main_Real.vcd");
  $dumpvars;


end

Main #(input_bitlength, sigmoid_bitlength, output_bitlength, in_dim, h_dim, out_dim, "./data/seed1x441.txt","./data/seed1x10.txt", 1000, 10)
m(clock, reset, ImageI, H_WeightI, H_BiasI, C_WeightI, C_BiasI, Output, ResultO, finish);

`DEFINE_PRINTING_VAR;

integer icounter = 0;
always begin
  clock = !clock;


#clock_period;
end


always @ (posedge clock) begin
if(start) begin
icounter = icounter + 1;
$display("Iteration No'%d", icounter);
`DISPLAY_1D_ARRAY(out_dim, "This iteration Output = ", Outputm)
// `DISPLAY_1D_ARRAY(out_dim, "Cumulated Result = ", Result)
$display("Clock is %b",clock);
// $display("Reset is %b", reset);

  if(finish) begin
    $display("The iteration is finished! ");
    `DISPLAY_1D_ARRAY(out_dim, "Cumulated Result = ", Result)

    $finish;
  end
end
end




endmodule
