#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/41_sequenza_mm10/qsub_sdout/23_1.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/41_sequenza_mm10
Rscript 23_full_breaks.R ../07_sequenza/S1N2P16_4-8.comp.seqz.rmGLMTJH.gz S1N2P16_4-8-23 1 2 mm10 XX &> 4-8_23.out