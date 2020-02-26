#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/07_sequenza/qsub_sdout/99_run_2.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/07_sequenza
gzip -d HBIR1-2.comp.seqz.rmGLMTJH.gz