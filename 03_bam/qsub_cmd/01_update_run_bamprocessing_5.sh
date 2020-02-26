#!/bin/bash
#PBS -l nodes=1:ppn=8
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/03_bam/qsub_sdout/01_update_run_bamprocessing_5.sh.sdout
#PBS -l mem=32GB
cd /home/users/jhyouk/06_mm10_SNUH_radiation/03_bam
sh 00_update_mm10_bamprocessing.sh /home/users/jhyouk/06_mm10_SNUH_radiation/01_fastq/S1_P12_2Gy-1_R1.fastq.gz /home/users/jhyouk/06_mm10_SNUH_radiation/01_fastq/S1_P12_2Gy-1_R2.fastq.gz S1-2Gy-1 /home/users/jhyouk/99_reference/mouse/mm10/GRCm38.fa