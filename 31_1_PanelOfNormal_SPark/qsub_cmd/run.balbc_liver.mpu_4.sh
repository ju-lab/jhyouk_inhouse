#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/31_1_PanelOfNormal_SPark/qsub_sdout/run.balbc_liver.mpu_4.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/31_1_PanelOfNormal_SPark
(samtools mpileup -AB -d 3000 -q 0 -Q 0 -f /home/users/jhyouk/99_reference/mouse/mm10/GRCm38.fa -r 8 /home/users/team_projects/Radiation_signature/02_bam/Liver_C3SO2.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/Liver_C3SO1.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/Liver_8Gy1_SO5.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/Liver_8Gy1_SO3.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/Liver_20Gy1_SO2.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/Liver_20Gy1_SO1.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/Liver_2Gy2_SO2.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/Liver_2Gy2_SO1.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/Liver_20Gy1_SO4.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/Panc_C3_SO1.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/mm_study2_liver_8by1Gy_SO4.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/mm_study2_liver_IR_8Gy_SO2.s.md.ir.br.bam -o balbc_liver.12s.q0Q0.chr8.mpileup) 2> balbc_liver.mpu.chr8.out && mv balbc_liver.mpu.chr8.out balbc_liver.mpu.chr8.success