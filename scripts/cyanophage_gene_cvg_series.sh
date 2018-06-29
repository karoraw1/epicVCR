
# the two peaks are in SERC_517_7, SERC_517_12, so we lump these

READS_DIR=~/scratch/Processed_data_group/SERC_051717_Shotgun_Metagenomes/QCd/QC_Renamed_Seqs

cd $READS_DIR
cat SERC_517_7_2.fastq SERC_517_12_2.fastq >> SERC_517_7and12_2.fastq
cat SERC_517_7_1.fastq SERC_517_12_1.fastq >> SERC_517_7and12_1.fastq

# we want coverage of cyanophage genes
REF_FA_DIR=~/scratch/Processed_data_group/repos/epicVCR/data/cyanophage_genomes
cd $REF_FA_DIR
mkdir Counts
# remove information lines from gff3 files
parallel -j 9 "sed -e '1,2d' {} > {.}.gff" ::: *.gff3
# remove all extra columns 
parallel -j 9 "cut -f 1,3,4,5 {} | grep gene | cut -f1,3,4 > {.}.genes" ::: *.gff

ml bowtie2 samtools
brc_=~/scratch/Processed_data_group/repos/bam-readcount-build/bin/bam-readcount

for c_g in `ls *.1.fasta`; do
   stub=`basename $c_g .fasta`
   bowtie2-build --seed 42 -o 3 $c_g ${stub}_bt2;
   bowtie2 -x ${stub}_bt2 -1 $READS_DIR/SERC_517_7and12_1.fastq \
   -2 $READS_DIR/SERC_517_7and12_2.fastq -S ${stub}_7and12.sam  -p 24;
   samtools view -@ 24 -h -b -S ${stub}_7and12.sam > ${stub}_7and12.bam;
   samtools view -@ 24 -b -F 4 ${stub}_7and12.bam > ${stub}_7and12.mapped.bam;
   samtools sort -@ 24 ${stub}_7and12.mapped.bam -o ${stub}_7and12.mapped.sorted.bam;
   samtools faidx $c_g
   $brc_ -q 20 -l ${stub}.genes -f $c_g ${stub}_7and12.mapped.sorted.bam 2> Counts/${stub}.err > Counts/${stub}.cnt
done
