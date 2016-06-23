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
localparam iteration_num = 100;

`ifndef SPARSE
localparam input_dim = general_input_dim;
`else
localparam input_dim = sparse_input_dim;
`endif


integer i = 0;
integer j = 0;
reg clock, reset, data_valid;
wire finish;
wire[w_bitlength-1:0] OutputData`DIM_1D(output_dim);
wire[`PORT_1D(output_dim, w_bitlength)] OutputDataPort;

reg InputData`DIM_1D(input_dim);
wire[`PORT_1D(input_dim, 1)] InputDataPort;
 

reg[w_bitlength-1:0] HiddenWeight`DIM_2D(general_input_dim, hidden_dim);
reg [`PORT_2D(general_input_dim, hidden_dim, w_bitlength)] HiddenWeightPort;


reg[w_bitlength-1:0] HiddenBias`DIM_1D(hidden_dim);
reg [`PORT_1D(hidden_dim, w_bitlength)] HiddenBiasPort;

reg HiddenSwitch`DIM_1D(hidden_dim);
reg [`PORT_1D(hidden_dim, 1)] HiddenSwitchPort;

reg[w_bitlength-1:0] ClassiWeight`DIM_2D(hidden_dim, output_dim);
reg [`PORT_2D(hidden_dim, output_dim, w_bitlength)] ClassiWeightPort;

reg[w_bitlength-1:0] ClassiBias`DIM_1D(output_dim);
reg [`PORT_1D(output_dim, w_bitlength)] ClassiBiasPort;

reg ClassiSwitch`DIM_1D(output_dim);
reg [`PORT_1D(output_dim, 1)] ClassiSwitchPort;


initial begin
  // $dumpfile ("./dumpFolder/Main_test_mnist.vcd");
  // $dumpvars;
  `ReadMem(h_weight_path, HiddenWeight);
  `ReadMem(h_bias_path, HiddenBias);
  `ReadMem(h_ord_path, HiddenSwitch);
  `ReadMem(c_weight_path, ClassiWeight);
  `ReadMem(c_bias_path, ClassiBias);
  `ReadMem(c_ord_path, ClassiSwitch);
  `ReadMem(input_image_path, InputData);

  for(i = 0; i < input_dim; i=i+1)  
    for(j = 0; j < hidden_dim; j=j+1)
      `GET_2D(HiddenWeightPort, hidden_dim, w_bitlength, i, j) = HiddenWeight[i][j];

  for(i = 0; i < hidden_dim; i=i+1) begin 
      `GET_1D(HiddenBiasPort, w_bitlength, i) = HiddenBias[i];
      `GET_1D(HiddenSwitchPort, 1, i) = HiddenSwitch[i];
  end

  for(i = 0; i < hidden_dim; i=i+1)  
    for(j = 0; j < output_dim; j=j+1)
      `GET_2D(ClassiWeightPort, output_dim, w_bitlength, i, j) = ClassiWeight[i][j];

  for(i = 0; i < output_dim; i=i+1) begin 
      `GET_1D(ClassiBiasPort, w_bitlength, i) = ClassiBias[i];
      `GET_1D(ClassiSwitchPort, 1, i) = ClassiSwitch[i];
  end


  clock = 0;
  reset = 0;
  data_valid = 0;
  #20 reset = 1;
  #30 reset = 0;
  #40 data_valid = 1;
end

`DEFINE_PACK_VAR;
`PACK_1D_ARRAY(input_dim, 1, InputData, InputDataPort)

// `PACK_2D_ARRAY(input_dim, hidden_dim, w_bitlength, HiddenWeight, HiddenWeightPort)
// `PACK_1D_ARRAY(hidden_dim, w_bitlength, HiddenBias, HiddenBiasPort)
// `PACK_1D_ARRAY(hidden_dim, 1, HiddenSwitch, HiddenSwitchPort)

// `PACK_2D_ARRAY(hidden_dim, output_dim, w_bitlength, ClassiWeight, ClassiWeightPort)
// `PACK_1D_ARRAY(output_dim, w_bitlength, ClassiBias, ClassiBiasPort)
// `PACK_1D_ARRAY(output_dim, 1, ClassiSwitch, ClassiSwitchPort)

`UNPACK_1D_ARRAY(output_dim, w_bitlength, OutputDataPort, OutputData)




Main  main(reset, clock, data_valid,
                HiddenWeightPort, HiddenBiasPort, HiddenSwitchPort,
                ClassiWeightPort, ClassiBiasPort, ClassiSwitchPort,
               InputDataPort, OutputDataPort, finish);


initial begin
  $display("BEGIN");
end

always begin
  clock = !clock;
#clock_period;
end

`DEFINE_PRINTING_VAR;
always @ (posedge finish) begin
  $display("FINISH");
  `DISPLAY_1D_ARRAY(output_dim ,"output of RBM = ",  OutputData)
  $finish;
end

endmodule
