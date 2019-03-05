#Arg1: pileup snv
#Arg2: sampleN

#last modification 2018-04-24
#2018-11-07: dpn error correction
#2018-11-14: if sum of dp == 0, then vaf = 'NA'

import sys, gzip
print(sys.argv[1])
if sys.argv[1][-3:]=='.gz':
	in_file=gzip.open(sys.argv[1])  # mpileup.call
	out_file=gzip.open(sys.argv[1][:-3]+'.edit.gz','w')
else:
	in_file=open(sys.argv[1])
	out_file=gzip.open(sys.argv[1]+'.edit.gz','w')

in_line=in_file.readline().strip()
caseN=int(sys.argv[2])   # Case number
n=0
while in_line:
	in_indi=in_line.split('\t')
	ref_base=in_indi[2]
	A_list=[];G_list=[];C_list=[];T_list=[]
	nt_lists=[A_list,G_list,C_list,T_list]
	nts=["A","G","C","T"]
	dp_list=[]
	dpn=0
	low_var=[] 
	total_var=[]
	for n in range(3,caseN+3):
		indi_dp=int(((in_indi[n].split('dp=')[1]).split('\t')[0]).split(';')[0])
		dp_list.append(indi_dp)
		if indi_dp > 0:
			dpn +=1
		for m in range(0,4):
			if nts[m] in in_indi[n]:
				num_read=int(((in_indi[n].split(nts[m]+'=')[1]).split('\t')[0]).split(';')[0])
				nt_lists[m].append(num_read)
			else:
				'blank'
	if sum(dp_list)==0:
		A_vaf='NA';G_vaf='NA';C_vaf='NA';T_vaf='NA'
	else:
		A_vaf=round(sum(A_list)*100/float(sum(dp_list)),2)
		G_vaf=round(sum(G_list)*100/float(sum(dp_list)),2)
		C_vaf=round(sum(C_list)*100/float(sum(dp_list)),2)
		T_vaf=round(sum(T_list)*100/float(sum(dp_list)),2)
	out_file.write('\t'.join(in_indi[0:3])+'\t'+str(sum(dp_list))+';'+str(dpn)+'\t'+str(sum(A_list))+';'+str(len(A_list))+';'+str(A_vaf)+'\t'+str(sum(G_list))+';'+str(len(G_list))+';'+str(G_vaf)+'\t'+str(sum(C_list))+';'+str(len(C_list))+';'+str(C_vaf)+'\t'+str(sum(T_list))+';'+str(len(T_list))+';'+str(T_vaf)+'\n')
	in_line=in_file.readline().strip()
