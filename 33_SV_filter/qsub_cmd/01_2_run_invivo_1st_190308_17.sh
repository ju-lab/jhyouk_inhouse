#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/33_SV_filter/qsub_sdout/01_2_run_invivo_1st_190308_17.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/33_SV_filter
sh 01_1_script_delly_annotation.sh Panc_2Gy2_SO2 Liver_2Gy_2_G