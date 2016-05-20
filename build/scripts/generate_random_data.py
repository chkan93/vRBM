#!/usr/bin/python
from __future__ import print_function
import sys
import random
import math
from numberToBitString import toHex


def generateRandomData(output_dir='./data/',  bit=8, dim1=1, dim2=6):
    dim = dim2*dim1
    file_name = "{0}{1}x{2}.txt".format(output_dir, dim1, dim2)
    lmt = math.pow(2, bit)-1
    with open(file_name, "w") as f:
        for _ in range(dim):
            print(toHex(random.randint(0, lmt)), file=f)


def getDim(st):
    x = st.split("*")
    if len(x) == 1:
        return (1, int(st))
    else:
        return (int(x[0]), int(x[1]))


if __name__ == "__main__":
    dim1, dim2 = getDim(sys.argv[3])
    generateRandomData(output_dir=sys.argv[1],
                       bit=eval(sys.argv[2]),
                       dim1=dim1,
                       dim2=dim2)
