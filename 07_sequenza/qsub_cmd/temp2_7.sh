#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/07_sequenza/qsub_sdout/temp2_7.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/07_sequenza
python 05_get_coverage.py /home/users/jhyouk/06_mm10_SNUH_radiation/06_mpileup/male_panc_L3BO.mpileup