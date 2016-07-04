from __future__ import print_function
import KEY, Util
import fileinput



def main(iteration=0, adder="", critical_id=0, critical_num=1, image=0):
    f = fileinput.FileInput('../test_bench/Main_real_tb.v', inplace=True)
    critical_path= Util.dump_critical([critical_id, critical_num])

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

    frbm = fileinput.FileInput('../RBMLayer.v', inplace=True)
    for line in frbm:
        if KEY.ADDER_TYPE_CURRENT_FOLDER in line:
            print('`include "{0}" //{1}\n'.format(adder, KEY.ADDER_TYPE_CURRENT_FOLDER), end='')
        elif KEY.ADDER_TYPE_PARENT_FOLDER in line:
            print('`include "../{0}" //{1}\n'.format(adder, KEY.ADDER_TYPE_PARENT_FOLDER), end='')
        else:
            print(line, end='')
    frbm.close()












import sys
if __name__ == "__main__":
    main(iteration=int(sys.argv[1]),
         adder="iadder_B16_{0}.v".format(sys.argv[2]),
         critical_id=int(sys.argv[3]),
         critical_num=int(sys.argv[4]),
         image=int(sys.argv[5]))