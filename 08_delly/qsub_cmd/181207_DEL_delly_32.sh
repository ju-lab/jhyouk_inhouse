#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/08_delly/qsub_sdout/181207_DEL_delly_32.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/08_delly
sh 00_1_DEL_Delly.sh /home/users/team_projects/Radiation_signature/02_bam B3-0_2Gy-7 Spleen_m3