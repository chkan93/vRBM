

set link_library {"*"}
set target_library  {"tc6a_cbacore.db"}
define_design_lib WORK -path ./WORK


analyze -f verilog ../ap_adder.v
elaborate ap_adder


analyze -f verilog ../iadder_B16_1.v   ;# KEY:ANALYZE_IADDER
elaborate i_ap_adder


set tcl_interactive false


analyze -f verilog ../RandomGenerator.v
elaborate RandomGenerator


analyze -f verilog ../sigmoid.v
elaborate sigmoid

analyze -f verilog ../RBMLayer.v
elaborate RBMLayer

analyze -f verilog ../ClassiLayer.v
elaborate ClassiLayer

read_verilog ../Main.v

current_design Main
create_clock clock -p 10
link
saif_map -start 
report_clock
compile
#######################################
set saiffiles [glob 2/*.saif] ;# KEY:IADDER_FOLDER


foreach f $saiffiles {
   reset_switching_activity
   puts -nonewline "# Analyzing $f ... " 
   read_saif -input  $f  -instance_name test_Main_Real/main 
   set fbasename [file rootname [file tail $f]]
report_power > 3/$fbasename.txt ; # KEY:REPORT_POWER
   puts "Finished"
}


exit




