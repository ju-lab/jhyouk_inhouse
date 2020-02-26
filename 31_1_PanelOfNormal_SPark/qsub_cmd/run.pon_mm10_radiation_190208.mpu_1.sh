#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/10_2_SNP_SPark_filter/qsub_sdout/run.pon_mm10_radiation_190208.mpu_1.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/10_2_SNP_SPark_filter
(samtools mpileup -AB -d 3000 -q 0 -Q 0 -f /home/users/jhyouk/99_reference/mouse/mm10/GRCm38.fa -r 5 /home/users/team_projects/Radiation_signature/02_bam/N1spleen.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/Spleen_m3.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/Panc_8Gy_2_G.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/Liver_20Gy_1_G.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/Liver_2Gy_2_G.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/Panc_C3_BO.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/Panc_8Gy1_BO.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/male_panc_L3BO.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/L3_Germline.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/Normal-spleen.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/IR-spleen.s.md.ir.br.bam -o pon_mm10_radiation_190208.11s.q0Q0.chr5.mpileup) 2> pon_mm10_radiation_190208.mpu.chr5.out && mv pon_mm10_radiation_190208.mpu.chr5.out pon_mm10_radiation_190208.mpu.chr5.success