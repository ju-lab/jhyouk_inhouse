#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/07_sequenza/qsub_sdout/05_1_run_get_coverage_2.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/07_sequenza
python 05_human_get_coverage.py /home/users/jhyouk/06_mm10_SNUH_radiation/06_mpileup/HBIR1_germline.mpileup