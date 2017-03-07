# vRBM

![](http://deeplearning4j.org/img/multiple_inputs_RBM.png)

This is a verilog implementation of a two-layered Spiking [Restrictive Boltzmann Machine](https://en.wikipedia.org/wiki/Restricted_Boltzmann_machine) with

- Verilog Test Bench
- Matlab Code to verify results
- Shell Scripts to run [modelsim](https://www.altera.com/products/design-software/model---simulation/modelsim-altera-software.highResolutionDisplay.html) simulation in parallel and measure power in [Synopsys DC Compiler](http://www.synopsys.com/Tools/Implementation/RTLSynthesis/DesignCompiler/Pages/default.aspx) and [Primetime](https://www.synopsys.com/apps/support/training/primetime1_fcd.html).

## Prerequisite Softwares

1. Linux OS(tested on [Centos 6.8](https://www.centos.org/)).
2. Modelsim from <https://www.altera.com/products/design-software/model---simulation/modelsim-altera-software.highResolutionDisplay.html>, student edition is ok.
3. Python 2.7 and scipy, numpy
4. Git
5. DC Compiler (`dc_shell`)
6. DC Primetime (`pt_shell`)
7. `pwgen` a linux command line tool.
8. Code editor with shell-script, python, verilog syntax support like [sublime](https://www.sublimetext.com/).
9. `vcd2saif` program.

Matlab is used to run matlab verification, but it's not required if you don't modify the source code.

## Usage

### 1\. Get Source code.

```shell
## go to home page.
cd ~
## create workspace
mkdir RBM_Workspace && cd RBM_Workspace
## checkout verilog source code & tcl scripts from github repo
git clone https://github.com/BenBBear/vRBM ./vRBM  
## checkout bash scripts(used to run simulation code) from github repo
git clone https://github.com/BenBBear/vRBM -b parallel_script ./parallel_script
## create temporary folder and saif files output directory
mkdir tmp saif_output
```

### 2\. Prepare configuration in parallel_script

`edit` is the code editor program here, for example `sublime_text`.

```shell
cd ./parallel_script
## set the simulation running configuration
edit ./setup.sim.sh
## set the power measurement running configuration
edit ./setup.power.sh
```

#### Simulation Configuration

```shell
## the source directory (specially used by modelsim)
SIM_SOURCE="/home/xy0/RBM_Workspace/vRBM"
## the temporary directory
SIM_TMP="/home/xy0/RBM_Workspace/tmp"
## the saif output
SIM_DEST="/home/xy0/RBM_Workspace/saif_output"

## where is the bash script directory
SIM_SOURCE_ROOT='/home/xy0/RBM_Workspace/parallel_script'

## where is python2.7 installed
SIM_PYTHON_PATH='/usr/local/bin'

## where is the vcd2saif installed
SIM_VCD2SAIF_PATH='/usr/local/bin'


## how many iterations you want to run
SIM_ITERATIONS=(5)

## how many images you want to use
SIM_IMAGE_NUM=50

## how many threads you want to use
SIM_THREADS=10


############### Basic Parameter Setup ###############

## which adders to simulate
SIM_ADDERS=(ZHU) ## (ETAIIM ZHU ZHU4 8A 4B 6B) available

## which criticality to use
SIM_CRITICAL_ID=(1 2 3 4 5 6)

## how many critical neuron for each criticality
SIM_CRITICAL_NUM=(1 41 81 121 161 201 241 281 321 361 401 441)

############### Advance Parameter Setup ###############

## specify all parameters by hand
SIM_ADVANCED_SETUPS=("4B 2 1" "4B 4 41")


############### Conclusion ###############

## use the advanced parameter or the basic parameter setup
SIM_USE_ADVANCED=true

## whether combine the two setup
SIM_COMBINE_SETUP=false
```

#### Power Measurement Configuration

Some variables are similar to those in simulation.

```shell
## the source directory (specially used by dc_shell)
DC_SOURCE="/home/xy0/RBM_Workspace/vRBM"
## where the saif file located (needed by power measurements, generated from modelsim)
DC_DEST="/home/xy0/RBM_Workspace/saif_output"
## which adders you want to measure power at
DC_ADDERS=(ZHU4 ETAIIM)
## where the bash script located
DC_SOURCE_ROOT='/home/xy0/RBM_Workspace/parallel_script'
## where the python 2.7 locate
DC_PYTHON_PATH='/home/g1/python27'
## where is dc compiler located
DC_PATH='/home/tool/synopsys/DesignCompiler/K-2015.06-SP4/bin/'
```

### 3\. Run Simulation

```shell
## load scripts into bash
source ~/RBM_Workspace/parallel_script/index.sh

## run modelsim simulations, usually takes 10hours+ depending on your parameter setup.
## watch all the error at the very beginning! If anything goes wrong Ctrl-C stop it.
## it will generate all the saif files to $SIM_DEST
run_simulations

## zip all saif files and copy the single .zip file (large) into your current dir.
zip_saif

## see your generated saif zip, this will be useful to someone else who want to measure power with different tool.
ls -al | grep all_saif_*.zip

############# This part is needed if the power measurement and simulation happens in different servers. #############

## transfer the saif to another server
scp ./all_saif_[$timestamp].zip  ${a remote server:~/RBM_Workspace/}

## go to the another server
ssh  ${a remote server}

## go to where the saif files located at
cd ~/RBM_Workspace/ && unzip ./all_saif_[$timestamp].zip
##############################################################################
```

### 4\. Measure Power in DC Compiler

First, make sure you have the `DC_SOURCE`, `DC_DEST` and etc correctly setup, especially if you measure the power in a different server.

```shell
## load it again, if you are in another server
source ~/RBM_Workspace/parallel_script/index.sh

## run dc_shell power measurement, usually takes 1-2hours depending on your parameter setup.
## watch all the error at the very beginning! If anything goes wrong Ctrl-C stop it.
## it will read all saif files from $DC_DEST and produce summary.{txt,csv} to $DC_DEST/summary/
dc_measure_power
```

## Working on the Code

Some advice if you want to work on the source code.

### Verilog

Starts from [RBMLayer.v](/RBMLayer.v), which is almost the same with [ClassiLayer.v](/ClassiLayer.v) and gives you the big picture. The [sigmoid](/sigmoid.v), [Random Number generator](/RandomGenerator.v) and `iadder_*` module are too detailed and can be understood easily from usage.

And then go to [Main.v](/Main.v), which is the top level module and just the concatenation of those two layers.

Finally the [test_bench/Main_real_tb.v](/test_bench/Main_real_tb.v), you will see a lot of parameters are defined at the top and those `KEY`:

```verilog
localparam input_image_path = "../build/data/mnist/selected/image_2.txt";  //KEY:MNIST_IMAGE
```

The `KEY:xxx` is used to easy string matching/replacing to run multiple simulation in shell script.

### Matlab

Entry of the matlab code is [example_dis_XX.m](https://github.com/BenBBear/vRBM/blob/matlab/example_dis_XX.m), just read it and [rbmPredict_spikingAAXX](https://github.com/BenBBear/vRBM/blob/matlab/rbmPredict_spikingAAXX.m) would be enough for understanding. Others are used to generate models & verification etc...

### Bash Script

Bash scripts are hard to read, there are three files you could read in order: [psimulate.sh](https://github.com/BenBBear/vRBM/blob/parallel_script/psimulate.sh), [simulate.sh](https://github.com/BenBBear/vRBM/blob/parallel_script/simulate.sh), [power.dc.sh](https://github.com/BenBBear/vRBM/blob/parallel_script/power.dc.sh).

### Important Notes on Primetime Power measurement

1. use correct `change_names -rules` in dc <[reference](https://github.com/BenBBear/vRBM/blob/master/Power%20Measurement%20Notes/use%20correct%20change_names%20-rules%20in%20dc.png)>

2. use `-propagated` in `write_saif` (output gate level saif from dc to primetime) <[reference](https://github.com/BenBBear/vRBM/blob/master/Power%20Measurement%20Notes/use%20-propagated%20in%20write_saif%20(output%20from%20dc%20to%20primetime).png)>

3. use `-auto_map_names` in `read_saif` (read rtl level saif from dc) <[reference](https://github.com/BenBBear/vRBM/blob/master/Power%20Measurement%20Notes/use%20-auto_map_names%20in%20read_saif%20(dc).png)>

4. `instance_name/strip_path` is the path of top module from testbench (for example `test_real_main/main`) <[reference](https://github.com/BenBBear/vRBM/blob/master/Power%20Measurement%20Notes/instance_name:strip_path%20%3D%3Epath%20of%20top%20module%20from%20testbench%20(for%20example%20test_real_main:main).png)>
