#!/bin/bash
#PBS -l nodes=1:ppn=2
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/06_mpileup/qsub_sdout/00_run_mpileup_13.sh.sdout
#PBS -l mem=32GB
cd /home/users/jhyouk/06_mm10_SNUH_radiation/06_mpileup
samtools mpileup -B -Q 20 -q 20 -f /home/users/jhyouk/99_reference/mouse/mm10/GRCm38.fa /home/users/jhyouk/06_mm10_SNUH_radiation/03_bam/S1-8Gy-1.s.md.ir.br.bam | gzip > S1-8Gy-1.mpileup.gz 2>/dev/null