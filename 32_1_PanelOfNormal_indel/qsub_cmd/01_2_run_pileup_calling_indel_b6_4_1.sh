#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/32_1_PanelOfNormal_indel/qsub_sdout/01_2_run_pileup_calling_indel_b6_4_1.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/32_1_PanelOfNormal_indel
python 01_pileup_calling_indel_181203.py  ../31_1_PanelOfNormal_SPark/mm10_b6_4_190226.4s.q0Q0.chr1.mpileup 4