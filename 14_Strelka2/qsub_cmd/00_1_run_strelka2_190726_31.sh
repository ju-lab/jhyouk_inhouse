#!/bin/bash
#PBS -l nodes=1:ppn=2
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/14_Strelka2/qsub_sdout/00_1_run_strelka2_190726_31.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/14_Strelka2
sh 00_script.sh /home/users/team_projects/Radiation_signature/02_bam/SI_IR_BOPO.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/mm_study4_SI_IR_SO1a.s.md.ir.br.bam mm_study4_SI_IR_SO1a