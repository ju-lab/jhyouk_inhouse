#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/32_indel_filter/qsub_sdout/000_2_run_invivo_2nd_20_17.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/32_indel_filter
sh 000_1_script_run_indel_invivo_2nd.sh mm_study4_SI_sham_SO1 mm_study4_germline_2nd_sham mm10_balbc_9_190521.9s.q0Q0.chr1.mpileup.indel.edit.gz