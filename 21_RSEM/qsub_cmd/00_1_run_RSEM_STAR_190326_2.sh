#!/bin/bash
#PBS -l nodes=1:ppn=4
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/21_RSEM/qsub_sdout/00_1_run_RSEM_STAR_190326_2.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/21_RSEM
sh 00_RSEM_STAR_script.sh M3P4_breast_bul