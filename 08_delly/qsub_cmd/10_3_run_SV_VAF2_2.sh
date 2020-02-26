#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/08_delly/qsub_sdout/10_3_run_SV_VAF2_2.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/08_delly
sh 10_1_run_SV_VAF_annot.sh dirams_8by1Gy_S2