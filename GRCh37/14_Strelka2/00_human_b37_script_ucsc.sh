normal=$1
tumor=$2
sampleName=$3
set -e

/home/users/jhyouk/tools/Strelka2/strelka-2.9.9.centos6_x86_64/bin/configureStrelkaSomaticWorkflow.py --normalBam $1 --tumorBam $2 --ref /home/users/jhyouk/99_reference/human/hg19_UCSC/ucsc.hg19.fasta --runDir $3 &>$3.strelka2.out &&
$3/runWorkflow.py -m local -j 1 &> $3.strelka2.runWorkflow.out
