#!/bin/bash

#SBATCH
#SBATCH --job-name=serc_qc
#SBATCH --time=100:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=24
#SBATCH --exclusive
#SBATCH --mem=100G
#SBATCH --partition=gpu
#SBATCH --mail-type=END
#SBATCH --mail-user=karoraw1@jhu.edu
#SBATCH --error=../Logs/serc_qc.err
#SBATCH --output=../Logs/serc_qc.out

source activate metawrap2-env
base_dir=/home-3/karoraw1@jhu.edu/scratch/Processed_data_group
D_D=$base_dir/SERC_051717_Shotgun_Metagenomes/Raw_Unzipped
T_D=$base_dir/SERC_051717_Shotgun_Metagenomes/QCd
sample_names=$base_dir/SERC_051717_Shotgun_Metagenomes/SERC_051717_Shotgun_Metagenomes.samplenames.tsv

mkdir -p $T_D

while read Sname F_read R_read; do
    metaWRAP read_qc -t 24 -1 $D_D/$F_read -2 $D_D/$R_read -o $T_D/$Sname
done < $sample_names
