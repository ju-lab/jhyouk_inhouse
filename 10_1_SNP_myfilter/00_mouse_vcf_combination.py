# written by SYPark
# a small modification by Youk, 2018/05/23

import sys
from operator import itemgetter
in_file=open(sys.argv[1])
ref_file=open(sys.argv[2])
id_name=sys.argv[3]
caller1=sys.argv[4]
caller2=sys.argv[5]

out_file=open(id_name+'.'+caller1+'_'+caller2+'_union.vcf','w')
in_line=in_file.readline().strip()

chr_list=['1','2','3','4','5','6','7','8','9','10','11','12','13','14','15','16','17','18','19','X','Y','MT']
print(sys.argv[3])
print('Only the chromosomes contained in the list below will be reported.')
print(chr_list)

in_dic={}
total_list=[]
while in_line:	
	in_indi=in_line.split('\t')
	if in_line[0:2]=='##':
		'blank'
	elif in_line[0:6]=='#CHROM':
		'blank'
	else:
		if in_indi[0] in chr_list:
			idx=in_indi[0]+'\t'+in_indi[1]+'\t'+in_indi[3]+'\t'+in_indi[4]
			chr1=((in_indi[0].replace('X','20')).replace('Y','21')).replace('MT','22')
			in_dic[idx]=['\t'.join(in_indi[0:6]), '\t'.join(in_indi[6:11])]
			total_list.append([int(chr1), int(in_indi[1]), idx])
		else:
			'blank'
	in_line=in_file.readline().strip()

ref_dic={}
ref_line=ref_file.readline().strip()
while ref_line:
	if ref_line[0:2]=='##':
		'blank'
	elif ref_line[0:6]=='#CHROM':
		'blank'
	else:
		ref_indi=ref_line.split('\t')

		if ref_indi[0] in chr_list:
			idx=ref_indi[0]+'\t'+ref_indi[1]+'\t'+ref_indi[3]+'\t'+ref_indi[4]
			chr1=((ref_indi[0].replace('X','20')).replace('Y','21')).replace('MT','22')
			ref_dic[idx]=['\t'.join(ref_indi[0:6]), '\t'.join(ref_indi[6:11])]
			total_list.append([int(chr1),int(ref_indi[1]), idx])
		else:
			'blank'
	ref_line=ref_file.readline().strip()


total_list.sort(key=itemgetter(0,1))

out_file.write('#CHROM\tPOS\tID\tREF\tALT\tQUAL\tFILTER1\tINFO1\tFORMAT1\tSAMPLE1_1\tSAMPLE1_2\tFILTER2\tINFO2\tFORMAT2\tSAMPLE2_1\tSAMPLE2_2\tCALLER\n')
empty_content='.\t.\t.\t.\t.'
n=0;m=0;c=0;d=0
prev_idx=''
for [chr1, pos1,idx] in total_list:
	if idx == prev_idx:
		d=d+1
		'blank'
	else:
		if idx in in_dic.keys():
			if idx in ref_dic.keys():
				out_file.write(in_dic[idx][0]+'\t'+in_dic[idx][1]+'\t'+ref_dic[idx][1]+'\t'+caller1+';'+caller2+'\n')
				c=c+1
			else:
				out_file.write(in_dic[idx][0]+'\t'+in_dic[idx][1]+'\t'+empty_content+'\t'+caller1+'\n')
				n=n+1
		elif idx in ref_dic.keys():
			out_file.write(ref_dic[idx][0]+'\t'+empty_content+'\t'+ref_dic[idx][1]+'\t'+caller2+'\n')
			m=m+1
		else:
			print('exception error')
			sys.exit()
	prev_idx = idx

if d != c:
	print('counting error')

print(caller1+' and '+caller2+' common: '+str(c))
print(caller1+' only: '+str(n))
print(caller2+' only: '+str(m))
