#!/bin/bash

#SBATCH
#SBATCH --job-name=serc_assembly
#SBATCH --time=20:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=24
#SBATCH --mem=100G
#SBATCH --exclusive
#SBATCH --partition=shared
#SBATCH --mail-type=END
#SBATCH --mail-user=karoraw1@jhu.edu

source activate metawrap2-env

BASE=/home-3/karoraw1@jhu.edu/scratch/Processed_data_group/SERC_051717_Shotgun_Metagenomes
BASE2=/home-3/karoraw1@jhu.edu/scratch/Processed_data_group/CB33_Summer17_NexteraXT

##BINNING

metaWRAP binning -t 24 --maxbin2 -a $BASE/CoAssembly/final.contigs.fa \
-o ../data/Bins \
$BASE/QCd/QC_Renamed_Seqs/SERC_517_10_1.fastq \
$BASE/QCd/QC_Renamed_Seqs/SERC_517_10_2.fastq \
$BASE/QCd/QC_Renamed_Seqs/SERC_517_11_1.fastq \
$BASE/QCd/QC_Renamed_Seqs/SERC_517_11_2.fastq \
$BASE/QCd/QC_Renamed_Seqs/SERC_517_12_1.fastq \
$BASE/QCd/QC_Renamed_Seqs/SERC_517_12_2.fastq \
$BASE/QCd/QC_Renamed_Seqs/SERC_517_13_1.fastq \
$BASE/QCd/QC_Renamed_Seqs/SERC_517_13_2.fastq \
$BASE/QCd/QC_Renamed_Seqs/SERC_517_3_1.fastq \
$BASE/QCd/QC_Renamed_Seqs/SERC_517_3_2.fastq \
$BASE/QCd/QC_Renamed_Seqs/SERC_517_4_1.fastq \
$BASE/QCd/QC_Renamed_Seqs/SERC_517_4_2.fastq \
$BASE/QCd/QC_Renamed_Seqs/SERC_517_5_1.fastq \
$BASE/QCd/QC_Renamed_Seqs/SERC_517_5_2.fastq \
$BASE/QCd/QC_Renamed_Seqs/SERC_517_6_1.fastq \
$BASE/QCd/QC_Renamed_Seqs/SERC_517_6_2.fastq \
$BASE/QCd/QC_Renamed_Seqs/SERC_517_7_1.fastq \
$BASE/QCd/QC_Renamed_Seqs/SERC_517_7_2.fastq \
$BASE/QCd/QC_Renamed_Seqs/SERC_517_8_1.fastq \
$BASE/QCd/QC_Renamed_Seqs/SERC_517_8_2.fastq \
$BASE/QCd/QC_Renamed_Seqs/SERC_517_9_1.fastq \
$BASE/QCd/QC_Renamed_Seqs/SERC_517_9_2.fastq \
$BASE/QCd/QC_Renamed_Seqs/SERC_Zymo_Pos_Control_1.fastq \
$BASE/QCd/QC_Renamed_Seqs/SERC_Zymo_Pos_Control_2.fastq \
$BASE2/QCd/QC_Renamed_Seqs/CB_Zymo_Cellular_Ctrl_1.fastq \
$BASE2/QCd/QC_Renamed_Seqs/CB_Zymo_Cellular_Ctrl_2.fastq \
$BASE2/QCd/QC_Renamed_Seqs/CB_Zymo_DNA_Ctrl_1.fastq \
$BASE2/QCd/QC_Renamed_Seqs/CB_Zymo_DNA_Ctrl_2.fastq \
$BASE2/QCd/QC_Renamed_Seqs/SERC_051717_Sample11_1.fastq \
$BASE2/QCd/QC_Renamed_Seqs/SERC_051717_Sample11_2.fastq


