set link_library {"*"}
set target_library  {"tc6a_cbacore.db"}
define_design_lib WORK -path ./WORK

# ap_adder.v is fixed
#  - use $signed()
#  - don't need to change parameter, use default
analyze -f verilog ../ap_adder.v 
elaborate ap_adder

analyze -f verilog ../i_ap_adder.v
elaborate i_ap_adder

# RandomGenerator.v is fixed
#  - use same and one always block
#  - don't need to change parameter, use default
analyze -f verilog ../RandomGenerator.v
elaborate RandomGenerator

# sigmoid.v has no error.
analyze -f verilog ../sigmoid.v
elaborate sigmoid
# RBMLayer.v is fixed
#  - add translate guard to initial block
#  - change integer to reg
#  - add name to generate block
#  - merge into one always block, one if block.
#  - loop variable to static
#  - **remaining problems: 
#    - type conversion signed to unsigned, line 90, 130
#    - Net SeedData is reg and connected to instance, but not driven by an always block. 
analyze -f verilog ../RBMLayer.v
elaborate RBMLayer

# Main.v is fixed
#  - combine the always block
#  - remove {negedge reset} block
read_verilog ../Main.v

#######################################
current_design Main

# Link
# Warning: Unable to resolve reference 'RBMLayer' in 'Main'. (LINK-5)
# Warning: Unable to resolve reference 'ap_adder' in 'Main'. (LINK-5)
link

# Create Clock
create_clock clock -p 10
report_clock

# Compile
compile



# exit
