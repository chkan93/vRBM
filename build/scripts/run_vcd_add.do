vcd file ./dumpFolder/Main_test_mnist.vcd
vcd add test_Main_Real/main/rbm/temp test_Main_Real/main/rbm/rnd/shiftReg 
vcd add test_Main_Real/main/classi/temp test_Main_Real/main/classi/rnd/shiftReg


vcd add test_Main_Real/main/reset test_Main_Real/main/clock test_Main_Real/main/Hvalue test_Main_Real/main/pixel_id test_Main_Real/main/pixel test_Main_Real/main/adder_type test_Main_Real/main/enable_hidden test_Main_Real/main/enable_classi test_Main_Real/main/Cvalue test_Main_Real/main/hidden_pixel test_Main_Real/main/hidden_id test_Main_Real/main/hidden test_Main_Real/main/hidden_finish  test_Main_Real/main/spike  test_Main_Real/main/finish 



run -all
