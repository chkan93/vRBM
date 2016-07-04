#!/bin/bash

SOURCE="/home/xy0/Workspace/modelsim/vRBM"
TMP="/home/xy0/Workspace/modelsim/tmp"
DEST="/home/xy0/Workspace/modelsim/dist"

ITERATIONS=(100)

##(ETAIIM ZHU ZHU4 8A 4B 6B)
ADDERS=(ETAIIM ZHU)
##(1 2 3 4 5 6)
CRITICAL_ID=(1 5)

CRITICAL_NUM=(1 111 221 331 441)


THREADS=5
IMAGE_NUM=50