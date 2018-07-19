sampleName=$1
bam_pwd=$2
somaticbam=$3
normalbam=$4
python2.7 05_filter_MP_MH.py $1.delly.somatic.vcf $2/$3.s.md.ir.br.rg.bam $2/$4.s.md.ir.br.rg.bam &> $1.05_filterMPMH.out
