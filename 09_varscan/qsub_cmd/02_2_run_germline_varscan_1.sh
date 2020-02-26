#!/bin/bash
#PBS -l nodes=1:ppn=2
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/09_varscan/qsub_sdout/02_2_run_germline_varscan_1.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/09_varscan
sh 02_germline_varscan.sh /home/users/jhyouk/06_mm10_SNUH_radiation/06_mpileup dirams_lowdose_germline