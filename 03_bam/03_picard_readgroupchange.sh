sampleName=$1

java -Xms8g -Xmx12g -jar /home/users/tools/picard/dist/picard.jar AddOrReplaceReadGroups I=$sampleName.s.md.ir.br.bam O=$sampleName.s.md.ir.br.rg.bam RGID=$sampleName RGLB=1 RGSM=$sampleName RGPL=ILLUMINA RGPU=1 &> $sampleName.picard_RG.out
