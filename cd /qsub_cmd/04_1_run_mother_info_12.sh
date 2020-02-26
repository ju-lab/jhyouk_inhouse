#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/31_SNP_New/qsub_sdout/04_1_run_mother_info_12.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/31_SNP_New
python /home/users/jhyouk/06_mm10_SNUH_radiation/31_SNP_New/sypark_PointMt_annot_filter/src/read_local_reassembly_190225.py S1P13_0-5_union_2_normalpanel1_11.readinfo.readc.rasmy_pon_b6_4_pon_balbc_7.filter1.vcf /home/users/team_projects/Radiation_signature/02_bam/S1P13_0-5.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/N1-S1.s.md.ir.br.bam