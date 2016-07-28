#!/bin/bash


## env variable definition

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PWD="$(pwd)"
VBIT_HOME="$DIR/.."



## load all
ARR=("functions" "variables")
for p in  "${ARR[@]}"; do 
	for f in $DIR/$p/*;  do
		if [ -f "$f" ] ; then
    		source $f;
  		fi
	done
done




