#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/33_SV_filter/qsub_sdout/000_1_run_delly_annotation_190728_23.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/33_SV_filter
sh 000_SV_anno_filter.sh mm_study4_pancreas_sham_SO3 /home/users/team_projects/Radiation_signature/02_bam/mm_study4_pancreas_sham_SO3.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/mm_study4_germline_3nd_sham.s.md.ir.br.bam PON.delly.mouse.13s.txt