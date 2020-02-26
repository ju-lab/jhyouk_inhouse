#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/05_mutect/qsub_sdout/00_1_run_mutect_181219_human_1.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/05_mutect
sh 00_human_Mutect.sh /home/users/team_projects/Radiation_signature/04_bam_human_sample HBIR1-1 HBIR1_germline