#!/bin/bash

#SBATCH
#SBATCH --job-name=serc_assembly
#SBATCH --time=20:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=12
#SBATCH --mem=100G
#SBATCH --exclusive
#SBATCH --partition=shared
#SBATCH --mail-type=END
#SBATCH --mail-user=karoraw1@jhu.edu
#SBATCH --error=serc_genes.err
#SBATCH --output=serc_genes.out

source activate metawrap2-env

##ASSEMBLY

#megahit -t 48 --min-contig-len 1000 --out-dir ../SERC_051717_Shotgun_Metagenomes/CoAssembly --verbose \
#-1 ../SERC_051717_Shotgun_Metagenomes/QCd/QC_Renamed_Seqs/SERC_517_10_1.fastq,\
#../SERC_051717_Shotgun_Metagenomes/QCd/QC_Renamed_Seqs/SERC_517_11_1.fastq,\
#../SERC_051717_Shotgun_Metagenomes/QCd/QC_Renamed_Seqs/SERC_517_12_1.fastq,\
#../SERC_051717_Shotgun_Metagenomes/QCd/QC_Renamed_Seqs/SERC_517_13_1.fastq,\
#../SERC_051717_Shotgun_Metagenomes/QCd/QC_Renamed_Seqs/SERC_517_3_1.fastq,\
#../SERC_051717_Shotgun_Metagenomes/QCd/QC_Renamed_Seqs/SERC_517_4_1.fastq,\
#../SERC_051717_Shotgun_Metagenomes/QCd/QC_Renamed_Seqs/SERC_517_5_1.fastq,\
#../SERC_051717_Shotgun_Metagenomes/QCd/QC_Renamed_Seqs/SERC_517_6_1.fastq,\
#../SERC_051717_Shotgun_Metagenomes/QCd/QC_Renamed_Seqs/SERC_517_7_1.fastq,\
#../SERC_051717_Shotgun_Metagenomes/QCd/QC_Renamed_Seqs/SERC_517_8_1.fastq,\
#../SERC_051717_Shotgun_Metagenomes/QCd/QC_Renamed_Seqs/SERC_517_9_1.fastq,\
#../SERC_051717_Shotgun_Metagenomes/QCd/QC_Renamed_Seqs/SERC_Zymo_Pos_Control_1.fastq \
#-2 ../SERC_051717_Shotgun_Metagenomes/QCd/QC_Renamed_Seqs/SERC_517_10_2.fastq,\
#../SERC_051717_Shotgun_Metagenomes/QCd/QC_Renamed_Seqs/SERC_517_11_2.fastq,\
#../SERC_051717_Shotgun_Metagenomes/QCd/QC_Renamed_Seqs/SERC_517_12_2.fastq,\
#../SERC_051717_Shotgun_Metagenomes/QCd/QC_Renamed_Seqs/SERC_517_13_2.fastq,\
#../SERC_051717_Shotgun_Metagenomes/QCd/QC_Renamed_Seqs/SERC_517_3_2.fastq,\
#../SERC_051717_Shotgun_Metagenomes/QCd/QC_Renamed_Seqs/SERC_517_4_2.fastq,\
#../SERC_051717_Shotgun_Metagenomes/QCd/QC_Renamed_Seqs/SERC_517_5_2.fastq,\
#../SERC_051717_Shotgun_Metagenomes/QCd/QC_Renamed_Seqs/SERC_517_6_2.fastq,\
#../SERC_051717_Shotgun_Metagenomes/QCd/QC_Renamed_Seqs/SERC_517_7_2.fastq,\
#../SERC_051717_Shotgun_Metagenomes/QCd/QC_Renamed_Seqs/SERC_517_8_2.fastq,\
#../SERC_051717_Shotgun_Metagenomes/QCd/QC_Renamed_Seqs/SERC_517_9_2.fastq,\
#../SERC_051717_Shotgun_Metagenomes/QCd/QC_Renamed_Seqs/SERC_Zymo_Pos_Control_2.fastq

##BINNING

