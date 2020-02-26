#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/08_delly/qsub_sdout/98_run_filter_MH_MP_4.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/08_delly
#sh 06_script_filter_MH_MP.sh S1-1Gy-2 /home/users/jhyouk/06_mm10_SNUH_radiation/03_bam S1-1Gy-2 N1spleen