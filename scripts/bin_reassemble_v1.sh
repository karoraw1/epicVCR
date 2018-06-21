#!/bin/bash

#SBATCH
#SBATCH --job-name=mys_bin_ra
#SBATCH --time=100:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=48
#SBATCH --mem=800G
#SBATCH --exclusive
#SBATCH --partition=lrgmem
#SBATCH --mail-type=END
#SBATCH --mail-user=k.arorawilliams2@gmail.com
#SBATCH --error=logs/bin_reassembly_1.err
#SBATCH --output=logs/bin_reassembly_1.out

source activate metawrap-env
MW_O=/home-3/karoraw1@jhu.edu/scratch/metaWRAP_Out
ASSEMBLY=$MW_O/mystic_n_posctrl_assem/final_assembly.fasta
BINS_DIR=$MW_O/Mystic_PC_Refined_MaB_MeB_Co

metawrap reassemble_bins \
-o $MW_O/Mystic_Bin_Reassembly \
-1 $MW_O/mystic_n_posctrl_libs_1.fastq \
-2 $MW_O/mystic_n_posctrl_libs_2.fastq \
-t 48 -m 800 \
-c 70 -x 10 \
-b $BINS_DIR/metaWRAP_bins
