#!/bin/bash
#PBS -l nodes=1:ppn=4
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/04_strelka/qsub_sdout/01_2_run_strelka_190116_1.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/04_strelka
sh 00_strelka.sh /home/users/team_projects/Radiation_signature/02_bam/L3_Germline.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/C3SO3.s.md.ir.br.bam C3SO3 /home/users/jhyouk/99_reference/mouse/mm10/GRCm38.fa