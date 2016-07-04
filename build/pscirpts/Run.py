from Pf import *
from Tasks import *
from Util import *

Register('copy_root_to', copy_root_to)
Register('cd_to', cd_to)
Register('run_setup', run_setup)
Register('copy_result_to', copy_result_back_to)



adders =  ["iadder_B16_{0}.v".format(a) for a in ["ETAIIM", "ZHU"]]
critical = [(t, r) for t in range(1, 7) for r in range(1, 442, 80)]
critical = [critical[x:x+6] for x in range(0, len(critical), 6)]
iterations = 100
image_num = 50

TMP = '/home/xy0/Workspace/modelsim/tmp'
DEST = '/home/xy0/Workspace/modelsim/dist'
FROM = '/home/xy0/Workspace/modelsim/vRBM'
VCD = 'Main_test_mnist.vcd'

for add in adders:
    for ct in critical:
        AddTask(random_string(), [["copy_root_to", {'from':FROM, 'to_home':TMP}],
                                  ["cd_to", {'relative':'build'}],
                                  ["run_setup", {'dump_path':'dumpFolder',
                                                 'vcd_path':VCD,
                                                 'iteration':iterations,
                                                 'image_num':image_num,
                                                 'adder':add,
                                                 'critical':ct}],
                                  ["copy_result_to", {'to': DEST}]])

Run()