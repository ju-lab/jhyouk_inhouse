#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/05_mutect/qsub_sdout/01_run_Mutect_11.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/05_mutect
sh 00_Mutect.sh dirams_8Gy dirams_germline dirams_8Gy /home/users/jhyouk/06_mm10_SNUH_radiation/03_bam