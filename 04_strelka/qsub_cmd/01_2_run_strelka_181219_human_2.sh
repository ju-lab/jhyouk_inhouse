#!/bin/bash
#PBS -l nodes=1:ppn=4
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/04_strelka/qsub_sdout/01_2_run_strelka_181219_human_2.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/04_strelka
sh 00_human_strelka.sh /home/users/team_projects/Radiation_signature/04_bam_human_sample/HBIR1_germline.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/04_bam_human_sample/HBIR1-2.s.md.ir.br.bam HBIR1-2 /home/users/jhyouk/99_reference/human/hg38/Homo_sapiens_assembly38.fasta