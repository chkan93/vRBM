ORG_DIR=$(pwd)
DIR=$( dirname "${BASH_SOURCE[0]}" ) 
cd $DIR 
source "psimulate.sh"
source "power.sh"
cd $ORG_DIR