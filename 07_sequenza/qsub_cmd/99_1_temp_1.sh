#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/07_sequenza/qsub_sdout/99_1_temp_1.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/07_sequenza
sh 99_flow_sequenza.sh /home/users/jhyouk/06_mm10_SNUH_radiation/06_mpileup C3SO3 L3_Germline