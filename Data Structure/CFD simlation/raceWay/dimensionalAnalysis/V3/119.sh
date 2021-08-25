#!/bin/bash
#SBATCH --account=co2cfd
#SBATCH --time=7-00
#SBATCH --job-name=119
#SBATCH --nodes=1
#SBATCH --output=log119
source ~/.bashrc
module load openmpi/3.1.6/gcc-8.4.0

mpirun -np 36 /lustre/eaglefs/projects/co2cfd/software/interFoamPisoOutLoopBreakResetFields/interFoam -parallel -case /lustre/eaglefs/projects/co2cfd/running/130/119 
cp /lustre/eaglefs/projects/co2cfd/running/130/controlDict  /lustre/eaglefs/projects/co2cfd/running/130/119/system 
mpirun -np 36 /lustre/eaglefs/projects/co2cfd/software/interFoamPisoOutLoopBreakResetFields/interFoam -parallel -case /lustre/eaglefs/projects/co2cfd/running/130/119

