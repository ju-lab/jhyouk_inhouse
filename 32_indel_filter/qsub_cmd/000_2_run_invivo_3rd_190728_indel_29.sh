#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/32_indel_filter/qsub_sdout/000_2_run_invivo_3rd_190728_indel_29.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/32_indel_filter
sh 000_1_script_run_indel_invivo_2nd.sh mm_study2_liver_IR_8Gy_SO2 Panc_8Gy1_BO mm10_balbc_9_190521.9s.q0Q0.chr1.mpileup.indel.edit.gz