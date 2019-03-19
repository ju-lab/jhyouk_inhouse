# gender info added
# sequenza R file for hg38 (it refers to the cytoBand file for hg38)

#!/bin/bash
normalBam=$1
tumorBam=$2
sampleName=$3
reference=$4
outDir=$5
#gender=$6

if [ ! $# == 5 ]; then echo "$0 normalbam tumorbam samplename reference outdir"; exit 1; fi
#if [ ! $# == 6 ]; then echo "$0 normalbam tumorbam samplename reference outdir gender"; exit 1; fi

set -e

mpileupDir=$outDir/mpileup
logDir=$outDir/log
seqzDir=$outDir/seqz
covDir=$outDir/coverage
sampleDir=$seqzDir/$sampleName
mkdir -p $mpileupDir $logDir $seqzDir $covDir $sampleDir

# create mpileup
echo mplieup
(/usr/local/bin/samtools mpileup -B -Q 20 -q 20 -f $reference $normalBam > $mpileupDir/$sampleName.N.mpileup) &> $logDir/$sampleName.N.mp.log &
(/usr/local/bin/samtools mpileup -B -Q 20 -q 20 -f $reference $tumorBam > $mpileupDir/$sampleName.T.mpileup) &> $logDir/$sampleName.T.mp.log

# smoothened copy number
echo smoothenedCN:get_coverage
(python2.7 /data/hspark/07_smoothendCN/01_get_coverage_hg38.py $mpileupDir/$sampleName.N.mpileup) &> $logDir/$sampleName.smootenedCN.N.step1.log || (echo ERROR:smoothenedCN_N_step1 > $logDir/$sampleName.log; exit 1) &
(python2.7 /data/hspark/07_smoothendCN/01_get_coverage_hg38.py $mpileupDir/$sampleName.T.mpileup) &> $logDir/$sampleName.smootenedCN.T.step1.log || (echo ERROR:smoothenedCN_T_step1 > $logDir/$sampleName.log; exit 1)

#echo smoothenedCN:calculate_stats
(python2.7 /data/hspark/07_smoothendCN/02_calculate_stats.py coverage/$sampleName.N.mpileup.100kbcov) &> $logDir/$sampleName.smootenedCN.N.step2.log || (echo ERROR:smoothenedCN_N_step2 > $logDir/$sampleName.log; exit 1) &
(python2.7 /data/hspark/07_smoothendCN/02_calculate_stats.py coverage/$sampleName.T.mpileup.100kbcov) &> $logDir/$sampleName.smootenedCN.T.step2.log || (echo ERROR:smoothenedCN_T_step2 > $logDir/$sampleName.log; exit 1)

# create seqz file from the two mpileups
echo pileup2seqz
/usr/local/bin/sequenza-utils bam2seqz -gc /data/hspark/03_sequenza/hg38.gc50Base.wig.gz -n $mpileupDir/$sampleName.N.mpileup -t $mpileupDir/$sampleName.T.mpileup -p -o $sampleDir/$sampleName.seqz &> $logDir/$sampleName.seqz.log|| (echo ERROR:pileup2seqz > $logDir/$sampleName.log; exit 1)

# remove mpileup
rm $mpileupDir/$sampleName.N.mpileup $mpileupDir/$sampleName.T.mpileup  ||(echo ERROR:remove_mpileups ;exit 1)

# binning
echo binning
/usr/local/bin/sequenza-utils seqz_binning --window 100 --seqz $sampleDir/$sampleName.seqz -o $sampleDir/$sampleName.comp.seqz &> $logDir/$sampleName.binning.log|| (echo ERROR:binning_failure >> $logDir/$sampleName.log; exit 1)

# remove unwanted contigs in reference fasta (hg38)
echo mtglremove
(cat $sampleDir/$sampleName.comp.seqz | grep -v chrM | grep -v random | grep -v chrUn | grep -v alt | grep -v chrEBV | grep -v HLA > $sampleDir/$sampleName.comp.seqz.rmGLMT) &> $logDir/$sampleName.mtglrm.log || (echo ERROR:removeMTGL_failure >> $logDir/$sampleName.log; exit 1)
echo done 

# gzip
echo gzip $sampleDir/$sampleName.comp.seqz.rmGLMT
ls $sampleDir/$sampleName.comp.seqz.rmGLMT
gzip $sampleDir/$sampleName.comp.seqz.rmGLMT

mv $logDir/$sampleName.log $logDir/$sampleName.done

# Run sequenza
#echo Run sequenza
#Rscript $outDir/run_sequenza.hg38.R --seqz_file $sampleDir/$sampleName.comp.seqz.rmGLMT.gz --sample_name $sampleName -o $sampleDir -g $gender &> $logDir/$sampleName.seqzR.log || (echo ERROR:runSequenza >> $logDir/$sampleName.log; exit 1)

# cleanup
rm $sampleDir/$sampleName.seqz $sampleDir/$sampleName.comp.seqz ||(echo ERROR:cleanupfail ;exit 1)

