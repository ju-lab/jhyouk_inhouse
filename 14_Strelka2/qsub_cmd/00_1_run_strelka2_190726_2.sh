#!/bin/bash
#PBS -l nodes=1:ppn=2
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/14_Strelka2/qsub_sdout/00_1_run_strelka2_190726_2.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/14_Strelka2
#sh 00_script.sh /home/users/team_projects/Radiation_signature/02_bam/Spleen_m3.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/B8.s.md.ir.br.bam B8