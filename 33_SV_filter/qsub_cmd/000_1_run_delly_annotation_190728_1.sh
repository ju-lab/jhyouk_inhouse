#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/33_SV_filter/qsub_sdout/000_1_run_delly_annotation_190728_1.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/33_SV_filter
sh 000_SV_anno_filter.sh N1-S4 /home/users/team_projects/Radiation_signature/02_bam/N1-S4.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/N1spleen.s.md.ir.br.bam PON.delly.mouse.13s.txt