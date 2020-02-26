#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/08_delly/qsub_sdout/05_2_run_filter_MH_181212_3.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/08_delly
sh 05_1_script_filter_MH_MP.sh /home/users/team_projects/Radiation_signature/02_bam 8Gy_2_S01_S Panc_8Gy_2_G