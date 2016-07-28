ORG_DIR=$(pwd)
DIR=$( dirname "${BASH_SOURCE[0]}" ) 
cd $DIR 
source "psimulate.sh"
source "power.dc.sh"
cd $ORG_DIR