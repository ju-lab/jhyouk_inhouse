#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/07_sequenza/qsub_sdout/05_1_run_invitro_pancreas_2.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/07_sequenza
python 05_get_coverage.py /home/users/jhyouk/06_mm10_SNUH_radiation/06_mpileup/S1P12_0-7.mpileup
python 05_get_coverage.py /home/users/jhyouk/06_mm10_SNUH_radiation/06_mpileup/S1P13_2-3.mpileup
python 05_get_coverage.py /home/users/jhyouk/06_mm10_SNUH_radiation/06_mpileup/S1N2P16_4-7.mpileup