#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/07_sequenza/qsub_sdout/00_gc_wiggle_hg38_1.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/07_sequenza
sequenza-utils gc_wiggle -w 50 -o gc50base.hg38.wig -f /home/users/jhyouk/99_reference/human/hg38/Homo_sapiens_assembly38.fasta > gc50basewiggle.hg38.out 2>&1 &&
gzip gc50base.hg38.wig &> gc50.hg38.gzip.out