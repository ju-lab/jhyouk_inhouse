#!/bin/bash

tumor=$1
normal=$2
sampleName=$3
bam_pwd=$4

/usr/java/jre1.7.0_80/bin/java -Xmx12g -jar /home/users/tools/mutect/mutect-1.1.7.jar --analysis_type MuTect --reference_sequence /home/users/jhyouk/99_reference/mouse/mm10/GRCm38.fa --input_file:tumor $4/$tumor.s.md.ir.br.rg.bam --input_file:normal $4/$normal.s.md.ir.br.rg.bam --vcf $sampleName.mutect.vcf --coverage_file $sampleName.mutect.wig > $sampleName.mutect.out 2>&1
