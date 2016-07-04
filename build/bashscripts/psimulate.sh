#!/bin/bash
## must use bash

source "simulate.sh"
source "setup.sh"

setups=()
function make_setups(){
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

        for p in $pids; do
            if wait $p; then
                echo "Process $p success"
            else
                echo "Process $p fail"
            fi
        done
    done

}

pmain
