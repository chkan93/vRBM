GEN = python ./scripts/generate_random_data.py
GEN_MATLAB = python ./scripts/generate_matlab_data.py

prepare:
	mkdir -p output

randomSeed:
	$(GEN) ./data/Hseed 8 441
	$(GEN) ./data/Cseed 8 10

randomRBMData:
	$(GEN)  ./data/image    1   4
	$(GEN)  ./data/Hweight  8  4*3
	$(GEN) ./data/Hseed     8  3
	$(GEN) ./data/Cseed     8  2
	$(GEN)  ./data/Hbias    8  3
	$(GEN)  ./data/Cweight  8  3*2
	$(GEN)  ./data/Cbias    8  2


generate_matlab_data:
	rm -rf ./data/nmist/verilog/* $@
	rm -rf ./data/model/verilog/* $@
	echo "Generating Mnist Test Data to verilog format." $@
	$(GEN_MATLAB)  ./data/mnist/matlab/data.mat mnist  ./data/mnist/verilog/ 8  12 && echo "Finished" || echo "Error Occured" $@
	echo "Generating RBM Model Data to verilog format." $@
	$(GEN_MATLAB)  ./data/model/matlab/data.mat  mnist_rbm_model  ./data/model/verilog/ 8 12 && echo "Finished" || echo "Error Occured" $@





load_modules:
	module load dc-2015.06-SP4 #dc_shell
	module load modelsim #vsim
	module load primetime-64



## ======================================================= New ================================================================= ##

ap_adder_TB: prepare
	iverilog -o ./output/ap_adder_TB ../test_bench/ap_adder_tb.v
	vvp ./output/ap_adder_TB


sigmoid_TB: prepare
	iverilog -o ./output/design_sigmoid_TB ../test_bench/sigmoid_tb.v
	vvp ./output/design_sigmoid_TB


RandomGenerator_TB: prepare
	iverilog -o ./output/design_RandomGenerator_TB   ../test_bench/RandomGenerator_tb.v
	vvp ./output/design_RandomGenerator_TB




Main_test_runnable: prepare
	iverilog -o ./output/design_Main_test_runnable_TB   ../test_bench/Main_tb.v
	vvp ./output/design_Main_test_runnable_TB

vlib:
	vlib work

vsim_ap_adder: vlib
	vlog ../test_bench/ap_adder_tb.v
	vsim -c -do "run -all" ap_adder_tb

vsim_sigmoid: vlib
	vlog ../test_bench/sigmoid_tb.v
	vsim -c -do "run -all" test_sigmoid

vsim_random: vlib
	vlog  ../test_bench/RandomGenerator_tb.v
	vsim -c -do "run -all" test_RandomGenerator

vsim_Main_test_runnable: vlib
	vlog  ../test_bench/Main_tb.v
	vsim -c -do "run -all" test_Main

vsim_Main_test_mnist: vlib
	vlog  ../test_bench/Main_real_tb.v
	vsim -c -do "run -all" test_Main_Real


run_mnist_test:
	python ./scripts/run_mnist_test.py  20 40

run_synthesis:
	dc_shell -tcl_mode -f ./scripts/synthesis.tcl
