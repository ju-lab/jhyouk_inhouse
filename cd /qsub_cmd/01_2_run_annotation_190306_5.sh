#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/31_SNP_New/qsub_sdout/01_2_run_annotation_190306_5.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/31_SNP_New
sh 01_1_script_run_annotation.sh B3-0_1Gy-5 B3S1