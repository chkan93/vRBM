#!/bin/bash

source "setup.sh"


function dc_measure_power(){
    local DC_TMP_SOURCE=${DC_DEST}/tmp_source
	local start=$(date +%s.%N)
	cd ${DC_DEST}
	mkdir -p summary ${DC_TMP_SOURCE}
	rm -rf ${DC_TMP_SOURCE}/*
	cp -rf ${DC_SOURCE}/* ${DC_TMP_SOURCE}
	local tst=$(timestamp)
	local SUMMARY_ALL_FULL=${DC_DEST}/summary/summary.${tst}.txt
	local SUMMARY_SHORT_FULL=${DC_DEST}/summary/summary.short.${tst}.txt
	local SUMMARY_CSV_FULL=${DC_DEST}/summary/summary.${tst}.csv
	local SUMMARY_CSV_SHORT=${DC_DEST}/summary/summary.${tst}.short.csv
	touch ${SUMMARY_ALL_FULL} ${SUMMARY_SHORT_FULL} ${SUMMARY_CSV_FULL}
	echo $'Iteration,Adder, Approximate_Adder_Num, Criticality_ID, Image_ID, Register_Power, Combinational_Power, Total_Power' > ${SUMMARY_CSV_FULL}

	for ad in "${DC_ADDERS[@]}"
	  do
	  	# unzip $ad.zip
	  	cd ${ad}
		local REPORTS=${DC_DEST}/${ad}/reports
		local POWER_NUMERS=${DC_DEST}/${ad}/power_numbers
		local SUMMARY_DIR=${DC_DEST}/${ad}/summary
		local SUMMARY_CSV=${SUMMARY_DIR}/summary.csv
		local SUMMARY_FULL=${SUMMARY_DIR}/summary.txt
		local SUMMARY_SHORT=${SUMMARY_DIR}/summary.short.txt
		mkdir -p ${REPORTS} ${POWER_NUMERS} ${SUMMARY_DIR}
		rm -rf ${REPORTS}/* ${POWER_NUMERS}/* ${SUMMARY_DIR}/*
		## DO STUFF
		cd ${DC_TMP_SOURCE}/build
		${DC_PYTHON_PATH}/python  ./pscripts/update_file_for_power.py  ${ad} ${DC_DEST}/${ad}   ${REPORTS}
		${DC_PATH}/dc_shell -tcl_mode -f ./pscripts/auto_power.tcl

		for rpt in ${REPORTS}/*.txt; do
			echo "Processing $rpt"  >&2
			python ${DC_SOURCE_ROOT}/analyze_report.py  ${rpt} > ${POWER_NUMERS}/$(basename ${rpt})
		done
		
		for nf in ${POWER_NUMERS}/*.txt; do
 			echo "Processing $nf" >&2
			n=`cat ${nf}`
			filename=$(just_filename ${nf})
			echo "$filename,$n" >> ${SUMMARY_FULL}
		done

		${DC_PYTHON_PATH}/python  ${DC_SOURCE_ROOT}/generate_summary.py  ${SUMMARY_FULL}  ${SUMMARY_SHORT}
		${DC_PYTHON_PATH}/python  ${DC_SOURCE_ROOT}/generate_csv.py  ${SUMMARY_FULL}  ${SUMMARY_CSV}
		## FINISH
		rm -rf ${REPORTS}/* ${POWER_NUMERS}/*
		cat ${SUMMARY_FULL} >>  ${SUMMARY_ALL_FULL}
		cat ${SUMMARY_SHORT} >> ${SUMMARY_SHORT_FULL}
		tail -n +2 ${SUMMARY_CSV} >> ${SUMMARY_CSV_FULL}
		cd ${DC_DEST}

	  done

	${DC_PYTHON_PATH}/python  ${DC_SOURCE_ROOT}/primetime_power_to_csv.py  ${SUMMARY_CSV_FULL} ${SUMMARY_CSV_SHORT}
	cd ${DC_DEST}
	local dur=$(echo "$(date +%s.%N) - $start" | bc)
    printf "Power Measurement finished, Execution time: %.6f seconds" ${dur}
}
