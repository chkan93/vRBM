GEN = python ./scripts/generate_random_data.py
GEN_MATLAB = python ./scripts/generate_matlab_data.py

prepare:
	mkdir -p output dumpFolder

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


generate_matlab_data_mnist:
	rm -rf ./data/nmist/verilog/* $@
	rm -rf ./data/model/verilog/* $@
	echo "Generating Mnist Test Data to verilog format." $@
	$(GEN_MATLAB)  ./data/mnist/matlab/data.mat mnist  ./data/mnist/verilog/ 8  12 && echo "Finished" || echo "Error Occured" $@

generate_matlab_data_model:
	rm -rf ./data/nmist/verilog/* $@
	rm -rf ./data/model/verilog/* $@
	python ./scripts/generate_matlab_data_new.py  ./data/model/matlab/   ./data/model/verilog/   12


generate_matlab_data: generate_matlab_data_model generate_matlab_data_mnist

generate_matlab_random_number:
	python ./scripts/transform_random_number_to_mat.py   ./data/random/1000.log    ./data/random/1000.mat    1000

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



Main_test_mnist: prepare
	iverilog -o ./output/design_Main_test_mnist_TB   ../test_bench/Main_real_tb.v
	vvp ./output/design_Main_test_mnist_TB


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


run_Main: vlib 
	vlog  ../test_bench/Main_real_tb.v
	vsim -c -do "run -all" test_Main_Real

run_Main_dump: vlib
	vlog  ../test_bench/Main_real_tb.v
	vsim -c -do "vcd file ./dumpFolder/Main_test_mnist.vcd; vcd add test_Main_Real/main/rbm/temp test_Main_Real/main/rbm/rnd/shiftReg test_Main_Real/main/classi/temp test_Main_Real/main/classi/rnd/shiftReg; run -all;" test_Main_Real

# run_Main_dump_2: vlib
# 	vlog ../test_bench/Main_real_tb.v
# 	vsim -c -do ./scripts/run_vcd_add.do  test_Main_Real


run_Main_dump_all: vlib
	vlog ../test_bench/Main_real_tb.v
	vsim -c -do "vcd file ./dumpFolder/Main_test_mnist.vcd; vcd add -r *; run -all;" test_Main_Real


debug_Main: vlib
	vlog ../test_bench/Main_real_tb.v
	vsim  test_Main_Real



run_mnist_test:
	python ./scripts/run_mnist_test.py  2 30  5,100  IADDER


run_mnist_test_all:
	echo "Simulation Begin"
	python ./scripts/run_mnist_test.py 50 100 5,100  ETAIIM
	python ./scripts/run_mnist_test.py 50 100 5,300  ETAIIM
	python ./scripts/run_mnist_test.py 50 100 1,300  ETAIIM
	python ./scripts/run_mnist_test.py 50 100 5,300  ZHU


run_generate_saif_all:
	echo "Not Implemented Yet"

run_generate_saif_test:
	python ./scripts/generate_saif.py  --iteration 30  --adder_type ETAIIM,ZHU  --critical_scheme 1,5  --critical_num 100,300

run_generate_saif_test2:
	python ./scripts/generate_saif.py  --iteration 30  --adder_type ETAIIM,ZHU  --critical_scheme 1  --critical_num 100


run_synthesis:
	dc_shell -tcl_mode -f ./scripts/synthesis.tcl
