#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/31_SNP_New/qsub_sdout/05_1_run_filter2_190306_19.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/31_SNP_New
python 05_filter2_motherinfo.py S1N2P16_4-6_union_2_normalpanel1_11.readinfo.readc.rasmy_pon_b6_4_pon_balbc_7.filter1.mreadc.rasmy.vcf /home/users/team_projects/Radiation_signature/02_bam/S1N2P16_4-6.s.md.ir.br.bam