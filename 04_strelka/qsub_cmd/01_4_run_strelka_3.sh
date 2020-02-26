#!/bin/bash
#PBS -l nodes=1:ppn=10
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/04_strelka/qsub_sdout/01_4_run_strelka_3.sh.sdout
#PBS -l mem=32GB
cd /home/users/jhyouk/06_mm10_SNUH_radiation/04_strelka
sh 00_strelka.sh /home/users/jhyouk/06_mm10_SNUH_radiation/03_bam/N1spleen.s.md.ir.br.bam /home/users/jhyouk/06_mm10_SNUH_radiation/03_bam/S1-1Gy-2.s.md.ir.br.bam S1-1Gy-2 /home/users/jhyouk/99_reference/mouse/mm10/GRCm38.fa