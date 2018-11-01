sampleName=$1

python 04_removeN1S1.py $1.strelka_varscan_union_indel_clonal.vcf /home/users/jhyouk/06_mm10_SNUH_radiation/03_bam/$1.s.md.ir.br.rg.bam /home/users/jhyouk/06_mm10_SNUH_radiation/03_bam/N1-S1.s.md.ir.br.rg.bam &> $1.04_removeN1S1.out
