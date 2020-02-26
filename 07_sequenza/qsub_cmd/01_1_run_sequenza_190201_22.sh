#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/07_sequenza/qsub_sdout/01_1_run_sequenza_190201_22.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/07_sequenza
sh 01_flow_sequenza.sh /home/users/jhyouk/06_mm10_SNUH_radiation/06_mpileup S1N2P16_2-9 N1spleen