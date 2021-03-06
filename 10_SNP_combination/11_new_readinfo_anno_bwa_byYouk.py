#for BWA
#updates
#180503: cigar loop update: error correction for deletion spanning the alt
#180518: cigar loop multiple error correction;add var_loca_reverse;change output format; get rlength from read
#180518: add informations: presence of clipping(soft of hard), INS, DEL in ref of var reads 
#180531: add informations: min, max location, refNM, varNM
#180723: add normal bam information by Youk

import sys,pysam
from numpy import median

def pysam_bam(in_line,bam_file):
	in_indi=in_line.split('\t')
	chr1=in_indi[0];pos1=int(in_indi[1]);ref_nt=in_indi[3];alt_nt=in_indi[4][0]
	var_mapq=[];ref_mapq=[];var_loca_lt=[];var_loca_rt=[];var_nm=[];ref_nm=[]
	ref_n=0;var_n=0
	ref_i=0;ref_d=0;ref_c=0;var_i=0;var_d=0;var_c=0
	j=0
	max_bq=0
	for read1 in bam_file.pileup(chr1,pos1-1,pos1,min_base_quality=1):
	    if long(read1.pos)==pos1-1:
			for pileupread in read1.pileups:
				if pileupread.query_position == None:
					j+=1
				elif pileupread.alignment.query_sequence[pileupread.query_position] == alt_nt:
					if int(pileupread.alignment.query_qualities[pileupread.query_position]) > max_bq:
						 max_bq = int(pileupread.alignment.query_qualities[pileupread.query_position])

	for read in bam_file.fetch(chr1,pos1-1,pos1):
	        est_dist=int(in_indi[1])-read.reference_start-1
		rlength=read.infer_query_length()
		if read.cigartuples==None:
			continue
		cigar_list=read.cigartuples
		current_m=0;current_i=0;current_d=0;target_del_stat=0
		for cigar in cigar_list:   #loop for calculate real distance
			if cigar[0]==0 and (current_m + current_d)  <=est_dist:
				current_m=current_m+cigar[1]
			elif cigar[0]==1 and (current_m + current_d) <=est_dist:
				current_i=current_i+cigar[1]
			elif cigar[0]==2 and (current_m + current_d) <=est_dist:
				if current_m+current_d+cigar[1] > est_dist:
					target_del_stat=1
					break
				else:
					current_d=current_d+cigar[1]
			elif current_m + current_d > est_dist:
				break
			else:
				'blank'
		if target_del_stat==1:
			continue

		cigar_i=0;cigar_d=0;cigar_s=0;cigar_h=0
		for cigar in cigar_list:   #loop for check presence of clipping, insertion, deletion
			if cigar[0]==1:
				cigar_i=cigar_i+1
			elif cigar[0]==2:
				cigar_d=cigar_d+1
			elif cigar[0]==4:
				cigar_s=cigar_s+1
			elif cigar[0]==5:
				cigar_h=cigar_h+1

		rel_dist=est_dist+current_i-current_d  # start with 0
		if read.query_alignment_sequence[rel_dist]==alt_nt:   #var_read
			var_n = var_n +1
			var_mapq.append(read.mapping_quality)
			if read.has_tag('NM')==True: var_nm.append(read.get_tag('NM'))
			if cigar_list[0][0]==0:
				dist=rel_dist
				var_loca_lt.append(dist)
				var_loca_rt.append(rlength-1-dist)
			elif cigar_list[0][0]==4 or cigar_list[0][0]==5:
				dist=rel_dist+cigar_list[0][1]
				var_loca_lt.append(dist)
				var_loca_rt.append(rlength-1-dist)
			else:
				'blank'

			if cigar_i > 0:
				var_i = var_i+1
			if cigar_d > 0:
				var_d = var_d+1
			if cigar_s > 0 or cigar_h > 0:
				var_c = var_c+1
		elif read.query_alignment_sequence[rel_dist]==ref_nt:  #ref_read
			ref_n = ref_n +1
			ref_mapq.append(read.mapping_quality)
			if read.has_tag('NM')==True: ref_nm.append(read.get_tag('NM'))
			if cigar_i > 0:
				ref_i = ref_i+1
			if cigar_d > 0:
				ref_d = ref_d+1
			if cigar_s > 0 or cigar_h > 0:
				ref_c = ref_c+1
		else:
			'blank'
        if len(ref_mapq)==0:
		mr_mq='NA'
	else:
		mr_mq=str(median(ref_mapq))
	if len(var_mapq)==0:
		mv_mq='NA'
	else:
		mv_mq=str(median(var_mapq))
	if len(var_loca_lt)==0:
		vlocal='NA'; vlocar='NA'
	else:
		vlocalmin=str(min(var_loca_lt))
		vlocalmed=str(median(var_loca_lt))
		vlocalmax=str(max(var_loca_lt))
		vlocarmin=str(min(var_loca_rt))
		vlocarmed=str(median(var_loca_rt))
		vlocarmax=str(max(var_loca_rt))
		vlocal=';'.join([vlocalmin, vlocalmed, vlocalmax])
		vlocar=';'.join([vlocarmin, vlocarmed, vlocarmax])
	if ref_n==0:
		clip_info = 'NA;NA;'+str(var_c)+';'+str(round(var_c*100/float(var_n),2))
        elif var_n == 0:
                clip_info = str(ref_c)+';'+str(round(ref_c*100/float(ref_n),2))+';NA;NA'
	else:
		clip_info=str(ref_c)+';'+str(round(ref_c*100/float(ref_n),2))+';'+str(var_c)+';'+str(round(var_c*100/float(var_n),2))

	if ref_n==0:
		ins_info = 'NA;NA;'+str(var_i)+';'+str(round(var_i*100/float(var_n),2))
        elif var_n==0:
                ins_info = str(ref_i)+';'+str(round(ref_i*100/float(ref_n),2))+';NA;NA'
	else:
		ins_info=str(ref_i)+';'+str(round(ref_i*100/float(ref_n),2))+';'+str(var_i)+';'+str(round(var_i*100/float(var_n),2))

	if (ref_n+j)==0:
		del_info = 'NA;NA;'+str(var_d)+';'+str(round(var_d*100/float(var_n),2))
        elif var_n==0:
                del_info = str(ref_d+j)+';'+str(round((ref_d+j)*100/float(ref_n+j),2))+';NA;NA'
	else:
		del_info=str(ref_d+j)+';'+str(round((ref_d+j)*100/float(ref_n+j),2))+';'+str(var_d)+';'+str(round(var_d*100/float(var_n),2))
	if len(ref_nm)==0:
		mr_nm='NA'
	else:
		mr_nm=str(median(ref_nm))
	if len(var_nm)==0:
		mv_nm='NA'
	else:
		mv_nm=str(median(var_nm))

	info_list=[str(ref_n)+';'+str(var_n)+';'+str(max_bq), mr_mq+';'+ mv_mq, vlocal+';'+ vlocar, clip_info, ins_info, del_info, mr_nm+';'+ mv_nm ]
        return '\t'.join(info_list)

	#out_file.write(in_line+'\t'+'\t'.join(info_list))

