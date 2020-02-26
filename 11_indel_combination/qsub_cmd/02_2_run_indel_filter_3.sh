#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/11_indel_combination/qsub_sdout/02_2_run_indel_filter_3.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/11_indel_combination
sh 02_1_bash_indel_filter.sh S1-1Gy-1 N1spleen