#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/06_mpileup/qsub_sdout/00_1_run_mpileup_190218_2.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/06_mpileup
sh 00_script_mpileup.sh test_190218