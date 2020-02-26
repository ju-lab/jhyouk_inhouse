#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/31_SNP_New/qsub_sdout/02_1_pon_balbc_7_190227_35.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/31_SNP_New
python 02_AddNpanelToVCFsnp_vaf.py S1N2P16_4-4_union_2_normalpanel1_11.readinfo.readc.rasmy_pon_b6_4.vcf ../31_1_PanelOfNormal_SPark/mm10_balbc_7_190226.7s.q0Q0.chr1.mpileup.snv.edit.gz pon_balbc_7