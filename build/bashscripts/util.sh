#!/bin/bash

source "setup.sh"

function random_string(){
    echo $(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)
}


function timestamp(){
	echo $(date +"%Y%m%d_%H%M%S")
}

function zipsaif(){
	local output=all_saif_$(timestamp).zip
	zip $output  $DEST/*
	cp $output .
	echo $output
}

function submitsaif(){
	local f=$(zipsaif)
	scp $f  $ACMS_TARGET
}


function just_filename(){
	local filename=$(basename $1)
	local filename="${filename%.*}"
	echo $filename
}