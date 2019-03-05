bam_pwd=$1
tumor=$2
normal=$3

/home/users/tools/delly-0.7.6/delly/src/delly call -t DEL -q 15 -o $tumor.DEL.bcf -g /home/users/jhyouk/99_reference/mouse/mm10/GRCm38.fa $bam_pwd/$tumor.bam $bam_pwd/$normal.s.md.ir.br.bam &> $tumor.DEL.out & 
/home/users/tools/delly-0.7.6/delly/src/delly call -t INS -q 15 -o $tumor.INS.bcf -g /home/users/jhyouk/99_reference/mouse/mm10/GRCm38.fa $bam_pwd/$tumor.bam $bam_pwd/$normal.s.md.ir.br.bam &> $tumor.INS.out &
/home/users/tools/delly-0.7.6/delly/src/delly call -t DUP -q 15 -o $tumor.DUP.bcf -g /home/users/jhyouk/99_reference/mouse/mm10/GRCm38.fa $bam_pwd/$tumor.bam $bam_pwd/$normal.s.md.ir.br.bam &> $tumor.DUP.out &
/home/users/tools/delly-0.7.6/delly/src/delly call -t INV -q 15 -o $tumor.INV.bcf -g /home/users/jhyouk/99_reference/mouse/mm10/GRCm38.fa $bam_pwd/$tumor.bam $bam_pwd/$normal.s.md.ir.br.bam &> $tumor.INV.out &
/home/users/tools/delly-0.7.6/delly/src/delly call -t TRA -q 15 -o $tumor.TRA.bcf -g /home/users/jhyouk/99_reference/mouse/mm10/GRCm38.fa $bam_pwd/$tumor.bam $bam_pwd/$normal.s.md.ir.br.bam &> $tumor.TRA.out
echo finish
wait
