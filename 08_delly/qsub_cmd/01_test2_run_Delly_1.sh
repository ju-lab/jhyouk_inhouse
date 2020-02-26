#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/08_delly/qsub_sdout/01_test2_run_Delly_1.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/08_delly
sh /home/users/jhyouk/05_radiation/07_delly/delly_MQ/01_delly.sh /home/users/jhyouk/06_mm10_SNUH_radiation/03_bam/S1-0Gy-2.s.md.ir.br.bam /home/users/jhyouk/06_mm10_SNUH_radiation/03_bam/N1spleen.s.md.ir.br.bam S1-0Gy-2