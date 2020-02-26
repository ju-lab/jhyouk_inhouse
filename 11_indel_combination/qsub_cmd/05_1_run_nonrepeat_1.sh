#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/11_indel_combination/qsub_sdout/05_1_run_nonrepeat_1.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/11_indel_combination
python 05_nonrepeat.py S1-0Gy-1.strelka_varscan_union_indel_clonal_removeN1S1.vcf
python 05_nonrepeat.py S1-0Gy-2.strelka_varscan_union_indel_clonal_removeN1S1.vcf
python 05_nonrepeat.py S1-1Gy-1.strelka_varscan_union_indel_clonal_removeN1S1.vcf
python 05_nonrepeat.py S1-1Gy-2.strelka_varscan_union_indel_clonal_removeN1S1.vcf
python 05_nonrepeat.py S1-2Gy-1.strelka_varscan_union_indel_clonal_removeN1S1.vcf
python 05_nonrepeat.py S1-2Gy-2.strelka_varscan_union_indel_clonal_removeN1S1.vcf
python 05_nonrepeat.py S1-4Gy-1.strelka_varscan_union_indel_clonal_removeN1S1.vcf
python 05_nonrepeat.py S1-4Gy-2.strelka_varscan_union_indel_clonal_removeN1S1.vcf
python 05_nonrepeat.py S1-8Gy-1.strelka_varscan_union_indel_clonal_removeN1S1.vcf