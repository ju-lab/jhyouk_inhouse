#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/07_sequenza/qsub_sdout/sequenza_190520_5.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/07_sequenza
sh 01_flow_sequenza_mm10.sh /home/users/jhyouk/06_mm10_SNUH_radiation/06_mpileup mm_study4_stomach_sham_SO3 Normal-spleen 1 2 mm10 XX