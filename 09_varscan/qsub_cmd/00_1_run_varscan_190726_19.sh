#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/09_varscan/qsub_sdout/00_1_run_varscan_190726_19.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/09_varscan
#sh 00_varscan.sh /home/users/jhyouk/06_mm10_SNUH_radiation/06_mpileup mm_study3_pancreas_Lowdose_SO1 male_panc_L3BO