#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/08_delly/qsub_sdout/01_run_Delly_DEL_181211_1.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/08_delly
sh 00_1_DEL_Delly.sh /home/users/jhyouk/06_mm10_SNUH_radiation/03_bam dirams_Panc_C3_S01 dirams_Panc_C3_germline