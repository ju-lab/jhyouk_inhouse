#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/33_SV_filter/qsub_sdout/01_2_run_breast_190307_8.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/33_SV_filter
sh 01_1_script_delly_annotation.sh B3-0_1Gy_1-P20 Spleen_m3