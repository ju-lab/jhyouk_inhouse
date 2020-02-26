#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/33_SV_filter/qsub_sdout/000_1_run_invitro_8.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/33_SV_filter
sh 000_SV_anno_filter.sh S1N2P15_2-7 /home/users/team_projects/Radiation_signature/02_bam/S1N2P15_2-7.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/N1spleen.s.md.ir.br.bam 190225_delly_panelofnormal_1_9.vcf /home/users/team_projects/Radiation_signature/02_bam/N1-S1.s.md.ir.br.bam
sh 000_SV_anno_filter.sh S1N2P15_2-6 /home/users/team_projects/Radiation_signature/02_bam/S1N2P15_2-6.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/N1spleen.s.md.ir.br.bam 190225_delly_panelofnormal_1_9.vcf /home/users/team_projects/Radiation_signature/02_bam/N1-S1.s.md.ir.br.bam
sh 000_SV_anno_filter.sh S1N2P15_2-1a /home/users/team_projects/Radiation_signature/02_bam/S1N2P15_2-1a.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/N1spleen.s.md.ir.br.bam 190225_delly_panelofnormal_1_9.vcf /home/users/team_projects/Radiation_signature/02_bam/N1-S1.s.md.ir.br.bam
sh 000_SV_anno_filter.sh S1N2P15_1-3a /home/users/team_projects/Radiation_signature/02_bam/S1N2P15_1-3a.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/N1spleen.s.md.ir.br.bam 190225_delly_panelofnormal_1_9.vcf /home/users/team_projects/Radiation_signature/02_bam/N1-S1.s.md.ir.br.bam
sh 000_SV_anno_filter.sh S1N2P15_1-5a /home/users/team_projects/Radiation_signature/02_bam/S1N2P15_1-5a.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/N1spleen.s.md.ir.br.bam 190225_delly_panelofnormal_1_9.vcf /home/users/team_projects/Radiation_signature/02_bam/N1-S1.s.md.ir.br.bam