#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/06_mpileup/qsub_sdout/98_gzip_36.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/06_mpileup
gzip Liver_2Gy2_SO4.mpileup &> Liver_2Gy2_SO4.mpileup.out