sampleName=$1

bcftools concat -a -O v -o $1.delly.vcf $1.DEL.bcf $1.DUP.bcf $1.INS.bcf $1.INV.bcf $1.TRA.bcf
