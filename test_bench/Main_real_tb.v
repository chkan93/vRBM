`define TEST_BENCH
`include "../config.v"
`include "../Main.v"



module test_Main_Real;
localparam h_weight_path = "../build/data/model/verilog/model_h_weight.txt";
localparam h_bias_path = "../build/data/model/verilog/model_h_bias.txt";
localparam c_weight_path = "../build/data/model/verilog/model_c_weight.txt";
localparam c_bias_path = "../build/data/model/verilog/model_c_bias.txt";
localparam input_image_path = "../build/data/mnist/verilog/mnist_testdata0.txt";
localparam h_ord_path = "../build/data/order/example/h_adder_ord_example.txt";

integer i = 0, j = 0, iteration_num = 100, interation_id = 0, OutputData[9:0];

reg InputData`DIM_1D(784);
reg HiddenData`DIM_1D(441);
reg[11:0] HiddenWeight`DIM_2D(784, 441);
reg[11:0] HiddenBias`DIM_1D(441);
reg HiddenSwitch`DIM_1D(441);
reg[11:0] ClassiWeight`DIM_2D(441, 10);
reg[11:0] ClassiBias`DIM_1D(10);


reg [9:0] pixel_id = 0;
reg [8:0] hidden_id = 0, spike_id = 0;
reg [11:0] Hvalue, Cvalue;
reg  clock, reset, enable_classi = 0, enable_hidden = 0, pixel, hidden_pixel;
wire hidden, hidden_finish, spike, finish;
//  HiddenWeight[pixel_id][hidden_id], HiddenBias[hidden_id]
//  ClassiWeight[hidden_id][spike_id], ClassiBias[spike_id]

Main main(reset, clock, Hvalue, pixel_id, pixel, HiddenSwitch[pixel_id],
    enable_hidden,
    enable_classi,
    Cvalue,
    hidden_id,
    hidden_pixel,
    hidden, hidden_finish,
    spike,  finish);

initial begin
  $dumpfile ("./dumpFolder/Main_test_mnist.vcd");
  $dumpvars;
  `ReadMem(h_weight_path, HiddenWeight);
  `ReadMem(h_bias_path, HiddenBias);
  `ReadMem(h_ord_path, HiddenSwitch);
  `ReadMem(c_weight_path, ClassiWeight);
  `ReadMem(c_bias_path, ClassiBias);
  `ReadMem(input_image_path, InputData);
  clock = 0;
  reset = 1;
  #30 reset = 0;
  enable_hidden = 1;
  enable_classi = 0;
  $display("BEGIN");
end
always begin
  clock = !clock;
#10;
end
`DEFINE_PRINTING_VAR;
always @ ( posedge clock ) begin  // complex state machine
  // if all interation finish
  if (interation_id == iteration_num) begin
    $display("FINISH");
    `DISPLAY_1D_ARRAY(10 ,"output of RBM = ",  OutputData)
    $finish;
  end

  if (enable_classi == 0) begin
    // calculation in the hidden layer
    if (hidden_finish && hidden_id == 441) begin
      // all hiddens are finished, disable hidden layer, enable classify layer
      enable_classi = 1;
      enable_hidden = 0;
      pixel_id = 0;
      hidden_id = 0;
    end else if(hidden_finish) begin
      //finish this hidden value, reset pixel_id, and increase hidden_id
      HiddenData[hidden_id] = hidden;
      pixel_id = 0;
      hidden_id = hidden_id + 1;
    end else begin
      // calculate current hidden value
      if (pixel_id < 784) begin
        pixel = InputData[pixel_id];
        Hvalue = HiddenWeight[pixel_id][hidden_id];
      end else begin
        pixel = 1;
        Hvalue = HiddenBias[hidden_id];
      end
      pixel_id = pixel_id + 1;
    end
  end else begin
    // calculation in the classify layer
      if (finish && spike_id == 10) begin
        // all spikes are finished, prepare for next iteration;
         interation_id = interation_id + 1;
         enable_classi = 0;
         enable_hidden = 1;
         hidden_id = 0;
         spike_id = 0;
      end else if (finish) begin
         OutputData[spike_id] = OutputData[spike_id] + spike;
         hidden_id = 0;
         spike_id = spike_id + 1;
      end else begin
        if (hidden_id < 441) begin
          hidden_pixel = HiddenData[hidden_id];
          Cvalue = ClassiWeight[hidden_id][spike_id];
        end else begin
          hidden_pixel = 1;
          Cvalue = ClassiBias[spike_id];
        end
        hidden_id = hidden_id + 1;
      end
  end
end



endmodule
