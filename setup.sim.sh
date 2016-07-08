#!/bin/bash

SOURCE="/home/xy0/Workspace/modelsim/vRBM"
TMP="/home/xy0/Workspace/modelsim/tmp"
DEST="/home/xy0/Workspace/modelsim/dist"

ITERATIONS=(5)

##(ETAIIM ZHU ZHU4 8A 4B 6B)
ADDERS=(ZHU)
##(1 2 3 4 5 6)
CRITICAL_ID=(5)

CRITICAL_NUM=(1 41 81 121 161 201 241 281 321 361 401 441)


THREADS=10
IMAGE_NUM=50


ACMS_TARGET='xiz368@ieng6-641.ucsd.edu:/home/linux/ieng6/oce/6i/xiz368/'
SOURCE_ROOT='/home/xy0/Workspace/psimulate'



USE_ADVANCED=true
ADVANCED_SETUPS=("ETAIIM 6 441" "ETAIIM 1 441" "ETAIIM 2 441" "ETAIIM 3 441" "ETAIIM 4 441" "ETAIIM 5 441" "ZHU 1 161" "ZHU 3 161" "ZHU 2 241" "ZHU 4 241" "ZHU 5 201" "ZHU 6 201" "ZHU4 1 1" "ZHU4 2 41" "ZHU4 3 41" "ZHU4 4 41" "ZHU4 5 41" "ZHU 6 41" "4B 1 41" "4B 2 41" "4B 3 41" "4B 4 41" "4B 5 41" "4B 6 41" "6B 1 41" "6B 2 41" "6B 3 41" "6B 4 41" "6B 5 41" "6B 6 41" "8A 1 41" "8A 2 41" "8A 3 41" "8A 4 41" "8A 5 41" "8A 6 41")
# adder criticalid criticalnum
# 0->6 random