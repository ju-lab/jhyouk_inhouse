#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/08_delly/qsub_sdout/08_1_run_filter1_11.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/08_delly
python 08_NA_filter.py dirams_8Gy.delly.somatic.vcf.BPinfo4