ID=$1
set -e

convert2annovar.pl -format vcf4old $1.strelka_varscan_union_indel_clonal_removeN1S1.vcf > $1.indel.input
annotate_variation.pl -out $1.annovar.indel.vcf -build mm10 $1.indel.input /home/users/data/02_annotation/02_annovar/mousedb
