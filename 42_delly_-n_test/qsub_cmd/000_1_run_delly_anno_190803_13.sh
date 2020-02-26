#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/42_delly_-n_test/qsub_sdout/000_1_run_delly_anno_190803_13.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/42_delly_-n_test
sh 000_SV_anno_filter.sh Panc_8Gy1_SO3 /home/users/team_projects/Radiation_signature/02_bam/Panc_8Gy1_SO3.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/mm_study2_liver_IR_8Gy_SO2.s.md.ir.br.bam PON.delly.mouse.13s.txt