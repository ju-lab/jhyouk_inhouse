#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/31_1_PanelOfNormal_SPark/qsub_sdout/02_1_run_edit_b6_4_190226_7.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/31_1_PanelOfNormal_SPark
python 02_normal_panel_snv_edit.py mm10_b6_4_190226.4s.q0Q0.chr7.mpileup.snv.gz 4