#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/07_sequenza/qsub_sdout/05_1_run_invitro_breast_11.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/07_sequenza
python 05_get_coverage.py /home/users/jhyouk/06_mm10_SNUH_radiation/06_mpileup/B3-0_1Gy-3.mpileup