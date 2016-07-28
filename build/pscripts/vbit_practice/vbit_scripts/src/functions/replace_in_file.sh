# core untility

function replace_in_file(){
	local f = $1
	local os = $2
	local ns = $3
	perl -pi -e "s/$os/$ns/g" $f
}


# extended usage utility

function generate_sources_on_bit(){
	local bits = $1;
	local sgmd_file = $VBIT_TEMPLATES_PATH/sigmoid.v
	local rand_file = $VBIT_TEMPLATES_PATH/RandomGenerator.v
	local adder_file = $VBIT_TEMPLATES_PATH/ap_adder.v
	#sigmoid
	replace_in_file $sgmd_file 1 2


	#random_generator
	replace_in_file $rand_file 1 2


	#adder_file
	replace_in_file $adder_file 1 2


}


