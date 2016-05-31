#!/usr/bin/python3
from __future__ import print_function, division
from subprocess import call
import json
import progressbar
import os
import fileinput
import re

def makeDetectionToken(gt=0,dt=0, num=0):
    return  {
        'id':num,
        'truth':gt,
        'detection':dt,
        'result':gt == dt
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
    call(["make", "vsim_Main_test_mnist"], stdout=file)
    file.close()
    file = open(TMP_FILE, 'r')
    r = file.read()
    file.close()
    return r

def updateContent(id, num):
    with fileinput.FileInput('../test_bench/Main_real_tb.v', inplace=True) as f:
        for line in f:
            if "iteration_num" in line:
                print(line.replace('localparam iteration_num = 25;',
                               'localparam iteration_num = {0};'.format(num)), end='')
            elif "mnist_testdata" in line:
                print('localparam input_image_path = "../build/data/mnist/verilog/mnist_testdata{0}.txt";\n'.format(id), end='')
            else:
                print(line, end='')


def getDetection(r):
    idx = r.find('output of RBM')
    s = r[idx:idx+70]
    numlist = re.findall(r'\d+', s)
    numlist = [int(n) for n in numlist]
    label = numlist.index(max(numlist))
    return label+1

def main(N=0,ITER=25):
    result = []
    print("Test Begin")
    print("Total Image Number: {0}, with iteration = {1}".format(N, ITER))
    bar = progressbar.ProgressBar()

    for i in bar(range(N)):
        updateContent(i, ITER)
        r = runCmd()
        dt = getDetection(r)
        with open('./data/mnist/verilog/mnist_testlabels{0}.txt'.format(i), 'r') as f:
            result.append(makeDetectionToken(int(f.read()),int(dt),num=i))

    s = summary(result)
    print("Test finished, Image Number: {0}, Correct Detection: {1}, Rate: {2}",
          s['ImageNumber'], s['CorrectDetection'], s['Rate'])
    print("Writing Test Result into file")
    output_json = 'mnist_test_result_{1}.json'.format(N)
    with open(output_json, 'w') as f:
        json.dump({'summary':s,'result':result}, f)
    print("Test Finished")



main(10,1)

import sys
if __name__ == "__main__":
    main(N=int(sys.argv[1]),ITER=int(sys.argv[2]))