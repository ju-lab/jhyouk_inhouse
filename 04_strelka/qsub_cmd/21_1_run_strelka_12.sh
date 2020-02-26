#!/bin/bash
#PBS -l nodes=1:ppn=4
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/04_strelka/qsub_sdout/21_1_run_strelka_12.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/04_strelka
sh 00_strelka.sh /home/users/team_projects/Radiation_signature/02_bam/Panc_8Gy1_BO.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/Liver_8Gy1_SO5.s.md.ir.br.bam Liver_8Gy1_SO5 /home/users/jhyouk/99_reference/mouse/mm10/GRCm38.fa