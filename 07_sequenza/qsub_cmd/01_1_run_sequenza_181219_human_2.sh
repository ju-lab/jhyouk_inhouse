#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/07_sequenza/qsub_sdout/01_1_run_sequenza_181219_human_2.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/07_sequenza
sh 01_human_flow_sequenza.sh /home/users/jhyouk/06_mm10_SNUH_radiation/06_mpileup HBIR1-2 HBIR1_germline