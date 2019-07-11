#Arg1 called pileup indel
#Arg2 case number

#last modification 2018-11-07
#181202 deletion writing error correction; RE error correction

import sys, gzip, re
print(sys.argv[1])
if sys.argv[1][-3:]=='.gz':
	in_file=gzip.open(sys.argv[1])  
	out_file=gzip.open(sys.argv[1][:-3]+'.edit.gz','w')
else:
	in_file=open(sys.argv[1])
	out_file=gzip.open(sys.argv[1]+'.edit.gz','w')


header_list=['#CHROM','POS','REF','ALT','DPsum;DPn;VARsum;VARn;VAFpct']
out_file.write('\t'.join(header_list)+'\n')
in_line=in_file.readline().strip()
caseN=int(sys.argv[2])   # Case number
n=0
while in_line:
	in_indi=in_line.split('\t')
	chr1=in_indi[0]
	pos1=in_indi[1]
	refnt=in_indi[2]
	dp_list=[]
	dpn=0
	ins_dic={}
	del_dic={}
	for n in range(3,caseN+3):
		indi_dp=int(((in_indi[n].split('dp=')[1]).split('\t')[0]).split(';')[0])
		if indi_dp > 0:
			dpn +=1
		dp_list.append(indi_dp)
	if '+' in in_line:
		obj_list=re.findall(r'\+[0-9]+[AGCTNactgn]+\([0-9]+\)', in_line)
		for obj in obj_list:
			sobj=re.search(r'\+[0-9]+([AGCTNagctn]+)\(([0-9]+)\)', obj)
			ins_seq=sobj.group(1)
			ins_rc=int(sobj.group(2))
			if ins_seq in ins_dic:
				ins_dic[ins_seq]["sampleN"]+=1
				ins_dic[ins_seq]["readC"]+=ins_rc
			else:
				ins_dic[ins_seq]={}
				ins_dic[ins_seq]["sampleN"]=1
				ins_dic[ins_seq]["readC"]=ins_rc
	if '-' in in_line:
		obj_list=re.findall(r'\-[0-9]+[AGCTNactgn]+\([0-9]+\)', in_line)
		for obj in obj_list:
			sobj=re.search(r'\-[0-9]+([AGCTNagctn]+)\(([0-9999]+)\)', obj)
			del_seq=sobj.group(1)
			del_rc=int(sobj.group(2))
			if del_seq in del_dic:
				del_dic[del_seq]["sampleN"]+=1
				del_dic[del_seq]["readC"]+=del_rc
			else:
				del_dic[del_seq]={}
				del_dic[del_seq]["sampleN"]=1
				del_dic[del_seq]["readC"]=del_rc
	dpsum=sum(dp_list)
	if len(ins_dic) > 0:
		for ins_seq in ins_dic.keys():
			altnt=refnt+ins_seq
			varsum=ins_dic[ins_seq]["readC"]
			varn=ins_dic[ins_seq]["sampleN"]
			vaf=round(varsum*100/float(dpsum),2)
			info_list=[chr1,pos1,refnt,altnt,str(dpsum)+';'+str(dpn)+';'+str(varsum)+';'+str(varn)+';'+str(vaf)]
			out_file.write('\t'.join(info_list)+'\n')
	if len(del_dic) > 0:
		for del_seq in del_dic.keys():
			altnt=refnt
			new_refnt=refnt+del_seq
			varsum=del_dic[del_seq]["readC"]
			varn=del_dic[del_seq]["sampleN"]
			vaf=round(varsum*100/float(dpsum),2)
			info_list=[chr1,pos1,new_refnt,altnt,str(dpsum)+';'+str(dpn)+';'+str(varsum)+';'+str(varn)+';'+str(vaf)]
			out_file.write('\t'.join(info_list)+'\n')
	in_line=in_file.readline().strip()
