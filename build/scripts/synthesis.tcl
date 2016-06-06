set link_library {"*"}
set target_library  {"tc6a_cbacore.db"}

# ap_adder.v is fixed
#  - use $signed()
#  - don't need to change parameter, use default
# read_verilog ../ap_adder.v

# RandomGenerator.v is fixed
#  - use same and one always block
#  - don't need to change parameter, use default
# read_verilog ../RandomGenerator.v

# sigmoid.v has no error.
# read_verilog ../sigmoid.v

# RBMLayer.v is fixed
#  - add translate guard to initial block
#  - change integer to reg
#  - add name to generate block
#  - merge into one always block, one if block.
#  - loop variable to static
#  - **remaining problems: 
#    - type conversion signed to unsigned, line 90, 130
#    - Net SeedData is reg and connected to instance, but not driven by an always block. 
# read_verilog ../RBMLayer.v

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
# compile



# exit
