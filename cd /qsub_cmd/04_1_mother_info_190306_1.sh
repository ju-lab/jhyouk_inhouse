#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/31_SNP_New/qsub_sdout/04_1_mother_info_190306_1.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/31_SNP_New
sh motherinfo_PointMt_annot_filter/PointMt_annot.sh N1-S1_union_2_normalpanel1_11.readinfo.readc.rasmy_pon_b6_4_pon_balbc_7.filter1.vcf /home/users/team_projects/Radiation_signature/02_bam/N1-S1.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/N1-S1.s.md.ir.br.bam motherinfo_PointMt_annot_filter/src &> N1-S1.annotation.out && mv N1-S1.annotation.out N1-S1.annotation.success