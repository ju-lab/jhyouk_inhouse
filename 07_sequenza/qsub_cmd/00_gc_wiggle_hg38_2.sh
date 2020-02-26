#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/07_sequenza/qsub_sdout/00_gc_wiggle_hg38_2.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/07_sequenza
gzip gc50base.hg38.wig &> gc50.hg38.gzip.out