input_file=open(sys.argv[1])  #substitution vcf
tbam_file=pysam.AlignmentFile(sys.argv[2],'rb') #somatic_bam file
nbam_file = pysam.AlignmentFile(sys.argv[3],'rb') #germline_control bam file
output_file=open(sys.argv[1]+'.readinfo','w')

input_line=input_file.readline().strip()
while input_line:
	if input_line[0:6]=='#CHROM':
		output_file.write(input_line+'\ttumor_ref_readN;var_readN\ttumor_ref_medMQ;var_medMQ\ttumor_var_LocaLeftMin;Med;Max;var_LocaRightMin;Med;Max\ttumor_refClip;pct;varClip;pct\ttumor_refIns;pct;varIns;pct\ttumor_refDel;pct;varDel;pct\ttumor_ref_medNM;var_medNM\tgermline_ref_readN;var_readN\tgermline_ref_medMQ;var_medMQ\tgermline_var_LocaLeftMin;Med;Max;var_LocaRightMin;Med;Max\tgermline_refClip;pct;varClip;pct\tgermline_refIns;pct;varIns;pct\tgermline_refDel;pct;varDel;pct\tgermline_ref_medNM;var_medNM\n')
	elif input_line[0]=='#':
		output_file.write(input_line+'\n')
	else:
                output_file.write(input_line + '\t' + pysam_bam(input_line,tbam_file)+'\t')
                output_file.write(pysam_bam(input_line,nbam_file)+'\n')
                
	input_line=input_file.readline().strip()
