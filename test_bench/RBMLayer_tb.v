`define TEST_BENCH
`include "../config.v"
`include "../RBMLayer.v"


module test_RBMLayer
#(
  parameter  input_bitlength = 12,
  parameter  sg_bitlength=8,
  parameter  output_bitlength = 12,
  parameter  in_dim = 15,
  parameter  out_dim = 5,
  parameter clock_period = 10,
  parameter  random_seed_file = "./data/seed1x5.txt"
);

reg clock;
reg reset;

wire[`PORT_1D(in_dim, input_bitlength)] InputHV;
wire[`PORT_2D(in_dim, out_dim, input_bitlength)] H_WeightI; //12*10
wire[`PORT_1D(out_dim,  input_bitlength)] H_BiasI;
wire[`PORT_1D(out_dim, output_bitlength)] Output;

reg[input_bitlength-1:0] InputHVm`DIM_1D(in_dim);
wire[input_bitlength-1:0] H_WeightIm`DIM_2D(in_dim, out_dim);
reg[input_bitlength-1:0] H_WeightIm_1d`DIM_1D(in_dim*out_dim);

reg[input_bitlength-1:0] H_BiasIm`DIM_1D(out_dim);
wire[output_bitlength-1:0] Outputm`DIM_1D(out_dim);



`DEFINE_PACK_VAR;
`PACK_1D_ARRAY(in_dim, input_bitlength, InputHVm, InputHV)
`D1_TO_D2_ARRAY(in_dim, out_dim, H_WeightIm_1d, H_WeightIm)
`PACK_2D_ARRAY(in_dim, out_dim, input_bitlength, H_WeightIm, H_WeightI)
`PACK_1D_ARRAY(out_dim, input_bitlength, H_BiasIm, H_BiasI)
`UNPACK_1D_ARRAY(out_dim, output_bitlength, Output, Outputm)

`DEFINE_READMEM_VAR;
initial begin
clock = 1;
reset = 0;
`ReadMem("./data/Hbias1x5.txt", H_BiasIm);
`ReadMem("./data/Hweight15x5.txt", H_WeightIm_1d);
`ReadMem("./data/image1x15.txt", InputHVm);
$dumpfile ("./dumpFolder/RBMLayer.vcd");
$dumpvars;
#100 $finish;
end

`DEFINE_PRINTING_VAR;

RBMLayer #(input_bitlength,sg_bitlength ,output_bitlength, in_dim, out_dim, random_seed_file)
             rbn(clock, reset, InputHV, H_WeightI, H_BiasI, Output);

always begin
    clock = !clock;
    `DISPLAY_1D_ARRAY(out_dim, "Output = ", Outputm)

#clock_period;
end

initial begin
  //`DISPLAY_1D_ARRAY(out_dim, "Bias =", H_BiasIm);
  //`DISPLAY_1D_ARRAY(in_dim, "Input =", InputHVm);
  //`DISPLAY_1D_ARRAY(in_dim*out_dim, "Weight_1D =", H_WeightIm_1d);
  //`DISPLAY_2D_ARRAY(in_dim, out_dim, "Weight_2D =", H_WeightIm);
  //`DISPLAY_2D_BIT_ARRAY(in_dim, out_dim, input_bitlength, "C_WeightI =", H_WeightI);
end


endmodule
