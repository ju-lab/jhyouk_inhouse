#!/bin/bash
set -e

mpileup_pwd=$1
sampleName=$2
normalPileup=$3
cellularity=$4 #ex>1 or 0.7
ploidy=$5 # ex>2
ref=$6 #mm10 or hg19
gender=$7 #XX or XY

#/home/users/jhyouk/miniconda2/bin/Rscript /home/users/jhyouk/06_mm10_SNUH_radiation/GRCh37/07_sequenza/11_Rscript_sequenza_6args.R $sampleName.comp.seqz.rmGLMTJH.gz $sampleName-withpurity $4 $5 $6 $7 &> $sampleName.purity.Rscript.out
#Rscript /home/users/yssong/uveal_melanoma/04_sequenza/12_Rscript_sequenza_6args_nopurityassign.R $sampleName.comp.seqz.rmGLMTJH.gz $sampleName 0 0$6 $7 &> $sampleName.Rscript.out
/home/users/jhyouk/miniconda2/bin/Rscript /home/users/yssong/uveal_melanoma/04_sequenza/13_Rscript_sequenza_6args_noploidyassign.R $sampleName.comp.seqz.rmGLMTJH.gz $sampleName-onlypurity $4 $5 $6 $7 &> $sampleName.onlypurity.Rscript.out
