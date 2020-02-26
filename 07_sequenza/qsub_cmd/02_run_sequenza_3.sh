#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/07_sequenza/qsub_sdout/02_run_sequenza_3.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/07_sequenza
sh 01_flow_sequenza.sh /home/users/jhyouk/06_mm10_SNUH_radiation/06_mpileup/N1-spleen.mpileup.gz /home/users/jhyouk/06_mm10_SNUH_radiation/06_mpileup/S1-1Gy-1.mpileup.gz S1-1Gy-1