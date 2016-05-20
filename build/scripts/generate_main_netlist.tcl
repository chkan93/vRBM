## read Design
read_verilog ../Main.v

# generic synthesis
# synth -top Main


# mapping to mycells.lib
# dfflibmap -liberty mycells.lib
# abc -liberty mycells.lib
# clean


# write synthesized design
# write_verilog ./output/Main_synth.v
