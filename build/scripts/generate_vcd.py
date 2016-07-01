from __future__ import print_function
import os, gzip, argparse
from scipy.io import loadmat
from easydict import EasyDict as edict
from os.path import abspath, join
import fileinput
from subprocess import call
import re
import KEY

ROOT = abspath('../')
CRITICAL_MAT = join(ROOT, 'build/data/order/criticality.mat')
OUTPUT_FOLDER = join(ROOT, 'build/dumpFolder')
DUMP_FILE = join(OUTPUT_FOLDER, 'Main_test_mnist.vcd')
global TOTAL, CURRENT
TOTAL = 1
CURRENT = 1



def getDetection(r):
    idx = r.find('output of RBM')
    s = r[idx:idx+70]
    numlist = re.findall(r'\d+', s)
    numlist = [int(n) for n in numlist]
    label = numlist.index(max(numlist))
    return label+1,numlist

def make_dump_name(it, adder, ct):
    return "iter{0}_critical{1},{2}_{3}cd.gz".format(it, ct.id, ct.num, adder)

def gzipfile(iname, oname):
    blocksize = 1 << 16
    with open(iname, 'rb') as f_in:
        f_out = gzip.open(oname, 'wb', 6)
        while True:
            block = f_in.read(blocksize)
            if block == '':
                break
            f_out.write(block)
        f_out.close()
    return

def runCmd(it, adder, ct):
    TMP_FILE='.tmp_python_call'
    file = open(TMP_FILE, 'w')
    call(["make", "run_Main_dump_all"], stdout=file)
    file.close()
    file = open(TMP_FILE, 'r')
    r = file.read()
    file.close()
    gzipfile(DUMP_FILE,join(OUTPUT_FOLDER, make_dump_name(it, adder, ct)) )
    os.remove(DUMP_FILE)
    return getDetection(r)

def print_process(it, adder, ct):
    global TOTAL, CURRENT
    print('Running {0} in {1} experiments. Iteration: {2}, Adder: {3}, Critical: {4},{5}'.format(CURRENT, TOTAL, it, adder, ct.id, ct.num))
    CURRENT += 1

def update_content(it, adder, ct):
    dump_order(ct)
    f = fileinput.FileInput('../test_bench/Main_real_tb.v', inplace=True)
    for line in f:
        if KEY.CRITICALITY_SCHEME in line:
            print('localparam h_ord_path = "../build/data/order/.tmp"; //{0}\n'.format(KEY.CRITICALITY_SCHEME), end='')
        elif KEY.ITERATION_NUM in line:
            print('integer  iteration_num = {0}; // {1}\n'.format(it, KEY.ITERATION_NUM), end='')
        else:
            print(line, end='')
    f.close()

    f = fileinput.FileInput('../RBMLayer.v', inplace=True)
    for line in f:
        if KEY.ADDER_TYPE_CURRENT_FOLDER in line:
            print('`include "{0}" //{1}\n'.format(adder, KEY.ADDER_TYPE_CURRENT_FOLDER), end='')
        elif KEY.ADDER_TYPE_PARENT_FOLDER in line:
            print('`include "../{0}" //{1}\n'.format(adder, KEY.ADDER_TYPE_PARENT_FOLDER), end='')
        else:
            print(line, end='')
    f.close()


def generate(critical_setups=[], adder_types=[], iteration_nums=[]):
    for it in iteration_nums:
        for adder in adder_types:
            for ct in critical_setups:
                print_process(it, adder, ct)
                update_content(it, adder, ct)
                label, numlist = runCmd(it, adder, ct)
                print('Output = {0}'.format(numlist))


def dump_order(od):
    with open(od.path, 'w') as f:
        for i in od.data:
            if i <= od.num:
                print('1', file=f)
            else:
                print('0', file=f)
        print('0', file=f)



def create_critical_setup(scheme=[], num=[]):
    r = []
    mat_contents = loadmat(CRITICAL_MAT)
    critical_orders = [mat_contents['critorder'][0][i][0] for i in range(5)]

    def get_single_setup(s, n):
        return edict({
            'path':join(ROOT, 'build/data/order/.tmp'),
            'data':critical_orders[s],
            'num':n,
            'id':s
        })


    for s in scheme:
        for n in num:
            r.append(get_single_setup(s, n))
    return r







parser = argparse.ArgumentParser(description="Generate Vcd files for different configurations {adder, critical_scheme, critical_neural_num, iteration_num}")
parser.add_argument('--iteration', help='10,30')
parser.add_argument('--adder_type', help='ZHU4,ZHU,ETAIIM,4B,6B,8A')
parser.add_argument('--critical_scheme', help='1,2,3')
parser.add_argument('--critical_num', help='30,40')


args = parser.parse_args()
iterations = [int(i) for i in args.iteration.split(',')]
adder_types = [ 'iadder_B16_'+a+'.v'  for a in args.adder_type.split(',')]
critical_scheme = [int(i) for i in args.critical_scheme.split(',')]
critical_num = [int(i) for i in args.critical_num.split(',')]
TOTAL = len(iterations) * len(adder_types) * len(critical_num) * len(critical_scheme)
print("The test will begin, don't modify any codes until it stops.")
print("Will run the simulation for {0} times.".format(TOTAL))

critical_setups = create_critical_setup(scheme=critical_scheme, num=critical_num)

generate(critical_setups=critical_setups, iteration_nums=iterations, adder_types=adder_types)
