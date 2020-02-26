#!/bin/bash

# change reference fai file

sampleID=$1
tumor_col=$2
tumorBam=$3
normalBam=$4
pon=$5
srcDir=$6
reference=$7 # mm10 or hg19

outDir=$(dirname $1)
rawDIR="../08_delly"
log=$outDir/$1.SVprocessing.log

# START
echo $1 $3 $4 $5 > $log
echo "start SV annotation from bcf combine"
if false; then
(bcftools concat -a -O v -o $1.delly.vcf $rawDIR/$1.DEL.bcf $rawDIR/$1.DUP.bcf $rawDIR/$1.INS.bcf $rawDIR/$1.INV.bcf $rawDIR/$1.TRA.bcf) &>> $log || { c=$?;echo "Error";exit $c; }
echo "done"
echo "filter somatic"
(python $srcDir/01.filter_somatic_delly.py $1.delly.vcf $tumor_col) &>> $log || { c=$?;echo "Error";exit $c; }
echo "done"
echo "Starting:sorting"
(python $srcDir/02.sorting_delly.py $1.delly.vcf.somatic) &>> $log || { c=$?;echo "Error";exit $c; }
#rm $1.delly.vcf.somatic
echo "done"
fi
echo "Starting:annotate PON"
(python $srcDir/03.annotate_PON.py $1.delly.vcf.somatic.sort $pon $srcDir/$7.fa.fai) &>> $log || { c=$?;echo "Error";exit $c; }
#rm $1.delly.vcf.somatic.sort
echo "done"
echo "Starting:find BP"
(python $srcDir/04.find_BP.py $1.delly.vcf.somatic.sort.pon $tumorBam $normalBam) &>> $log || { c=$?;echo "Error";exit $c; }
rm $1.delly.vcf.somatic.sort.pon
echo "done"
echo "Starting:BP adjustment"
(python $srcDir/05.BP_adjustment.py $1.delly.vcf.somatic.sort.pon.BPinfo) &>> $log || { c=$?;echo "Error";exit $c; } 
rm $1.delly.vcf.somatic.sort.pon.BPinfo
echo "done"
echo "Starting:count fragments and find newBP"
(python $srcDir/06.07.count_frag_find_newBP.py $1.delly.vcf.somatic.sort.pon.BPinfo.BPadj $tumorBam $normalBam) &>> $log || { c=$?;echo "Error";exit $c; }
rm $1.delly.vcf.somatic.sort.pon.BPinfo.BPadj
echo "done"
echo "Starting:annotate background information"
(python $srcDir/08.annotate_BGinfo.py $1.delly.vcf.somatic.sort.pon.BPinfo.BPadj.SVvaf $tumorBam $normalBam) &>> $log || { c=$?;echo "Error";exit $c; }
rm $1.delly.vcf.somatic.sort.pon.BPinfo.BPadj.SVvaf
echo "done"
echo "Starting:annotate paired normal same clipping"
(python $srcDir/09.PN_same_clipping.py $1.delly.vcf.somatic.sort.pon.BPinfo.BPadj.SVvaf.bginfo $tumorBam $normalBam) &>> $log || { c=$?;echo "Error";exit $c; }
rm $1.delly.vcf.somatic.sort.pon.BPinfo.BPadj.SVvaf.bginfo
echo "done"
echo "Starting:annotate mapq starting position variance"
(python $srcDir/10.MAPQ_start_pos.py $1.delly.vcf.somatic.sort.pon.BPinfo.BPadj.SVvaf.bginfo.pnsc $tumorBam) &>> $log || { c=$?;echo "Error";exit $c; }
rm $1.delly.vcf.somatic.sort.pon.BPinfo.BPadj.SVvaf.bginfo.pnsc
mv $1.delly.vcf.somatic.sort.pon.BPinfo.BPadj.SVvaf.bginfo.pnsc.mqpos $1.delly.vcf.somatic.annotated
echo "All Done"
