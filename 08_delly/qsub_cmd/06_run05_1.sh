#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/08_delly/qsub_sdout/06_run05_1.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/08_delly
python2.7 05_filtre_MP_MH.py S1-8Gy-1.delly.somatic.vcf /home/users/jhyouk/06_mm10_SNUH_radiation/03_bam/S1-8Gy-1.s.md.ir.br.rg.bam /home/users/jhyouk/06_mm10_SNUH_radiation/03_bam/N1spleen.s.md.ir.br.rg.bam &> test06.out