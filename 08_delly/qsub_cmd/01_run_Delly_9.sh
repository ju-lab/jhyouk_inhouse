#!/bin/bash
#PBS -l nodes=1:ppn=5
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/08_delly/qsub_sdout/01_run_Delly_9.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/08_delly
sh 00_Delly.sh /home/users/jhyouk/06_mm10_SNUH_radiation/03_bam dirams_lowdose_S2 dirams_lowdose_germline