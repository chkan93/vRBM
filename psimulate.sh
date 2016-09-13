#!/bin/bash
## must use bash

source "simulate.sh"
source "setup.sh"

SIM_setups=()
function make_setups(){
echo "USE_ADVANCED = $SIM_USE_ADVANCED"
if [ "$SIM_USE_ADVANCED" = true ] ; then
     for i1 in "${SIM_ITERATIONS[@]}"
     do
        for i2 in "${SIM_ADVANCED_SETUPS[@]}"
        do
            for i3 in $(seq ${SIM_IMAGE_NUM})
            do
                SIM_setups+=("$i1 $i2 $i3")
            done
        done
    done
fi


if [ "$SIM_USE_ADVANCED" = false ] || [ "$SIM_COMBINE_SETUP" = true ]; then
 for i1 in "${SIM_ITERATIONS[@]}"
  do
    for i2 in "${SIM_ADDERS[@]}"
        do
            for i3 in "${SIM_CRITICAL_ID[@]}"
                do
                    for i4 in "${SIM_CRITICAL_NUM[@]}"
                      do
                        for i5 in $(seq ${SIM_IMAGE_NUM})
                        do
                            SIM_setups+=("$i1 $i2 $i3 $i4 $i5")
                        done
                      done
                done
        done
  done
fi
echo "In total, ${#SIM_setups[@]} simulations." >&2
}


function pmain(){
    make_setups
    current_setup=0
    setup_num=${#SIM_setups[@]}
    while [ "$current_setup" -le "$setup_num" ]; do
        for i in $(seq ${SIM_THREADS}); do
            echo "${SIM_setups[$current_setup]}" >&2
            if [ "$current_setup" -ge "$setup_num" ]; then
                break
            fi
            ( main  ${SIM_setups[$current_setup]}) >/dev/null &  
            ((current_setup++))
        done
        wait
    done
}



function run_simulations(){

    local start=$(date +%s.%N)
    org_home=$(pwd)
    printf "Clearing Cache..."
    clear_cache
    printf "Finished"
    printf "Start simulations: "
    pmain
    cd ${org_home}
    local dur=$(echo "$(date +%s.%N) - $start" | bc)
    zipsaif
    split_zip_saif
    printf "Execution time: %.6f seconds" ${dur}

}
