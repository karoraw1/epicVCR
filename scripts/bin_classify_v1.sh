#!/bin/bash

#SBATCH
#SBATCH --job-name=classify
#SBATCH --time=100:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=48
#SBATCH --exclusive
#SBATCH --mem=900G
#SBATCH --partition=lrgmem
#SBATCH --mail-type=END
#SBATCH --mail-user=k.arorawilliams2@gmail.com
#SBATCH --error=logs/bin_classify.err
#SBATCH --output=logs/bin_classify.out

source activate metawrap-env
MW_O=/home-3/karoraw1@jhu.edu/scratch/metaWRAP_Out

metawrap classify_bins \
-b $MW_O/Mystic_Bin_Reassembly/reassembled_bins \
-o $MW_O/Mystic_Bin_Taxa_Classes \
-t 48
