normal=$1
tumor=$2
sampleName=$3
set -e

/home/users/jhyouk/tools/Strelka2/strelka-2.9.9.centos6_x86_64/bin/configureStrelkaSomaticWorkflow.py --normalBam $1 --tumorBam $2 --ref /home/users/jhyouk/99_reference/mouse/mm10/GRCm38.fa --runDir $3 &>$3.strelka2.out &&
$3/runWorkflow.py -m local -j 2 &> $3.strelka2.runWorkflow.out
