#!/bin/bash

germline=$1
somatic=$2
sampleName=$3
reference=$4

/home/users/tools/strelka/bin/configureStrelkaWorkflow.pl --normal $germline --tumor $somatic --ref $reference --config /home/users/jhyouk/06_mm10_SNUH_radiation/04_strelka/strelka_config_bwa_default.ini --output-dir ./$sampleName > $sampleName.strelka.out 2>&1 &&

cd /home/users/jhyouk/06_mm10_SNUH_radiation/04_strelka/$sampleName &&
make -j 4
