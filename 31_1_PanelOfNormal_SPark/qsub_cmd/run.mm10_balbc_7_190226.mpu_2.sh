#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/31_1_PanelOfNormal_SPark/qsub_sdout/run.mm10_balbc_7_190226.mpu_2.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/31_1_PanelOfNormal_SPark
(samtools mpileup -AB -d 3000 -q 0 -Q 0 -f /home/users/jhyouk/99_reference/mouse/mm10/GRCm38.fa -r 6 /home/users/team_projects/Radiation_signature/02_bam/Panc_8Gy_2_G.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/Liver_20Gy_1_G.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/Liver_2Gy_2_G.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/Panc_C3_BO.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/Panc_8Gy1_BO.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/male_panc_L3BO.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/L3_Germline.s.md.ir.br.bam -o mm10_balbc_7_190226.7s.q0Q0.chr6.mpileup) 2> mm10_balbc_7_190226.mpu.chr6.out && mv mm10_balbc_7_190226.mpu.chr6.out mm10_balbc_7_190226.mpu.chr6.success