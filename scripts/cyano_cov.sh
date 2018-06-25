#!/bin/bash

#SBATCH
#SBATCH --job-name=cov_test
#SBATCH --time=4:00:00
#SBATCH --mail-type=END
#SBATCH --mail-user=karoraw1@jhu.edu
#SBATCH --nodes=1
#SBATCH --exclusive
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=24
#SBATCH --mem=100G
#SBATCH --partition=parallel

NUM_THREADS=24
ml samtools
ml bowtie2
ml bedtools

#genome_file=../data/cyanophage_genomes/NC_031242.1.fasta
#samtools faidx $genome_file
#awk -v OFS='\t' {'print $1,$2'} ${genome_file}.fai > ${genome_file}.bed
bt_idx=../data/cyanophage_genomes/NC_031242.1_idx
#bowtie2-build ${genome_file} $bt_idx

read_dir=../../../SERC_051717_Shotgun_Metagenomes/QCd/QC_Renamed_Seqs
R1_1=SERC_517_6_1.fastq; R2_1=SERC_517_6_2.fastq; 
R1_2=SERC_517_12_1.fastq; R2_2=SERC_517_12_2.fastq;

samRoot1=NC_031242.SERC_517_6
samRoot2=NC_031242.SERC_517_12

bowtie2 --threads $NUM_THREADS \
-x $bt_idx \
-1 $read_dir/$R1_1 \
-2 $read_dir/$R2_1 \
--no-unal \
-S ../data/cyanophage_genomes/${samRoot1}.sam

bowtie2 --threads $NUM_THREADS \
-x $bt_idx \
-1 $read_dir/$R1_2 \
-2 $read_dir/$R2_2 \
--no-unal \
-S ../data/cyanophage_genomes/${samRoot2}.sam

cd ../data/cyanophage_genomes/

samtools view -F 4 -b ${samRoot1}.sam > ${samRoot1}.bam
samtools sort ${samRoot1}.bam -o ${samRoot1}.sorted.bam
samtools index ${samRoot1}.sorted.bam
bedtools bamtobed -i ${samRoot1}.sorted.bam > ${samRoot1}.bed
bedtools coverage -a ${genome_file}.bed -b ${samRoot1}.bed > ${samRoot1}.cov

samtools view -F 4 -b ${samRoot2}.sam > ${samRoot2}.bam
samtools sort ${samRoot2}.bam -o ${samRoot2}.sorted.bam
samtools index ${samRoot2}.sorted.bam
bedtools bamtobed -i ${samRoot2}.sorted.bam > ${samRoot2}.bed
bedtools coverage -a ${genome_file}.bed -b ${samRoot2}.bed > ${samRoot2}.cov

# the last command doesn't hand paths correctly and the way of making bed files from genomes is also wrong, and requies a 0 before the total length
