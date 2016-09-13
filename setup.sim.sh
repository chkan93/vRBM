## the source directory (specially used by modelsim)
SIM_SOURCE="/home/xy0/RBM_Workspace/vRBM"
## the temporary directory
SIM_TMP="/home/xy0/RBM_Workspace/tmp"
## the saif output
SIM_DEST="/home/xy0/RBM_Workspace/saif_output"

## where is the bash script directory
SIM_SOURCE_ROOT='/home/xy0/RBM_Workspace/parallel_script'

## where is python2.7 installed
SIM_PYTHON_PATH='/home/xy0/Applications/Python'

## where is the vcd2saif installed
SIM_VCD2SAIF_PATH='/home/xy0/Applications/bin'


## how many iterations you want to run
SIM_ITERATIONS=(5)

## how many images you want to use
SIM_IMAGE_NUM=5

## how many threads you want to use
SIM_THREADS=10


############### Basic Parameter Setup ###############

## which adders to simulate
SIM_ADDERS=(ZHU) ## (ETAIIM ZHU ZHU4 8A 4B 6B) available

## which criticality to use
SIM_CRITICAL_ID=(6)

## how many critical neuron for each criticality
SIM_CRITICAL_NUM=(1 441)

############### Advance Parameter Setup ###############

## specify all parameters by hand
SIM_ADVANCED_SETUPS=("4B 2 1" "4B 4 41")


############### Conclusion ###############

## use the advanced parameter or the basic parameter setup
SIM_USE_ADVANCED=true

## whether combine the two setup
SIM_COMBINE_SETUP=false
