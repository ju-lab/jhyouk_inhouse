#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/06_mpileup/qsub_sdout/temp_190306_12.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/06_mpileup
gzip -d Liver_2Gy2_SO1.mpileup.gz