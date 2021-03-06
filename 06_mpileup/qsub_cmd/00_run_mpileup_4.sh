#!/bin/bash
#PBS -l nodes=1:ppn=2
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/06_mpileup/qsub_sdout/00_run_mpileup_4.sh.sdout
#PBS -l mem=32GB
cd /home/users/jhyouk/06_mm10_SNUH_radiation/06_mpileup
samtools mpileup -B -Q 20 -q 20 -f /home/users/jhyouk/99_reference/mouse/mm10/GRCm38.fa /home/users/jhyouk/06_mm10_SNUH_radiation/03_bam/dirams_germline.s.md.ir.br.bam | gzip > dirams_germline.mpileup.gz 2>/dev/null