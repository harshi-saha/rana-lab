#!/bin/bash
#PBS -q hotel
#PBS -N htseq_count
#PBS -l nodes=1:ppn=16
#PBS -l walltime=48:00:00
#PBS -o /home/kay002/logs/htseq.out
#PBS -e /home/kay002/logs/htseq.err
#PBS -V 
#PBS -M kay002@ucsd.edu

# manual: https://htseq.readthedocs.io/en/release_0.11.1/count.html, https://manpages.ubuntu.com/manpages/bionic/man1/htseq-count.1.html
# pip install --upgrade numpy if binary incompatibility arises

#htseq installed by pip, no need to activate environment

DATA_DIR=/oasis/tscc/scratch/kay002/20MRepeat/HISAT2
WORKING_DIR=/oasis/tscc/scratch/kay002/20MRepeat
GTF_FILE=/oasis/tscc/scratch/z4jia/Genomes/GRCm38/Mus_musculus.GRCm38.102.gtf
METADATA_FILE=/home/kay002/bulk_RNAseq/filenames.txt

mkdir --parents ${WORKING_DIR}/HTSEQ

while read f
do
	htseq-count -n 16 \
		    -f sam \
		    -s no \
		    -i gene_name \
		    -r name \
		    ${DATA_DIR}/${f}.sam \
		    ${GTF_FILE} > ${WORKING_DIR}/HTSEQ/${f}.genename_count.txt 

done < ${METADATA_FILE}
