#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/31_SNP_New/qsub_sdout/02_1_pon_b6_4_190227_40.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/31_SNP_New
python 02_AddNpanelToVCFsnp_vaf.py S1N2P15_1-3a_union_2_normalpanel1_11.vcf.readinfo.readc.rasmy ../31_1_PanelOfNormal_SPark/mm10_b6_4_190226.4s.q0Q0.chr1.mpileup.snv.edit.gz pon_b6_4