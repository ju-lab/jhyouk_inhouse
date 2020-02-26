#!/bin/bash
#PBS -l nodes=1:ppn=4
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/14_Strelka2/qsub_sdout/temp_1.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/14_Strelka2
sh 00_script.sh /home/users/team_projects/Radiation_signature/02_bam/IR-spleen.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/mm_study4_fallopian_IR_SO1.s.md.ir.br.bam mm_study4_fallopian_IR_SO1