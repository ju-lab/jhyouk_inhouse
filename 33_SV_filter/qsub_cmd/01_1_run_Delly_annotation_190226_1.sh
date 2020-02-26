#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/33_SV_filter/qsub_sdout/01_1_run_Delly_annotation_190226_1.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/33_SV_filter
sh 01_Delly_annotation.sh N1-S1.delly.vcf 10 /home/users/team_projects/Radiation_signature/02_bam/N1-S1.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/N1spleen.s.md.ir.br.bam 190225_delly_panelofnormal_1_9.vcf Delly_annotation_scripts/  &> N1-S1.annotation.out && mv N1-S1.annotation.out N1-S1.annotation.success