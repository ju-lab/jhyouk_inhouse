#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/03_bam/qsub_sdout/04_run_picard_readgroupchange_7.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/03_bam
sh 03_picard_readgroupchange.sh S1-4Gy-2