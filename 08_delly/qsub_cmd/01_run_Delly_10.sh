#!/bin/bash
#PBS -l nodes=1:ppn=6
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/08_delly/qsub_sdout/01_run_Delly_10.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/08_delly
sh 00_Delly.sh /home/users/jhyouk/06_mm10_SNUH_radiation/03_bam S1-4Gy-2 N1spleen S1-4Gy-2