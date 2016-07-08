#!/bin/bash

SOURCE="/home/linux/ieng6/oce/6i/xiz368/vRBM"
TMP="/home/xy0/Workspace/modelsim/tmp"
DEST="/home/linux/ieng6/oce/6i/xiz368/home/xy0/Workspace/modelsim/dist"

ITERATIONS=(5)

##(ETAIIM ZHU ZHU4 8A 4B 6B)
ADDERS=(ZHU)
##(1 2 3 4 5 6)
CRITICAL_ID=(5)

CRITICAL_NUM=(1 41 81 121 161 201 241 281 321 361 401 441)


THREADS=10
IMAGE_NUM=50


ACMS_TARGET='xiz368@ieng6-641.ucsd.edu:/home/linux/ieng6/oce/6i/xiz368/'
SOURCE_ROOT='/home/linux/ieng6/oce/6i/xiz368/psimulate'