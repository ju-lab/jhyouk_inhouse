#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/07_sequenza/qsub_sdout/01_1_run_sequenza_190726_32.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/07_sequenza
#sh 01_flow_sequenza_mm10.sh /home/users/jhyouk/06_mm10_SNUH_radiation/06_mpileup mm_study4_SI_IR_SO3a SI_IR_BOPO 1 2 mm10 XY