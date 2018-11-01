# This script was made 2018-05-24 at first
# Breakpoints should be accurate!
# 2018-05-28 make functions; add split read count
# 2018-05-29 major revision; Only the properly paired pairs with insert size less than cutoff will be counted as reference allele.
# 2018-05-30 pass read without 'MC' tag in situation of mate spanning breakpoint; correct minor errors; different VAF calculation when pairread == 0 for BPs with unavailable pair reads; apply strict criteria for asr1 and asr2.
# 2018-05-31 Error correction: if r1==0 -> if a1==0; error correction: a1 or a2 read direction
# 2018-06-04 (1) Count only primary alignment and use as1+as2 as as1 and as2. (d/t Suppl or Secondary alignments may have not gone through Markduplicates in Picard), (2) filter out duplication-marked reads (is_duplicate) (4) pair ref read count upgrade 
# 2018-06-04_2 (1) Count fragments spanning breakpoint rather than reads. total paired read(tpr) is counted at BP1 (tpr = a1) (2) Only the fragments which are not cunted in BP1 are counted at BP2 -> asp2. total split read(tsr) = as1+asp2 (3) beside the SA tag matching, split reads with exact clipping boundary are counted as splitread
#2018-06-05 minor error correction
#2018-07-16 filter out unmapped read by is_unmapped == True
#2018-07-16: if read has false SA tag: 'blank' -> it can be reassed by split point.; make tsr_sD for short deletion which is the supporting pairread count is not available; user asr1 and asr2 for shortdeletion; setting shorDel cutoff
#2018-08-29: Resolve a problem calculating some reads twice in both pair read and split read.
#Version2
#2018-08-30: In the previous version, split read count need very accurate breakpoint information. To increase the accuracy in inaccurate BP, I changed the result form from reporting paired read and split read to reporting all supporint read and split read.; correct error when calculating short duplication
#2018-08-31: Add rows for column number assignment.
#2018-09-01: minor error correction
#2018-09-02: prevent error from fetching negative values; prevent error from adf + ref == 0


import sys,pysam
sv_file=open(sys.argv[1]) #CHR1 POS1 CHR2 POS2 MH Terminal SVtype
print(sys.argv[1])
bam_file=pysam.AlignmentFile(sys.argv[2],'rb') #Cancer bam
out_file=open(sys.argv[1]+'.SVvaf','w')
fors=500; bacs=5  # search range for pairread counting # You can adjust these values.
iscut=700 # insert size cut for call reference pair # You can adjust this value.
shortDco=500
sv_line=sv_file.readline().strip()
#Assign the column number starting from 0
c_chr1=0
c_pos1=1
c_chr2=2
c_pos2=3
c_ter=5   # e.g. 3to5, 5to3, 3to3, etc.
c_type=6  # e.g. DEL, TRA, DUP, INV

def make_cigartuple(cigarstring):
	cg_num=len(cigarstring)
	lt=''
	cigar_tuple_list=[]
	for n in range(0,cg_num):
		try: lt = lt+str(int(cigarstring[n]))
		except:
			if cigarstring[n]=='M': cigar_tuple_list.append((0,int(lt)))
			elif cigarstring[n]=='I': cigar_tuple_list.append((1,int(lt)))
			elif cigarstring[n]=='D': cigar_tuple_list.append((2,int(lt)))
			elif cigarstring[n]=='N': cigar_tuple_list.append((3,int(lt)))
			elif cigarstring[n]=='S': cigar_tuple_list.append((4,int(lt)))
			elif cigarstring[n]=='H': cigar_tuple_list.append((5,int(lt)))
			elif cigarstring[n]=='P': cigar_tuple_list.append((6,int(lt)))
			elif cigarstring[n]=='=': cigar_tuple_list.append((7,int(lt)))
			elif cigarstring[n]=='X': cigar_tuple_list.append((8,int(lt)))
			elif cigarstring[n]=='B': cigar_tuple_list.append((9,int(lt)))
			lt=''
	return cigar_tuple_list

def estimate_mappedlength(cigarstring):  # this function is same with read.reference_length made for MC tag or SA tag
	cg_num=len(cigarstring)
	lt=''
	current_m=0;current_d=0
	for n in range(0,cg_num):
		try: lt = lt+str(int(cigarstring[n]))
		except:
			if cigarstring[n]=='M': current_m = current_m + int(lt)
			elif cigarstring[n]=='D' and current_m > 0:
				current_d = current_d +int(lt)
			else:'blank'
			lt=''
	return current_m+current_d


