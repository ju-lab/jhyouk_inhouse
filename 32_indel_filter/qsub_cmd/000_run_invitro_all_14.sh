#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/32_indel_filter/qsub_sdout/000_run_invitro_all_14.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/32_indel_filter
sh 000_indel_annotation_filter.sh S1P12_0-3 N1-S1 N1spleen