#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/42_delly_-n_test/qsub_sdout/000_1_run_delly_anno_190803_5.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/42_delly_-n_test
sh 000_SV_anno_filter.sh male_panc_L3SO4 /home/users/team_projects/Radiation_signature/02_bam/male_panc_L3SO4.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/Panc_C3_BO.s.md.ir.br.bam PON.delly.mouse.13s.txt