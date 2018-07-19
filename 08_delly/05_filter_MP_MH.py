# last modification 20170902 by SPark
import sys, pysam
import collections
from scipy.stats import ttest_ind
dl_file=open(sys.argv[1])   # delly output
dl_line=dl_file.readline().strip()
bam_file=pysam.AlignmentFile(sys.argv[2],'rb')  # Cancer bam
nbam_file=pysam.AlignmentFile(sys.argv[3],'rb') #Normal bam
out_file=open(sys.argv[1]+'.BPinfo4','w')

def split_cigar(a):
	cg_num=len(a)
	lt=''
	cigar_list=[]
	for n in range(0,cg_num):
		try:
			lt=lt+str(int(a[n]))
		except:
			cigar_list.append([lt,a[n]])
			lt=''
	total_num_list=[]
	num_list=[0]
	M_list=[]
	for [num,let] in cigar_list:
		if let=='M':
			start=sum(num_list)
			num_list.append(int(num))
			end=sum(num_list)
			M_list.append([start,end])
			total_num_list.append(int(num))
		else:
			if let=='D':
				num_list.append(int(num))
			else:	
				total_num_list.append(int(num))
				num_list.append(int(num))
	global read_size
	read_size=sum(total_num_list)
#	True_M_list=[]
#	for [n1,n2] in M_list:
#		if int(n1)==0 or int(n2)==int(read_size):
#			True_M_list.append([n1,n2])
#		else:
#			'blank'
	True_M_list=M_list
	return(True_M_list)

			
			

dl_list=[]
while dl_line:
	if dl_line[0:2]=='##':
		out_file.write(dl_line+'\n')
	elif dl_line[0]=='#':
		out_file.write(dl_line+'\ttBPinfo\tnBPinfo\n')
	else:
		dl_indi=dl_line.split('\t')
		chr1=dl_indi[0];pos1=int(dl_indi[1]);chr2=(dl_indi[7].split('CHR2=')[1]).split(';')[0];pos2=int((dl_indi[7].split('END=')[1]).split(';')[0])
		ct1=(dl_indi[7].split('CT=')[1]).split(';')[0][0]
		ct2=(dl_indi[7].split('CT=')[1]).split(';')[0][-1]
		sv_type=dl_indi[2][0:3]
		dist=abs(pos1-pos2)
		fors=500; bacs=100  #check

		if (sv_type=='INV' or sv_type=='DEL') and dist<fors:
			fors=dist-10

		if (sv_type=='INV' or sv_type=='DUP') and dist<bacs:
			bacs=dist-10

		if ct1=='5':
			search1=pos1-fors; search2=pos1+bacs
		elif ct1=='3':
			search1=pos1-bacs; search2=pos1+fors
		elif ct1=='N':
			search1=pos1-250; search2=pos1+250

		if ct2=='5':
			search3=pos2-fors; search4=pos2+bacs
		elif ct2=='3':
			search3=pos2-bacs; search4=pos2+fors
		elif ct2=='N':
			search3=pos2-250; search4=pos2+250
		dl_list.append([chr1,max(1,search1),search2,chr2,max(1,search3),search4,dl_line]) #check
	dl_line=dl_file.readline().strip()

