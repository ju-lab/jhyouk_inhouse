#!/bin/bash
set -e

normalPileup=$1
tumorPileup=$2
sampleName=$3

if false; then
#create seqz file from the two mpileups
echo bam2seqz
sequenza-utils bam2seqz -gc /home/users/jhyouk/06_mm10_SNUH_radiation/07_sequenza/gc50base.mm10.wig.gz -n $normalPileup -t $tumorPileup -p -o $sampleName.seqz > $sampleName.bam2seqz.out 2>&1

#binning
echo binning
sequenza-utils seqz_binning --window 100 --seqz $sampleName.seqz -o $sampleName.comp.seqz > $sampleName.binnnig.out 2>&1

# remove unwanted contigs in reference fasta
echo mtglremove
cat $sampleName.comp.seqz | grep -v 'MT' | grep -v 'GL' | grep -v 'JH' > $sampleName.comp.seqz.rmGLMTJH 2> $sampleName.mtglremove.out

## gzip 
echo gzip
gzip $sampleName.comp.seqz.rmGLMTJH > $sampleName.gzip.out 2>&1

echo done 

#cleanup
#rm $normalBam.mpileup.gz $tumorBam.mpileup.gz $sampleName.seqz $sampleName.comp.seqz 
fi

# further analysis
Rscript /home/users/jhyouk/06_mm10_SNUH_radiation/07_sequenza/03_Rscript_sequenza.R $sampleName.comp.seqz.rmGLMTJH.gz $sampleName > $sampleName.Rscript.out 2>&1
