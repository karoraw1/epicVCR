#!/bin/bash

#SBATCH
#SBATCH --job-name=classify
#SBATCH --time=24:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=48
#SBATCH --exclusive
#SBATCH --mem=900G
#SBATCH --partition=lrgmem
#SBATCH --mail-type=END
#SBATCH --mail-user=k.arorawilliams2@gmail.com
#SBATCH --error=bin_classify.err
#SBATCH --output=bin_classify.out

source activate metawrap2-env

Bin_Dir=../data/Bins/maxbin2_bins
Tax_Out=../data/bin_taxa

metawrap classify_bins \
-b $Bin_Dir \
-o $Tax_Out \
-t 48
