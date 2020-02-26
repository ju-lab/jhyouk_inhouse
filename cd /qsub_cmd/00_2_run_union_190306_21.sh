#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/31_SNP_New/qsub_sdout/00_2_run_union_190306_21.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/31_SNP_New
python 00_vcf_combination_by_Youk.py B3-0_0Gy_2 mouse 2 /home/users/jhyouk/06_mm10_SNUH_radiation/14_Strelka2/B3-0_0Gy_2/results/variants/somatic.snvs.vcf.gz /home/users/jhyouk/06_mm10_SNUH_radiation/09_varscan/B3-0_0Gy_2.varscan.snp.somatic.vcf &> B3-0_0Gy_2.union.out