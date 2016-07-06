source "setup.sh"

REPORTS=$DEST/reports  
POWER_NUMERS=$DEST/power_numbers
SUMMARY_DIR=$DEST/summary 
SUMMARY=$SUMMARY_DIR/summary.txt
TMP_SOURCE=$DEST/tmp_source

function make_adder_folder(){
		echo adder_$1
}

function make_tmp_workspace(){
	cd $DEST
	mkdir -p $REPORTS
	mkdir -p $POWER_NUMERS
	mkdir -p $SUMMARY_DIR
	rm -rf $TMP_SOURCE/*
	rm -rf $SUMMARY_DIR/*
	cp -rf $SOURCE/* $TMP_SOURCE
	for ad in "${ADDERS[@]}"
	  do
	  	adder_folder=$(make_adder_folder $ad)
	  	mkdir -p $adder_folder
	  	rm -rf adder_folder/*
	  	cp ./*$ad*  $adder_folder/
	  done

}

function make_power_summary(){
	cd $DEST
	rm $SUMMARY
	touch $SUMMARY
	for nf in $POWER_NUMERS/*.txt; do 
		echo "Processing $nf" >&2
		n=`cat $nf` 
		filename=$(just_filename $nf)
		echo "$filename,$n" >> $SUMMARY
	done
	python  $SOURCE_ROOT/generate_summary.py $SUMMARY $SUMMARY_DIR/summary.12.txt
}

function generate_power_numbers(){
	cd $DEST
	for rpt in $REPORTS/*.txt; do
		echo "Processing $rpt"  >&2
	   	python $SOURCE_ROOT/analyze_report.py  $rpt > $POWER_NUMERS/$(basename $rpt)
	done
}

function generate_reports(){
	cd $DEST
	for ad in "${ADDERS[@]}"
	  do
	  	adder_folder=$(make_adder_folder $ad)
	  	cd $TMP_SOURCE/build
	  	python  ./pscripts/update_file_for_power.py  $ad $adder_folder 
	  	dc_shell -tcl_mode -f ./pscripts/auto_power.tcl
	  done
	cd $DEST
}



function measure_power(){
	make_tmp_workspace
	generate_reports
	generate_power_numbers
}