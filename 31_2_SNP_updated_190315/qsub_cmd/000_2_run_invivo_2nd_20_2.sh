#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/31_2_SNP_updated_190315/qsub_sdout/000_2_run_invivo_2nd_20_2.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/31_2_SNP_updated_190315
sh 000_1_script_run_invivo_2nd.sh mm_study4_breast_sham_SO3 Normal-spleen mm10_b6_6_190521.6s.q0Q0.chr1.mpileup.snv.edit.gz