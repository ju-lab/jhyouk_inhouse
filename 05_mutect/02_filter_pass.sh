sampleName=$1
grep 'PASS' $1.mutect.vcf > $1.mutect.pass.vcf 2>$1.passfilter.out
