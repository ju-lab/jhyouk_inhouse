#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/32_indel_filter/qsub_sdout/000_2_run_invivo_1st_10.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/32_indel_filter
sh 000_1_script_run_invivo.sh Liver_C3SO2 Panc_C3_BO