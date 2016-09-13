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
    local TO=${SIM_TMP}/${param_id}
    local build=${TO}/build
    cp -rf  ${SIM_SOURCE} ${TO}
    # echo $1 $2 $3 $4 $5 >&2
    cd $build
    vlib work
    pwd
    mkdir -p ${build}/dumpFolder
    rm -rf ${build}/dumpFolder/*

    $SIM_PYTHON_PATH/python ${build}/pscripts/update_file.py  $iteration  $adder  $critical_id $critical_num  $image
    vlog ${TO}/test_bench/Main_real_tb.v
    vsim -c -do "vcd file ./dumpFolder/Main_test_mnist.vcd; vcd add -r *; run -all;" test_Main_Real
    $SIM_VCD2SAIF_PATH/vcd2saif -input ${build}/dumpFolder/Main_test_mnist.vcd   -output  ${build}/dumpFolder/${saif_file}
    rm ${build}/dumpFolder/Main_test_mnist.vcd
    cp ${build}/dumpFolder/${saif_file} $SIM_DEST
    cd ${home}
    rm -rf ${TO}
    # sleep  60
}



function clear_cache(){
    rm -rf ${SIM_TMP}/*
}

