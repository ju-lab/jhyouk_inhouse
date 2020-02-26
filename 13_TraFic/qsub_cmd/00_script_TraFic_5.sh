#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/13_TraFic/qsub_sdout/00_script_TraFic_5.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/13_TraFic
sh /home/users/tools/trafic/trafic.sh -t /home/users/jhyouk/06_mm10_SNUH_radiation/03_bam/S1-2Gy-1.s.md.ir.br.rg.bam -n /home/users/jhyouk/06_mm10_SNUH_radiation/03_bam/N1spleen.s.md.ir.br.rg.bam -s S1-2Gy-1-TraFic