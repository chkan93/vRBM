GEN = python ./scripts/generate_random_data.py

prepare:
	mkdir -p output

randomNumber1x5_Seed:
	$(GEN) ./data/seed 8 5

randomRBMData:
	$(GEN)  ./data/image    1   15
	$(GEN)  ./data/Hweight  12  15*5
	$(GEN)  ./data/Hbias    12  5
	$(GEN)  ./data/Cweight  12  5*2
	$(GEN)  ./data/Cbias    12  2



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


all_TB: sigmoid_TB MatrixAdd_TB MatrixMul_TB RandomGenerator_TB
