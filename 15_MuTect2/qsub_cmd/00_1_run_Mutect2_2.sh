#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/15_MuTect2/qsub_sdout/00_1_run_Mutect2_2.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/15_MuTect2
sh 00_script_Mutect2.sh B8 Spleen_m3