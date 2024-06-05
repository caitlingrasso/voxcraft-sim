#!/bin/bash
# specify a partition
#SBATCH --partition=dggpu
# Request nodes
#SBATCH --nodes=1
# Request some processor cores
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
# Request GPUs
#SBATCH --gres=gpu:1
# Request memory 
#SBATCH --mem=16G
# Maximum runtime of 10 minutes
#SBATCH --time=00:10:00
# Name of this job
#SBATCH --job-name=build
# Output of this job, stderr and stdout are joined by default
# %x=job-name %j=jobid
#SBATCH --output=out/%x.out

# Remove old build files
rm -rf build/

# Load software modules
module load spack/spack-0.15.4
source $SPACK_ROOT/share/spack/setup-env.sh
spack load gcc@7.3.0
spack load cuda
spack load cmake
spack load boost@1.66.0

# Build
mkdir build
cd build
cmake ..

# Make it!
make -j 4