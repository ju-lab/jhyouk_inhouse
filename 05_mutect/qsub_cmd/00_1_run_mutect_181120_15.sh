#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/05_mutect/qsub_sdout/00_1_run_mutect_181120_15.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/05_mutect
sh 00_Mutect.sh /home/users/team_projects/Radiation_signature/02_bam Liver_C3SO2 Panc_C3_BO