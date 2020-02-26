#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/05_mutect/qsub_sdout/99_run_Mutect_1.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/05_mutect
sh 00_Mutect.sh S1-0Gy-1 N1S1 S1-0Gy-1_N1S1 /home/users/jhyouk/06_mm10_SNUH_radiation/03_bam