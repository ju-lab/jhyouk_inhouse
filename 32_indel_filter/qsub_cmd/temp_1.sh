#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/32_indel_filter/qsub_sdout/temp_1.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/32_indel_filter
python sypark_PointMt_annot_filter/src/readcount_only_anno_190314_clipinsdeladd_Y.py S1-2Gy-1_indel_union_2.readinfo.readc.rasmy.vcf.pon.readinfo /home/users/team_projects/Radiation_signature/02_bam/N1spleen.s.md.ir.br.bam pairN &>temp.out