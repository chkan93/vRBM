from os import path
import numpy as np
from scipy.io import savemat
import sys

##1000x441, 1000x10
def process(in_path, out_path, N):
    with open(in_path, 'r') as logfile:
        mat = {
            'hidden_random':np.zeros((N, 441)),
            'classi_random':np.zeros((N, 10))
        }
        start_parse = False
        current_iteration = 0
        current_hidden_id = 0
        current_classi_id = 0
        for line in logfile:
            line = line[2:]
            if line == "BEGIN\n":
                start_parse = True
                continue
            elif line == "FINISH\n":
                break

            if start_parse:
                id, rd = line.split(',')
                if id == "EOT":
                    current_hidden_id = 0
                    current_classi_id = 0
                    current_iteration = int(rd)+1
                else:
                    rd = float(rd)
                    if id == "1":
                        mat['hidden_random'][current_iteration, current_hidden_id] = rd
                        current_hidden_id += 1
                    elif id == "2":
                        mat['classi_random'][current_iteration, current_classi_id] = rd
                        current_classi_id += 1
                    else:
                        raise "Unfound layer ID"



        savemat(out_path, mat)














if __name__ == "__main__":
    process(path.abspath(sys.argv[1]),
            path.abspath(sys.argv[2]),
            int(sys.argv[3]))