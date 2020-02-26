#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/08_delly/qsub_sdout/11_2_run_dellyVaf_1.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/08_delly
sh 11_1_script_dellyVaf.sh S1-0Gy-1
sh 11_1_script_dellyVaf.sh S1-0Gy-2
sh 11_1_script_dellyVaf.sh S1-1Gy-1
sh 11_1_script_dellyVaf.sh S1-1Gy-2
sh 11_1_script_dellyVaf.sh S1-2Gy-1
sh 11_1_script_dellyVaf.sh S1-2Gy-2
sh 11_1_script_dellyVaf.sh S1-4Gy-1
sh 11_1_script_dellyVaf.sh S1-4Gy-2
sh 11_1_script_dellyVaf.sh S1-8Gy-1
sh 11_1_script_dellyVaf.sh N1-S1
sh 11_1_script_dellyVaf.sh dirams_8Gy