def find_discordant_read(chr1, pos1, ter1, chr2, pos2, ter2):
	global a1,as1,asa1,r1,rj1, r2, rj2
	pos1=int(pos1); pos2=int(pos2); ter1=int(ter1); ter2=int(ter2)
	if ter1==3: pos1_start=pos1-fors; pos1_end=pos1+bacs
	elif ter1==5: pos1_start=pos1-bacs; pos1_end=pos1+fors
	if ter2==3: pos2_start=pos2-fors; pos2_end=pos2+bacs
	elif ter2==5: pos2_start=pos2-bacs; pos2_end=pos2+fors
	pos1_start=max(pos1_start, 1); pos2_start=max(pos2_start, 1)
	if chr1 == chr2 and ter1==5 and ter2 == 3:   # exceptional short duplication
		pos1_end=min(pos1_end, pos1+(pos2-pos1)/2)
		pos2_start=max(pos2_start, pos2-(pos2-pos1)/2)
	a1=0; as1=0; asa1=0;r1=0;rj1=0; r2=0; rj2=0
	for read in bam_file.fetch(chr1, pos1_start-1, pos1_end):
		true_pair='off';true_split='off';true_ref='off';true_SA='off'
		if read.is_unmapped == True or read.is_paired == False or read.mate_is_unmapped == True or read.is_secondary == True or read.is_supplementary == True or read.is_duplicate == True: continue
		if read.has_tag('SA')== True:
			SA_list=str(read.get_tag('SA')).split(';')[:-1]
			if read.is_reverse == True: PA_strand='+'
			elif read.is_reverse == False: PA_strand='-'
			SA_BP_candi=[]
			for SA_indi in SA_list:
				SA_chr=SA_indi.split(',')[0]
				SA_pos=int(SA_indi.split(',')[1])
				SA_strand=SA_indi.split(',')[2]
				SA_cigar=SA_indi.split(',')[3]
				SA_cigartuples=make_cigartuple(SA_cigar)
				SA_MQ=SA_indi.split(',')[4]
				current_m=0; current_d=0
				for cigar in SA_cigartuples:
					if cigar[0]==0:
						current_m=current_m+cigar[1]
					elif cigar[0]==2 and current_m > 0:
						current_d=current_d+cigar[1]
					elif (cigar[0]==4 or cigar[0]==5) and current_m > 0:
						break
				if SA_chr == chr2 and ( abs(SA_pos-pos2)<=1 or abs(SA_pos+current_m+current_d-1-pos2) <=1 ):
					asa1 += 1
		if ter1==3:
			if read.is_reverse == False and read.next_reference_name == chr2 and read.next_reference_start +1 >= pos2_start and read.next_reference_start +1 < pos2_end:
				if ter2==3 and read.mate_is_reverse == False: true_pair='on'
				elif ter2==5 and read.mate_is_reverse == True: true_pair='on'
			if pos1 - (read.reference_start +1) +1 == read.reference_length:
				if read.cigartuples[-1][0]==4 or read.cigartuples[-1][0]==5: 
					true_split='on'
						
			if true_split=='on': as1 +=1
			if true_pair=='on' or true_split=='on': a1 += 1; continue

			if read.reference_start + 1 <= pos1 and read.reference_start + 1 + read.reference_length - 1 > pos1: rj1 +=1
			if read.is_reverse == False and read.next_reference_name == chr1 and read.reference_start +1 < pos1:
				if read.next_reference_start +1 > pos1 and read.template_length < iscut : r1 = r1+1; continue
				elif read.next_reference_start +1 <= pos1:
					if read.has_tag('MC') == False: continue
					next_cigar = str(read.get_tag('MC'))
					next_maplen = estimate_mappedlength(next_cigar)
					if read.next_reference_start +1 + next_maplen -1 > pos1: r1 = r1 +1; continue
		elif ter1==5:
			if read.is_reverse == True and read.next_reference_name == chr2 and read.next_reference_start +1 >= pos2_start and read.next_reference_start +1 < pos2_end:
				if ter2==3 and read.mate_is_reverse == False: true_pair='on'
				elif ter2==5 and read.mate_is_reverse == True: true_pair='on'
			if read.reference_start + 1 == pos1:
				if read.cigartuples[0][0] == 4 or read.cigartuples[0][0]==5:
					true_split='on'
			if true_split=='on': as1 +=1
			if true_pair=='on' or true_split=='on': a1 += 1; continue

			if read.reference_start + 1 < pos1 and read.reference_start + 1 + read.reference_length - 1 >= pos1: rj1 +=1
			if read.is_reverse == True and read.next_reference_name == chr1 and read.reference_start +1 + int(read.infer_query_length())-1 >= pos1:
				if read.next_reference_start +1  < pos1 and read.template_length < iscut: r1 = r1+1; continue

	for read in bam_file.fetch(chr2, pos2_start-1, pos2_end):
		true_pair='off';true_split='off';true_ref='off';true_SA='off'
		if read.is_unmapped == True or read.is_paired == False or read.mate_is_unmapped == True or read.is_secondary == True or read.is_supplementary == True or read.is_duplicate == True: continue
		if read.has_tag('SA')== True:
			SA_list=str(read.get_tag('SA')).split(';')[:-1]
			if read.is_reverse == True: PA_strand='+'
			elif read.is_reverse == False: PA_strand='-'
			SA_BP_candi=[]
			for SA_indi in SA_list:
				SA_chr=SA_indi.split(',')[0]
				SA_pos=int(SA_indi.split(',')[1])
				SA_strand=SA_indi.split(',')[2]
				SA_cigar=SA_indi.split(',')[3]
				SA_cigartuples=make_cigartuple(SA_cigar)
				SA_MQ=SA_indi.split(',')[4]
				current_m=0; current_d=0
				for cigar in SA_cigartuples:
					if cigar[0]==0:
						current_m=current_m+cigar[1]
					elif cigar[0]==2 and current_m > 0:
						current_d=current_d+cigar[1]
					elif (cigar[0]==4 or cigar[0]==5) and current_m > 0:
						break
				if SA_chr == chr2 and ( abs(SA_pos-pos2)<=1 or abs(SA_pos+current_m+current_d-1-pos2) <=1 ):
					asa1 += 1
		if ter2==3:
			if read.is_reverse == False and read.next_reference_name == chr1 and read.next_reference_start +1 >= pos1_start and read.next_reference_start +1 < pos1_end:
				if ter1==3 and read.mate_is_reverse == False: true_pair='on'
				elif ter1==5 and read.mate_is_reverse == True: true_pair='on'
			if pos2 - (read.reference_start +1) +1 == read.reference_length:
				if read.cigartuples[-1][0]==4 or read.cigartuples[-1][0]==5: true_split='on'
			if true_pair == 'on': continue
			if true_split == 'on':a1 +=1; as1 +=1; continue

			if read.reference_start + 1 <= pos2 and read.reference_start + 1 + read.reference_length - 1 > pos2: rj2 +=1
			if read.is_reverse == False and read.next_reference_name == chr2 and read.reference_start +1 < pos2:
				if read.next_reference_start +1 > pos2 and read.template_length < iscut: r2 = r2+1; continue
				elif read.next_reference_start +1 <= pos2:
					if read.has_tag('MC') == False: continue
					next_cigar = str(read.get_tag('MC'))
					next_maplen = estimate_mappedlength(next_cigar)
					if read.next_reference_start +1 + next_maplen -1 > pos2: r2 = r2 +1; continue
		if ter2==5:
			if read.is_reverse == True and read.next_reference_name == chr1 and read.next_reference_start +1 >= pos1_start and read.next_reference_start +1 < pos1_end:
				if ter1==3 and read.mate_is_reverse == False: true_pair='on'
				elif ter1==5 and read.mate_is_reverse == True: true_pair='on'
			if read.reference_start + 1 == pos2:
				if read.cigartuples[0][0] == 4 or read.cigartuples[0][0]==5:true_split='on'
			if true_pair == 'on': continue
			if true_split=='on': a1 +=1; as1 +=1; continue

			if read.reference_start + 1 < pos2 and read.reference_start + 1 + read.reference_length - 1 >= pos2: rj2 +=1
			if read.is_reverse == True and read.next_reference_name == chr2 and read.reference_start +1 + read.reference_length -1 >= pos2:
				if read.next_reference_start +1 < pos2 and read.template_length < iscut: r2 = r2+1; continue
	return([a1,as1,asa1,r1,rj1, r2,rj2]) # all_supporting_reads, split_reads, split_reads_with_accurateSAtag, ref1_reads, ref1_junctional_reads,  ref2_reads, ref2_junctional_reads



