#!/bin/bash

#SBATCH
#SBATCH --job-name=v_recruit
#SBATCH --time=02:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=24
#SBATCH --mem=900G
#SBATCH --exclusive
#SBATCH --partition=lrgmem
#SBATCH --mail-type=END
#SBATCH --mail-user=karoraw1@jhu.edu
#SBATCH --error=v_rec2.err
#SBATCH --output=v_rec2.out

## This script recruits reads to all viral genomes with BWA
## It calculates genome lengths with a script from the DESMAN repo
## It calculates coverage with bedtools & samtools

ml samtools bedtools

W_D_=../SERC_051717_Shotgun_Metagenomes/Virus_Coverage
V_REF=/data/sprehei1/Raw_data/viral_genomes.fasta
LIB_DIR=../SERC_051717_Shotgun_Metagenomes/QCd/QC_Renamed_Seqs
MY_BWA=/home-3/karoraw1@jhu.edu/scratch/Processed_data_group/Scripts/bwa
V_REF2=$W_D_/`basename $V_REF`

#mkdir $W_D_; mkdir $W_D_/Map
#cp $V_REF $W_D_
#$MY_BWA index $V_REF2

#source activate pyDesman
#python3 ../repos/DESMAN/scripts/Lengths.py -i $V_REF2 > $W_D_/viral_genomes.len
#source deactivate

#for file in $LIB_DIR/*_1.fastq
#do 
#   stub=${file%_1.fastq}
#   file2=${stub}_2.fastq   
#   baseStub=`basename $stub`
#   echo $baseStub
#   $MY_BWA mem -t 48 $V_REF2 $file $file2 > $W_D_/Map/${baseStub}.sam
#done

for file in $W_D_/Map/*.sam
do
    stub=${file%.sam}
    echo $stub
#    samtools view -@ 24 -h -b -S $file > ${stub}.bam;
#    samtools view -@ 24 -b -F 4 ${stub}.bam > ${stub}.mapped.bam; 
#    samtools sort -@ 24 ${stub}.mapped.bam -o ${stub}.mapped.sorted.bam; 
    bedtools genomecov -max 1 -ibam ${stub}.mapped.sorted.bam -g $W_D_/viral_genomes.len > ${stub}_cov2.txt
done
