# Script for Parallel Simulation/Power Measurement

## Require softwares

- `pwgen`
- `python 2.7 or higher` and `scipy/numpy`
- `bash`
- `modelsim`
- `vcd2saif`
- `primetime`
- `DC compiler`


## Usage

- Set correct environment variable in `setup.sim.sh` and `setup.power.sh`

```shell
bash
source index.sh
run_simulations 
dc_measure_power 
pt_measure_power
```

