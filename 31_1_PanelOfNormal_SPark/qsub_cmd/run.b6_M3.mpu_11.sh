#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/31_1_PanelOfNormal_SPark/qsub_sdout/run.b6_M3.mpu_11.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/31_1_PanelOfNormal_SPark
(samtools mpileup -AB -d 3000 -q 0 -Q 0 -f /home/users/jhyouk/99_reference/mouse/mm10/GRCm38.fa -r 14 /home/users/team_projects/Radiation_signature/02_bam/B3-0_2Gy-2.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/B3-0_2Gy-3.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/B3-0_1Gy-4.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/B3-0_2Gy-6.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/B3-0_1Gy-5.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/B3-0_2Gy-4.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/B3-0_1Gy-6.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/B3-0_1Gy_1-P20.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/B3-0_P19_2Gy-8.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/B3-0_1Gy-2.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/B3-0_1Gy-3.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/B3-0_P19_0Gy-1.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/B3-0_0Gy-3.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/B3-0_2Gy-5.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/B3-0_P19_4Gy-4.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/B3-0_P19_4Gy-5.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/B3-0_2Gy-7.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/B3-0_2Gy-1.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/B3-0_P19_4Gy-2.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/B3-0_0Gy_2.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/B3S100.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/B8.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/B3P16_0Gy_4.s.md.ir.br.bam -o b6_M3.23s.q0Q0.chr14.mpileup) 2> b6_M3.mpu.chr14.out && mv b6_M3.mpu.chr14.out b6_M3.mpu.chr14.success