#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/06_mpileup/qsub_sdout/21_1_run2_58.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/06_mpileup
python 21_callable_region_bed_file.py B3-0_P19_4Gy-5 &> B3-0_P19_4Gy-5.out