#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/10_SNP_combination/qsub_sdout/11_1_script_readinfo_anno_bwa_1.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/10_SNP_combination
python 11_new_readinfo_anno_bwa_byYouk.py S1-0Gy-1.combination.Mutect_Strelka_union.vcf ../03_bam/S1-0Gy-1.s.md.ir.br.rg.bam ../03_bam/N1spleen.s.md.ir.br.rg.bam &>11.out