reverse_list=['1','3','5','7','9','b','d','f']
for [a,b,c,d,e,f,g] in dl_list:
	Pair_N=0
	SA_N=0
	out_file.write(g)
	tINFO=[];nINFO=[]
	for read in bam_file.fetch(a,b,c):
		if read.has_tag('SA'):
			cigar_info=read.cigarstring
			SA_list=str(read.get_tag('SA')).split(';')[:-1]
			for SA_indi in SA_list:
				SA_chr=SA_indi.split(',')[0]
				SA_pos=SA_indi.split(',')[1]
				SA_strand=SA_indi.split(',')[2]
				SA_cigar=SA_indi.split(',')[3]
				SA_MQ=SA_indi.split(',')[4]
				if SA_chr==d and int(SA_pos)>=int(e) and int(SA_pos)<=int(f): #check
					pri_M_list=split_cigar(cigar_info)		
					SA_M_list=split_cigar(SA_cigar)
					if len(pri_M_list)!=1 or len(SA_M_list)!=1:
						'blank'
					else:
						SA_N=SA_N+1
						if (hex(int(read.flag))[-2] in reverse_list and SA_strand=='-') or (hex(int(read.flag))[-2] not in reverse_list and SA_strand=='+'):
							if 0 in pri_M_list[0] and int(read_size) in SA_M_list[0]:
								pri_len=int(pri_M_list[0][1])-int(pri_M_list[0][0])
								SA_len=int(SA_M_list[0][1])-int(SA_M_list[0][0])
								MHLEN=pri_len+SA_len-int(read_size)
								bp1=read.reference_start+pri_len
								bp2=int(SA_pos)
								terminal1="3"; terminal2="5"
								if read.reference_name!=SA_chr:
									rearr="TRA"
								else:
									if bp1<bp2:
										rearr="DEL"
									elif bp1>bp2:
										rearr="DUP"
								tINFO.append(read.reference_name+':'+str(bp1)+'_'+SA_chr+':'+str(bp2)+'_'+str(MHLEN)+'_'+rearr+'_'+terminal1+'-'+terminal2)
							elif  int(read_size) in pri_M_list[0] and 0 in SA_M_list[0]:
								pri_len=int(pri_M_list[0][1])-int(pri_M_list[0][0])
								SA_len=int(SA_M_list[0][1])-int(SA_M_list[0][0])
								MHLEN=pri_len+SA_len-int(read_size)
								bp1=read.reference_start+1
								bp2=int(SA_pos)+SA_len-1
								terminal1="5";terminal2="3"
								if read.reference_name!=SA_chr:
									rearr="TRA"
								else:
									if bp1<bp2:
										rearr="DUP"
									elif bp1>bp2:
										rearr="DEL"
			
								tINFO.append(read.reference_name+':'+str(bp1)+'_'+SA_chr+':'+str(bp2)+'_'+str(MHLEN)+'_'+rearr+'_'+terminal1+'-'+terminal2)
							#	bam_file.count_coverage(reference=a, start=, end=, quality_threshold=15)
							else:
								'blank'
						else:
							if 0 in pri_M_list[0] and 0 in SA_M_list[0]:
								pri_len=int(pri_M_list[0][1])-int(pri_M_list[0][0])
								SA_len=int(SA_M_list[0][1])-int(SA_M_list[0][0])
								MHLEN=pri_len+SA_len-int(read_size)
								bp1=read.reference_start+pri_len
								bp2=int(SA_pos)+SA_len-1
								terminal1="3";terminal2="3"
								if read.reference_name!=SA_chr:
									rearr="TRA"
								else:
									rearr="INV"
								tINFO.append(read.reference_name+':'+str(bp1)+'_'+SA_chr+':'+str(bp2)+'_'+str(MHLEN)+'_'+rearr+'_'+terminal1+'-'+terminal2)
							elif int(read_size) in pri_M_list[0] and int(read_size) in SA_M_list[0]:
								pri_len=int(pri_M_list[0][1])-int(pri_M_list[0][0])
								SA_len=int(SA_M_list[0][1])-int(SA_M_list[0][0])
								MHLEN=pri_len+SA_len-int(read_size)
								bp1=read.reference_start+1
								bp2=int(SA_pos)
								terminal1="5";terminal2="5"
								if read.reference_name!=SA_chr:
									rearr="TRA"
								else:
									rearr="INV"
								tINFO.append(read.reference_name+':'+str(bp1)+'_'+SA_chr+':'+str(bp2)+'_'+str(MHLEN)+'_'+rearr+'_'+terminal1+'-'+terminal2)
							else:
								'blank'
				else:
					'blank'	
		else:
			'blank'		

