sampleName=$1

python 10_SV_VAF_annot.py $1.delly.somatic.vcf.BPinfo4.filter1.rearrange ../03_bam/$1.s.md.ir.br.rg.bam &> $1.10_SV.out