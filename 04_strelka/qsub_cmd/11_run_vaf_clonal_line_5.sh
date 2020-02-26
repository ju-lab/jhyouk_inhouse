#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/04_strelka/qsub_sdout/11_run_vaf_clonal_line_5.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/04_strelka
python 10_vaf_clonal_line.py /home/users/jhyouk/06_mm10_SNUH_radiation/04_strelka S1-2Gy-1