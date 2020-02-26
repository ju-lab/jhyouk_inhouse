#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/31_1_PanelOfNormal_SPark/qsub_sdout/run.balbc_others.mpu_12.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/31_1_PanelOfNormal_SPark
(samtools mpileup -AB -d 3000 -q 0 -Q 0 -f /home/users/jhyouk/99_reference/mouse/mm10/GRCm38.fa -r 15 /home/users/team_projects/Radiation_signature/02_bam/mm_study4_SI_IR_SO1.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/mm_study4_SI_IR_SO4.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/mm_study4_SI_sham_SO1.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/mm_study4_SI_sham_SO2.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/mm_study4_SI_sham_SO3.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/mm_study4_germline_2nd_sham.s.md.ir.br.bam -o balbc_others.6s.q0Q0.chr15.mpileup) 2> balbc_others.mpu.chr15.out && mv balbc_others.mpu.chr15.out balbc_others.mpu.chr15.success