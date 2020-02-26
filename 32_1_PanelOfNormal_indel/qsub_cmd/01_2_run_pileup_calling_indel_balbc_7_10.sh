#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/32_1_PanelOfNormal_indel/qsub_sdout/01_2_run_pileup_calling_indel_balbc_7_10.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/32_1_PanelOfNormal_indel
python 01_pileup_calling_indel_181203.py  ../31_1_PanelOfNormal_SPark/mm10_balbc_7_190226.7s.q0Q0.chr10.mpileup 7