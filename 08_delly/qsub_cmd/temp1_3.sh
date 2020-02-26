#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/08_delly/qsub_sdout/temp1_3.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/08_delly
sh 02_merge_delly.sh mm_study4_colon_sham_SO2
sh 02_merge_delly.sh mm_study4_colon_IR_SO1
sh 02_merge_delly.sh mm_study4_colon_IR_SO2