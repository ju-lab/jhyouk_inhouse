#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/31_1_PanelOfNormal_SPark/qsub_sdout/01_2_run_pileup_calling_snv_b6_N1_re_1.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/31_1_PanelOfNormal_SPark
python 01_pileup_calling_snv.py b6_N1.44s.q0Q0.chr1.mpileup 44