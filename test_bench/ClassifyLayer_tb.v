`define TEST_BENCH
`include "../config.v"
`include "../ClassifyLayer.v"


module test_ClassifyLayer

#(
  parameter  input_bitlength = 12,
  parameter  output_bitlength = 8,
  parameter  in_dim = 5,
  parameter  out_dim = 2,
  parameter clock_period = 10
);

wire[`PORT_1D(in_dim, input_bitlength)] InputHV;
wire[`PORT_2D(in_dim, out_dim, input_bitlength)] C_WeightI; //12*10
wire[`PORT_1D(out_dim,  input_bitlength)] C_BiasI;
wire[`PORT_1D(out_dim, output_bitlength)] Output;

reg[input_bitlength-1:0] InputHVm`DIM_1D(in_dim);
wire[input_bitlength-1:0] C_WeightIm`DIM_2D(in_dim, out_dim);
reg[input_bitlength-1:0] C_WeightIm_1d`DIM_1D(in_dim*out_dim);

reg[input_bitlength-1:0] C_BiasIm`DIM_1D(out_dim);
wire[output_bitlength-1:0] Outputm`DIM_1D(out_dim);



`DEFINE_PACK_VAR;
`PACK_1D_ARRAY(in_dim, input_bitlength, InputHVm, InputHV)
`D1_TO_D2_ARRAY(in_dim, out_dim, C_WeightIm_1d, C_WeightIm)
`PACK_2D_ARRAY(in_dim, out_dim, input_bitlength, C_WeightIm, C_WeightI)
`PACK_1D_ARRAY(out_dim, input_bitlength, C_BiasIm, C_BiasI)
`UNPACK_1D_ARRAY(out_dim, output_bitlength, Output, Outputm)


initial begin
$readmemh("./data/Cbias1x2.txt", C_BiasIm);
$readmemh("./data/Cweight5x2.txt", C_WeightIm_1d);
$readmemh("./data/Htemp1x5.txt", InputHVm);
$dumpfile ("./dumpFolder/ClassifyLayer.vcd");
$dumpvars;
#50 $finish;
end

`DEFINE_PRINTING_VAR;

ClassifyLayer #(input_bitlength, output_bitlength, in_dim, out_dim)
             cl(InputHV, C_WeightI, C_BiasI, Output);

always begin
    `DISPLAY_1D_ARRAY(out_dim, "Output = ", Outputm);
#clock_period;
end

initial begin
  `DISPLAY_1D_ARRAY(out_dim, "Bias =", C_BiasIm);
  `DISPLAY_1D_ARRAY(in_dim, "Input =", InputHVm);
  `DISPLAY_1D_ARRAY(in_dim*out_dim, "Weight_1D =", C_WeightIm_1d);
  `DISPLAY_2D_ARRAY(in_dim, out_dim, "Weight_2D =", C_WeightIm);
  `DISPLAY_2D_BIT_ARRAY(in_dim, out_dim, input_bitlength, "C_WeightI =", C_WeightI);
end


endmodule
