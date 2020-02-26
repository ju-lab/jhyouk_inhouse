#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/08_delly/qsub_sdout/temp_1.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/08_delly
/home/users/tools/delly-0.7.6/delly/src/delly call -t INS -q 15 -o B3-0_2Gy-4.INS.bcf -g /home/users/jhyouk/99_reference/mouse/mm10/GRCm38.fa /home/users/team_projects/Radiation_signature/02_bam/B3-0_2Gy-4.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/Spleen_m3.s.md.ir.br.bam