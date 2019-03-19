#!/bin/bash
set -e

mpileup_pwd=$1
sampleName=$2
normalPileup=$3
cellularity=$4 #ex>1 or 0.7
ploidy=$5 # ex>2
ref=$6 #mm10 or hg19
gender=$7 #XX or XY

if false; then
#create seqz file from the two mpileups
echo bam2seqz
sequenza-utils bam2seqz -gc /home/users/jhyouk/06_mm10_SNUH_radiation/07_sequenza/gc50base.mm10.wig.gz -n $1/$normalPileup.mpileup -t $1/$sampleName.mpileup -p -o $sampleName.seqz > $sampleName.bam2seqz.out 2>&1

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
rm $sampleName.seqz $sampleName.comp.seqz 
fi

# further analysis
#Rscript /home/users/jhyouk/06_mm10_SNUH_radiation/07_sequenza/03_Rscript_sequenza.R $sampleName.comp.seqz.rmGLMTJH.gz $sampleName &> $sampleName.Rscript.out
Rscript 11_Rscript_sequenza_6args.R ../07_sequenza/$sampleName.comp.seqz.rmGLMTJH.gz $sampleName-mm10 $4 $5 $6 $7 &> $sampleName.Rscript.out
