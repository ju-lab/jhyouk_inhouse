#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/06_mpileup/qsub_sdout/00_1_run_mpileup_190516_35.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/06_mpileup
sh 00_script_mpileup.sh mm_study4_germline_3nd_sham