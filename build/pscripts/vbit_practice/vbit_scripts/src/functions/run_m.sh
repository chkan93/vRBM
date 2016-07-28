# core utility
function run_m(){
	local p="$(pwd)"
	cd $VBIT_MATLAB_PATH
	matlab -nodisplay -nodesktop -r "run $1"
	cd $p
}


## usage
function generate_model_weight_on_bit(){
	local bit_b=$1
	local bit_a=$2
	local target_m=$VBIT_MATLAB_PATH/export_model_to_file.m
	replace_in_file $target_m $MATLAB_BEFORE_DECIMAL   $bit_b
	replace_in_file $target_m $MATLAB_AFTER_DECIMAL   $bit_a
	run_m $target_m
}