#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/31_SNP_New/qsub_sdout/00_2_run_union_190221_1.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/31_SNP_New
python 00_vcf_combination_by_Youk.py N1-S1 mouse 2 /home/users/jhyouk/06_mm10_SNUH_radiation/14_Strelka2/N1-S1/results/variants/somatic.snvs.vcf.gz /home/users/jhyouk/06_mm10_SNUH_radiation/09_varscan/N1-S1.varscan.snp.somatic.vcf &> N1-S1.union.out