#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/06_mpileup/qsub_sdout/21_1_run2_36.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/06_mpileup
python 21_callable_region_bed_file.py S1N2P15_2-7 &> S1N2P15_2-7.out