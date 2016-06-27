`define TEST_BENCH
`include "../config.v"
`include "../Main.v"

`define ERR $display("ERROR")
`define STATE(x) $display("STATE: %s", x)

module test_Main_Real;
localparam h_weight_path = "../build/data/model/verilog/model_h_weight.txt";
localparam h_bias_path = "../build/data/model/verilog/model_h_bias.txt";
localparam c_weight_path = "../build/data/model/verilog/model_c_weight.txt";
localparam c_bias_path = "../build/data/model/verilog/model_c_bias.txt";
localparam input_image_path = "../build/data/mnist/verilog/mnist_testdata0.txt";
localparam h_ord_path = "../build/data/order/example/h_adder_ord_example.txt";

integer  iteration_num = 100;


integer i = 0, j = 0, iteration_id = 0, OutputData[9:0];

reg InputData`DIM_1D(784);
reg HiddenData`DIM_1D(441);
reg[11:0] HiddenWeight`DIM_2D(784, 441);
reg[11:0] HiddenBias`DIM_1D(441);
reg HiddenSwitch`DIM_1D(442);
reg[11:0] ClassiWeight`DIM_2D(441, 10);
reg[11:0] ClassiBias`DIM_1D(10);


reg [9:0] pixel_id = 0;
reg [8:0] hidden_id = 0, spike_id = 0;
reg [11:0] Hvalue, Cvalue;
reg  clock, my_clock, reset, enable_classi = 0, enable_hidden = 0, pixel, hidden_pixel;
wire hidden, hidden_finish, spike, finish;
//  HiddenWeight[pixel_id][hidden_id], HiddenBias[hidden_id]
//  ClassiWeight[hidden_id][spike_id], ClassiBias[spike_id]

Main main(reset, clock, Hvalue, pixel_id, pixel, HiddenSwitch[hidden_id],
    enable_hidden,
    enable_classi,
    Cvalue,
    hidden_id,
    hidden_pixel,
    hidden, hidden_finish,
    spike,  finish);
integer next_state;
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
  my_clock = 0;
  reset = 1;
  next_state = 0;
  #30 reset = 0;
  enable_hidden = 0;
  enable_classi = 0;
  for (i = 0; i<10; i=i+1)
    OutputData[i] = 0;
  $display("BEGIN");
end
always begin
  clock = !clock;
#10;
end


`DEFINE_PRINTING_VAR;
always @ ( posedge clock ) begin  // complex state machine



  // STATE: reset
  if (reset == 1) begin
    //`STATE("RESET");
    //do nothign
  end

  if (reset == 0) begin

    //STATE: Unreachable
    if (enable_hidden == 1 && enable_classi == 1) begin
      //`STATE("ERROR");
      $finish;
    end

    //STATE: Prepare to calculate next iteration
    if (enable_hidden == 0 && enable_classi == 0 && next_state == 0) begin
      // Prepare for inter cycle calculation
      // $display("STATE: PREPARE NEXT ITERATION %0d", iteration_id);
      pixel_id = 0;
      Hvalue = HiddenWeight[pixel_id][hidden_id];
      pixel = InputData[pixel_id];
      //Manage STATE transfer
      enable_hidden = 1;
      next_state = 1;
    end



    //STATE: Calculating current hidden
    if (enable_hidden == 1 && enable_classi == 0 && next_state == 0) begin
      pixel_id = pixel_id + 1;
      if (pixel_id < 784) begin
      // Prepare for inter cycle calculation
        pixel = InputData[pixel_id];
        Hvalue = HiddenWeight[pixel_id][hidden_id];
      end else if (pixel_id == 784) begin
      // Prepare for inter cycle calculation
        pixel = 1;
        Hvalue = HiddenBias[hidden_id];
      end else if(pixel_id == 785) begin
        HiddenData[hidden_id] = hidden;
        // $display("STATE: CALCULATED HIDDEN VALUE %0d = %0d", hidden_id, HiddenData[hidden_id]);
      // end else if (pixel_id == 786) begin
        if (hidden_id < 440) begin
        // Prepare for inter cycle calculation
          hidden_id = hidden_id + 1;
          pixel_id = 0; // again, set to zero, how to work around this
          pixel = InputData[pixel_id];
          Hvalue = HiddenWeight[pixel_id][hidden_id];
        end else if(hidden_id == 440) begin
          //Prepare for inter cycle calculation
          hidden_id = 0;
          hidden_pixel = HiddenData[hidden_id];
          // $display("%d", HiddenData[hidden_id]); // problem, X
          Cvalue = ClassiWeight[hidden_id][spike_id];
          // Mange STATE transfer
          enable_hidden = 0;
          enable_classi = 1;
        end
      end
      next_state = 1;
    end

    // STATE: Calculating current Spike
    if (enable_hidden == 0 && enable_classi == 1 && next_state == 0) begin
      hidden_id = hidden_id + 1;
      if (hidden_id < 441) begin
      // Prepare for inter cycle calculation
        hidden_pixel = HiddenData[hidden_id];
        Cvalue = ClassiWeight[hidden_id][spike_id];
      end else if (hidden_id == 441) begin
      // Prepare for inter cycle calculation
        hidden_pixel = 1;
        Cvalue = ClassiBias[spike_id];
      end else if (hidden_id == 442) begin
         OutputData[spike_id] = OutputData[spike_id] + spike;
        //  $display("STATE: CALCULATED SPIKE VALUE %0d = %0d", spike_id, OutputData[spike_id]);

      // end else if(hidden_id == 443) begin
         if (spike_id < 9) begin
         // Prepare for inter cycle calculation
          hidden_id = 0;
          spike_id = spike_id + 1;
          hidden_pixel = HiddenData[hidden_id];
          Cvalue = ClassiWeight[hidden_id][spike_id];
         end else if(spike_id == 9) begin
         // Prepare for inter cycle calculation
          spike_id = 0;
          hidden_id = 0;
          enable_hidden = 0;
          enable_classi = 0;

          iteration_id = iteration_id + 1;
          // $display("STATE: ITERATION %0d COMPLETED", iteration_id);
          // manage STATE transfer
          if (iteration_id == iteration_num) begin
            `STATE("FINISH");
            `DISPLAY_1D_ARRAY(10 ,"output of RBM = ",  OutputData)
            $finish;
          end
         end
      end
    end
    next_state = 1;
  end

  next_state = 0;
end



endmodule
