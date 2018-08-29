sampleName=$1

python 11_new_readinfo_anno_bwa_byYouk.py $1.combination.Mutect_Strelka_union.vcf ../03_bam/$1.s.md.ir.br.rg.bam ../03_bam/N1spleen.s.md.ir.br.rg.bam &>$1.11.out