#		if read.mate_is_unmapped=='True':
#			'blank'
#		else:
#			m_chr=read.next_reference_name
#			m_pos=read.next_reference_start
#			if m_chr==d and m_pos>=int(e) and m_pos<=int(f):
#				Pair_N=Pair_N+1
#			else:
#				'blank'

	for read in bam_file.fetch(d,e,f):
		if read.has_tag('SA'):
			cigar_info=read.cigarstring
			SA_list=str(read.get_tag('SA')).split(';')[:-1]
			for SA_indi in SA_list:
				SA_chr=SA_indi.split(',')[0]
				SA_pos=SA_indi.split(',')[1]
				SA_strand=SA_indi.split(',')[2]
				SA_cigar=SA_indi.split(',')[3]
				SA_MQ=SA_indi.split(',')[4]
			
				if SA_chr==a and int(SA_pos)>=int(b) and int(SA_pos)<=int(c):  #check
					pri_M_list=split_cigar(cigar_info)		
					SA_M_list=split_cigar(SA_cigar)
					if len(pri_M_list)!=1 or len(SA_M_list)!=1:
						'blank'
					else:	
						SA_N=SA_N+1
						if (hex(int(read.flag))[-2] in reverse_list and SA_strand=='-') or (hex(int(read.flag))[-2] not in reverse_list and SA_strand=='+'):  # same strand direction between PA and SA
							if pri_M_list[0][1] > SA_M_list[0][1]:
								pri_len=int(pri_M_list[0][1])-int(pri_M_list[0][0])
								SA_len=int(SA_M_list[0][1])-int(SA_M_list[0][0])
								total_len= int(pri_M_list[0][1])-int(SA_M_list[0][0])
								MHLEN=pri_len+SA_len-total_len
								bp1=read.reference_start+1
								bp2=int(SA_pos)+SA_len-1
								terminal1="5";terminal2="3"
								if read.reference_name!=SA_chr:
									rearr="TRA"
								else:
									if bp1<bp2:
										rearr="DUP"
									elif bp1>bp2:
										rearr="DEL"
								rvsinfo=read.reference_name+':'+str(bp1)+'_'+SA_chr+':'+str(bp2)+'_'+str(MHLEN)+'_'+rearr+'_'+terminal1+'-'+terminal2
								if rvsinfo not in tINFO:
									tINFO.append(SA_chr+':'+str(bp2)+'_'+read.reference_name+':'+str(bp1)+'_'+str(MHLEN)+'_'+rearr+'_'+terminal2+'-'+terminal1)
							elif pri_M_list[0][1] < SA_M_list[0][1]:
								pri_len=int(pri_M_list[0][1])-int(pri_M_list[0][0])
								SA_len=int(SA_M_list[0][1])-int(SA_M_list[0][0])
								total_len=int(SA_M_list[0][1])-int(pri_M_list[0][0])
								MHLEN=pri_len+SA_len-total_len
								bp1=read.reference_start+pri_len
								bp2=int(SA_pos)
								terminal1="3"; terminal2="5"
								if read.reference_name!=SA_chr:
									rearr="TRA"
								else:
									if bp1<bp2:
										rearr="DEL"
									elif bp1>bp2:
										rearr="DUP"
								rvsinfo=read.reference_name+':'+str(bp1)+'_'+SA_chr+':'+str(bp2)+'_'+str(MHLEN)+'_'+rearr+'_'+terminal1+'-'+terminal2
								if rvsinfo not in tINFO:
									tINFO.append(SA_chr+':'+str(bp2)+'_'+read.reference_name+':'+str(bp1)+'_'+str(MHLEN)+'_'+rearr+'_'+terminal2+'-'+terminal1)
							else:
								'blank'
						else: # opposite strand direction between PA and SA
							rv_SA=[int(read_size)-int(SA_M_list[0][1]),int(read_size)-int(SA_M_list[0][0])]
							if pri_M_list[0][1] > rv_SA[1]:
								pri_len=int(pri_M_list[0][1])-int(pri_M_list[0][0])
								SA_len=int(rv_SA[1])-int(rv_SA[0])
								total_len= int(pri_M_list[0][1])-int(rv_SA[0])
								MHLEN=pri_len+SA_len-total_len
								bp1=read.reference_start+1
								bp2=int(SA_pos)
								terminal1="5";terminal2="5"
								if read.reference_name!=SA_chr:
									rearr="TRA"
								else:
									rearr="INV"
								rvsinfo=read.reference_name+':'+str(bp1)+'_'+SA_chr+':'+str(bp2)+'_'+str(MHLEN)+'_'+rearr+'_'+terminal1+'-'+terminal2
								if rvsinfo not in tINFO:
									tINFO.append(SA_chr+':'+str(bp2)+'_'+read.reference_name+':'+str(bp1)+'_'+str(MHLEN)+'_'+rearr+'_'+terminal2+'-'+terminal1)
							elif pri_M_list[0][1] < rv_SA[1]:
								pri_len=int(pri_M_list[0][1])-int(pri_M_list[0][0])
								SA_len=int(rv_SA[1])-int(rv_SA[0])
								total_len= int(rv_SA[1])-int(pri_M_list[0][0])
								MHLEN=pri_len+SA_len-total_len
								bp1=read.reference_start+pri_len
								bp2=int(SA_pos)+SA_len-1
								terminal1="3"; terminal2="3"
								if read.reference_name!=SA_chr:
									rearr="TRA"
								else:
									rearr="INV"
								rvsinfo=read.reference_name+':'+str(bp1)+'_'+SA_chr+':'+str(bp2)+'_'+str(MHLEN)+'_'+rearr+'_'+terminal1+'-'+terminal2
								if rvsinfo not in tINFO:
									tINFO.append(SA_chr+':'+str(bp2)+'_'+read.reference_name+':'+str(bp1)+'_'+str(MHLEN)+'_'+rearr+'_'+terminal2+'-'+terminal1)
							else:
								'blank'
				else:
					'blank'
		else:
			'blank'


	tINFOc=collections.Counter(tINFO)
	tINFOc_list=[]
	for key in tINFOc.keys():
		tINFOc_list.append(key+'('+str(tINFOc[key])+')')
	if len(tINFOc_list)>0:
		out_file.write('\t'+','.join(tINFOc_list))
	else:
		out_file.write('\tNA')

	
	for read in nbam_file.fetch(a,b,c):
		if read.has_tag('SA'):
			cigar_info=read.cigarstring
			SA_list=str(read.get_tag('SA')).split(';')[:-1]
			for SA_indi in SA_list:
				SA_chr=SA_indi.split(',')[0]
				SA_pos=SA_indi.split(',')[1]
				SA_strand=SA_indi.split(',')[2]
				SA_cigar=SA_indi.split(',')[3]
				SA_MQ=SA_indi.split(',')[4]
				if SA_chr==d and int(SA_pos)>=int(e) and int(SA_pos)<=int(f): #check
					pri_M_list=split_cigar(cigar_info)		
					SA_M_list=split_cigar(SA_cigar)
					if len(pri_M_list)!=1 or len(SA_M_list)!=1:
						'blank'
					else:
						SA_N=SA_N+1
						if (hex(int(read.flag))[-2] in reverse_list and SA_strand=='-') or (hex(int(read.flag))[-2] not in reverse_list and SA_strand=='+'):
							if 0 in pri_M_list[0] and int(read_size) in SA_M_list[0]:
								pri_len=int(pri_M_list[0][1])-int(pri_M_list[0][0])
								SA_len=int(SA_M_list[0][1])-int(SA_M_list[0][0])
								MHLEN=pri_len+SA_len-int(read_size)
								bp1=read.reference_start+pri_len
								bp2=int(SA_pos)
								terminal1="3"; terminal2="5"
								if read.reference_name!=SA_chr:
									rearr="TRA"
								else:
									if bp1<bp2:
										rearr="DEL"
									elif bp1>bp2:
										rearr="DUP"
								nINFO.append(read.reference_name+':'+str(bp1)+'_'+SA_chr+':'+str(bp2)+'_'+str(MHLEN)+'_'+rearr+'_'+terminal1+'-'+terminal2)
							elif  int(read_size) in pri_M_list[0] and 0 in SA_M_list[0]:
								pri_len=int(pri_M_list[0][1])-int(pri_M_list[0][0])
								SA_len=int(SA_M_list[0][1])-int(SA_M_list[0][0])
								MHLEN=pri_len+SA_len-int(read_size)
								bp1=read.reference_start+1
								bp2=int(SA_pos)+SA_len-1
								terminal1="5";terminal2="3"
								if read.reference_name!=SA_chr:
									rearr="TRA"
								else:
									if bp1<bp2:
										rearr="DUP"
									elif bp1>bp2:
										rearr="DEL"
			
								nINFO.append(read.reference_name+':'+str(bp1)+'_'+SA_chr+':'+str(bp2)+'_'+str(MHLEN)+'_'+rearr+'_'+terminal1+'-'+terminal2)
							#	nbam_file.count_coverage(reference=a, start=, end=, quality_threshold=15)
							else:
								'blank'
						else:
							if 0 in pri_M_list[0] and 0 in SA_M_list[0]:
								pri_len=int(pri_M_list[0][1])-int(pri_M_list[0][0])
								SA_len=int(SA_M_list[0][1])-int(SA_M_list[0][0])
								MHLEN=pri_len+SA_len-int(read_size)
								bp1=read.reference_start+pri_len
								bp2=int(SA_pos)+SA_len-1
								terminal1="3";terminal2="3"
								if read.reference_name!=SA_chr:
									rearr="TRA"
								else:
									rearr="INV"
								nINFO.append(read.reference_name+':'+str(bp1)+'_'+SA_chr+':'+str(bp2)+'_'+str(MHLEN)+'_'+rearr+'_'+terminal1+'-'+terminal2)
							elif int(read_size) in pri_M_list[0] and int(read_size) in SA_M_list[0]:
								pri_len=int(pri_M_list[0][1])-int(pri_M_list[0][0])
								SA_len=int(SA_M_list[0][1])-int(SA_M_list[0][0])
								MHLEN=pri_len+SA_len-int(read_size)
								bp1=read.reference_start+1
								bp2=int(SA_pos)
								terminal1="5";terminal2="5"
								if read.reference_name!=SA_chr:
									rearr="TRA"
								else:
									rearr="INV"
								nINFO.append(read.reference_name+':'+str(bp1)+'_'+SA_chr+':'+str(bp2)+'_'+str(MHLEN)+'_'+rearr+'_'+terminal1+'-'+terminal2)
							else:
								'blank'
				else:
					'blank'	
		else:
			'blank'		

