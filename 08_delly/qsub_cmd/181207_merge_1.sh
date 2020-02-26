#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/08_delly/qsub_sdout/181207_merge_1.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/08_delly
python 04_filter_somatic.py Panc_20Gy1_SO2.delly.vcf &&
python 04_filter_somatic.py Liver_20Gy1_SO1.delly.vcf &&
python 04_filter_somatic.py Liver_20Gy1_SO2.delly.vcf &&
python 04_filter_somatic.py Liver_20Gy1_SO4.delly.vcf &&
python 04_filter_somatic.py Panc_8Gy1_SO1.delly.vcf &&
python 04_filter_somatic.py Panc_8Gy1_SO3.delly.vcf &&
python 04_filter_somatic.py Liver_8Gy1_SO3.delly.vcf &&
python 04_filter_somatic.py Liver_8Gy1_SO5.delly.vcf &&
python 04_filter_somatic.py Panc_2Gy2_SO2.delly.vcf &&
python 04_filter_somatic.py Liver_2Gy2_SO1.delly.vcf &&
python 04_filter_somatic.py Liver_2Gy2_SO2.delly.vcf &&
python 04_filter_somatic.py Liver_2Gy2_SO4.delly.vcf &&
python 04_filter_somatic.py C3SO3.delly.vcf &&
python 04_filter_somatic.py Liver_C3SO1.delly.vcf &&
python 04_filter_somatic.py Liver_C3SO2.delly.vcf &&
python 04_filter_somatic.py S1P13_2-3.delly.vcf &&
python 04_filter_somatic.py S1P13_0-4.delly.vcf &&
python 04_filter_somatic.py S1P13_0-5.delly.vcf &&
python 04_filter_somatic.py S1P12_0-7.delly.vcf &&
python 04_filter_somatic.py S1P12_0-3.delly.vcf &&
python 04_filter_somatic.py B3-0_1Gy-3.delly.vcf &&
python 04_filter_somatic.py B3-0_1Gy-4.delly.vcf &&
python 04_filter_somatic.py B3-0_2Gy-6.delly.vcf &&
python 04_filter_somatic.py B3-0_1Gy_1-P20.delly.vcf &&
python 04_filter_somatic.py B3-0_1Gy-5.delly.vcf &&
python 04_filter_somatic.py B3-0_0Gy-3.delly.vcf &&
python 04_filter_somatic.py B3-0_P19_4Gy-4.delly.vcf &&
python 04_filter_somatic.py B3-0_P19_4Gy-5.delly.vcf &&
python 04_filter_somatic.py B3-0_P19_2Gy-8.delly.vcf &&
python 04_filter_somatic.py B3-0_P19_0Gy-1.delly.vcf &&
python 04_filter_somatic.py B3-0_1Gy-6.delly.vcf &&
python 04_filter_somatic.py B3-0_1Gy-2.delly.vcf &&
python 04_filter_somatic.py B3-0_2Gy-7.delly.vcf &&
python 04_filter_somatic.py B3-0_P19_4Gy-2.delly.vcf &&
python 04_filter_somatic.py B3-0_2Gy-1.delly.vcf &&
python 04_filter_somatic.py B3-0_2Gy-5.delly.vcf &&
python 04_filter_somatic.py B3-0_2Gy-2.delly.vcf &&
python 04_filter_somatic.py B3-0_2Gy-3.delly.vcf &&
python 04_filter_somatic.py B3-0_2Gy-4.delly.vcf &&
python 04_filter_somatic.py male_panc_L3SO4.delly.vcf &&
python 04_filter_somatic.py male_panc_L3SO5.delly.vcf &&
python 04_filter_somatic.py B3P7.delly.vcf &&
python 04_filter_somatic.py B8.delly.vcf &&
python 04_filter_somatic.py B3-0_0Gy_2.delly.vcf &&
python 04_filter_somatic.py B3P16_0Gy_4.delly.vcf &&
echo finish