#!/bin/bash
#PBS -l nodes=1:ppn=4
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/04_strelka/qsub_sdout/01_2_run_strelka_181205_3.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/04_strelka
sh 00_strelka.sh /home/users/team_projects/Radiation_signature/02_bam/N1spleen.s.md.ir.br.rg.bam /home/users/team_projects/Radiation_signature/02_bam/S1P13_0-5.s.md.ir.br.bam S1P13_0-5 /home/users/jhyouk/99_reference/mouse/mm10/GRCm38.fa