#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/10_SNP_combination/qsub_sdout/11_2_run_readinfo_anno_bwa_1.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/10_SNP_combination
sh 11_1_script_readinfo_anno_bwa.sh S1-0Gy-1