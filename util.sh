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
	ZIPSAIF_NAME=all_saif_$(timestamp).zip
	zip $ZIPSAIF_NAME  $SIM_DEST/*
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
	ssh $ACMS_IP 'rm -rf ./*saif*.zip'
	ssh $ACMS_IP 'rm -rf ./*SAIF*.zip'
	scp $ZIPSAIF_NAME  $ACMS_TARGET
	scp $ZIPSAIF_NAME  'g1@dfm.ucsd.edu:/home/g1/'
	echo "SAIFs are transfered to $ACMS_TARGET"
}



function just_filename(){
	local filename=$(basename $1)
	local filename="${filename%.*}"
	echo $filename
}

function kill_all_background(){
    kill $(jobs -p)
}