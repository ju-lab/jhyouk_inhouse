#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/31_1_PanelOfNormal_SPark/qsub_sdout/run.mm10_b6_4_190226.mpu_6.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/31_1_PanelOfNormal_SPark
(samtools mpileup -AB -d 3000 -q 0 -Q 0 -f /home/users/jhyouk/99_reference/mouse/mm10/GRCm38.fa -r 10 /home/users/team_projects/Radiation_signature/02_bam/N1spleen.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/Spleen_m3.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/Normal-spleen.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/IR-spleen.s.md.ir.br.bam -o mm10_b6_4_190226.4s.q0Q0.chr10.mpileup) 2> mm10_b6_4_190226.mpu.chr10.out && mv mm10_b6_4_190226.mpu.chr10.out mm10_b6_4_190226.mpu.chr10.success