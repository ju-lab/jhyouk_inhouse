#!/bin/bash

# change reference fai file

vcf=$1
tumor_col=$2
tumorBam=$3
normalBam=$4
pon=$5
srcDir=$6
outDir=$(dirname $vcf)

log=$outDir/$vcf.SVprocessing.log

# START
echo $1 $3 $4 $5 > $log
echo "Starting:filter somatic"
(python $srcDir/01.filter_somatic_delly.py $vcf $tumor_col) &>> $log || { c=$?;echo "Error";exit $c; }
echo "done"
echo "Starting:sorting"
(python $srcDir/02.sorting_delly.py $vcf.somatic) &>> $log || { c=$?;echo "Error";exit $c; }
#rm $vcf.somatic
echo "done"
echo "Starting:annotate PON"
#(python $srcDir/03.annotate_PON.py $vcf.somatic.sort $pon $srcDir/hg19_ref.fa.fai) &>> $log || { c=$?;echo "Error";exit $c; }
(python $srcDir/03.annotate_PON.py $vcf.somatic.sort $pon $srcDir/GRCm38.fa.fai) &>> $log || { c=$?;echo "Error";exit $c; }
#rm $vcf.somatic.sort
echo "done"
echo "Starting:find BP"
(python $srcDir/04.find_BP.py $vcf.somatic.sort.pon $tumorBam $normalBam) &>> $log || { c=$?;echo "Error";exit $c; }
rm $vcf.somatic.sort.pon
echo "done"
echo "Starting:BP adjustment"
(python $srcDir/05.BP_adjustment.py $vcf.somatic.sort.pon.BPinfo) &>> $log || { c=$?;echo "Error";exit $c; } 
rm $vcf.somatic.sort.pon.BPinfo
echo "done"
echo "Starting:count fragments and find newBP"
(python $srcDir/06.07.count_frag_find_newBP.py $vcf.somatic.sort.pon.BPinfo.BPadj $tumorBam $normalBam) &>> $log || { c=$?;echo "Error";exit $c; }
rm $vcf.somatic.sort.pon.BPinfo.BPadj
echo "done"
echo "Starting:annotate background information"
(python $srcDir/08.annotate_BGinfo.py $vcf.somatic.sort.pon.BPinfo.BPadj.SVvaf $tumorBam $normalBam) &>> $log || { c=$?;echo "Error";exit $c; }
rm $vcf.somatic.sort.pon.BPinfo.BPadj.SVvaf
echo "done"
echo "Starting:annotate paired normal same clipping"
(python $srcDir/09.PN_same_clipping.py $vcf.somatic.sort.pon.BPinfo.BPadj.SVvaf.bginfo $tumorBam $normalBam) &>> $log || { c=$?;echo "Error";exit $c; }
rm $vcf.somatic.sort.pon.BPinfo.BPadj.SVvaf.bginfo
echo "done"
echo "Starting:annotate mapq starting position variance"
(python $srcDir/10.MAPQ_start_pos.py $vcf.somatic.sort.pon.BPinfo.BPadj.SVvaf.bginfo.pnsc $tumorBam) &>> $log || { c=$?;echo "Error";exit $c; }
rm $vcf.somatic.sort.pon.BPinfo.BPadj.SVvaf.bginfo.pnsc
mv $vcf.somatic.sort.pon.BPinfo.BPadj.SVvaf.bginfo.pnsc.mqpos $vcf.somatic.annotated
echo "All Done"
