#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/31_1_PanelOfNormal_SPark/qsub_sdout/run.b6_N1.mpu_14.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/31_1_PanelOfNormal_SPark
(samtools mpileup -AB -d 3000 -q 0 -Q 0 -f /home/users/jhyouk/99_reference/mouse/mm10/GRCm38.fa -r 17 /home/users/team_projects/Radiation_signature/02_bam/S1-4Gy-2.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/S1-8Gy-1.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/S1-1Gy-2.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/S1-2Gy-2.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/S1-0Gy-2.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/S1-2Gy-1.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/S1-4Gy-1.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/S1-1Gy-1.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/S1-0Gy-1.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/S1P13_0-4.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/S1P13_0-5.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/S1P12_0-3.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/S1P12_0-7.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/S1P13_2-3.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/S1N2P16_4-7.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/S1N2P15_2-8.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/S1N2P16_4-5.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/S1N2P16_4-6.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/S1N2P15_4-1.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/S1N2P15_0-2.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/S1N2P15_0-1.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/S1N2P16_2-11.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/S1N2P16_4-8.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/S1N2P15_4-2.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/S1N2P15_0-3.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/S1N2P15_0-4.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/S1N2P16_2-4.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/S1N2P16_2-3.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/S1N2P15_0-5.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/S1N2P16_2-5.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/S1N2P15_1-1.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/S1N2P16_4-3.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/S1N2P16_2-9.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/S1N2P16_4-4.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/S1N2P15_2-2.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/S1N2P15_2-7.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/S1N2P15_2-6.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/S1N2P15_2-1a.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/S1N2P15_1-3a.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/S1N2P15_1-5a.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/S1N2P15_1-4a.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/S1N2P15_1-2a.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/N1-S1.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/N1-S4.s.md.ir.br.bam -o b6_N1.44s.q0Q0.chr17.mpileup) 2> b6_N1.mpu.chr17.out && mv b6_N1.mpu.chr17.out b6_N1.mpu.chr17.success