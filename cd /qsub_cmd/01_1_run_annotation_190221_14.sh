#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/31_SNP_New/qsub_sdout/01_1_run_annotation_190221_14.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/31_SNP_New
sh sypark_PointMt_annot_filter/PointMt_annot.sh S1P12_0-7_union_2.vcf /home/users/team_projects/Radiation_signature/02_bam/S1P12_0-7.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/N1spleen.s.md.ir.br.bam sypark_PointMt_annot_filter/src &> S1P12_0-7.annotation.out && mv S1P12_0-7.annotation.out S1P12_0-7.annotation.success