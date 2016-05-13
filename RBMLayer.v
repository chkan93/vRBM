`ifndef  TEST_BENCH
	`include "config.v"
  `include "MatrixMul.v"
  `include "MatrixAdd.v"
  `include "sigmoid.v"
  `include "RandomGenerator.v"
`else
  `include "../MatrixMul.v"
  `include "../MatrixAdd.v"
  `include "../sigmoid.v"
  `include "../RandomGenerator.v"
`endif



`define IN `RBM_INPUT_DIMENSION  //784
`define OUT `RBM_OUTPUT_DIMENSION //441

module RBMLayer(
  input clock,
  input wire[`PORT_1D(`IN, `BITN)] ImageI,
  input wire[`PORT_2D(`IN, `OUT, `BITN)] WeightI,
  input wire[`PORT_1D(`OUT, `BITN)] BiasI,
  output reg[`PORT_1D(`OUT, `BITN)] HoutputO
  );

  wire[`PORT_1D(`OUT, `BITN)] temp_mul;
  wire[`PORT_1D(`OUT, `BITN)] temp_add;


  // wire[`BITN_RANGE] Image[1:`IN];
  // wire[`BITN_RANGE] Weight[1:`IN][1:`OUT];
  // wire[`BITN_RANGE] Bias[1:`OUT];
  // wire[`BITN_RANGE] Houtput[1:`OUT];
  //
  // `DEFINE_PACK_VAR;
  // `UNPACK_2D_ARRAY(`IN, `OUT, `BITN, WeightI, Weight)
  // `UNPACK_1D_ARRAY(`IN, `BITN, ImageI, Image)
  // `UNPACK_1D_ARRAY(`OUT, `BITN, BiasI, Bias)
  // `PACK_1D_ARRAY(`OUT, `BITN, Houtput, HoutputO)


  MatrixMul mm(ImageI, WeightI, temp_mul); // V * W
  MatrixAdd ma(temp_mul, BiasI, temp_add); // V * W + b
	wire[`BITN_RANGE] temp[1:`OUT], Houtput[1:`OUT];
  `DEFINE_PACK_VAR;
  `UNPACK_1D_ARRAY( `OUT, `BITN, temp_add, temp) //temp[i]

	reg[`SIGMOID_OUTPUT_BITN-1:0] sg_output[1:`OUT];

  genvar i;
  generate
    for(i=1;i<`OUT;i=i+1) begin
			sigmoid sg(temp[i], sg_output[i]);
    end
  endgenerate

	
	always @(posedge clock)
	begin
	// statements
	end



  // 1. matrix Multiplication         [x]
  // 2. Add Bias                      [x]
  // 3. go to sigmoid                 [x]
  // 3. compare with RandomGenerator  []
  // 4. output result                 []



endmodule


/*
目前计算是8bit计算， 如何输入到12bit的sigmoid里面？ 难道是每个都要扩bit？ 还是说加法和乘法需要用12bit，考虑到8bit的溢出？

sigmoid 用了reg output, 是否是必须？ 换成wire是不是也可以， 只有randomgenerator必须是reg好像

因为randomgenerator的特性， 1x441个random number都是一样的，这个是不是不好呀


*/
