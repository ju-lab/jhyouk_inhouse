#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/11_indel_combination/qsub_sdout/04_2_removeN1S1_7.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/11_indel_combination
sh 04_1_removeN1S1.sh S1-4Gy-1