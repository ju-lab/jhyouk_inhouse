#!/bin/bash
#PBS -l nodes=1:ppn=2
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/02_fastqc/qsub_sdout/00_run_fastqc_8.sh.sdout
#PBS -l mem=12GB
cd /home/users/jhyouk/06_mm10_SNUH_radiation/02_fastqc
fastqc -f fastq ~/06_mm10_SNUH_radiation/01_fastq/S1_P11_1Gy-1_R1.fastq.gz &>S1_1-2-R2.out