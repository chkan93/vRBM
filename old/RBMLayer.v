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


`ifndef RBMLayer
`define RBMLayer

module RBMLayer
#(parameter  input_bitlength = 12,
	parameter  sg_bitlength = 8,
	parameter  output_bitlength = 12,
	parameter  in_dim = 6,
	parameter  out_dim = 5,
	parameter  random_seed_file = "./data/seed1x5.txt"
)
(
  input clock,
	input reset,
  input wire [`PORT_1D(in_dim, input_bitlength)] ImageI,
  input wire signed[`PORT_2D(in_dim, out_dim, input_bitlength)] WeightI,
  input wire signed[`PORT_1D(out_dim, input_bitlength)] BiasI,
  output signed[`PORT_1D(out_dim, output_bitlength)] HoutputO
  );

  wire[`PORT_1D(out_dim, input_bitlength)] temp_mul;
  wire[`PORT_1D(out_dim, input_bitlength)] temp_add;



  MatrixMul #(input_bitlength, 1, in_dim, out_dim) mm(ImageI, WeightI, temp_mul); // V * W
  MatrixAdd #(input_bitlength, 1, out_dim) ma(temp_mul, BiasI, temp_add); // V * W + b
	wire[input_bitlength-1:0] temp`DIM_1D(out_dim);
	reg[output_bitlength-1:0] Houtput`DIM_1D(out_dim);
  `DEFINE_PACK_VAR;
  `UNPACK_1D_ARRAY( out_dim, input_bitlength, temp_add, temp) //temp[i]
	`PACK_1D_ARRAY( out_dim, output_bitlength, Houtput, HoutputO)


	wire[sg_bitlength-1:0] sg_output`DIM_1D(out_dim);

  genvar i;
  generate
    for(i=0;i<out_dim;i=i+1) begin
			sigmoid #(input_bitlength,sg_bitlength) sg(temp[i], sg_output[i]);
    end
  endgenerate


	wire[sg_bitlength-1:0] random_vector`DIM_1D(out_dim);
	reg[sg_bitlength-1:0]  seed`DIM_1D(out_dim);
	wire[7:0] rvalue;

	generate
		for(i=0;i<out_dim;i=i+1) begin
			RandomGenerator #(sg_bitlength) rnd(reset, clock, seed[i], random_vector[i]);
		end
	endgenerate



	integer ci;
	always @(posedge clock)
	begin
		for(ci=0;ci<out_dim;ci=ci+1) begin
			if(sg_output[ci] > random_vector[ci])
				Houtput[ci] <= 1;
			else
			  Houtput[ci] <= 0;
		end
	end

`DEFINE_READMEM_VAR;
initial begin
	`ReadMem(random_seed_file, seed);
end

  // 1. matrix Multiplication         [x]
  // 2. Add Bias                      [x]
  // 3. go to sigmoid                 [x]
  // 3. compare with RandomGenerator  []
  // 4. output result                 []



endmodule

`endif
/*
目前计算是8bit计算， 如何输入到12bit的sigmoid里面？ 难道是每个都要扩bit？ 还是说加法和乘法需要用12bit，考虑到8bit的溢出？

sigmoid 用了reg output, 是否是必须？ 换成wire是不是也可以， 只有randomgenerator必须是reg好像

因为randomgenerator的特性， 1x441个random number都是一样的，这个是不是不好呀


*/
