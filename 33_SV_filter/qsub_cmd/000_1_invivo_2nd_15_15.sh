#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/33_SV_filter/qsub_sdout/000_1_invivo_2nd_15_15.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/33_SV_filter
sh 000_SV_anno_filter.sh mm_study2_pancreas_sham_C3SO1SO1_normoxia_SO1 /home/users/team_projects/Radiation_signature/02_bam/mm_study2_pancreas_sham_C3SO1SO1_normoxia_SO1.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/Panc_C3_BO.s.md.ir.br.bam PON.delly.mouse.13s.txt