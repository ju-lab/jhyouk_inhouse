#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/07_sequenza/qsub_sdout/01_1_run_sequenza_181205_25.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/07_sequenza
sh 01_flow_sequenza.sh /home/users/jhyouk/06_mm10_SNUH_radiation/06_mpileup male_panc_L3SO4 male_panc_L3BO