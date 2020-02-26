#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/09_varscan/qsub_sdout/21_2_run_union_list_190220_1.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/09_varscan
python 21_somaticfilter.py N1-S1.varscan.snp.vcf
python 21_somaticfilter.py S1-4Gy-2.varscan.snp.vcf
python 21_somaticfilter.py S1-8Gy-1.varscan.snp.vcf
python 21_somaticfilter.py S1-1Gy-2.varscan.snp.vcf
python 21_somaticfilter.py S1-2Gy-2.varscan.snp.vcf
python 21_somaticfilter.py S1-0Gy-2.varscan.snp.vcf
python 21_somaticfilter.py S1-2Gy-1.varscan.snp.vcf
python 21_somaticfilter.py S1-4Gy-1.varscan.snp.vcf
python 21_somaticfilter.py S1-1Gy-1.varscan.snp.vcf
python 21_somaticfilter.py S1-0Gy-1.varscan.snp.vcf
python 21_somaticfilter.py S1P13_0-4.varscan.snp.vcf
python 21_somaticfilter.py S1P13_0-5.varscan.snp.vcf
python 21_somaticfilter.py S1P12_0-3.varscan.snp.vcf
python 21_somaticfilter.py S1P12_0-7.varscan.snp.vcf
python 21_somaticfilter.py S1P13_2-3.varscan.snp.vcf
python 21_somaticfilter.py S1N2P16_4-7.varscan.snp.vcf
python 21_somaticfilter.py S1N2P15_2-8.varscan.snp.vcf
python 21_somaticfilter.py S1N2P16_4-5.varscan.snp.vcf
python 21_somaticfilter.py S1N2P16_4-6.varscan.snp.vcf
python 21_somaticfilter.py S1N2P15_4-1.varscan.snp.vcf
python 21_somaticfilter.py S1N2P15_0-2.varscan.snp.vcf
python 21_somaticfilter.py S1N2P15_0-1.varscan.snp.vcf
python 21_somaticfilter.py S1N2P16_2-11.varscan.snp.vcf
python 21_somaticfilter.py S1N2P16_4-8.varscan.snp.vcf
python 21_somaticfilter.py S1N2P15_4-2.varscan.snp.vcf
python 21_somaticfilter.py S1N2P15_0-3.varscan.snp.vcf
python 21_somaticfilter.py S1N2P15_0-4.varscan.snp.vcf
python 21_somaticfilter.py S1N2P16_2-4.varscan.snp.vcf
python 21_somaticfilter.py S1N2P16_2-3.varscan.snp.vcf
python 21_somaticfilter.py S1N2P15_0-5.varscan.snp.vcf
python 21_somaticfilter.py S1N2P16_2-5.varscan.snp.vcf
python 21_somaticfilter.py S1N2P15_1-1.varscan.snp.vcf
python 21_somaticfilter.py S1N2P16_4-3.varscan.snp.vcf
python 21_somaticfilter.py S1N2P16_2-9.varscan.snp.vcf
python 21_somaticfilter.py S1N2P16_4-4.varscan.snp.vcf
python 21_somaticfilter.py S1N2P15_2-2.varscan.snp.vcf
python 21_somaticfilter.py S1N2P15_2-7.varscan.snp.vcf
python 21_somaticfilter.py S1N2P15_2-6.varscan.snp.vcf
python 21_somaticfilter.py S1N2P15_2-1a.varscan.snp.vcf
python 21_somaticfilter.py S1N2P15_1-3a.varscan.snp.vcf
python 21_somaticfilter.py S1N2P15_1-5a.varscan.snp.vcf
python 21_somaticfilter.py S1N2P15_1-4a.varscan.snp.vcf
python 21_somaticfilter.py S1N2P15_1-2a.varscan.snp.vcf