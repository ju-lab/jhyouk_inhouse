#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/07_sequenza/qsub_sdout/14_1_run_report_Tspecific_absolute_CN_1.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/07_sequenza
python 14_report_Tspecific_absolute_CN.py S1-0Gy-1.mpileup.100kbcov N1-spleen.mpileup.100kbcov 30.15 38.86 1 2
python 14_report_Tspecific_absolute_CN.py S1-0Gy-2.mpileup.100kbcov N1-spleen.mpileup.100kbcov 36.17 38.86 1 2
python 14_report_Tspecific_absolute_CN.py S1-1Gy-1.mpileup.100kbcov N1-spleen.mpileup.100kbcov 35.77 38.86 1 2
python 14_report_Tspecific_absolute_CN.py S1-1Gy-2.mpileup.100kbcov N1-spleen.mpileup.100kbcov 36.65 38.86 1 2
python 14_report_Tspecific_absolute_CN.py S1-2Gy-1.mpileup.100kbcov N1-spleen.mpileup.100kbcov 36.59 38.86 1 2
python 14_report_Tspecific_absolute_CN.py S1-2Gy-2.mpileup.100kbcov N1-spleen.mpileup.100kbcov 36.17 38.86 1 2
python 14_report_Tspecific_absolute_CN.py S1-4Gy-1.mpileup.100kbcov N1-spleen.mpileup.100kbcov 35.87 38.86 1 2
python 14_report_Tspecific_absolute_CN.py S1-4Gy-2.mpileup.100kbcov N1-spleen.mpileup.100kbcov 35.34 38.86 1 2
python 14_report_Tspecific_absolute_CN.py S1-8Gy-1.mpileup.100kbcov N1-spleen.mpileup.100kbcov 36.61 38.86 1 2
python 14_report_Tspecific_absolute_CN.py N1-S1.mpileup.100kbcov N1-spleen.mpileup.100kbcov 38.91 38.86 1 2