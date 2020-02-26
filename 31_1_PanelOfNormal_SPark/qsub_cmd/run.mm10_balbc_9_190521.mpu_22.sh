#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/31_1_PanelOfNormal_SPark/qsub_sdout/run.mm10_balbc_9_190521.mpu_22.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/31_1_PanelOfNormal_SPark
(samtools mpileup -AB -d 3000 -q 0 -Q 0 -f /home/users/jhyouk/99_reference/mouse/mm10/GRCm38.fa -r 1 /home/users/team_projects/Radiation_signature/02_bam/Panc_8Gy_2_G.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/Liver_20Gy_1_G.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/Liver_2Gy_2_G.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/Panc_C3_BO.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/Panc_8Gy1_BO.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/male_panc_L3BO.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/L3_Germline.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/mm_study4_germline_2nd_sham.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/mm_study4_germline_2nd_IR.s.md.ir.br.bam -o mm10_balbc_9_190521.9s.q0Q0.chr1.mpileup) 2> mm10_balbc_9_190521.mpu.chr1.out && mv mm10_balbc_9_190521.mpu.chr1.out mm10_balbc_9_190521.mpu.chr1.success