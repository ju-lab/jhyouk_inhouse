#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/31_SNP_New/qsub_sdout/01_1_run_annotation_190221_35.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/31_SNP_New
sh sypark_PointMt_annot_filter/PointMt_annot.sh S1N2P16_4-4_union_2.vcf /home/users/team_projects/Radiation_signature/02_bam/S1N2P16_4-4.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/N1spleen.s.md.ir.br.bam sypark_PointMt_annot_filter/src &> S1N2P16_4-4.annotation.out && mv S1N2P16_4-4.annotation.out S1N2P16_4-4.annotation.success