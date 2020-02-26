#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/33_SV_filter/qsub_sdout/000_1_run_delly_annotation_190728_20.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/33_SV_filter
sh 000_SV_anno_filter.sh mm_study3_pancreas_Lowdose_SO2 /home/users/team_projects/Radiation_signature/02_bam/mm_study3_pancreas_Lowdose_SO2.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/male_panc_L3BO.s.md.ir.br.bam PON.delly.mouse.13s.txt