#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/42_delly_-n_test/qsub_sdout/000_1_run_delly_anno_190803_17.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/42_delly_-n_test
sh 000_SV_anno_filter.sh Liver_20Gy1_SO2 /home/users/team_projects/Radiation_signature/02_bam/Liver_20Gy1_SO2.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/20Gy_1_S01_S.s.md.ir.br.bam PON.delly.mouse.13s.txt