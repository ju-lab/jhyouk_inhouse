#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/33_SV_filter/qsub_sdout/000_1_run_invitro_10.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/33_SV_filter
sh 000_SV_anno_filter.sh B3-0_2Gy-6 /home/users/team_projects/Radiation_signature/02_bam/B3-0_2Gy-6.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/Spleen_m3.s.md.ir.br.bam 190225_delly_panelofnormal_1_9.vcf /home/users/team_projects/Radiation_signature/02_bam/B3S100.s.md.ir.br.bam
sh 000_SV_anno_filter.sh B3-0_1Gy-5 /home/users/team_projects/Radiation_signature/02_bam/B3-0_1Gy-5.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/Spleen_m3.s.md.ir.br.bam 190225_delly_panelofnormal_1_9.vcf /home/users/team_projects/Radiation_signature/02_bam/B3S100.s.md.ir.br.bam
sh 000_SV_anno_filter.sh B3-0_2Gy-4 /home/users/team_projects/Radiation_signature/02_bam/B3-0_2Gy-4.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/Spleen_m3.s.md.ir.br.bam 190225_delly_panelofnormal_1_9.vcf /home/users/team_projects/Radiation_signature/02_bam/B3S100.s.md.ir.br.bam
sh 000_SV_anno_filter.sh B3-0_1Gy-6 /home/users/team_projects/Radiation_signature/02_bam/B3-0_1Gy-6.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/Spleen_m3.s.md.ir.br.bam 190225_delly_panelofnormal_1_9.vcf /home/users/team_projects/Radiation_signature/02_bam/B3S100.s.md.ir.br.bam
sh 000_SV_anno_filter.sh B3-0_1Gy_1-P20 /home/users/team_projects/Radiation_signature/02_bam/B3-0_1Gy_1-P20.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/Spleen_m3.s.md.ir.br.bam 190225_delly_panelofnormal_1_9.vcf /home/users/team_projects/Radiation_signature/02_bam/B3S100.s.md.ir.br.bam