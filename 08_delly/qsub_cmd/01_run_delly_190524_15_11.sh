#!/bin/bash
#PBS -l nodes=1:ppn=5
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/08_delly/qsub_sdout/01_run_delly_190524_15_11.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/08_delly
sh 00_Delly.sh /home/users/team_projects/Radiation_signature/02_bam mm_study4_SI_IR_SO1 mm_study4_germline_2nd_IR