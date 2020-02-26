#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/43_bulk_organoid_snp/qsub_sdout/00_1_run_varscan_6.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/43_bulk_organoid_snp
sh 00_varscan.sh /home/users/jhyouk/06_mm10_SNUH_radiation/06_mpileup Panc_C3_BO mm_study4_germline_2nd_sham