#!/bin/bash
#PBS -l nodes=1:ppn=2
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/14_Strelka2/qsub_sdout/00_1_run_strelka2_190726_9.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/14_Strelka2
#sh 00_script.sh /home/users/team_projects/Radiation_signature/02_bam/mm_study4_germline_3nd_IR.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/mm_study4_pancreas_IR_SO1.s.md.ir.br.bam mm_study4_pancreas_IR_SO1