#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/15_MuTect2/qsub_sdout/01_absolute_script_Mutect2_1.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/15_MuTect2
/home/users/jhyouk/tools/gatk-4.0.11.0/gatk --java-options "-Xmx16G" Mutect2 -R /home/users/jhyouk/99_reference/mouse/mm10/GRCm38.fa -I /home/users/jhyouk/06_mm10_SNUH_radiation/03_bam/breast_mother.s.md.ir.br.bam -I /home/users/jhyouk/06_mm10_SNUH_radiation/03_bam/Spleen_m3.s.md.ir.br.bam -tumor B3P7 -normal Spleen_m3 -O B3P7.Mutect2.vcf &> B3P7.Mutect2.out