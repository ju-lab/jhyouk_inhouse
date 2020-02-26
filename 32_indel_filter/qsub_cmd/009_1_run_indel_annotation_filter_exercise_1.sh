#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/32_indel_filter/qsub_sdout/009_1_run_indel_annotation_filter_exercise_1.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/32_indel_filter
sh 009_indel_annotation_filter_exercise.sh S1-2Gy-1 N1-S1 N1spleen