sampleName=$1
n_bam_ID=$2

python 02_script_indel_filter.py $1.strelka_varscan_union.vcf /home/users/jhyouk/06_mm10_SNUH_radiation/03_bam/$1.s.md.ir.br.rg.bam /home/users/jhyouk/06_mm10_SNUH_radiation/03_bam/$2.s.md.ir.br.rg.bam &> $1.02_indel_filter.out
