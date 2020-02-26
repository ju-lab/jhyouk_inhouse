#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/31_SNP_New/qsub_sdout/02_1_pon_b6_4_invitro_breast_190307_2.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/31_SNP_New
python 02_AddNpanelToVCFsnp_vaf.py B3-0_2Gy-3_union_2.readinfo.readc.rasmy.vcf ../31_1_PanelOfNormal_SPark/mm10_b6_4_190226.4s.q0Q0.chr1.mpileup.snv.edit.gz pon_b6_4