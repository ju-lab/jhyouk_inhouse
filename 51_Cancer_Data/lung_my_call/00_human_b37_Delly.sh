bam_pwd=$1
tumor=$2
normal=$3

/home/users/tools/delly-0.7.6/delly/src/delly call -t DEL -q 15 -o $tumor.DEL.bcf -g /home/users/sypark/02_Reference/15_pcawg/genome.fa $bam_pwd/$tumor.bam $bam_pwd/$normal.bam &> $tumor.DEL.out && 
/home/users/tools/delly-0.7.6/delly/src/delly call -t INS -q 15 -o $tumor.INS.bcf -g /home/users/sypark/02_Reference/15_pcawg/genome.fa $bam_pwd/$tumor.bam $bam_pwd/$normal.bam &> $tumor.INS.out &&
/home/users/tools/delly-0.7.6/delly/src/delly call -t DUP -q 15 -o $tumor.DUP.bcf -g /home/users/sypark/02_Reference/15_pcawg/genome.fa $bam_pwd/$tumor.bam $bam_pwd/$normal.bam &> $tumor.DUP.out &&
/home/users/tools/delly-0.7.6/delly/src/delly call -t INV -q 15 -o $tumor.INV.bcf -g /home/users/sypark/02_Reference/15_pcawg/genome.fa $bam_pwd/$tumor.bam $bam_pwd/$normal.bam &> $tumor.INV.out &&
/home/users/tools/delly-0.7.6/delly/src/delly call -t TRA -q 15 -o $tumor.TRA.bcf -g /home/users/sypark/02_Reference/15_pcawg/genome.fa $bam_pwd/$tumor.bam $bam_pwd/$normal.bam &> $tumor.TRA.out &&
bcftools concat -a -O v -o $2.delly.vcf $2.DEL.bcf $2.DUP.bcf $2.INS.bcf $2.INV.bcf $2.TRA.bcf
