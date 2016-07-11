source "setup.sh"

# REPORTS=$DEST/reports  
# POWER_NUMERS=$DEST/power_numbers
# SUMMARY_DIR=$DEST/summary 
# SUMMARY=$SUMMARY_DIR/summary.txt
TMP_SOURCE=$DEST/tmp_source

# function make_adder_folder(){
# 		echo adder_$1
# }

# function make_tmp_workspace(){
# 	cd $DEST
# 	mkdir -p $REPORTS
# 	mkdir -p $POWER_NUMERS
# 	mkdir -p $SUMMARY_DIR
# 	mkdir -p $TMP_SOURCE
# 	rm -rf $TMP_SOURCE/*
# 	rm -rf $SUMMARY_DIR/*
# 	rm -rf $POWER_NUMERS/*
# 	rm -rf $REPORTS/*
# 	cp -rf $SOURCE/* $TMP_SOURCE
# 	for ad in "${ADDERS[@]}"
# 	  do
# 	  	adder_folder=$(make_adder_folder $ad)
# 	  	mkdir -p $adder_folder
# 	  	rm -rf $adder_folder/*
# 	  	cp ./*adder-$ad,cid-*  $adder_folder/
# 	  done

# }

# function make_power_summary(){
# 	cd $DEST
# 	rm $SUMMARY
# 	touch $SUMMARY
# 	for nf in $POWER_NUMERS/*.txt; do 
# 		echo "Processing $nf" >&2
# 		n=`cat $nf` 
# 		filename=$(just_filename $nf)
# 		echo "$filename,$n" >> $SUMMARY
# 	done
# 	python  $SOURCE_ROOT/generate_summary.py $SUMMARY $SUMMARY_DIR/summary.short.txt
# 	python  $SOURCE_ROOT/generate_csv.py  $SUMMARY  $SUMMARY_DIR/summary.csv
# }

# function generate_power_numbers(){
# 	cd $DEST
# 	for rpt in $REPORTS/*.txt; do
# 		echo "Processing $rpt"  >&2
# 	   	python $SOURCE_ROOT/analyze_report.py  $rpt > $POWER_NUMERS/$(basename $rpt)
# 	done
# }

# function generate_reports(){
# 	cd $DEST
# 	for ad in "${ADDERS[@]}"
# 	  do
# 	  	adder_folder=$(make_adder_folder $ad)
# 	  	cd $TMP_SOURCE/build
# 	  	python  ./pscripts/update_file_for_power.py  $ad $adder_folder 
# 	  	dc_shell -tcl_mode -f ./pscripts/auto_power.tcl
# 	  	# sleep 10
# 	  done
# 	cd $DEST
# }



# function measure_power_old(){
# 	make_tmp_workspace
# 	generate_reports
# 	generate_power_numbers
# 	make_power_summary
# }


function measure_power(){
	local org_home=$(pwd)
	local start=$(date +%s.%N)
	loadALL
	cd $DEST
	mkdir -p summary $TMP_SOURCE
	rm -rf $TMP_SOURCE/*
	cp -rf $SOURCE/* $TMP_SOURCE
	local tst=$(timestamp)
	local SUMMARY_ALL_FULL=$DEST/summary/summary.${tst}.txt
	local SUMMARY_SHORT_FULL=$DEST/summary/summary.short.${tst}.txt
	local SUMMARY_CSV_FULL=$DEST/summary/summary.${tst}.csv
	local SUMMARY_SHORT_CSV=$DEST/summary/summary.short.${tst}.csv
	touch $SUMMARY_ALL_FULL $SUMMARY_SHORT_FULL $SUMMARY_CSV_FULL
	echo $'Iteration,Adder, Approximate_Adder_Num, Criticality_ID, Image_ID, Register_Power, Combinational_Power, Total_Power' > $SUMMARY_CSV_FULL
	# for ad in "${ADDERS[@]}"
	# do
	# 	zip -r $ad.zip $ad/*
	# 	rm -rf $ad 
	# done

	for ad in "${ADDERS[@]}"
	  do
	  	# unzip $ad.zip
	  	cd $ad
		local REPORTS=$DEST/$ad/reports
		local POWER_NUMERS=$DEST/$ad/power_numbers
		local SUMMARY_DIR=$DEST/$ad/summary
		local SUMMARY_CSV=$SUMMARY_DIR/summary.csv
		local SUMMARY_FULL=$SUMMARY_DIR/summary.txt
		local SUMMARY_SHORT=$SUMMARY_DIR/summary.short.txt
		mkdir -p $REPORTS $POWER_NUMERS $SUMMARY_DIR
		rm -rf $REPORTS/* $POWER_NUMERS/* $SUMMARY_DIR/*
		## DO STUFF
		cd $TMP_SOURCE/build
		python  ./pscripts/update_file_for_power.py  $ad $DEST/$ad   $REPORTS
		dc_shell -tcl_mode -f ./pscripts/auto_power.tcl

		for rpt in $REPORTS/*.txt; do
			echo "Processing $rpt"  >&2
			python $SOURCE_ROOT/analyze_report.py  $rpt > $POWER_NUMERS/$(basename $rpt)
		done
		
		for nf in $POWER_NUMERS/*.txt; do 
 			echo "Processing $nf" >&2
			n=`cat $nf` 
			filename=$(just_filename $nf)
			echo "$filename,$n" >> $SUMMARY_FULL
		done

		python  $SOURCE_ROOT/generate_summary.py  $SUMMARY_FULL  $SUMMARY_SHORT

		python  $SOURCE_ROOT/generate_csv.py  $SUMMARY_FULL  $SUMMARY_CSV
		python  $SOURCE_ROOT/generate_csv.py  $SUMMARY_SHORT_FULL  $SUMMARY_SHORT_CSV
		## FINISH
		rm -rf $REPORTS/* $POWER_NUMERS/* 
		cat $SUMMARY_FULL >>  $SUMMARY_ALL_FULL
		cat $SUMMARY_SHORT >> $SUMMARY_SHORT_FULL
		tail -n +2 $SUMMARY_CSV >> $SUMMARY_CSV_FULL
		cd $DEST
		# rm -rf $ad.zip
		# zip -r $ad.zip $ad/*
		# rm -rf $ad
	  done

	cd $DEST
	local dur=$(echo "$(date +%s.%N) - $start" | bc)
    printf "Power Measurement finished, Execution time: %.6f seconds" $dur

    cd $org_home
}