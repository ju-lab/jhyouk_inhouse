#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/09_varscan/qsub_sdout/04_1_run_somatic_filter_1.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/09_varscan
python 21_somaticfilter.py B3-0_2Gy-2.varscan.snp.vcf
python 21_somaticfilter.py B3-0_2Gy-3.varscan.snp.vcf
python 21_somaticfilter.py B3-0_1Gy-4.varscan.snp.vcf
python 21_somaticfilter.py B3-0_2Gy-6.varscan.snp.vcf
python 21_somaticfilter.py B3-0_1Gy-5.varscan.snp.vcf
python 21_somaticfilter.py B3-0_2Gy-4.varscan.snp.vcf
python 21_somaticfilter.py B3-0_1Gy-6.varscan.snp.vcf
python 21_somaticfilter.py B3-0_1Gy_1-P20.varscan.snp.vcf
python 21_somaticfilter.py B3-0_P19_2Gy-8.varscan.snp.vcf
python 21_somaticfilter.py B3-0_1Gy-2.varscan.snp.vcf
python 21_somaticfilter.py B3-0_1Gy-3.varscan.snp.vcf
python 21_somaticfilter.py B3-0_P19_0Gy-1.varscan.snp.vcf
python 21_somaticfilter.py B3-0_0Gy-3.varscan.snp.vcf
python 21_somaticfilter.py B3-0_2Gy-5.varscan.snp.vcf
python 21_somaticfilter.py B3-0_P19_4Gy-4.varscan.snp.vcf
python 21_somaticfilter.py B3-0_P19_4Gy-5.varscan.snp.vcf
python 21_somaticfilter.py B3-0_2Gy-7.varscan.snp.vcf
python 21_somaticfilter.py B3-0_2Gy-1.varscan.snp.vcf
python 21_somaticfilter.py B3-0_P19_4Gy-2.varscan.snp.vcf
python 21_somaticfilter.py B3S100.varscan.snp.vcf
python 21_somaticfilter.py B3-0_0Gy_2.varscan.snp.vcf