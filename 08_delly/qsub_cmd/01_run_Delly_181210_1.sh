#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/08_delly/qsub_sdout/01_run_Delly_181210_1.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/08_delly
sh 00_1_INS_Delly.sh /home/users/team_projects/Radiation_signature/02_bam B3-0_2Gy-4 Spleen_m3