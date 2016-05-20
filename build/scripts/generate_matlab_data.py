#!/usr/bin/python
from __future__ import print_function
import sys
import scipy.io as io
import os
import math
from numberToBitString import toHex

TYPE = {
    'MNIST':'mnist',
    'MNIST_RBM_MODEL':'mnist_rbm_model'
}
EXT = '.txt'


def binary(lst):
    return [ int(round(l)) for l in lst]


def rounding(lst, floating_bits):
    return [int(l * math.pow(2, floating_bits)) for l in lst]


def output_list(f,list):
    for d in list:
        print(toHex(d), file=f)


def get_data(m, key, fun=lambda x:x):
    return {
        'key': key,
        'data': fun(m[key])
    }

def generate_data(input_file='', output_dir='', prefix='', floating_bits=4):
    data = None
    if prefix == TYPE['MNIST']:
        md = io.loadmat(input_file)
        data = [
                # get_data(md, 'data'),
                # get_data(md, 'labels'),
                get_data(md, 'testdata'),
                get_data(md, 'testlabels')]
        for m in data:
            for i in range(len(m['data'])):
                with open(os.path.join(output_dir, prefix + '_' + m['key'] + str(i) + EXT), 'w') as f:
                    output_list(f, binary(m['data'][i]))

    elif prefix == TYPE['MNIST_RBM_MODEL']:
        md = io.loadmat(input_file)
        fun = lambda x:x.ravel()
        data = [get_data(md, 'cweight', fun=fun),
                get_data(md, 'cbias',  fun=fun),
                get_data(md, 'hweight',  fun=fun),
                get_data(md, 'hbias',  fun=fun)]
        for m in data:
            with open(os.path.join(output_dir, prefix + '_' + m['key'] + EXT), 'w') as f:
                output_list(f, rounding(m['data'], floating_bits))

    else:
        print('Unrecognized data type.')
        return





if __name__ == "__main__":
    generate_data(input_file=os.path.realpath(sys.argv[1]),
                  prefix=sys.argv[2],
                  output_dir=os.path.realpath(sys.argv[3]),
                  floating_bits=int(sys.argv[4]))