#metaWRAP binning -t 48 --maxbin2 -a ../SERC_051717_Shotgun_Metagenomes/CoAssembly/final.contigs.fa \
#-o ../SERC_051717_Shotgun_Metagenomes/Bins \
#../SERC_051717_Shotgun_Metagenomes/QCd/QC_Renamed_Seqs/SERC_517_10_1.fastq ../SERC_051717_Shotgun_Metagenomes/QCd/QC_Renamed_Seqs/SERC_517_10_2.fastq \
#../SERC_051717_Shotgun_Metagenomes/QCd/QC_Renamed_Seqs/SERC_517_11_1.fastq ../SERC_051717_Shotgun_Metagenomes/QCd/QC_Renamed_Seqs/SERC_517_11_2.fastq \
#../SERC_051717_Shotgun_Metagenomes/QCd/QC_Renamed_Seqs/SERC_517_12_1.fastq ../SERC_051717_Shotgun_Metagenomes/QCd/QC_Renamed_Seqs/SERC_517_12_2.fastq \
#../SERC_051717_Shotgun_Metagenomes/QCd/QC_Renamed_Seqs/SERC_517_13_1.fastq ../SERC_051717_Shotgun_Metagenomes/QCd/QC_Renamed_Seqs/SERC_517_13_2.fastq \
#../SERC_051717_Shotgun_Metagenomes/QCd/QC_Renamed_Seqs/SERC_517_3_1.fastq ../SERC_051717_Shotgun_Metagenomes/QCd/QC_Renamed_Seqs/SERC_517_3_2.fastq \
#../SERC_051717_Shotgun_Metagenomes/QCd/QC_Renamed_Seqs/SERC_517_4_1.fastq ../SERC_051717_Shotgun_Metagenomes/QCd/QC_Renamed_Seqs/SERC_517_4_2.fastq \
#../SERC_051717_Shotgun_Metagenomes/QCd/QC_Renamed_Seqs/SERC_517_5_1.fastq ../SERC_051717_Shotgun_Metagenomes/QCd/QC_Renamed_Seqs/SERC_517_5_2.fastq \
#../SERC_051717_Shotgun_Metagenomes/QCd/QC_Renamed_Seqs/SERC_517_6_1.fastq ../SERC_051717_Shotgun_Metagenomes/QCd/QC_Renamed_Seqs/SERC_517_6_2.fastq \
#../SERC_051717_Shotgun_Metagenomes/QCd/QC_Renamed_Seqs/SERC_517_7_1.fastq ../SERC_051717_Shotgun_Metagenomes/QCd/QC_Renamed_Seqs/SERC_517_7_2.fastq \
#../SERC_051717_Shotgun_Metagenomes/QCd/QC_Renamed_Seqs/SERC_517_8_1.fastq ../SERC_051717_Shotgun_Metagenomes/QCd/QC_Renamed_Seqs/SERC_517_8_2.fastq \
#../SERC_051717_Shotgun_Metagenomes/QCd/QC_Renamed_Seqs/SERC_517_9_1.fastq ../SERC_051717_Shotgun_Metagenomes/QCd/QC_Renamed_Seqs/SERC_517_9_2.fastq \
#../SERC_051717_Shotgun_Metagenomes/QCd/QC_Renamed_Seqs/SERC_Zymo_Pos_Control_1.fastq ../SERC_051717_Shotgun_Metagenomes/QCd/QC_Renamed_Seqs/SERC_Zymo_Pos_Control_2.fastq

##GENE CALLS
cO_Asm=../SERC_051717_Shotgun_Metagenomes/CoAssembly
THIS_PROD=~/scratch/miniconda2/envs/metawrap2-env/bin/prodigal

$THIS_PROD -i $cO_Asm/final.contigs.fa -a $cO_Asm/final_contigs.faa \
-d $cO_Asm/final_contigs.fna -f gff -p meta -o $cO_Asm/final_contigs.gff

#source deactivate 
#source activate pyDesman

#NR_DMD=/data/sprehei1/metaWRAP_DBs/NCBI_nr_faa/nr.dmnd
#DESMAN=/home-3/karoraw1@jhu.edu/scratch/Processed_data_group/Scripts/DESMAN
#LINEAGE=/data/sprehei1/metaWRAP_DBs/NCBI_nr_faa/

#diamond blastp -p 32 -d $NR_DMD -q $cO_Asm/final_contigs.faa -a $cO_Asm/final_contigs > d.out
#diamond view -a $cO_Asm/final_contigs.daa -o $cO_Asm/final_contigs.m8
#python $DESMAN/scripts/Lengths.py -i $cO_Asm/final_contigs.faa > $cO_Asm/final_contigs_aa.lens
#python $DESMAN/scripts/ClassifyContigNR.py $cO_Asm/final_contigs.m8 $cO_Asm/final_contigs_aa.lens \
#-o $cO_Asm/final_contigs_nr -l $LINEAGE/all_taxa_lineage_notnone.tsv -g $LINEAGE/gi_taxid_prot.dmp

