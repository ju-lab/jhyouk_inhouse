#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/09_varscan/qsub_sdout/00_1_run_varscan_190524_15_12.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/09_varscan
sh 00_varscan.sh /home/users/jhyouk/06_mm10_SNUH_radiation/06_mpileup mm_study4_fallopian_IR_SO1 IR-spleen