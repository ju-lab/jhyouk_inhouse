#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/31_1_PanelOfNormal_SPark/qsub_sdout/02_1_run_edit_indel_b6_N1_7.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/31_1_PanelOfNormal_SPark
python 02_normal_panel_indel_edit_181202.py b6_N1.44s.q0Q0.chr7.mpileup.indel.gz 44