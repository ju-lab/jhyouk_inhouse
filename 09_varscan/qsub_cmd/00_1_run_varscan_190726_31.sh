#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/09_varscan/qsub_sdout/00_1_run_varscan_190726_31.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/09_varscan
sh 00_varscan.sh /home/users/jhyouk/06_mm10_SNUH_radiation/06_mpileup mm_study4_SI_IR_SO1a SI_IR_BOPO