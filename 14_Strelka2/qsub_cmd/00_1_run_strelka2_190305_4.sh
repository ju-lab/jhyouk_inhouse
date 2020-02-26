#!/bin/bash
#PBS -l nodes=1:ppn=4
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/14_Strelka2/qsub_sdout/00_1_run_strelka2_190305_4.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/14_Strelka2
sh 00_script.sh /home/users/team_projects/Radiation_signature/02_bam/Panc_8Gy_2_G.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/8Gy_2_S02_S.s.md.ir.br.bam 8Gy_2_S02_S