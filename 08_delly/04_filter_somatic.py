import sys, os
input_fn = sys.argv[1]
in_file = file(input_fn)
out_file=file(input_fn.replace('.vcf','.somatic.vcf'),'w')
in_line=in_file.readline().strip()
while in_line:
	if in_line[0]=='#':
		out_file.write(in_line+'\n')
	else:
		in_indi=in_line.split('\t')
		tDV=int(in_indi[9].split(':')[9])
		tRV=int(in_indi[9].split(':')[11])
		nDV=int(in_indi[10].split(':')[9])
		nRV=int(in_indi[10].split(':')[11])
		if tDV+tRV==0: #filter out
			'blank'
		elif nDV+nRV>0:  #filter out
			'blank'
		else:
			out_file.write(in_line+'\n')
	in_line=in_file.readline().strip()
