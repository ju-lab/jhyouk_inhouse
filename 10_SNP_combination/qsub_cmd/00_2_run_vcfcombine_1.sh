#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/10_SNP_combination/qsub_sdout/00_2_run_vcfcombine_1.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/10_SNP_combination
#sh 00_1_script.sh S1-0Gy-1
sh 00_1_script.sh S1-0Gy-2
sh 00_1_script.sh S1-1Gy-1
sh 00_1_script.sh S1-1Gy-2
sh 00_1_script.sh S1-2Gy-1
sh 00_1_script.sh S1-2Gy-2
sh 00_1_script.sh S1-4Gy-1
sh 00_1_script.sh S1-4Gy-2
sh 00_1_script.sh S1-8Gy-1
sh 00_1_script.sh N1-S1
sh 00_1_script.sh dirams_8Gy