#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/08_delly/qsub_sdout/07_run_filter_MH_MP_10.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/08_delly
sh 06_script_filter_MH_MP.sh dirams_8Gy /home/users/jhyouk/06_mm10_SNUH_radiation/03_bam dirams_8Gy dirams_germline