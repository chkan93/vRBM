from __future__ import print_function
import random, string
from subprocess import call
from os import remove
from scipy.io import loadmat
from numpy.random import permutation
import fileinput
import KEY

def random_string(length=10):
   return ''.join(random.choice(string.lowercase) for i in range(length))


def run(s):
    TMP_FILE='.tmp_subprocess_call' + random_string()
    lst = s.split(" ")
    file = open(TMP_FILE, 'w')
    call(lst, stdout=file)
    file.close()
    file = open(TMP_FILE, 'r')
    r = file.read()
    file.close()
    remove(TMP_FILE)
    return r


def toList(x):
    if type(x) == list:
        return x
    else:
        return [x]


# st[0]==>critical order, st[1]==>num
def dump_critical(st):
    mat_contents = loadmat('./data/order/criticality.mat')
    output_critical = 'data/order/.tmp'
    order = None
    if st[0] > len(mat_contents['critorder'][0]):
        order = [o+1 for o in permutation(441)]
    else:
        order = mat_contents['critorder'][0][st[0]-1][0]

    with open(output_critical, 'w') as f:
        for i in order:
            if i <= st[1]:
                print('1', file=f)
            else:
                print('0', file=f)
        print('0', file=f)

    return output_critical


def make_name(iteration, adder, critical, image):
    return "iteration-{0},adder-{1},corder-{2},cnum-{3},image-{4}.saif"\
        .format(iteration, adder, critical[0], critical[1], image)


def update_files(iteration, adder, critical_path, image):
    f = fileinput.FileInput('../test_bench/Main_real_tb.v', inplace=True)
    for line in f:
        if KEY.CRITICALITY_SCHEME in line:
            print('localparam h_ord_path = "../build/{0}"; //{1}\n'.format(critical_path, KEY.CRITICALITY_SCHEME), end='')
        elif KEY.ITERATION_NUM in line:
            print('integer  iteration_num = {0}; // {1}\n'.format(iteration, KEY.ITERATION_NUM), end='')
        elif KEY.MNIST_IMAGE in line:
            print('localparam input_image_path = "../build/data/mnist/selected/image_{0}.txt";  //{1}\n'
                  .format(image, KEY.MNIST_IMAGE), end='')
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