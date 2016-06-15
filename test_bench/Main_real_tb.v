`define TEST_BENCH
`include "../config.v"
`include "../Main.v"

// `timescale 1s/1s

module test_Main_Real;

localparam  output_dim = 10;  //10
localparam  bitlength = 16;
localparam  w_bitlength = 12;
localparam  clock_period = 10;
localparam  sigmoid_bitlength = 8;
localparam  general_input_dim = 784; //784
localparam  sparse_input_dim = 64 ;
localparam  hidden_dim = 441; //441
localparam   Inf = 12'b0111_1111_1111;
localparam h_weight_path = "../build/data/model/verilog/model_h_weight.txt";  // load a different weight for sparse case 64x441
localparam h_bias_path = "../build/data/model/verilog/model_h_bias.txt";
localparam h_seed_path = "../build/data/Hseed1x441.txt";
localparam c_weight_path = "../build/data/model/verilog/model_c_weight.txt";  // load a different weight for sparse case 64x441
localparam c_bias_path = "../build/data/model/verilog/model_c_bias.txt";
localparam c_seed_path = "../build/data/Cseed1x10.txt";
localparam input_image_path = "../build/data/mnist/verilog/mnist_testdata0.txt";
localparam h_ord_path = "../build/data/order/example/h_adder_ord_example.txt";
localparam c_ord_path = "../build/data/order/example/c_adder_ord_example.txt";
localparam hidden_adder_group_num = 1;
localparam cl_adder_group_num = 1;
localparam iteration_num = 2;

`ifndef SPARSE
localparam input_dim = general_input_dim;
`else
localparam input_dim = sparse_input_dim;
`endif


integer i = 0;
reg clock, reset, data_valid;
wire finish;
wire[w_bitlength-1:0] OutputData`DIM_1D(output_dim);
wire[`PORT_1D(output_dim, w_bitlength)] OutputDataPort;

reg InputData`DIM_1D(input_dim);
wire[`PORT_1D(input_dim, 1)] InputDataPort;

initial begin
  $dumpfile ("./dumpFolder/Main_test_mnist.vcd");
  $dumpvars;
  `ReadMem(input_image_path, InputData);
  clock = 0;
  reset = 0;
  data_valid = 0;
  #20 reset = 1;
  #30 reset = 0;
  #40 data_valid = 1;
end

`DEFINE_PACK_VAR;
`PACK_1D_ARRAY(input_dim, 1, InputData, InputDataPort)
`UNPACK_1D_ARRAY(output_dim, w_bitlength, OutputDataPort, OutputData)

Main #(bitlength,w_bitlength, sigmoid_bitlength, general_input_dim,
           sparse_input_dim, hidden_dim, output_dim, Inf,
           h_weight_path, h_bias_path, h_seed_path, h_ord_path, 
           c_weight_path, c_bias_path, c_seed_path, c_ord_path,
           hidden_adder_group_num, cl_adder_group_num, iteration_num)
           main(reset, clock, data_valid, InputDataPort, OutputDataPort, finish);


initial begin
  $display("BEGIN");
end

always begin
  clock = !clock;
  //check finish
#clock_period;
end

`DEFINE_PRINTING_VAR;
always @ (posedge finish) begin
  $display("FINISH");
  `DISPLAY_1D_ARRAY(output_dim ,"output of RBM = ",  OutputData)
  // $display("Output of this RBM is %b", OutputDataPort);
  $finish;
end

endmodule
