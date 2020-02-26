#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/05_mutect/qsub_sdout/01_run_Mutect_9.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/05_mutect
sh 00_Mutect.sh S1-4Gy-2 N1spleen S1-4Gy-2 /home/users/jhyouk/06_mm10_SNUH_radiation/03_bam