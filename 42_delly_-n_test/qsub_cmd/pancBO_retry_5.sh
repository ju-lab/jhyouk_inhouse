#!/bin/bash
#PBS -l nodes=1:ppn=5
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/42_delly_-n_test/qsub_sdout/pancBO_retry_5.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/42_delly_-n_test
sh 00_Delly.sh /home/users/team_projects/Radiation_signature/02_bam male_panc_L3SO4 Panc_C3_BO