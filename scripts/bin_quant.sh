#!/bin/bash

#SBATCH
#SBATCH --job-name=serc_quant
#SBATCH --time=24:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=24
#SBATCH --mem=100G
#SBATCH --exclusive
#SBATCH --partition=parallel
#SBATCH --mail-type=END
#SBATCH --mail-user=k.arorawilliams2@gmail.com
#SBATCH --error=bin_quant.err
#SBATCH --output=bin_quant.out

source activate metawrap2-env

MW_O=/home-3/karoraw1@jhu.edu/scratch/Processed_data_group/SERC_051717_Shotgun_Metagenomes
ASSEMBLY=$MW_O/CoAssembly/final.contigs.fa
BINS_DIR=../data/Bins/maxbin2_bins
N_CPUS=24

metawrap quant_bins \
-t $N_CPUS \
-b $BINS_DIR \
-o $MW_O/Bin_Quant \
-a $ASSEMBLY \
$MW_O/QCd/QC_Renamed_Seqs/*fastq
