#!/bin/bash
#PBS -l nodes=1:ppn=8
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/14_Strelka2/qsub_sdout/00_1_run_strelka2_1.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/14_Strelka2
sh 00_script.sh /home/users/jhyouk/06_mm10_SNUH_radiation/03_bam/Spleen_m3.s.md.ir.br.bam /home/users/jhyouk/06_mm10_SNUH_radiation/03_bam/breast_mother.s.md.ir.br.bam breast_spleen_mother_new