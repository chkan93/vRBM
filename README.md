### 1\. Run Simulation
1. Create RBM_Workspace directory. Download parallel_script and vRBM branch.
2. Create folder "saif_output" in RBM_Workspace.
3. Go to directory vRBM/build
4. To generate sigmoid input/output, random number, enter command: make run_Main
5. Check for matching with matlab.
6. load source code: source ~/RBM_Workspace/parallel_script/index.sh
7. To generate saif files, command: run_simulations
8. zip all saif files: split_zip_saif

* commands are in vRBM/build/Makefile
* in vRBM: Main.v, RBMLayer.v, ClassiLayer.v, RandomGenerator.v, sigmoid.v, ap_adder.v

# if the power measurement and simulation happens in different servers. #
1. transfer the saif to another server
scp ./all_saif_[$timestamp].zip  ${a remote server:~/RBM_Workspace/}
2. go to the another server
ssh  ${a remote server}
3. go to where the saif files located at
cd ~/RBM_Workspace/ && unzip ./all_saif_[$timestamp].zip

### 2\. Power Measurement
1. load source code: source ~/RBM_Workspace/parallel_script/index.sh
2. power simulation: dc_measure_power

* read all saif files from $DC_DEST and produce summary.{txt,csv} to $DC_DEST/summary/
