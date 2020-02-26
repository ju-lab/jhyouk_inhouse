#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/05_mutect/qsub_sdout/02_1_run_filter_pass_1.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/05_mutect
sh 02_filter_pass.sh S1-0Gy-1
sh 02_filter_pass.sh S1-0Gy-2
sh 02_filter_pass.sh S1-1Gy-1
sh 02_filter_pass.sh S1-1Gy-2
sh 02_filter_pass.sh S1-2Gy-1
sh 02_filter_pass.sh S1-2Gy-2
sh 02_filter_pass.sh S1-4Gy-1
sh 02_filter_pass.sh S1-4Gy-2
sh 02_filter_pass.sh S1-8Gy-1
sh 02_filter_pass.sh N1-S1
sh 02_filter_pass.sh dirams_8Gy