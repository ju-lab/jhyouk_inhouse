#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/31_2_SNP_updated_190315/qsub_sdout/temp_1.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/31_2_SNP_updated_190315
sh 000_1_script_run_invivo_2nd.sh Liver_20Gy_1_G_bulk mm_study4_germline_2nd_sham mm10_balbc_9_190521.9s.q0Q0.chr1.mpileup.snv.edit.gz