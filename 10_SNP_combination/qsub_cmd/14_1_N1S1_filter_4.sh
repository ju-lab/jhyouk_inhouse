#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/10_SNP_combination/qsub_sdout/14_1_N1S1_filter_4.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/10_SNP_combination
python 14_N1S1_filter.py S1-1Gy-2.combination.Mutect_Strelka_union.vcf.readinfo.filtered