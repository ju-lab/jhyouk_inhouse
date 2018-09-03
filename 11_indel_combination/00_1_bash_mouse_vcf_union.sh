sampleName=$1

python 00_mouse_vcf_combination.py /home/users/jhyouk/06_mm10_SNUH_radiation/04_strelka/$1/results/all.somatic.indels.vcf /home/users/jhyouk/06_mm10_SNUH_radiation/09_varscan/$1.varscan.indel.somatic.vcf $1 strelka varscan

