#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/07_sequenza/qsub_sdout/05_1_run_invitro_pancreas_4.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/07_sequenza
python 05_get_coverage.py /home/users/jhyouk/06_mm10_SNUH_radiation/06_mpileup/S1N2P15_4-1.mpileup
python 05_get_coverage.py /home/users/jhyouk/06_mm10_SNUH_radiation/06_mpileup/S1N2P15_0-2.mpileup
python 05_get_coverage.py /home/users/jhyouk/06_mm10_SNUH_radiation/06_mpileup/S1N2P15_0-1.mpileup