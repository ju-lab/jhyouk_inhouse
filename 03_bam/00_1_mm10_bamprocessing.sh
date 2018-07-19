#!/bin/bash
set -e
fastq1=$1
fastq2=$2
sampleName=$3
reference=$4

echo create sam using bwa mem
bwa mem -M -t 6 -R "@RG\tID:$sampleName\tLB:1\tSM:$sampleName\tPL:ILLUMINA" $reference $fastq1 $fastq2 > $sampleName.sam 2> $sampleName.bwamem.out 

echo sam to bam
samtools view -Sb -@ 8 -o $sampleName.bam $sampleName.sam > $sampleName.StoB.out 2>&1 
rm $sampleName.sam 

echo sort
samtools sort -@ 8 -o $sampleName.s.bam $sampleName.bam > $sampleName.sort.out 2>&1 
rm $sampleName.bam 

if false; then
echo MarkDuplicate
java -Xms8g -Xmx12g -jar /home/users/tools/picard/dist/picard.jar MarkDuplicates REMOVE_DUPLICATES=true REMOVE_SEQUENCING_DUPLICATES=ture I=$sampleName.s.bam O=$sampleName.s.md.bam M=$sampleName.matrics.txt VALIDATION_STRINGENCY=LENIENT CREATE_INDEX=true > $sampleName.markdup.out 2>&1 
rm $sampleName.s.bam 

echo realignment
java -Xms8g -Xmx12g -jar /home/users/tools/gatk/gatk-3.5/GenomeAnalysisTK.jar -T RealignerTargetCreator -R /home/users/jhyouk/99_reference/mouse/mm10/GRCm38.fa -I $sampleName.s.md.bam --known /home/users/jhyouk/99_reference/mouse/mm10/mgp.v5.merged.indels.dbSNP142.normed.reduce.s.vcf -o $sampleName.s.md.bam.intervals -nt 8 > $sampleName.RTC.out 2>&1 

java -Xms8g -Xmx12g -jar /home/users/tools/gatk/gatk-3.5/GenomeAnalysisTK.jar -T IndelRealigner -R /home/users/jhyouk/99_reference/mouse/mm10/GRCm38.fa -I $sampleName.s.md.bam -known /home/users/jhyouk/99_reference/mouse/mm10/mgp.v5.merged.indels.dbSNP142.normed.reduce.s.vcf -targetIntervals $sampleName.s.md.bam.intervals -o $sampleName.s.md.ir.bam > $sampleName.IR.out 2>&1 

rm $sampleName.s.md.bam 
fi

echo recalibration
java -Xms8g -Xmx12g -jar /home/users/tools/gatk/gatk-3.5/GenomeAnalysisTK.jar -T BaseRecalibrator -R /home/users/jhyouk/99_reference/mouse/mm10/GRCm38.fa -I $sampleName.s.md.ir.bam --knownSites /home/users/jhyouk/99_reference/mouse/mm10/mgp.v5.merged.indels.dbSNP142.normed.reduce.s.vcf -knownSites /home/users/jhyouk/99_reference/mouse/mm10/mgp.v5.merged.snps_all.dbSNP142.reduce.s.vcf -o $sampleName.s.md.ir.bam.table -nct 8 > $sampleName.BR.out 2>&1 

java -Xms8g -Xmx12g -jar /home/users/tools/gatk/gatk-3.5/GenomeAnalysisTK.jar -T PrintReads -R /home/users/jhyouk/99_reference/mouse/mm10/GRCm38.fa -I $sampleName.s.md.ir.bam -BQSR $sampleName.s.md.ir.bam.table -o $sampleName.s.md.ir.br.bam -nct 8 > $sampleName.PR.out 2>&1 

rm $sampleName.s.md.ir.bam 
rm $sampleName.s.md.ir.bam.table 
rm $sampleName.s.md.bam.intervals

