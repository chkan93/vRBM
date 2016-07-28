#!/bin/bash

source "setup.sh"

# this one is kind of complex
# 1. generate gate level saif from dc, no compile ultra, use -propogated and proper change_names
# 2. write sdc from dc shell
# 3. in primetime read sdc, foreach to read saif
# 4. analyze report_power result. 

function pt_measure_power {
    echo "TO DO"
}
