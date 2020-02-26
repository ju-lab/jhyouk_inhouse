#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/31_SNP_New/qsub_sdout/00_2_run_union_190221_43.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/31_SNP_New
python 00_vcf_combination_by_Youk.py S1N2P15_1-2a mouse 2 /home/users/jhyouk/06_mm10_SNUH_radiation/14_Strelka2/S1N2P15_1-2a/results/variants/somatic.snvs.vcf.gz /home/users/jhyouk/06_mm10_SNUH_radiation/09_varscan/S1N2P15_1-2a.varscan.snp.somatic.vcf &> S1N2P15_1-2a.union.out