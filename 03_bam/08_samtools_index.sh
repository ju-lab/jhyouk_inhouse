sampleName=$1

samtools index -@ 6 $sampleName.s.md.ir.br.rg.bam $sampleName.s.md.ir.br.rg.bai &> $sampleName.rg.index.out
