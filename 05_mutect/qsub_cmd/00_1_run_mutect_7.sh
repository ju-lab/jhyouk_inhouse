#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/05_mutect/qsub_sdout/00_1_run_mutect_7.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/05_mutect
sh 00_Mutect.sh /home/users/jhyouk/06_mm10_SNUH_radiation/03_bam dirams_8by4Gy_S2 dirams_8by4Gy_germline