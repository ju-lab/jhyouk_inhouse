#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/31_SNP_New/qsub_sdout/190225_temp_1.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/31_SNP_New
python sypark_PointMt_annot_filter/src/read_local_reassembly_190225.py S1-0Gy-1_union_2.vcf.readinfo.readc.rasm /home/users/team_projects/Radiation_signature/02_bam/S1-0Gy-1.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/N1spleen.s.md.ir.br.bam &> 190225_temp.out