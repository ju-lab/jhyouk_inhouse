#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/31_1_PanelOfNormal_SPark/qsub_sdout/02_1_run_edit_b6_6_190522_10.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/31_1_PanelOfNormal_SPark
python 02_normal_panel_snv_edit.py mm10_b6_6_190521.6s.q0Q0.chr10.mpileup.snv.gz 6