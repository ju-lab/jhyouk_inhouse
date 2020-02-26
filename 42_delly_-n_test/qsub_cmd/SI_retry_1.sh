#!/bin/bash
#PBS -l nodes=1:ppn=5
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/42_delly_-n_test/qsub_sdout/SI_retry_1.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/42_delly_-n_test
sh 00_Delly.sh /home/users/team_projects/Radiation_signature/02_bam mm_study4_SI_IR_SO1 Panc_C3_BO