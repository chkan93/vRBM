#!/usr/bin/python3
from __future__ import print_function, division
from subprocess import call
import json
import progressbar
import os
import fileinput
import re
import KEY

IMAGE_PREFIX = '../build/data/mnist/selected/image_'
LABEL_PREFIX = './data/mnist/selected/label_'

def makeDetectionToken(gt=0,dt=0, id=0, weight=[]):
    return  {
        'id':id,
        'truth':gt,
        'detection':dt,
        'result':gt == dt,
        'weight':weight
    }

def summary(result):
    N = len(result)
    C = len([r for r in result if r['result'] == True])
    return {
        'ImageNumber':N,
        'CorrectDetection':C,
        'Rate':C/N
    }


def runCmd():
    TMP_FILE='.tmp'
    file = open(TMP_FILE, 'w')
    call(["make", "run_Main"], stdout=file)
    file.close()
    file = open(TMP_FILE, 'r')
    r = file.read()
    file.close()
    return r


def updateRBM(adder):
    f =  fileinput.FileInput('../RBMLayer.v', inplace=True)
    for line in f:
        if KEY.ADDER_TYPE_CURRENT_FOLDER in line:
            print('`include "{0}" //{1}\n'.format(adder, KEY.ADDER_TYPE_CURRENT_FOLDER), end='')
        elif KEY.ADDER_TYPE_PARENT_FOLDER in line:
            print('`include "../{0}" //{1}\n'.format(adder, KEY.ADDER_TYPE_PARENT_FOLDER), end='')
        else:
            print(line, end='')
    f.close()

def updateContent(id, num, critical):
    f = fileinput.FileInput('../test_bench/Main_real_tb.v', inplace=True)
    for line in f:
        if KEY.ITERATION_NUM in line:
            print('integer  iteration_num = {0}; // {1}\n'.format(num, KEY.ITERATION_NUM), end='')
        elif KEY.MNIST_IMAGE in line:
            print('localparam input_image_path = "{0}{1}.txt";  //{2}\n'
                .format(IMAGE_PREFIX, id, KEY.MNIST_IMAGE), end='')
        elif KEY.CRITICALITY_SCHEME in line:
            print('localparam h_ord_path = "../build/data/order/real/critorder.{0}.{1}.txt"; //{2}\n'.format(critical[0], critical[1], KEY.CRITICALITY_SCHEME), end='')
        else:
            print(line, end='')
    f.close()


def getDetection(r):
    idx = r.find('output of RBM')
    s = r[idx:idx+70]
    numlist = re.findall(r'\d+', s)
    numlist = [int(n) for n in numlist]
    label = numlist.index(max(numlist))
    return label+1,numlist

def main(N=0,ITER=25,CRITICAL=[1,100], ADDER='i_ap_adder.v'):
    result = []
    print("When testing, please don't edit test_bench/Main_real_tb.v")
    print("Test Begin")
    print("Total Image Number: {0}, with iteration = {1}, with critical {2}, num of iadder {3}, adder: {4}".format(N, ITER, CRITICAL[0], CRITICAL[1], ADDER))
    bar = progressbar.ProgressBar()
    updateRBM(ADDER)

    for i in bar(range(N)):
        updateContent(i+1, ITER, CRITICAL)
        r = runCmd()
        dt,numlist = getDetection(r)
        with open('{0}{1}.txt'.format(LABEL_PREFIX, i+1), 'r') as f:
            result.append(makeDetectionToken(int(f.read()),int(dt),id=i,weight=numlist))

    s = summary(result)
    print("Test finished, Image Number: {0}, Correct Detection: {1}, Rate: {2}".format(
          s['ImageNumber'], s['CorrectDetection'], s['Rate']))
    print("Writing Test Result into file")
    output_json = './data/JSON/mnist_test_result_images{0}_iter{1}_crit{2}-{3}_{4}.json'.format(N, ITER, CRITICAL[0], CRITICAL[1], adder)
    with open(output_json, 'w') as f:
        json.dump({'summary':s,'result':result}, f)
    print("Test Finished")



import sys
import time
if __name__ == "__main__":
    start_time = time.time()
    adder =  sys.argv[4]
    main(N=int(sys.argv[1]),ITER=int(sys.argv[2]), 
         CRITICAL=[int(i) for i in sys.argv[3].split(',')],
         ADDER=  ('iadder_B16_'+ adder +'.v') if adder in ['ZHU4','ZHU','ETAIIM','4B','6B','8A'] else 'i_ap_adder.v') ## '1,100'
    print("--------------------- Program Run Time: {0} seconds. ---------------------".format(time.time()-start_time))
