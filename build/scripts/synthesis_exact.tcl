set link_library {"*"}
set target_library  {"tc6a_cbacore.db"}
define_design_lib WORK -path ./WORK


analyze -f verilog ../ap_adder.v
elaborate ap_adder

analyze -f verilog ../i_ap_adder.v
elaborate i_ap_adder


analyze -f verilog ../RandomGenerator.v
elaborate RandomGenerator


analyze -f verilog ../sigmoid.v
elaborate sigmoid

analyze -f verilog ../RBMLayer.v
elaborate RBMLayer

analyze -f verilog ../ClassiLayer.v
elaborate ClassiLayer

read_verilog ../Main.v

#######################################
current_design Main

create_clock clock -p 10

link

saif_map -start 

report_clock

compile




# read_saif -input ./data/SAIF/EXACT.saif   -instance_name test_Main_Real/main
read_saif -input ./data/SAIF/EXACT_without_clock_mask.saif   -instance_name test_Main_Real/main

change_names -rules verilog -hierarchy -verbose

write -format verilog -hierarchy  -output ./data/Netlist/EXACT_without_clock_mask.v

write_saif -output  ./data/SAIF/EXACT_without_clock_mask.from_dc.saif

report_power > ./data/log/report_power_dcshell_EXACT_without_clock_mask.log

report_area > ./data/log/report_area_EXACT_without_clock_mask.log

report_power



