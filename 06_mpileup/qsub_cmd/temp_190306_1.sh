#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/06_mpileup/qsub_sdout/temp_190306_1.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/06_mpileup
gzip -d Panc_20Gy1_SO2.mpileup.gz