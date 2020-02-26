#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/31_1_PanelOfNormal_SPark/qsub_sdout/run.b6_others_somatic.mpu_4.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/31_1_PanelOfNormal_SPark
(samtools mpileup -AB -d 3000 -q 0 -Q 0 -f /home/users/jhyouk/99_reference/mouse/mm10/GRCm38.fa -r 8 /home/users/team_projects/Radiation_signature/02_bam/mm_study4_breast_sham_SO1.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/mm_study4_breast_sham_SO2.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/mm_study4_breast_sham_SO3.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/mm_study4_breast_IR_SO1.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/mm_study4_breast_IR_SO2.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/mm_study4_breast_IR_SO3.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/mm_study4_stomach_sham_SO1.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/mm_study4_stomach_sham_SO2.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/mm_study4_stomach_sham_SO3.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/mm_study4_stomach_IR_SO1.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/mm_study4_stomach_IR_SO2.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/mm_study4_stomach_IR_SO3.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/mm_study4_liver_IR_SO1.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/mm_study4_liver_IR_SO2.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/mm_study4_liver_IR_SO3.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/mm_study4_liver_sham_SO1.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/mm_study4_liver_sham_SO2.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/mm_study4_liver_sham_SO3.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/mm_study4_colon_sham_SO1.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/mm_study4_colon_sham_SO2.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/mm_study4_colon_sham_SO3.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/mm_study4_colon_IR_SO1.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/mm_study4_colon_IR_SO2.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/mm_study4_colon_IR_SO3.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/mm_study4_fallopian_IR_SO1.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/mm_study4_fallopian_IR_SO2.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/mm_study4_fallopian_sham_SO1.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/mm_study4_fallopian_sham_SO2.s.md.ir.br.bam -o b6_others_somatic.28s.q0Q0.chr8.mpileup) 2> b6_others_somatic.mpu.chr8.out && mv b6_others_somatic.mpu.chr8.out b6_others_somatic.mpu.chr8.success