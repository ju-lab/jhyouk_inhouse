#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/62_callableLoci/qsub_sdout/00_callableLoci_1.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/62_callableLoci
java -Xms8g -Xmx12g -jar /home/users/tools/gatk/gatk-3.5/GenomeAnalysisTK.jar -T CallableLoci -R /home/users/jhyouk/99_reference/mouse/mm10/GRCm38.fa -I /home/users/team_projects/Radiation_signature/02_bam/N1-S1.s.md.ir.br.bam -o callableloci_all.bed --summary callableloci-summary.txt --minBaseQuality 20 --minMappingQuality 20 --maxFractionOfReadsWithLowMAPQ 0.5 --minDepth 10 &> callable.out