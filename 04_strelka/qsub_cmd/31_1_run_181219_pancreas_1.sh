#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/04_strelka/qsub_sdout/31_1_run_181219_pancreas_1.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/04_strelka
python 31_Clonality_Mother_read_removal.py S1P13_2-3