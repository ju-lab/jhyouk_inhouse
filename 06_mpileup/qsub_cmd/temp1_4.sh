#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/06_mpileup/qsub_sdout/temp1_4.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/06_mpileup
gzip -d S1-0Gy-2.mpileup.gz