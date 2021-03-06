#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/33_SV_filter/qsub_sdout/000_1_run_invitro_9.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/33_SV_filter
sh 000_SV_anno_filter.sh S1N2P15_1-4a /home/users/team_projects/Radiation_signature/02_bam/S1N2P15_1-4a.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/N1spleen.s.md.ir.br.bam 190225_delly_panelofnormal_1_9.vcf /home/users/team_projects/Radiation_signature/02_bam/N1-S1.s.md.ir.br.bam
sh 000_SV_anno_filter.sh S1N2P15_1-2a /home/users/team_projects/Radiation_signature/02_bam/S1N2P15_1-2a.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/N1spleen.s.md.ir.br.bam 190225_delly_panelofnormal_1_9.vcf /home/users/team_projects/Radiation_signature/02_bam/N1-S1.s.md.ir.br.bam
sh 000_SV_anno_filter.sh B3-0_2Gy-2 /home/users/team_projects/Radiation_signature/02_bam/B3-0_2Gy-2.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/Spleen_m3.s.md.ir.br.bam 190225_delly_panelofnormal_1_9.vcf /home/users/team_projects/Radiation_signature/02_bam/B3S100.s.md.ir.br.bam
sh 000_SV_anno_filter.sh B3-0_2Gy-3 /home/users/team_projects/Radiation_signature/02_bam/B3-0_2Gy-3.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/Spleen_m3.s.md.ir.br.bam 190225_delly_panelofnormal_1_9.vcf /home/users/team_projects/Radiation_signature/02_bam/B3S100.s.md.ir.br.bam
sh 000_SV_anno_filter.sh B3-0_1Gy-4 /home/users/team_projects/Radiation_signature/02_bam/B3-0_1Gy-4.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/Spleen_m3.s.md.ir.br.bam 190225_delly_panelofnormal_1_9.vcf /home/users/team_projects/Radiation_signature/02_bam/B3S100.s.md.ir.br.bam