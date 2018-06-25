#!/bin/bash

#SBATCH
#SBATCH --job-name=checkm
#SBATCH --time=24:00:00
#SBATCH --mail-type=END
#SBATCH --mail-user=karoraw1@jhu.edu
#SBATCH --nodes=1
#SBATCH --exclusive
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=48
#SBATCH --mem=950G
#SBATCH --partition=lrgmem

source activate metawrap2-env

checkm lineage_wf -x fa --threads 48 --pplacer_threads 20 ../data/Bins/maxbin2_bins ../data/Bins/checkm_out
