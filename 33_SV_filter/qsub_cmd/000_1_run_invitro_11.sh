#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/33_SV_filter/qsub_sdout/000_1_run_invitro_11.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/33_SV_filter
sh 000_SV_anno_filter.sh B3-0_P19_2Gy-8 /home/users/team_projects/Radiation_signature/02_bam/B3-0_P19_2Gy-8.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/Spleen_m3.s.md.ir.br.bam 190225_delly_panelofnormal_1_9.vcf /home/users/team_projects/Radiation_signature/02_bam/B3S100.s.md.ir.br.bam
sh 000_SV_anno_filter.sh B3-0_1Gy-2 /home/users/team_projects/Radiation_signature/02_bam/B3-0_1Gy-2.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/Spleen_m3.s.md.ir.br.bam 190225_delly_panelofnormal_1_9.vcf /home/users/team_projects/Radiation_signature/02_bam/B3S100.s.md.ir.br.bam
sh 000_SV_anno_filter.sh B3-0_1Gy-3 /home/users/team_projects/Radiation_signature/02_bam/B3-0_1Gy-3.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/Spleen_m3.s.md.ir.br.bam 190225_delly_panelofnormal_1_9.vcf /home/users/team_projects/Radiation_signature/02_bam/B3S100.s.md.ir.br.bam
sh 000_SV_anno_filter.sh B3-0_P19_0Gy-1 /home/users/team_projects/Radiation_signature/02_bam/B3-0_P19_0Gy-1.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/Spleen_m3.s.md.ir.br.bam 190225_delly_panelofnormal_1_9.vcf /home/users/team_projects/Radiation_signature/02_bam/B3S100.s.md.ir.br.bam
sh 000_SV_anno_filter.sh B3-0_0Gy-3 /home/users/team_projects/Radiation_signature/02_bam/B3-0_0Gy-3.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/Spleen_m3.s.md.ir.br.bam 190225_delly_panelofnormal_1_9.vcf /home/users/team_projects/Radiation_signature/02_bam/B3S100.s.md.ir.br.bam