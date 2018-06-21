#!/bin/bash -l

#SBATCH

#SBATCH --job-name=vir2con
#SBATCH --time=12:00:00
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=48
#SBATCH --mem=500GB
#SBATCH --exclusive
#SBATCH --partition=lrgmem
#SBATCH --mail-type=END
#SBATCH --mail-user=k.arorawilliams2@gmail.com

MUM_D=../bin/mummer-4.0.0beta2
QRY_=../../../SERC_051717_Shotgun_Metagenomes/CoAssembly/final.contigs.fa
REF_=../../../SERC_051717_Shotgun_Metagenomes/Virus_Coverage/viral_genomes.fasta
O_ROOT=../data/virus_to_contig_alignment

$MUM_D/nucmer --mum $REF_ $QRY_ -t 48 -p $O_ROOT
$MUM_D/delta-filter -l 1000 -q ${O_ROOT}.delta > ${O_ROOT}_filter.delta
$MUM_D/show-coords -c -l -L 1000 -r -T ${O_ROOT}_filter.delta | gzip > ${O_ROOT}_filter_coords.txt.gz

