#!/bin/bash
#PBS -q hotel
#PBS -N hisat2
#PBS -l nodes=1:ppn=16
#PBS -l walltime=48:00:00
#PBS -o /home/kay002/logs/hisat2.out
#PBS -e /home/kay002/logs/hisat2.err
#PBS -V 
#PBS -M kay002@ucsd.edu

# manual: http://daehwankimlab.github.io/hisat2/manual/

source /home/kay002/miniconda3/etc/profile.d/conda.sh
conda activate bulkrnaseq

HISAT2_GENOME=/oasis/tscc/scratch/z4jia/Genomes/GRCm38/HISAT2_GENOME/genome_tran # use all prefixes to the genome, eg. HISAT2_GENOME/genome_tran
DATA_DIR=/oasis/tscc/scratch/kay002/20MRepeat/FASTP
WORKING_DIR=/oasis/tscc/scratch/kay002/20MRepeat
METADATA_FILE=/home/kay002/bulk_RNAseq/filenames.txt

mkdir --parents ${WORKING_DIR}/HISAT2

while read f
do
	hisat2 -q \
	       --time \
	       --threads 16 \
	       -x ${HISAT2_GENOME} \
	       -1 ${DATA_DIR}/${f}_R1.trimmed.fastq \
	       -2 ${DATA_DIR}/${f}_R2.trimmed.fastq \
	       -S ${WORKING_DIR}/HISAT2/${f}.sam &> ${WORKING_DIR}/HISAT2/${f}_alignment_log.txt
done < $METADATA_FILE

mkdir ${WORKING_DIR}/HISAT2/logs
mv ${WORKING_DIR}/HISAT2/*.txt ${WORKING_DIR}/HISAT2/logs
