#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/31_1_PanelOfNormal_SPark/qsub_sdout/01_2_run_pileup_calling_snv_b6_4_190226_8.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/31_1_PanelOfNormal_SPark
python 01_pileup_calling_snv.py mm10_b6_4_190226.4s.q0Q0.chr8.mpileup 4