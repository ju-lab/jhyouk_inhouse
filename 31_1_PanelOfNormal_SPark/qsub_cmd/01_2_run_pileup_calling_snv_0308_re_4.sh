#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/31_1_PanelOfNormal_SPark/qsub_sdout/01_2_run_pileup_calling_snv_0308_re_4.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/31_1_PanelOfNormal_SPark
python 01_pileup_calling_snv.py b6_others_somatic.28s.q0Q0.chr8.mpileup 28