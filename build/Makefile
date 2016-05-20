OBGEN = python ./scripts/generate_random_data.py
GEN_MATLAB = python ./scripts/generate_matlab_data.py

prepare:
	mkdir -p output

randomNumber1x5_Seed:
	$(GEN) ./data/seed 5 5

randomRBMData:
	$(GEN)  ./data/image    1   15
	$(GEN)  ./data/Hweight  12  15*5
	$(GEN)  ./data/Hbias    12  5
	$(GEN)  ./data/Cweight  12  5*2
	$(GEN)  ./data/Cbias    12  2


generate_matlab_data:
	rm -rf ./data/mnist/verilog/* $@
	rm -rf ./data/model/verilog/* $@
	echo "Generating Mnist Test Data to verilog format." $@
	$(GEN_MATLAB)  ./data/mnist/matlab/data.mat mnist  ./data/mnist/verilog/ 4  && echo "Finished" || echo "Error Occured" $@
	echo "Generating RBM Model Data to verilog format." $@
	$(GEN_MATLAB)  ./data/model/matlab/data.mat  mnist_rbm_model  ./data/model/verilog/ 4 && echo "Finished" || echo "Error Occured" $@





sigmoid_TB: prepare
	iverilog -o ./output/design_sigmoid_TB ../test_bench/sigmoid_tb.v
	vvp ./output/design_sigmoid_TB


RandomGenerator_TB: prepare
	iverilog -o ./output/design_RandomGenerator_TB   ../test_bench/RandomGenerator_tb.v
	vvp ./output/design_RandomGenerator_TB


MatrixMul_TB: prepare
	iverilog -o ./output/design_MatrixMul_TB   ../test_bench/MatrixMul_tb.v
	vvp ./output/design_MatrixMul_TB



MatrixAdd_TB: prepare
	iverilog -o ./output/design_MatrixAdd_TB   ../test_bench/MatrixAdd_tb.v
	vvp ./output/design_MatrixAdd_TB


Main_TB: prepare
	iverilog -o ./output/design_Main_TB ../test_bench/Main_tb.v
	vvp ./output/design_Main_TB


RBMLayer_TB: prepare
	iverilog -o ./output/design_RBMLayer_TB ../test_bench/RBMLayer_tb.v
	vvp ./output/design_RBMLayer_TB

ClassifyLayer_TB: prepare
	iverilog -o ./output/design_ClassifyLayer_TB ../test_bench/ClassifyLayer_tb.v
	vvp ./output/design_ClassifyLayer_TB

Main_wave:
	gtkwave ./dumpFolder/Main.vcd &


Main_syth:
	yosys  -Q -T -s ./scripts/generate_main_netlist.tcl


Main_real_TB: prepare
	iverilog -o ./output/design_Main_Real_TB ../test_bench/Main_Real_tb.v
	vvp ./output/design_Main_Real_TB


vlib: 
	vlib work


vsim_Main_TB: vlib
	vlog  ../test_bench/Main_tb.v
	vsim -c -do "run -all" test_Main

vsim_Main_Real_TB: vlib
	vlog ../test_bench/Main_Real_tb.v
	vsim -c  -do "run -all" test_Real_Main

vsim_RandomGenerator_TB: vlib
	vlog ../test_bench/RandomGenerator_tb.v
	vsim -c  -do "run -all" test_RandomGenerator

vsim_sigmoid_TB: vlib
	vlog ../test_bench/sigmoid_tb.v
	vsim -c -do "run -all" test_sigmoid

vsim_RBMLayer_TB: vlib
	vlog ../test_bench/RBMLayer_tb.v
	vsim -c -do "run -all" test_RBMLayer

vsim_MatrixAdd_TB: vlib
	vlog ../test_bench/MatrixAdd_tb.v
	vsim -c -do "run -all" test_MatrixAdd

vsim_MatrixMul_TB: vlib
	vlog ../test_bench/MatrixMul_tb.v
	vsim -c -do "run -all" test_MatrixMul



load_modules:
	module load dc-2015.06-SP4 #dc_shell
	module load modelsim #vsim
	module load primetime-64