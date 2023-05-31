#!/bin/bash
#PBS -q hotel
#PBS -N fastp
#PBS -l nodes=1:ppn=16
#PBS -l walltime=48:00:00
#PBS -o /home/kay002/logs/fastp.out
#PBS -e /home/kay002/logs/fastp.err
#PBS -V 
#PBS -M kay002@ucsd.edu

# https://genomics.sschmeier.com/ngs-qc/index.html
# fastp manual: https://github.com/OpenGene/fastp#overrepresented-sequence-analysis

#activate your conda environment
source /home/kay002/miniconda3/etc/profile.d/conda.sh
conda activate bulkrnaseq

#paths to directories used
DATA_DIR=/oasis/tscc/scratch/kay002/20MRepeat/RNAseq_20M_raw
WORKING_DIR=/oasis/tscc/scratch/kay002/20MRepeat
READ1_ADAPTER=$(cat /home/kay002/bulk_RNAseq/Adapters/FASTP_R1.txt)
READ2_ADAPTER=$(cat /home/kay002/bulk_RNAseq/Adapters/FASTP_R2.txt)
METADATA_FILE=/home/kay002/bulk_RNAseq/filenames.txt

#make the directory to put the results
mkdir --parents ${WORKING_DIR}/FASTP
mkdir --parents ${WORKING_DIR}/FASTP/RESULTS

# decompress
for f in ${DATA_DIR}/*.gz
do
	gunzip ${f} &
done
wait

# for every set of pair-end data
while read f
do
	fastp --adapter_sequence ${READ1_ADAPTER}\
	      --adapter_sequence_r2 ${READ2_ADAPTER}\
	      --overrepresentation_analysis \
	      --correction --cut_front --cut_right --thread 16 \
	      --html ${WORKING_DIR}/FASTP/RESULTS/${f}.trimming.fastp.html \
	      --json ${WORKING_DIR}/FASTP/RESULTS/${f}.trimming.fastp.json \
	      --in1 ${DATA_DIR}/${f}_L001_R1_001.fastq --in2 ${DATA_DIR}/${f}_L001_R2_001.fastq \
	      --out1 ${WORKING_DIR}/FASTP/${f}_R1.trimmed.fastq --out2 ${WORKING_DIR}/FASTP/${f}_R2.trimmed.fastq
done < $METADATA_FILE

# recompress
for f in ${DATA_DIR}/*.fastq
do
	gzip ${f} &
done
wait

