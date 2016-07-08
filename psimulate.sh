#!/bin/bash
## must use bash

source "simulate.sh"
source "setup.sh"

setups=()
function make_setups(){
echo "USE_ADVANCED = $USE_ADVANCED"
if [ "$USE_ADVANCED" = true ] ; then 
     for i1 in "${ITERATIONS[@]}"
     do
        for i2 in "${ADVANCED_SETUPS[@]}" 
        do
            for i3 in $(seq ${IMAGE_NUM})
            do
                setups+=("$i1 $i2 $i3")
            done
        done
    done
fi


if [ "$USE_ADVANCED" = false ] || [ "$COMBINE_SETUP" = true ]; then 
 for i1 in "${ITERATIONS[@]}"
  do
    for i2 in "${ADDERS[@]}"
        do
            for i3 in "${CRITICAL_ID[@]}"
                do
                    for i4 in "${CRITICAL_NUM[@]}"
                      do
                        for i5 in $(seq ${IMAGE_NUM})
                        do
                            setups+=("$i1 $i2 $i3 $i4 $i5")
                        done
                      done
                done
        done
  done
fi
echo "Run Setups: $setups" >&2 
echo "In total, ${#setups[@]} simulations." >&2
}


function pmain(){
    make_setups
    current_setup=1
    setup_num=${#setups[@]}
    while [ "$current_setup" -le "$setup_num" ]; do

        pid=()
        for i in $(seq ${THREADS}); do
            ( main  ${setups[$current_setup]}) &
#            # store PID of process
            pids+=(" $!")
            ((current_setup++))
            if [ "$current_setup" -gt "$setup_num" ]; then
                break
            fi
        done
        wait
        sleep 10
    done

}



function run_simulate(){

    start=$(date +%s.%N)
    org_home=$(pwd)
    printf "Clearing Cache..."
    clear_cache
    printf "Finished"
    printf "Start simulations: "
    pmain
    cd $org_home
    dur=$(echo "$(date +%s.%N) - $start" | bc)
    printf "Execution time: %.6f seconds" $dur
}
