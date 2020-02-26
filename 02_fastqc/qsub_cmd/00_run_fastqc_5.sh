#!/bin/bash
#PBS -l nodes=1:ppn=2
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/02_fastqc/qsub_sdout/00_run_fastqc_5.sh.sdout
#PBS -l mem=12GB
cd /home/users/jhyouk/06_mm10_SNUH_radiation/02_fastqc
fastqc -f fastq ~/06_mm10_SNUH_radiation/01_fastq/S1_P12_4Gy-1_R1.fastq.gz &>S1_1-1-R1.out