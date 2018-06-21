#!/bin/bash

#SBATCH
#SBATCH --job-name=bin_refine1
#SBATCH --time=100:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=24
#SBATCH --mem=500G
#SBATCH --partition=lrgmem
#SBATCH --mail-type=END
#SBATCH --mail-user=k.arorawilliams2@gmail.com
#SBATCH --error=logs/bin_refine1.err
#SBATCH --output=logs/bin_refine1.out

source activate metawrap-env
MW_O=/home-3/karoraw1@jhu.edu/scratch/metaWRAP_Out
output_dir=$MW_O/Mystic_PC_Refined_MaB_MeB_Co
N_CPUS=24
bin_folderA=$MW_O/mystic_pc_bins/maxbin2_bins
bin_folderB=$MW_O/mystic_pc_bins/metabat2_bins
bin_folderC=$MW_O/mystic_pc_bins_concoct/concoct_bins

srun="srun -N1 -n1 --exclusive -c 24"

$srun metaWRAP bin_refinement \
-t $N_CPUS \
-o $output_dir \
-A $bin_folderA \
-B $bin_folderB \
-C $bin_folderC
