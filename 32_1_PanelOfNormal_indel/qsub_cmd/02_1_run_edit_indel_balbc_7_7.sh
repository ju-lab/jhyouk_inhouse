#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/32_1_PanelOfNormal_indel/qsub_sdout/02_1_run_edit_indel_balbc_7_7.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/32_1_PanelOfNormal_indel
python 02_normal_panel_indel_edit_181202.py  ../31_1_PanelOfNormal_SPark/mm10_balbc_7_190226.7s.q0Q0.chr7.mpileup.indel.gz 7