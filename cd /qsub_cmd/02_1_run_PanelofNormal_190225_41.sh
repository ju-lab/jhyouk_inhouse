#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/31_SNP_New/qsub_sdout/02_1_run_PanelofNormal_190225_41.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/31_SNP_New
python 02_AddNpanelToVCFsnp_vaf.py S1N2P15_1-5a_union_2.vcf ../31_1_PanelOfNormal_SPark/pon_mm10_radiation_190208.11s.q0Q0.chr1.mpileup.snv.edit.gz normalpanel1_11