#!/bin/bash
#PBS -l nodes=1:ppn=2
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/14_Strelka2/qsub_sdout/00_1_run_strelka2_181205_5.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/14_Strelka2
sh 00_script.sh /home/users/team_projects/Radiation_signature/02_bam/N1spleen.s.md.ir.br.rg.bam /home/users/team_projects/Radiation_signature/02_bam/S1P12_0-3.s.md.ir.br.bam S1P12_0-3