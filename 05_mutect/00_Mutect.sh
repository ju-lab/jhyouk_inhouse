#!/bin/bash

bam_pwd=$1
tumor=$2
normal=$3

/usr/java/jre1.7.0_80/bin/java -Xmx12g -jar /home/users/tools/mutect/mutect-1.1.7.jar --analysis_type MuTect --reference_sequence /home/users/jhyouk/99_reference/mouse/mm10/GRCm38.fa --input_file:tumor $1/$tumor.s.md.ir.br.bam --input_file:normal $1/$normal.s.md.ir.br.bam --vcf $tumor.mutect.vcf --coverage_file $tumor.mutect.wig &> $tumor.mutect.out
