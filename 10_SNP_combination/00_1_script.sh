sampleName=$1

python 00_mouse_vcf_combination.py ../05_mutect/$1.mutect.pass.vcf ../04_strelka/$1/results/passed.somatic.snvs.vcf $1.combination Mutect Strelka &> $1.vcfcombine.out
