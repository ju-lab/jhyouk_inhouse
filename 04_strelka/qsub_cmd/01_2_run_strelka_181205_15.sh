#!/bin/bash
#PBS -l nodes=1:ppn=4
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/04_strelka/qsub_sdout/01_2_run_strelka_181205_15.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/04_strelka
sh 00_strelka.sh /home/users/team_projects/Radiation_signature/02_bam/Spleen_m3.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/B3-0_P19_0Gy-1.s.md.ir.br.bam B3-0_P19_0Gy-1 /home/users/jhyouk/99_reference/mouse/mm10/GRCm38.fa