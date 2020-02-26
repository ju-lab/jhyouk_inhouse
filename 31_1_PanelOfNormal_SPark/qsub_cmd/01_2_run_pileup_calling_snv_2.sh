#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/10_2_SNP_SPark_filter/qsub_sdout/01_2_run_pileup_calling_snv_2.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/10_2_SNP_SPark_filter
python 01_pileup_calling_snv.py pon_mm10_radiation_190208.11s.q0Q0.chr2.mpileup 11