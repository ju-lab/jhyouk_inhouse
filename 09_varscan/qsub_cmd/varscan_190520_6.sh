#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/09_varscan/qsub_sdout/varscan_190520_6.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/09_varscan
sh 00_varscan.sh /home/users/jhyouk/06_mm10_SNUH_radiation/06_mpileup mm_study4_stomach_IR_SO1 IR-spleen