#!/bin/bash
#PBS -l nodes=1:ppn=4
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/14_Strelka2/qsub_sdout/00_1_run_strelka2_181219_human_2.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/14_Strelka2
sh 00_human_script.sh /home/users/team_projects/Radiation_signature/04_bam_human_sample/HBIR1_germline.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/04_bam_human_sample/HBIR1-2.s.md.ir.br.bam HBIR1-2