#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/07_sequenza/qsub_sdout/99_run_1.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/07_sequenza
gzip -d S1P13_0-5.comp.seqz.rmGLMTJH.gz