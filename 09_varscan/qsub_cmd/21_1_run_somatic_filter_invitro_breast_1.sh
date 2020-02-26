#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/09_varscan/qsub_sdout/21_1_run_somatic_filter_invitro_breast_1.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/09_varscan
python 21_somaticfilter.py B3-0_2Gy-2.varscan.indel.vcf
python 21_somaticfilter.py B3-0_2Gy-3.varscan.indel.vcf
python 21_somaticfilter.py B3-0_1Gy-4.varscan.indel.vcf
python 21_somaticfilter.py B3-0_2Gy-6.varscan.indel.vcf
python 21_somaticfilter.py B3-0_1Gy-5.varscan.indel.vcf
python 21_somaticfilter.py B3-0_2Gy-4.varscan.indel.vcf
python 21_somaticfilter.py B3-0_1Gy-6.varscan.indel.vcf
python 21_somaticfilter.py B3-0_1Gy_1-P20.varscan.indel.vcf
python 21_somaticfilter.py B3-0_P19_2Gy-8.varscan.indel.vcf
python 21_somaticfilter.py B3-0_1Gy-2.varscan.indel.vcf
python 21_somaticfilter.py B3-0_1Gy-3.varscan.indel.vcf
python 21_somaticfilter.py B3-0_P19_0Gy-1.varscan.indel.vcf
python 21_somaticfilter.py B3-0_0Gy-3.varscan.indel.vcf
python 21_somaticfilter.py B3-0_2Gy-5.varscan.indel.vcf
python 21_somaticfilter.py B3-0_P19_4Gy-4.varscan.indel.vcf
python 21_somaticfilter.py B3-0_P19_4Gy-5.varscan.indel.vcf
python 21_somaticfilter.py B3-0_2Gy-7.varscan.indel.vcf
python 21_somaticfilter.py B3-0_2Gy-1.varscan.indel.vcf
python 21_somaticfilter.py B3-0_P19_4Gy-2.varscan.indel.vcf
python 21_somaticfilter.py B3S100.varscan.indel.vcf
python 21_somaticfilter.py B3-0_0Gy_2.varscan.indel.vcf