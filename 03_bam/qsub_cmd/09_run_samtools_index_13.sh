#!/bin/bash
#PBS -l nodes=1:ppn=6
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/03_bam/qsub_sdout/09_run_samtools_index_13.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/03_bam
sh 08_samtools_index.sh dirams_8Gy