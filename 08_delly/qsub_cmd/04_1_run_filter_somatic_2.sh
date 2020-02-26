#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/08_delly/qsub_sdout/04_1_run_filter_somatic_2.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/08_delly
python 04_filter_somatic.py S1-0Gy-2.delly.vcf