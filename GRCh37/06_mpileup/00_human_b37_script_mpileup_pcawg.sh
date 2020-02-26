#!/bin/bash
set -e

sampleID=$1

log=$1.mpileup.log


echo "mpileup for $1" > $log
(samtools mpileup -B -Q 20 -q 20 -f /home/users/jhyouk/99_reference/human/hg19_PCAWG/genome.fa /home/users/team_projects/Radiation_signature/05_bam_human_sample_GRCh37/$1.s.md.ir.br.bam -o $1.mpileup) &>> $log || { c=$?;echo "Error";exit $c; }
echo "done" >> $log
echo "get coverage" >> $log
(python 05_hg19_get_coverage.py $1.mpileup) &>> $log || { c=$?;echo "Error";exit $c; }
echo "done" >> $log
echo "calculate stats"
(python 06_calculate_stats.py $1.mpileup.100kbcov) &>> $log || { c=$?;echo "Error";exit $c; }
(mv $1.mpileup.100kbcov ../07_sequenza) &>> $log || { c=$?;echo "Error";exit $c; }
(mv $1.mpileup.100kbcov.covstat ../07_sequenza) &>> $log || { c=$?;echo "Error";exit $c; }
echo "finish" >> $log
