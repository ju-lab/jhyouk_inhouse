#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/31_1_PanelOfNormal_SPark/qsub_sdout/run.b6_germline.mpu_17.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/31_1_PanelOfNormal_SPark
(samtools mpileup -AB -d 3000 -q 0 -Q 0 -f /home/users/jhyouk/99_reference/mouse/mm10/GRCm38.fa -r 19 /home/users/team_projects/Radiation_signature/02_bam/N1spleen.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/Spleen_m3.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/Normal-spleen.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/IR-spleen.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/mm_study4_germline_3nd_IR.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/N1spleen.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/m3-PGL.s.md.ir.br.bam -o b6_germline.7s.q0Q0.chr19.mpileup) 2> b6_germline.mpu.chr19.out && mv b6_germline.mpu.chr19.out b6_germline.mpu.chr19.success