`ifndef  TEST_BENCH
	`include "config.v"
  `include "RBMLayer_new.v"
`else
  `include "../RBMLayer_new.v"
`endif


module Main_new #(parameter integer bitlength = 12,
                  parameter integer sigmoid_bitlength = 8,
                  parameter integer input_dim = 15,
                  parameter integer sparse_input_dim = 64,
                  parameter integer hidden_dim = 5,
                  parameter integer output_dim = 2,
                  parameter h_weight_path = "../build/data/Hweight15x5.txt",  // load a different weight for sparse case 64x441
                  parameter h_bias_path = "../build/data/Hbias1x5.txt",
                  parameter h_seed_path = "../build/data/Hseed1x5.txt",
                  parameter c_weight_path = "../build/data/Cweight5x2.txt",  // load a different weight for sparse case 64x441
                  parameter c_bias_path = "../build/data/Cbias1x2.txt"
                  ) ();



endmodule
