#!/bin/bash
#PBS -l nodes=1:ppn=4
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/04_strelka/qsub_sdout/21_1_run_strelka_6.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/04_strelka
sh 00_strelka.sh /home/users/team_projects/Radiation_signature/02_bam/Liver_2Gy_2_G.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/Liver_2Gy2_SO2.s.md.ir.br.bam Liver_2Gy2_SO2 /home/users/jhyouk/99_reference/mouse/mm10/GRCm38.fa