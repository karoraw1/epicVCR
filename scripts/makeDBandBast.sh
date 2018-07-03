#!/bin/bash

#SBATCH
#SBATCH --job-name=homo_check
#SBATCH --time=3:00:00
#SBATCH --mail-type=END
#SBATCH --mail-user=karoraw1@jhu.edu
#SBATCH --nodes=1
#SBATCH --exclusive
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=24
#SBATCH --mem=100G
#SBATCH --partition=parallel

ml blast parallel

outD=/home-3/karoraw1@jhu.edu/scratch/Processed_data_group/repos/epicVCR/data/Bins/Blast_DBs
#mkdir -p $outD
#inD=../data/Bins/maxbin2_bins
#cd $inD
#parallel -j 24 "makeblastdb -in {} -input_type fasta -dbtype nucl -out ../Blast_DBs/{.}.db" ::: *.fa
cd $outD
parallel -j 24 "blastn -task dc-megablast -db {.} -query /home-3/karoraw1@jhu.edu/scratch/Processed_data_group/repos/epicVCR/data/CFB_contig_5.fasta -outfmt '6 qseqid qstart qend qlen sseqid staxids sstart send bitscore evalue nident length' -out {.}.hits" ::: *.db.nhr
