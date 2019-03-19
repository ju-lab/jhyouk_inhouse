#last modification 20170924 by SPark
#correction for refnt'N'
#2018-10-12 revised for abt Npanel input
#NA add for parsing


import sys,gzip
in_file=open(sys.argv[1])  # vcf file
Npfn=sys.argv[2]  # /path/to/NormalPanelChr1.snv.edit.gz
Npcn=sys.argv[3]  # Normal panel cohort name
out_file=open(sys.argv[1].replace('.vcf','')+'_'+Npcn+'.vcf','w')
in_line=in_file.readline().strip()
n=0
#chr_list=["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","X","Y"] #human
chr_list=["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","X","Y"] #mouse
nt_list=["A","G","C","T"]
for chr_ref in chr_list:
	if Npfn[-3:]=='.gz':
		ref_file=gzip.open(Npfn.replace('chr1','chr'+chr_ref))
	else:
		ref_file=open(Npfn.replace('chr1','chr'+chr_ref))
	ref_line=ref_file.readline().strip()
	ref_indi=ref_line.split('\t')
	print("chr"+chr_ref)
	if chr_ref=='X':
		chr2=23
	elif chr_ref=='Y':
		chr2=24
	else:
		chr2=int(chr_ref)

	while in_line:
		in_indi=in_line.split('\t')
		if in_line[0:6]=='#CHROM':
			out_file.write(in_line+'\t'+Npcn+'_DP;DP_N;Ref;RefN;Var;VarN;Error_vaf\n')
			in_line=in_file.readline().strip()
		elif in_line[0]=='#':
			out_file.write(in_line+'\n')
			in_line=in_file.readline().strip()
		elif in_indi[0][0:2]=='MT' or in_indi[0][0:2]=='GL':
			print("done")
			sys.exit()
		elif ref_line=='':
			if in_indi[0]==chr_ref:
				out_file.write(in_line+'\tNA\tNA\tNA\tNA\tNA\tNA\tNA\n')
				in_line=in_file.readline().strip()
			elif in_indi[0]!=chr_ref:
				break
		elif in_indi[3] not in nt_list:
			out_file.write(in_line+'\tNA\tNA\tNA\tNA\tNA\tNA\tNA\n')
			in_line=in_file.readline().strip()
		else:
			ref_indi=ref_line.split('\t')
			if in_indi[0]=='X':
				chr1=23
			elif in_indi[0]=='Y':
				chr1=24
			else:
				chr1=int(in_indi[0])

			ref_base=in_indi[3];ref_idx=nt_list.index(ref_base)
			var_base=in_indi[4][0];var_idx=nt_list.index(var_base)
			ref_dp=int(ref_indi[3].split(';')[0])
			var_rc=int(ref_indi[4+var_idx].split(';')[0])
			error_vaf=round(100*var_rc/float(ref_dp),3)
			if chr1==chr2:
				if int(in_indi[1])==int(ref_indi[1]):
					out_file.write(in_line+'\t'+ref_indi[3]+';'+';'.join(ref_indi[4+ref_idx].split(';')[0:2])+';'+';'.join(ref_indi[4+var_idx].split(';')[0:2])+';'+str(error_vaf)+'\n')
					in_line=in_file.readline().strip()
					ref_line=ref_file.readline().strip()
					n=n+1
				elif int(in_indi[1])>int(ref_indi[1]):
					ref_line=ref_file.readline().strip()
					n=n+1
				elif int(in_indi[1])<int(ref_indi[1]):
					out_file.write(in_line+'\tNA\n')
					in_line=in_file.readline().strip()
			elif chr1>chr2:
				break
			elif chr1<chr2:
				print("Error: input chr > ref chr>")
				print(in_line)
				print(ref_line)
				sys.exit()
		if n!=0 and n%10000000==0:
			print(n)
