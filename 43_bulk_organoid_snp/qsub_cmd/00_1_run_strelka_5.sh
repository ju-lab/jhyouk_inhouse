#!/bin/bash
#PBS -l nodes=1:ppn=4
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/43_bulk_organoid_snp/qsub_sdout/00_1_run_strelka_5.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/43_bulk_organoid_snp
sh 00_script.sh /home/users/team_projects/Radiation_signature/02_bam/mm_study4_germline_2nd_sham.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/Liver_2Gy_2_G.s.md.ir.br.bam Liver_2Gy_2_G_bulk