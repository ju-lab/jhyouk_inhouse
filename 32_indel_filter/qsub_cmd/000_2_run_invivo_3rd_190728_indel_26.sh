#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/32_indel_filter/qsub_sdout/000_2_run_invivo_3rd_190728_indel_26.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/32_indel_filter
sh 000_1_script_run_indel_invivo_2nd.sh mm_study4_lung_IR_SO3 mm_study4_germline_3nd_IR mm10_b6_6_190521.6s.q0Q0.chr1.mpileup.indel.edit.gz