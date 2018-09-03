import sys, pysam
bam_fn = sys.argv[1]
i=0
bam_file = pysam.AlignmentFile(bam_fn,'rb')
for read in bam_file.fetch('7',117707109,117707110):
	print read
	print read.reference_start
	break
