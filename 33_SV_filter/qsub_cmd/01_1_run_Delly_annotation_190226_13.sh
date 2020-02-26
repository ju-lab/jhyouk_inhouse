#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/33_SV_filter/qsub_sdout/01_1_run_Delly_annotation_190226_13.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/33_SV_filter
sh 01_Delly_annotation.sh S1P12_0-3.delly.vcf 10 /home/users/team_projects/Radiation_signature/02_bam/S1P12_0-3.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/N1spleen.s.md.ir.br.bam 190225_delly_panelofnormal_1_9.vcf Delly_annotation_scripts/  &> S1P12_0-3.annotation.out && mv S1P12_0-3.annotation.out S1P12_0-3.annotation.success