#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/42_delly_-n_test/qsub_sdout/000_1_run_delly_anno_190803_11.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/42_delly_-n_test
sh 000_SV_anno_filter.sh 8Gy_2_S02_S /home/users/team_projects/Radiation_signature/02_bam/8Gy_2_S02_S.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/Panc_C3_BO.s.md.ir.br.bam PON.delly.mouse.13s.txt