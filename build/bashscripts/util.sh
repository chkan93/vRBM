#!/bin/bash

source "setup.sh"

function random_string(){
    echo $(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)
}


