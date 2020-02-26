#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/32_indel_filter/qsub_sdout/000_2_run_invivo_2nd_15_indel_10.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/32_indel_filter
sh 000_1_script_run_indel_invivo_2nd.sh mm_study4_colon_IR_SO3 IR-spleen mm10_b6_6_190521.6s.q0Q0.chr1.mpileup.indel.edit.gz