#!/bin/bash

source "setup.sh"

function random_string(){
    # echo $(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)
    echo $(pwgen 8 1)
}


function timestamp(){
	echo $(date +"%Y%m%d_%H%M%S")
}

ZIPSAIF_NAME=""
function zipsaif(){
	ZIPSAIF_NAME=all_saif_$(timestamp).zip
	zip $ZIPSAIF_NAME  $DEST/*
	cp $ZIPSAIF_NAME .
}

function submitsaif(){
	zipsaif
	scp $ZIPSAIF_NAME  $ACMS_TARGET
	echo "SAIFs are transfered to $ACMS_TARGET"
}


function just_filename(){
	local filename=$(basename $1)
	local filename="${filename%.*}"
	echo $filename
}