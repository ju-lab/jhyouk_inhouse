#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/41_sequenza_mm10/qsub_sdout/01_1_run_mm10_flow_sequenza_invitrobreast_11.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/41_sequenza_mm10
sh 01_flow_sequenza_mm10.sh /home/users/jhyouk/06_mm10_SNUH_radiation/06_mpileup B3-0_1Gy-3 Spleen_m3 1 2 mm10 XX