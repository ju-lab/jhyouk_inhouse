bam_pwd=$1
tumor=$2
normal=$3

/home/users/tools/delly-0.7.6/delly/src/delly call -t INS -q 15 -o $tumor.INS.bcf -g /home/users/jhyouk/99_reference/mouse/mm10/GRCm38.fa $bam_pwd/$tumor.s.md.ir.br.bam $bam_pwd/$normal.s.md.ir.br.bam &> $tumor.INS.out
