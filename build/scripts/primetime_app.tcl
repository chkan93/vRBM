
set power_enable_analysis true
set power_analysis_mode "averaged" 

set search_path ". /software/nonrdist64/dc-2015.06-SP4/libraries/syn /software/nonrdist64/dc-2015.06-SP4/minpower/syn /software/nonrdist64/dc-2015.06-SP4/dw/syn_ver /software/nonrdist64/dc-2015.06-SP4/dw/sim_ver /software/nonrdist64/primetime/minpower/syn /software/nonrdist64/primetime/libraries/syn"
 
set target_library "tc6a_cbacore.db" 
set link_path "* $target_library" 

read_verilog ./data/Netlist/APP_without_clock_mask.v
current_design Main
link

read_saif  ./data/SAIF/APP_without_clock_mask.from_dc.saif  -strip_path  Main


report_power > ./data/log/report_power_primetime_app_without_clock_mask.log

report_power