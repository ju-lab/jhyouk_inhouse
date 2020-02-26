#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/07_sequenza/qsub_sdout/01_1_run_sequenza_190524_15_7.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/07_sequenza
sh 01_flow_sequenza_mm10.sh /home/users/jhyouk/06_mm10_SNUH_radiation/06_mpileup mm_study4_colon_sham_SO2 Normal-spleen 1 2 mm10 XX