while sv_line:
	if sv_line[0:5]=='#CHR1':
		out_file.write(sv_line+'\tRef1\tRef2\tAllDiscordantFragments\tSplitFragments\tSATagFragments\tVaf1\tVaf2\n')
	elif sv_line[0]=='#':
		out_file.write(sv_line+'\n')
	else:
		shortDstatus='off'
		sv_indi=sv_line.split('\t')
		chr1=sv_indi[c_chr1]; pos1=sv_indi[c_pos1]; chr2=sv_indi[c_chr2]; pos2=sv_indi[c_pos2]
		svtype=sv_indi[c_type]
		if pos2 == '.' or svtype == 'INS': 
			ref1='.';ref2='.';vaf1='.';vaf2='.';adf='.';sf='.';saf='.'
		else:
			ter1=sv_indi[c_ter].split('to')[0]; ter2=sv_indi[c_ter].split('to')[1]
			res = find_discordant_read(chr1, pos1, ter1, chr2, pos2, ter2)
			adf=res[0];sf=res[1];saf=res[2];ref1=res[3];rj1=res[4];ref2=res[5];rj2=res[6]
	
			if chr1 == chr2 and ter1 == '3' and ter2 == '5' and abs(int(pos2)-int(pos1)) < shortDco:
				adf=sf
				ref1=rj1
				ref2=rj2
			elif adf == sf:
				ref1=rj1
				ref2=rj2
			if adf+ref1 == 0:
				vaf1 = 'NA'
			else:
				vaf1=str(round((adf)*100/float(adf+ref1),2))+'%'
			if adf+ref2 == 0:
				vaf2 = 'NA'
			else:
				vaf2=str(round((adf)*100/float(adf+ref2),2))+'%'
			# asr1 and asr2 were not counted in 'else' d/t redundancy with r1, r2
		info_list=[str(ref1),str(ref2),str(adf),str(sf),str(saf),vaf1,vaf2]
		out_file.write(sv_line+'\t'+'\t'.join(info_list)+'\n')
	sv_line=sv_file.readline().strip()
