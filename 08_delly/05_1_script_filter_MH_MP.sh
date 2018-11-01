bam_pwd=$1
somaticbam=$2
normalbam=$3

python2.7 05_filter_MP_MH.py $2.delly.somatic.vcf $1/$2.s.md.ir.br.bam $1/$3.s.md.ir.br.bam &> $2.05_filterMPMH.out
