#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/06_mpileup/qsub_sdout/98_gzip_1.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/06_mpileup
gzip dirams_lowdose_S2.mpileup &> dirams_lowdose_S2.mpileup.out &&
gzip B3P16_0Gy_4.mpileup &> B3P16_0Gy_4.mpileup.out &&
gzip Liver_8Gy1_SO5.mpileup &> Liver_8Gy1_SO5.mpileup.out &&
gzip Liver_20Gy1_SO2.mpileup &> Liver_20Gy1_SO2.mpileup.out &&
gzip dirams_20Gy_S2.mpileup &> dirams_20Gy_S2.mpileup.out &&
gzip Panc_8Gy1_BO.mpileup &> Panc_8Gy1_BO.mpileup.out &&
gzip B3-0_0Gy_2.mpileup &> B3-0_0Gy_2.mpileup.out &&
gzip C3SO3.mpileup &> C3SO3.mpileup.out &&
gzip Liver_C3SO1.mpileup &> Liver_C3SO1.mpileup.out &&
gzip Liver_20Gy1_SO4.mpileup &> Liver_20Gy1_SO4.mpileup.out &&
gzip Liver_8Gy1_SO3.mpileup &> Liver_8Gy1_SO3.mpileup.out &&
gzip dirams_8by1Gy_S2.mpileup &> dirams_8by1Gy_S2.mpileup.out &&
gzip dirams_lowdose_S1.mpileup &> dirams_lowdose_S1.mpileup.out &&
gzip Spleen_m3.mpileup &> Spleen_m3.mpileup.out &&
gzip dirams_lowdose_germline.mpileup &> dirams_lowdose_germline.mpileup.out &&
gzip dirams_20Gy_germline.mpileup &> dirams_20Gy_germline.mpileup.out &&
gzip breast_mother.mpileup &> breast_mother.mpileup.out &&
gzip dirams_8by1Gy_germline.mpileup &> dirams_8by1Gy_germline.mpileup.out &&
gzip Panc_8Gy1_SO1.mpileup &> Panc_8Gy1_SO1.mpileup.out &&
gzip Liver_2Gy2_SO1.mpileup &> Liver_2Gy2_SO1.mpileup.out &&
gzip dirams_8by4Gy_germline.mpileup &> dirams_8by4Gy_germline.mpileup.out &&
gzip Panc_20Gy1_SO2.mpileup &> Panc_20Gy1_SO2.mpileup.out &&
gzip dirams_20Gy_S1.mpileup &> dirams_20Gy_S1.mpileup.out &&
gzip breast_germline.mpileup &> breast_germline.mpileup.out &&
gzip Liver_C3SO2.mpileup &> Liver_C3SO2.mpileup.out &&
gzip Panc_2Gy2_SO2.mpileup &> Panc_2Gy2_SO2.mpileup.out &&
gzip Panc_C3_BO.mpileup &> Panc_C3_BO.mpileup.out &&
gzip Liver_20Gy1_SO1.mpileup &> Liver_20Gy1_SO1.mpileup.out &&
gzip B8.mpileup &> B8.mpileup.out &&
gzip Panc_8Gy1_SO3.mpileup &> Panc_8Gy1_SO3.mpileup.out &&
gzip dirams_8by1Gy_S1.mpileup &> dirams_8by1Gy_S1.mpileup.out &&
gzip dirams_8by4Gy_S1.mpileup &> dirams_8by4Gy_S1.mpileup.out &&
gzip N1-spleen.mpileup &> N1-spleen.mpileup.out &&
gzip Liver_2Gy2_SO2.mpileup &> Liver_2Gy2_SO2.mpileup.out &&
gzip dirams_8by4Gy_S2.mpileup &> dirams_8by4Gy_S2.mpileup.out &&
gzip Liver_2Gy2_SO4.mpileup &> Liver_2Gy2_SO4.mpileup.out