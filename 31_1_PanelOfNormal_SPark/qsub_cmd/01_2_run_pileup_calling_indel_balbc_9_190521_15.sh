#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/31_1_PanelOfNormal_SPark/qsub_sdout/01_2_run_pileup_calling_indel_balbc_9_190521_15.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/31_1_PanelOfNormal_SPark
python 01_pileup_calling_indel_181203.py mm10_balbc_9_190521.9s.q0Q0.chr15.mpileup 9