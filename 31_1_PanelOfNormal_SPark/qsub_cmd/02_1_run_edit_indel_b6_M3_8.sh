#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/31_1_PanelOfNormal_SPark/qsub_sdout/02_1_run_edit_indel_b6_M3_8.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/31_1_PanelOfNormal_SPark
python 02_normal_panel_indel_edit_181202.py b6_M3.23s.q0Q0.chr8.mpileup.indel.gz 23