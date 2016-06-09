`define TEST_BENCH
`include "../config.v"
`include "../Main.v"

// `timescale 1s/1s

module test_Main;
localparam  output_dim = 2;
localparam  bitlength = 12;
localparam  clock_period = 10;
localparam  sigmoid_bitlength = 8;
localparam  general_input_dim = 4;
localparam  sparse_input_dim = 64;
localparam  hidden_dim = 3;
localparam   Inf = 12'b0111_1111_1111;
localparam h_weight_path = "../build/data/Hweight4x3.txt";  // load a different weight for sparse case 64x441
localparam h_bias_path = "../build/data/Hbias1x3.txt";
localparam h_seed_path = "../build/data/Hseed1x3.txt";
localparam c_weight_path = "../build/data/Cweight3x2.txt";  // load a different weight for sparse case 64x441
localparam c_bias_path = "../build/data/Cbias1x2.txt";
localparam c_seed_path = "../build/data/Cseed1x2.txt";
localparam hidden_adder_group_num = 1;
localparam cl_adder_group_num = 1;
localparam iteration_num = 30;

`ifndef SPARSE
localparam input_dim = general_input_dim;
`else
localparam input_dim = sparse_input_dim;
`endif


integer i = 0;
reg clock, reset, data_valid;
wire finish;
wire[bitlength-1:0] OutputData`DIM_1D(output_dim);
wire[`PORT_1D(output_dim, bitlength)] OutputDataPort;

reg InputData`DIM_1D(input_dim);
wire[`PORT_1D(input_dim, 1)] InputDataPort;

initial begin
  $dumpfile ("./dumpFolder/Main_test_runnable.vcd");
  $dumpvars;
  `ReadMem("./data/image1x4.txt",InputData);
  clock = 0;
  reset = 0;
  data_valid = 0;
  #20 reset = 1;
  #30 reset = 0;
  #40 data_valid = 1;
end

`DEFINE_PACK_VAR;

`PACK_1D_ARRAY(input_dim, 1, InputData, InputDataPort)
`UNPACK_1D_ARRAY(output_dim, bitlength, OutputDataPort, OutputData)

Main #(bitlength, sigmoid_bitlength, general_input_dim,
           sparse_input_dim, hidden_dim, output_dim, Inf,
           h_weight_path, h_bias_path, h_seed_path, c_weight_path,
           c_bias_path, c_seed_path,
           hidden_adder_group_num, cl_adder_group_num, iteration_num)
           main(reset, clock, data_valid, InputDataPort, OutputDataPort, finish);


always begin
  clock = !clock;
  //check finish
#clock_period;
end

`DEFINE_PRINTING_VAR;
always @ (posedge finish) begin
  `DISPLAY_1D_ARRAY(output_dim ,"output of RBM = ",  OutputData)
  // $display("Output of this RBM is %b", OutputDataPort);
  $finish;
end

endmodule
