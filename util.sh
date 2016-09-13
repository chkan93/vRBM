#!/bin/bash

source "setup.sh"

function random_string(){
    echo $(pwgen 8 1)
}


function timestamp(){
	echo $(date +"%Y%m%d_%H%M%S")
}

ZIPSAIF_NAME=""
function zipsaif(){
	local PWD=`pwd`
	ZIPSAIF_NAME=$PWD/all_saif_$(timestamp).zip
	cd $SIM_DEST
	zip $ZIPSAIF_NAME  ./*.saif
	cd $PWD
	cp $ZIPSAIF_NAME .
}

function submitsaif(){
	zipsaif
	scp $ZIPSAIF_NAME  $ACMS_TARGET
	echo "SAIFs are transfered to $ACMS_TARGET"
}


function split_zip_saif(){
	ZIPSAIF_NAME=all_saif_6_adder.$(timestamp).zip
	mkdir -p SAIFS
	rm -rf SAIFS/*
	cd  SAIFS
	for ad in "${SIM_ADDERS[@]}"
	  do
	  	mkdir -p $ad
	  	cp $SIM_DEST/*adder-$ad,cid-*  $ad/
	  done
	cd ..
	zip -r $ZIPSAIF_NAME  SAIFS/*
	cp $ZIPSAIF_NAME .
}



function just_filename(){
	local filename=$(basename $1)
	local filename="${filename%.*}"
	echo $filename
}

function kill_all_background(){
    kill $(jobs -p)
}

function send_file_to_g1(){
	scp $1 g1@dfm.ucsd.edu:/home/g1/
}

function login_to_g1(){
	ssh -X g1@dfm.ucsd.edu
}




