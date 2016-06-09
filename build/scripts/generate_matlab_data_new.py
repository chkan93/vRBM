from __future__ import print_function
import sys
from os.path import join
from numberToBitString import toBin, binToHex


def generate(in_filename, out_filename, bits):
    with open(in_filename+".txt", "r") as in_file:
        with open(out_filename+".txt", "w") as out_file:
            for line in in_file:
                print(binToHex(toBin(int(line), bits=bits)), file=out_file)

if __name__ == "__main__":
    in_dir = sys.argv[1]
    out_dir = sys.argv[2]
    bits = int(sys.argv[3])
    generate(join(in_dir, "W_h"), join(out_dir, "model_h_weight"), bits)
    generate(join(in_dir, "W_c"), join(out_dir, "model_c_weight"), bits)
    generate(join(in_dir, "b_h"), join(out_dir, "model_h_bias"), bits)
    generate(join(in_dir, "b_c"), join(out_dir, "model_c_bias"), bits)