#		if read.mate_is_unmapped=='True':
#			'blank'
#		else:
#			m_chr=read.next_reference_name
#			m_pos=read.next_reference_start
#			if m_chr==d and m_pos>=int(e) and m_pos<=int(f):
#				Pair_N=Pair_N+1
#			else:
#				'blank'

	for read in nbam_file.fetch(d,e,f):
		if read.has_tag('SA'):
			cigar_info=read.cigarstring
			SA_list=str(read.get_tag('SA')).split(';')[:-1]
			for SA_indi in SA_list:
				SA_chr=SA_indi.split(',')[0]
				SA_pos=SA_indi.split(',')[1]
				SA_strand=SA_indi.split(',')[2]
				SA_cigar=SA_indi.split(',')[3]
				SA_MQ=SA_indi.split(',')[4]
			
				if SA_chr==a and int(SA_pos)>=int(b) and int(SA_pos)<=int(c):  #check
					pri_M_list=split_cigar(cigar_info)		
					SA_M_list=split_cigar(SA_cigar)
					if len(pri_M_list)!=1 or len(SA_M_list)!=1:
						'blank'
					else:	
						SA_N=SA_N+1
						if (hex(int(read.flag))[-2] in reverse_list and SA_strand=='-') or (hex(int(read.flag))[-2] not in reverse_list and SA_strand=='+'):  # same strand direction between PA and SA
							if pri_M_list[0][1] > SA_M_list[0][1]:
								pri_len=int(pri_M_list[0][1])-int(pri_M_list[0][0])
								SA_len=int(SA_M_list[0][1])-int(SA_M_list[0][0])
								total_len= int(pri_M_list[0][1])-int(SA_M_list[0][0])
								MHLEN=pri_len+SA_len-total_len
								bp1=read.reference_start+1
								bp2=int(SA_pos)+SA_len-1
								terminal1="5";terminal2="3"
								if read.reference_name!=SA_chr:
									rearr="TRA"
								else:
									if bp1<bp2:
										rearr="DUP"
									elif bp1>bp2:
										rearr="DEL"
								rvsinfo=read.reference_name+':'+str(bp1)+'_'+SA_chr+':'+str(bp2)+'_'+str(MHLEN)+'_'+rearr+'_'+terminal1+'-'+terminal2
								if rvsinfo not in nINFO:
									nINFO.append(SA_chr+':'+str(bp2)+'_'+read.reference_name+':'+str(bp1)+'_'+str(MHLEN)+'_'+rearr+'_'+terminal2+'-'+terminal1)
							elif pri_M_list[0][1] < SA_M_list[0][1]:
								pri_len=int(pri_M_list[0][1])-int(pri_M_list[0][0])
								SA_len=int(SA_M_list[0][1])-int(SA_M_list[0][0])
								total_len=int(SA_M_list[0][1])-int(pri_M_list[0][0])
								MHLEN=pri_len+SA_len-total_len
								bp1=read.reference_start+pri_len
								bp2=int(SA_pos)
								terminal1="3"; terminal2="5"
								if read.reference_name!=SA_chr:
									rearr="TRA"
								else:
									if bp1<bp2:
										rearr="DEL"
									elif bp1>bp2:
										rearr="DUP"
								rvsinfo=read.reference_name+':'+str(bp1)+'_'+SA_chr+':'+str(bp2)+'_'+str(MHLEN)+'_'+rearr+'_'+terminal1+'-'+terminal2
								if rvsinfo not in nINFO:
									nINFO.append(SA_chr+':'+str(bp2)+'_'+read.reference_name+':'+str(bp1)+'_'+str(MHLEN)+'_'+rearr+'_'+terminal2+'-'+terminal1)
							else:
								'blank'
						else: # opposite strand direction between PA and SA
							rv_SA=[int(read_size)-int(SA_M_list[0][1]),int(read_size)-int(SA_M_list[0][0])]
							if pri_M_list[0][1] > rv_SA[1]:
								pri_len=int(pri_M_list[0][1])-int(pri_M_list[0][0])
								SA_len=int(rv_SA[1])-int(rv_SA[0])
								total_len= int(pri_M_list[0][1])-int(rv_SA[0])
								MHLEN=pri_len+SA_len-total_len
								bp1=read.reference_start+1
								bp2=int(SA_pos)
								terminal1="5";terminal2="5"
								if read.reference_name!=SA_chr:
									rearr="TRA"
								else:
									rearr="INV"
								rvsinfo=read.reference_name+':'+str(bp1)+'_'+SA_chr+':'+str(bp2)+'_'+str(MHLEN)+'_'+rearr+'_'+terminal1+'-'+terminal2
								if rvsinfo not in nINFO:
									nINFO.append(SA_chr+':'+str(bp2)+'_'+read.reference_name+':'+str(bp1)+'_'+str(MHLEN)+'_'+rearr+'_'+terminal2+'-'+terminal1)
							elif pri_M_list[0][1] < rv_SA[1]:
								pri_len=int(pri_M_list[0][1])-int(pri_M_list[0][0])
								SA_len=int(rv_SA[1])-int(rv_SA[0])
								total_len= int(rv_SA[1])-int(pri_M_list[0][0])
								MHLEN=pri_len+SA_len-total_len
								bp1=read.reference_start+pri_len
								bp2=int(SA_pos)+SA_len-1
								terminal1="3"; terminal2="3"
								if read.reference_name!=SA_chr:
									rearr="TRA"
								else:
									rearr="INV"
								rvsinfo=read.reference_name+':'+str(bp1)+'_'+SA_chr+':'+str(bp2)+'_'+str(MHLEN)+'_'+rearr+'_'+terminal1+'-'+terminal2
								if rvsinfo not in nINFO:
									nINFO.append(SA_chr+':'+str(bp2)+'_'+read.reference_name+':'+str(bp1)+'_'+str(MHLEN)+'_'+rearr+'_'+terminal2+'-'+terminal1)
							else:
								'blank'
				else:
					'blank'
		else:
			'blank'


	nINFOc=collections.Counter(nINFO)
	nINFOc_list=[]
	for key in nINFOc.keys():
		nINFOc_list.append(key+'('+str(nINFOc[key])+')')
	if len(nINFOc_list)>0:
		out_file.write('\t'+','.join(nINFOc_list)+'\n')
	else:
		out_file.write('\tNA\n')
