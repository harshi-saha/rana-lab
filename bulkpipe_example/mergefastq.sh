DATA_DIR=

cd ${DATA_DIR}

cat <seq_file_A>_R1.fastq <seq_file_B>_R1.fastq > <merged_file>_R1.fastq &
cat <seq_file_A>_R2.fastq <seq_file_B>_R2.fastq > <merged_file>_R2.fastq &

