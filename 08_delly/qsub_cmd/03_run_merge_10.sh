#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/08_delly/qsub_sdout/03_run_merge_10.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/08_delly
sh 02_merge_delly.sh N1-S1