bam_pwd=$1
tumor=$2
normal=$3
sampleName=$4

/home/users/tools/delly-0.7.6/delly/src/delly call -t DEL -q 15 -o $sampleName.DEL.bcf -g /home/users/jhyouk/99_reference/mouse/mm10/GRCm38.fa $bam_pwd/$tumor.s.md.ir.br.rg.bam $bam_pwd/$normal.s.md.ir.br.rg.bam &> $sampleName.DEL.out & 
/home/users/tools/delly-0.7.6/delly/src/delly call -t DEL -q 15 -s 100 -n -o $sampleName.DEL100.bcf -g /home/users/jhyouk/99_reference/mouse/mm10/GRCm38.fa $bam_pwd/$tumor.s.md.ir.br.rg.bam $bam_pwd/$normal.s.md.ir.br.rg.bam &> $sampleName.DEL100.out &
/home/users/tools/delly-0.7.6/delly/src/delly call -t INS -q 15 -o $sampleName.INS.bcf -g /home/users/jhyouk/99_reference/mouse/mm10/GRCm38.fa $bam_pwd/$tumor.s.md.ir.br.rg.bam $bam_pwd/$normal.s.md.ir.br.rg.bam &> $sampleName.INS.out &
/home/users/tools/delly-0.7.6/delly/src/delly call -t DUP -q 15 -o $sampleName.DUP.bcf -g /home/users/jhyouk/99_reference/mouse/mm10/GRCm38.fa $bam_pwd/$tumor.s.md.ir.br.rg.bam $bam_pwd/$normal.s.md.ir.br.rg.bam &> $sampleName.DUP.out &
/home/users/tools/delly-0.7.6/delly/src/delly call -t INV -q 15 -o $sampleName.INV.bcf -g /home/users/jhyouk/99_reference/mouse/mm10/GRCm38.fa $bam_pwd/$tumor.s.md.ir.br.rg.bam $bam_pwd/$normal.s.md.ir.br.rg.bam &> $sampleName.INV.out &
/home/users/tools/delly-0.7.6/delly/src/delly call -t TRA -q 15 -o $sampleName.TRA.bcf -g /home/users/jhyouk/99_reference/mouse/mm10/GRCm38.fa $bam_pwd/$tumor.s.md.ir.br.rg.bam $bam_pwd/$normal.s.md.ir.br.rg.bam &> $sampleName.TRA.out
