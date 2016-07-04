#!/bin/bash

source "setup.sh"
source "util.sh"


function main(){
    local home=$(pwd)
    local iteration=$1
    local adder=$2
    local critical_id=$3
    local critical_num=$4
    local image=$5

    local param_id="iteration-$iteration,adder-$adder,cid-$critical_id,cnum-$critical_num,image-$image"
    local saif_file=${param_id}".saif"
    local TO=${TMP}/${param_id}
    cp -rf  ${SOURCE} ${TO}
    echo $1 $2 $3 $4>&2
    cd ${TO}/build
    mkdir -p dumpFolder
    rm -rf ./dumpFolder/*

    python ./pscripts/update_file.py  $iteration  $adder  $critical_id $critical_num  $image
    vlog ../test_bench/Main_real_tb.v
    vsim -c -do "vcd file ./dumpFolder/Main_test_mnist.vcd; vcd add -r *; run -all;" test_Main_Real
    vcd2saif -input ./dumpFolder/Main_test_mnist.vcd   -output  ./dumpFolder/${saif_file}
    cp ${saif_file} $DEST
    cd ${home}
}



function clear(){
    rm -rf ${TMP}/*
}

