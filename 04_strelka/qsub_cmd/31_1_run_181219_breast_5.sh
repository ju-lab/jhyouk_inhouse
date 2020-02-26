#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/04_strelka/qsub_sdout/31_1_run_181219_breast_5.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/04_strelka
python 31_Clonality_Mother_read_removal_breast.py B3-0_1Gy-5