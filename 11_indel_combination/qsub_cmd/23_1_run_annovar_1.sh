#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/11_indel_combination/qsub_sdout/23_1_run_annovar_1.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/11_indel_combination
sh 23_Annovar.sh S1-0Gy-1
sh 23_Annovar.sh S1-0Gy-2
sh 23_Annovar.sh S1-1Gy-1
sh 23_Annovar.sh S1-1Gy-2
sh 23_Annovar.sh S1-2Gy-1
sh 23_Annovar.sh S1-2Gy-2
sh 23_Annovar.sh S1-4Gy-1
sh 23_Annovar.sh S1-4Gy-2
sh 23_Annovar.sh S1-8Gy-1