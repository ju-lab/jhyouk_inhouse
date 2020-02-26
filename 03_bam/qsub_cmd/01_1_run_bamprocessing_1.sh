#!/bin/bash
#PBS -l nodes=1:ppn=8
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/03_bam/qsub_sdout/01_1_run_bamprocessing_1.sh.sdout
#PBS -l mem=32GB
cd /home/users/jhyouk/06_mm10_SNUH_radiation/03_bam
sh 00_mm10_bamprocessing.sh /home/users/sypark/00_Project/17_jhy_files/1804KHX-0014/01_fastq/N1-spleen_R1.fastq.gz /home/users/sypark/00_Project/17_jhy_files/1804KHX-0014/01_fastq/N1-spleen_R1.fastq.gz N1-spleen /home/users/jhyouk/99_reference/mouse/mm10/GRCm38.fa