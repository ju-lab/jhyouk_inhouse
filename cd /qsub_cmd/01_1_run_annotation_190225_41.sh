#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/31_SNP_New/qsub_sdout/01_1_run_annotation_190225_41.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/31_SNP_New
sh sypark_PointMt_annot_filter/PointMt_annot.sh S1N2P15_1-5a_union_2_normalpanel1_11.vcf /home/users/team_projects/Radiation_signature/02_bam/S1N2P15_1-5a.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/N1spleen.s.md.ir.br.bam sypark_PointMt_annot_filter/src &> S1N2P15_1-5a.annotation.out && mv S1N2P15_1-5a.annotation.out S1N2P15_1-5a.annotation.success