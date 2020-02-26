sequenza-utils gc_wiggle -w 50 -o gc50base.ucsc.wig -f /home/users/jhyouk/99_reference/human/hg19_UCSC/ucsc.hg19.fasta > gc50basewiggle.ucsc.out 2>&1 &&
gzip gc50base.ucsc.wig &> gc50.ucsc.gzip.out
