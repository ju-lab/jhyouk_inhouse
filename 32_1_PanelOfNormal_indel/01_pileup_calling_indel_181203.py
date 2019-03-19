#Arg1 mpileup
#Arg2 sample number


#2018-11-05 made
#2018-11-14 exception for rarely happened column number inconsistency in mpileup file.
#2018-12-03 regular expression error correction

import sys, gzip, collections, re
if sys.argv[1][-3:]=='.gz':
	in_file=gzip.open(sys.argv[1])
	out_file=gzip.open(sys.argv[1][:-3]+'.indel.gz','w')
else:
	in_file=open(sys.argv[1])		#mpileup file
	out_file=gzip.open(sys.argv[1]+'.indel.gz','w')
in_line=in_file.readline().strip()
in_indi=in_line.split('\t')
sampleNo=int(sys.argv[2])
def is_int(s):
	try:
		int(s)
		return True
	except:
		return False

while in_line:
	in_indi=in_line.split('\t')
	if in_indi[2]=='N':
		'blank'
	else:
		out_file.write(in_indi[0]+'\t'+in_indi[1]+'\t'+in_indi[2])
		refnt=in_indi[2]
		for a in range (0,sampleNo):
			dp=int(in_indi[1+(a*3)+2])
			info_list=[]
			try:
				A=in_indi[1+(a*3)+3]
			except:
				out_file.write('\tdp='+str(dp))
				continue
			if '+' in in_indi[1+(a*3)+3]:
				obj_list=re.findall(r'\+[0-9]+[ACGTNacgtn]+', in_indi[1+(a*3)+3])
				new_obj_list=[]
				for obj in obj_list:
					new_obj_list.append(obj.upper())
				obj_dic=collections.Counter(new_obj_list)
				for obj in obj_dic.keys():
					info_list.append(obj+'('+str(obj_dic[obj])+')')
			if '-' in in_indi[1+(a*3)+3]:
				obj_list=re.findall(r'\-[0-9]+[ACGTNacgtn]+', in_indi[1+(a*3)+3])
				new_obj_list=[]
				for obj in obj_list:
					new_obj_list.append(obj.upper())
				obj_dic=collections.Counter(new_obj_list)
				for obj in obj_dic.keys():
					info_list.append(obj+'('+str(obj_dic[obj])+')')
			if len(info_list) > 0:
				out_file.write('\tdp='+str(dp)+';'+';'.join(info_list))
			else:
				out_file.write('\tdp='+str(dp))
		out_file.write('\n')
	in_line=in_file.readline().strip()
