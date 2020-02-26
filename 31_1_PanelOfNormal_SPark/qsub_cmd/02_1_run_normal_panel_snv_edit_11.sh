#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/10_2_SNP_SPark_filter/qsub_sdout/02_1_run_normal_panel_snv_edit_11.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/10_2_SNP_SPark_filter
python 02_normal_panel_snv_edit.py pon_mm10_radiation_190208.11s.q0Q0.chr11.mpileup.snv.gz 11