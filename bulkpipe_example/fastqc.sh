#!/bin/bash
#PBS -q hotel
#PBS -N fastqc
#PBS -l nodes=1:ppn=16
#PBS -l walltime=48:00:00
#PBS -o /home/kay002/logs/fastqc.out
#PBS -e /home/kay002/logs/fastqc.err
#PBS -V 
#PBS -M kay002@ucsd.edu

# FASTQC manual: https://www.bioinformatics.babraham.ac.uk/projects/fastqc/Help/

source /home/kay002/miniconda3/etc/profile.d/conda.sh
conda activate bulkrnaseq

DATA_DIR_FILTERED=/oasis/tscc/scratch/kay002/20MRepeat/FASTP
DATA_DIR_RAW=/oasis/tscc/scratch/kay002/20MRepeat/RNAseq_20M_raw
WORKING_DIR=/oasis/tscc/scratch/kay002/20MRepeat
ADAPTERS=/home/kay002/bulk_RNAseq/Adapters/FASTQC_PE.txt

mkdir --parents $WORKING_DIR/FASTQC_RAW
mkdir --parents $WORKING_DIR/FASTQC_FILTERED

# QC for raw files
for f in ${DATA_DIR_RAW}/*.fastq*
do
	fastqc ${f} \
	       --threads 16 \
	       --outdir ${WORKING_DIR}/FASTQC_RAW \
	       --adapters ${ADAPTERS} 
done

# QC for filtered files
for f in ${DATA_DIR_FILTERED}/*.fastq*
do
	fastqc ${f} \
	       --threads 16 \
	       --outdir ${WORKING_DIR}/FASTQC_FILTERED \
	       --adapters ${ADAPTERS}  
done
