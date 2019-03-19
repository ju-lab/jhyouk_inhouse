#2018-11-19 made

import sys,gzip
print(sys.argv[1])
in_file=open(sys.argv[1])  # vcf file
Npifn=sys.argv[2]  # /path/to/SNV_NormalPanelChr1.indel.edit.gz
Npcn=sys.argv[3]  # Normal panel cohort namea
out_file=open(sys.argv[1]+'.'+Npcn,'w')

#ref_fai='/home/users/data/01_reference/human_g1k_v37/human_g1k_v37.fa.fai'
ref_fai='/home/users/jhyouk/99_reference/mouse/mm10/GRCm38.fa.fai'
dic_bin=1000000

size_file=open(ref_fai)
ip_dic={}
size_line=size_file.readline().strip()
while size_line:
	size_indi=size_line.split('\t')
	ip_dic[size_indi[0]]={}
	for i in range(0, int(size_indi[1])/dic_bin+1):
		ip_dic[size_indi[0]][i]={}
	size_line=size_file.readline().strip()

print('making indel reference dictionary')
#chr_list=["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","X","Y"] #human
chr_list=["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","X","Y"] #mouse

for chrom in chr_list:
	print(chrom)
	if Npifn[-3:]=='.gz':
		ref_file=gzip.open(Npifn.replace('chr1', 'chr'+chrom))
	else:
		ref_file=open(Npifn.replace('chr1', 'chr'+chrom))
	ref_line=ref_file.readline().strip()
	while ref_line:
		if ref_line[0]=='#':
			'blank'
		else:
			ref_indi=ref_line.split('\t')
			chr1=ref_indi[0]
			pos1=int(ref_indi[1])
			idx='\t'.join(ref_indi[0:4])
			info=ref_indi[4]
			ip_dic[chr1][pos1/dic_bin][idx]=info
		ref_line=ref_file.readline().strip()

print('Starting annotation')
in_line=in_file.readline().strip()
n=0
nt_list=["A","G","C","T"]
while in_line:
	in_indi=in_line.split('\t')
	if in_line[0:6]=='#CHROM':
		out_file.write(in_line+'\t'+Npcn+'_DP;DP_N;Var;VarN;Error_vaf\n')
	elif in_line[0]=='#':
		out_file.write(in_line+'\n')
	elif in_indi[0][0:2]=='MT' or in_indi[0][0:2]=='GL':
		print("done")
		sys.exit()
	else:
		chr1=in_indi[0]
		pos1=int(in_indi[1])
		refnt=in_indi[3]
		altnt=in_indi[4].split(',')[0]
		idx='\t'.join([chr1,str(pos1),refnt,altnt])
		if idx in ip_dic[chr1][pos1/dic_bin].keys():
			info=ip_dic[chr1][pos1/dic_bin][idx]
			out_file.write(in_line+'\t'+info+'\n')
		else:
			out_file.write(in_line+'\tNA;NA;0;0;0\n')
	in_line=in_file.readline().strip()
