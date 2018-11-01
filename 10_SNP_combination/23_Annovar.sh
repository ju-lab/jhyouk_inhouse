ID=$1
set -e

convert2annovar.pl -format vcf4old $1.combination.Mutect_Strelka_union.filteredN1S1.vcf > $1.input
annotate_variation.pl -out $1.annovar.vcf -build mm10 $1.input /home/users/data/02_annotation/02_annovar/mousedb
