#!/bin/bash -l

#SBATCH

#SBATCH --job-name=casc
#SBATCH --time=5:00:00
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=24
#SBATCH --exclusive
#SBATCH --mem=100GB
#SBATCH --partition=parallel
#SBATCH --mail-type=END
#SBATCH --mail-user=k.arorawilliams@gmail.com
#SBATCH --error=casc.err
#SBATCH --output=casc.out

ml perl/5.26.2 blast git

## installation instructions
#git clone https://github.com/dnasko/CASC.git
#cd CASC; perl Makefile.PL PREFIX=$HOME/work
#make
#make test
#make install
#echo "PATH=$PATH:$HOME/work/bin" >> ~/.bash_profile
#echo "PERL5LIB=$HOME/lib/site_perl" >> ~/.bash_profile
#echo "export PATH" >> ~/.bash_profile
#git clone https://github.com/lh3/seqtk.git;
#cd seqtk; make
#mv seqtk ../seqtk_bin
#cd ..; rm -rf seqtk/; mv seqtk_bin seqtk;

source ~/.bash_profile

casc -i final.contigs.fa -o ContigCRISPRs -n 24

for fq_file in `ls *1.fastq`; do
   fa_base=${fq_file%.*}
   ./seqtk seq -a $fq_file > ${fa_base}.fa
   casc -i ${fa_base}.fa -o $fa_base -n 24
done


