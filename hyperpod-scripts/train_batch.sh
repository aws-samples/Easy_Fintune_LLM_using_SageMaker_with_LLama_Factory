#!/bin/bash
#SBATCH --nodes 2
#SBATCH --exclusive
srun --auto-resume=1 train_multi_ds.sh
