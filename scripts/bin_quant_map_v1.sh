#!/bin/bash

#SBATCH
#SBATCH --job-name=mys_quant_1
#SBATCH --time=100:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=24
#SBATCH --mem=100G
#SBATCH --exclusive
#SBATCH --partition=shared
#SBATCH --mail-type=END
#SBATCH --mail-user=k.arorawilliams2@gmail.com
#SBATCH --error=logs/bin_quant_1.err
#SBATCH --output=logs/bin_quant_1.out

source activate metawrap-env
MW_O=/home-3/karoraw1@jhu.edu/scratch/metaWRAP_Out
ASSEMBLY=$MW_O/mystic_n_posctrl_assem/final_assembly.fasta
BINS_DIR=$MW_O/Mystic_PC_Refined_MaB_MeB_Co
N_CPUS=24

metawrap quant_bins \
-t $N_CPUS \
-b $BINS_DIR/metaWRAP_bins \
-o $MW_O/Mystic_Bin_Quant \
-a $ASSEMBLY \
$MW_O/QC_Renamed/*fastq
