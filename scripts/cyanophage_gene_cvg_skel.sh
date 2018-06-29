#!/bin/bash

#SBATCH
#SBATCH --job-name=@@@@@
#SBATCH --time=02:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=24
#SBATCH --mem=100G
#SBATCH --exclusive
#SBATCH --partition=gpuk80
#SBATCH --mail-type=END
#SBATCH --mail-user=karoraw1@jhu.edu

ml bowtie2 samtools
brc_=~/scratch/Processed_data_group/repos/bam-readcount-build/bin/bam-readcount
READS_DIR=~/scratch/Processed_data_group/SERC_051717_Shotgun_Metagenomes/QCd/QC_Renamed_Seqs
REF_FA_DIR=~/scratch/Processed_data_group/repos/epicVCR/data/cyanophage_genomes

c_g=*****

cd $REF_FA_DIR
stub=`basename $c_g .fasta`
bowtie2-build --seed 42 -o 3 $c_g ${stub}_bt2;
bowtie2 -x ${stub}_bt2 -1 $READS_DIR/SERC_517_7and12_1.fastq \
-2 $READS_DIR/SERC_517_7and12_2.fastq -S ${stub}_7and12.sam  -p 24;
samtools view -@ 24 -h -b -S ${stub}_7and12.sam > ${stub}_7and12.bam;
samtools view -@ 24 -b -F 4 ${stub}_7and12.bam > ${stub}_7and12.mapped.bam;
samtools sort -@ 24 ${stub}_7and12.mapped.bam -o ${stub}_7and12.mapped.sorted.bam;
samtools faidx $c_g
$brc_ -q 20 -l ${stub}.genes -f $c_g ${stub}_7and12.mapped.sorted.bam 2> Counts/${stub}.err > Counts/${stub}.cnt
