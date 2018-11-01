
# coding: utf-8

# In[1]:


import sys, os, pysam
def cigar_fc(cigar_list, repeat_abs_pos, repeat_rel_pos, repeat_remain_distance,repeat_final):
    for cigar in cigar_list:
        if repeat_abs_pos > repeat_final:
            repeat_rel_pos += repeat_remain_distance
            repeat_abs_pos += repeat_remain_distance
            repeat_remain_distance = 0            
        elif cigar[0] == 0:
            if (repeat_abs_pos + cigar[1]) < repeat_final:
                repeat_abs_pos += cigar[1]
                repeat_rel_pos += cigar[1]
                repeat_remain_distance -= cigar[1]
            else:
                repeat_rel_pos += repeat_remain_distance
                repeat_abs_pos += repeat_remain_distance
                repeat_remain_distance = 0
                break
        elif cigar[0] == 1:
            if repeat_abs_pos == repeat_final:
                break
            else:
                repeat_rel_pos += cigar[1] # no change of abs_pos and remain_distance
        elif cigar[0] == 2:
            if repeat_abs_pos == repeat_final:
                break
            else:
                if (repeat_abs_pos + cigar[1]) < repeat_final:
                    repeat_abs_pos += cigar[1] # no change of rel_pos 
                    repeat_remain_distance -= cigar[1]
                else:
                    repeat_abs_pos += repeat_remain_distance # no change of rel_pos
                    repeat_remain_distance = 0
                    break
        elif cigar[0] == 3:
            if (repeat_abs_pos + cigar[1]) < repeat_final:
                repeat_abs_pos += cigar[1]
                repeat_rel_pos += cigar[1]
                repeat_remain_distance -= cigar[1]
            else:
                repeat_rel_pos += repeat_remain_distance
                repeat_abs_pos += repeat_remain_distance
                repeat_remain_distance = 0
                break
        elif cigar[0] == 4 or cigar[0] == 5:
            repeat_rel_pos += repeat_remain_distance
            repeat_abs_pos += repeat_remain_distance
            repeat_remain_distance = 0
            break
        else:
            print 'cigar[0]>5, unexpected'
            print read
            sys.exit(1)
    #print '123'
    #print repeat_abs_pos, repeat_rel_pos, repeat_remain_distance
    temp_return = repeat_rel_pos+repeat_remain_distance
    return temp_return

def indel_bam(input_line, bam_file, ref_fasta):
    input_split = input_line.split('\t')
    indel = 999
    if len(input_split[3]) < len(input_split[4]):
        indel = 1
    elif len(input_split[3]) > len(input_split[4]):
        indel = 2
    else:
        print 'unexpected indel_length'
        print input_line
        sys.exit(1)
        
    input_chr = input_split[0]
    input_pos = long(input_split[1])
    if indel == 1:
        initial_ru = input_split[4][1:]
    elif indel == 2:
        initial_ru = input_split[3][1:]
        
    initial_rlen = len(initial_ru)
    call_ru = initial_ru
    initial_rc = 0

    for k in range(1,(initial_rlen+1)):
        min_repeat = []
        k_start = 0
        temp_ru = ''
        #print k
        if (initial_rlen % k) !=0:
            continue
        else:
            while k_start < initial_rlen:                
                temp_ru = initial_ru[k_start:k_start+k]
                if temp_ru in min_repeat:
                    'blank'
                else:
                    min_repeat.append(temp_ru)
                    if len(min_repeat) > 1:
                        break
                k_start += k
            if len(min_repeat) == 1:
                call_ru = temp_ru
                call_rlen = len(call_ru)
                initial_rc = initial_rlen / call_rlen
                #print initial_rc
                break
    #print initial_ru, call_ru, call_rlen
    ref_rc_l = 0; ref_rc_r = 0
    ref_rc = 0
    nref = 0; nvar = 0; nother = 0; ndup = 0

    
    temp_pos = input_pos
    while 1:
        if ref_fasta.fetch(input_chr,temp_pos-call_rlen,temp_pos) == call_ru:
            ref_rc_l += 1
            temp_pos = temp_pos - call_rlen
        else:
            break
            
    temp_pos = input_pos
    while 1:    
        if ref_fasta.fetch(input_chr,temp_pos,temp_pos+call_rlen) == call_ru:
            ref_rc_r += 1
            temp_pos = temp_pos + call_rlen
        else:
            break
    #print ref_rc_l, ref_rc_r    
    ref_rc = ref_rc_l + ref_rc_r
    repeat_start = input_pos - ref_rc_l*call_rlen
    repeat_end = input_pos + ref_rc_r*call_rlen
    #print call_ru, call_rlen, ref_rc, repeat_start, repeat_end
    #print 'repetitive_reference_sequence = ' + ref_fasta.fetch(input_chr,repeat_start, repeat_end)
    #temp_num = 0
    
    var_seq =[]
    temp_seq2 = []
    
    fetch_num = 0
    if indel == 2:
        fetch_num = initial_rlen
    else:
        'blank'
        
    if indel == 1:
        for read in bam_file.fetch(input_chr,input_pos-1,input_pos+1):
            target = ''
            temp_seq = ''
            temp_seq1 = []
            target_length = 0

            if read.cigartuples == None:
                continue
            else:
                #print read
                #print read.reference_start, read.reference_end
                #print read.query_alignment_start, read.query_alignment_end

                for nn in range(0,initial_rc+1):
                    if ((read.reference_start - read.query_alignment_start) <= repeat_start - (initial_rc-nn) * call_rlen) and ((read.reference_end + 151 - read.query_alignment_end) >= repeat_end + nn*call_rlen):
                        target_length = 1
                        break

                abs_pos = read.reference_start # include clip
                rel_pos = read.query_alignment_start # consider left softclip, hardclip (ex> cigar: 10s141M => 10)
                remain_distance = input_pos - abs_pos

                cigar_list = read.cigartuples

                ncigar = 0

                for cigar in cigar_list:
                    ncigar += 1
                    if cigar[0] == 0:
                        if (abs_pos + cigar[1]) <= input_pos:
                            abs_pos += cigar[1]
                            rel_pos += cigar[1]
                            remain_distance -= cigar[1]
                            if ncigar == len(cigar_list):
                                target = 'no_var'
                                break
                        else:
                            rel_pos += remain_distance
                            abs_pos += remain_distance
                            remain_distance = 0
                            target = 'no_var'
                            break
                    elif cigar[0] == 1:
                        if abs_pos == input_pos:
                            if read.query_sequence[rel_pos:(rel_pos + cigar[1])] == initial_ru:
                                target = 'var'
                                break
                            else:
                                target = 'no_var'
                                break
                        else:
                            rel_pos += cigar[1] # no change of abs_pos and remain_distance
                    elif cigar[0] == 2:
                        if abs_pos == input_pos:
                            target = 'no_var'
                            break
                        else:
                            if (abs_pos + cigar[1]) <= input_pos:
                                abs_pos += cigar[1] # no change of rel_pos 
                                remain_distance -= cigar[1]
                            else:
                                abs_pos += remain_distance
                                rel_pos += remain_distance
                                remain_distance = 0
                                target = 'no_var'
                                break
                    elif cigar[0] == 3:
                        if (abs_pos + cigar[1]) <= input_pos:
                            abs_pos += cigar[1]
                            rel_pos += cigar[1]
                            remain_distance -= cigar[1]
                            if ncigar == len(cigar_list):
                                target = 'no_var'
                                break
                        else:
                            rel_pos += remain_distance
                            abs_pos += remain_distance
                            remain_distance = 0
                            target = 'no_var'
                            break
                    elif cigar[0] == 4 or cigar[0] == 5:
                        rel_pos += remain_distance
                        abs_pos += remain_distance
                        remain_distance = 0
                        target = 'no_var'
                        break
                    else:
                        print 'cigar[0]>5, unexpected'
                        print read
                        break

                #if read.reference_start == 66711410:
                    #print read
                    #print input_pos, abs_pos, rel_pos, remain_distance, target, read.query_sequence[rel_pos:(rel_pos + cigar[1])]

                repeat_abs_pos1 = read.reference_start # include clip
                repeat_abs_pos2 = read.reference_start # include clip
                repeat_rel_pos1 = read.query_alignment_start # consider left softclip, hardclip (ex> cigar: 10s141M => 10)
                repeat_rel_pos2 = read.query_alignment_start # consider left softclip, hardclip (ex> cigar: 10s141M => 10)
                repeat_remain_distance1 = repeat_start - repeat_abs_pos1
                repeat_remain_distance2 = repeat_end - repeat_abs_pos2
                #print read
                #print repeat_abs_pos,repeat_rel_pos,repeat_remain_distance
                repeat_rel_pos = 999

                if ref_rc_l == 0:
                    repeat_rel_pos_temp = rel_pos
                    repeat_rel_pos = rel_pos                
                else:
                    repeat_rel_pos_temp = cigar_fc(cigar_list, repeat_abs_pos1, repeat_rel_pos1, repeat_remain_distance1, repeat_start)
                    if repeat_rel_pos_temp < 0:
                        repeat_rel_pos = 0
                    else:
                        repeat_rel_pos = repeat_rel_pos_temp

                if repeat_rel_pos == 999:
                    print rel_pos
                    print 'unexpected_repeat_rel_pos'
                    print input_line
                    print read
                    sys.exit(1)                               

                if target_length == 0:
                    temporary_num = 0
                    for tt in range(1,call_rlen+1):    #consider seqeunces right after repeat sequences
                        if ref_fasta.fetch(input_chr,repeat_end,repeat_end+tt) == call_ru[0:tt]:
                            temporary_num = tt
                        else:
                            break
                    
                    temporary_num_l = 0
                    for ttt in range(1,call_rlen+1):    #consider seqeunces left before repeat sequences
                        if ref_fasta.fetch(input_chr,repeat_start-ttt,repeat_start) == call_ru[call_rlen-ttt:call_rlen]:
                            temporary_num_l = ttt
                        else:
                            break
                    #print repeat_rel_pos_temp, temporary_num_l

                    end_repeat_rel_pos_temp = cigar_fc(cigar_list, repeat_abs_pos2, repeat_rel_pos2, repeat_remain_distance2, repeat_end) # maximum of end_repeat_rel_pos = 151, end_repeat_rel_pos is incorrect when the end of read does not reach repeat_end
                    if end_repeat_rel_pos_temp > 151:
                        end_repeat_rel_pos = 151
                    else:
                        end_repeat_rel_pos = end_repeat_rel_pos_temp  

### need to modify temporary_num_l consider..
                    if (end_repeat_rel_pos - repeat_rel_pos >= temporary_num+1 + ref_rc*call_rlen): #call_rlen <- initial_rlen d/t AGAG insertion & read ends before last AG 
                        if repeat_rel_pos_temp >=0:
                            target_length = 2                    
                        elif end_repeat_rel_pos <=151:
                            target_length = 3
                            #print 'target_length = 3'
                            #print repeat_start, repeat_end
                            #print input_line
                            #print read                            
                    elif repeat_end == input_pos and (end_repeat_rel_pos - repeat_rel_pos + initial_rlen >= temporary_num+1 + ref_rc*call_rlen):
                        target_length = 3                                                
                    elif (end_repeat_rel_pos - repeat_rel_pos >= temporary_num_l+1 + ref_rc*call_rlen):
                        target_length = 3
                    elif repeat_rel_pos > temporary_num_l and end_repeat_rel_pos < (151-temporary_num):
                        target_length = 2
                        #print 'consider target_length=2'
                        #print repeat_start,repeat_end
                        #print input_line
                        #print read
                    
                    
                    


                else:
                    repeat_abs_pos2 = 0
                    repeat_rel_pos2 = 0
                    end_repeat_rel_pos = 0


                #print read
                #print input_pos,abs_pos,rel_pos, repeat_abs_pos1,repeat_rel_pos,repeat_abs_pos2,end_repeat_rel_pos

                if target_length == 0:
                    nother += 1
                    #print read
                    if target == 'var':
                        print 'misclassified variant insertion in input_bam file'
                        print repeat_rel_pos, end_repeat_rel_pos,repeat_start,repeat_end
                        print input_line
                        print read
                        print ''
                else:
                    if target == 'var':
                        nvar += 1
                        if target_length == 1 or target_length == 2:
                            temp_seq = read.query_sequence[repeat_rel_pos:(repeat_rel_pos + initial_rlen + ref_rc*call_rlen)]
                        elif target_length == 3:
                            temp_seq = read.query_sequence[(end_repeat_rel_pos - initial_rlen - ref_rc*call_rlen):end_repeat_rel_pos]
                        else:
                            print 'unexpected result in target == var'
                            print input_line
                            sys.exit(1)               

                        if temp_seq in var_seq:
                            continue
                        else:
                            var_seq.append(temp_seq)

                    elif target == 'no_var':
                        nref += 1
                        if target_length == 1 or target_length == 2:
                            for ij in range(0,initial_rc+1):
                                temp_seq1.append(read.query_sequence[(repeat_rel_pos - (initial_rc-ij)*call_rlen):(repeat_rel_pos + ref_rc*call_rlen + ij*call_rlen)])
                            temp_seq2.append(temp_seq1)
                        elif target_length == 3:
                            for ij in range(0,initial_rc+1):
                                temp_seq1.append(read.query_sequence[(end_repeat_rel_pos - (initial_rc-ij)*call_rlen - ref_rc*call_rlen):(end_repeat_rel_pos + ij*call_rlen)])
                            temp_seq2.append(temp_seq1)
                        else:
                            print 'unexpected result in target == no_var'
                            print input_line
                            sys.exit(1)    
                    else:
                        print input_line
                        print 'unexpected target'
                        print read
                        sys.exit(1)  

    else:
        for read in bam_file.fetch(input_chr,input_pos-1,input_pos+1+fetch_num):
            target = ''
            temp_seq = ''
            temp_seq1 = []
            target_length = 0

            if read.cigartuples == None:
                continue
            else:
                abs_pos = read.reference_start # include clip
                rel_pos = read.query_alignment_start # consider left softclip, hardclip (ex> cigar: 10s141M => 10)
                remain_distance = input_pos - abs_pos

                cigar_list = read.cigartuples

                ncigar = 0
                for cigar in cigar_list:
                    ncigar += 1
                    if cigar[0] == 0:
                        if (abs_pos + cigar[1]) <= input_pos:
                            abs_pos += cigar[1]
                            rel_pos += cigar[1]
                            remain_distance -= cigar[1]
                            if ncigar == len(cigar_list):
                                target = 'no_var'
                                break
                        else:
                            rel_pos += remain_distance
                            abs_pos += remain_distance
                            remain_distance = 0
                            target = 'no_var'
                            break
                    elif cigar[0] == 1:                        
                        if abs_pos < input_pos:
                            rel_pos += cigar[1] # no change of abs_pos and remain_distance  
                        else:
                            rel_pos += cigar[1] # no change of abs_pos and remain_distance
                            target = 'no_var'
                            break                           
                    elif cigar[0] == 2:                                           
                        if abs_pos == input_pos:
                            if ref_fasta.fetch(input_chr,abs_pos,abs_pos+cigar[1]) == initial_ru:
                                target = 'var'
                                break                            
                            else:
                                target = 'no_var'
                                break
                        else:
                            if (abs_pos + cigar[1]) <= input_pos:
                                abs_pos += cigar[1] # no change of rel_pos 
                                remain_distance -= cigar[1]
                            else:
                                abs_pos += remain_distance 
                                rel_pos = 'Null' # there is no real rel.position of input_pos
                                remain_distance = 0
                                target = 'no_var'
                                break                                
                    elif cigar[0] == 3:
                        if (abs_pos + cigar[1]) <= input_pos:
                            abs_pos += cigar[1]
                            rel_pos += cigar[1]
                            remain_distance -= cigar[1]
                            if ncigar == len(cigar_list):
                                target = 'no_var'
                                break                            
                        else:
                            rel_pos += remain_distance
                            abs_pos += remain_distance
                            remain_distance = 0
                            target = 'no_var'
                            break
                    elif cigar[0] == 4 or cigar[0] == 5:
                        rel_pos += remain_distance
                        abs_pos += remain_distance
                        remain_distance = 0                        
                        target = 'no_var'
                        break
                    else:
                        print 'cigar[0]>5, unexpected'
                        print read
                        break

                #if read.reference_start == 66711410:
                #print read
                #print input_pos, abs_pos, rel_pos, remain_distance, target

                repeat_abs_pos1 = read.reference_start # include clip
                repeat_abs_pos2 = read.reference_start # include clip
                repeat_rel_pos1 = read.query_alignment_start # consider left softclip, hardclip (ex> cigar: 10s141M => 10)
                repeat_rel_pos2 = read.query_alignment_start # consider left softclip, hardclip (ex> cigar: 10s141M => 10)
                repeat_remain_distance1 = repeat_start - repeat_abs_pos1
                repeat_remain_distance2 = repeat_end - repeat_abs_pos2
                #print read
                #print repeat_abs_pos,repeat_rel_pos,repeat_remain_distance
                repeat_rel_pos = 999

                if ref_rc_l == 0:
                    repeat_rel_pos_temp = rel_pos
                    repeat_rel_pos = rel_pos                
                else:
                    repeat_rel_pos_temp = cigar_fc(cigar_list, repeat_abs_pos1, repeat_rel_pos1, repeat_remain_distance1, repeat_start)
                    if repeat_rel_pos_temp < 0:
                        repeat_rel_pos = 0
                    else:
                        repeat_rel_pos = repeat_rel_pos_temp
                    
                end_repeat_rel_pos_temp = cigar_fc(cigar_list, repeat_abs_pos2, repeat_rel_pos2, repeat_remain_distance2, repeat_end)
                if end_repeat_rel_pos_temp > 151:
                    end_repeat_rel_pos = 151
                else:
                    end_repeat_rel_pos = end_repeat_rel_pos_temp
                #print end_repeat_rel_pos_temp            
                #print read
                #print read.reference_start
                #if read.reference_start == 90998564:
                    #print read
                    #print repeat_rel_pos_temp, end_repeat_rel_pos_temp
                #if read.reference_start == 155304272:
                    #print read
                
                if repeat_rel_pos_temp == 'Null' or end_repeat_rel_pos_temp == 'Null':
                    target_length = 4
                    #print 'repeat_Rel_res_temp or end_repeat_rel_pos_temp == Null'
                    #print input_line
                    #print read
                elif repeat_rel_pos_temp >=1 and end_repeat_rel_pos_temp <=150:
                    target_length = 1
                elif read.reference_start == (input_pos + initial_rlen):
                    target_length = 2                    
                elif read.reference_end == input_pos:
                    target_length = 3                
                else:
                    'blank'

                #print read
                #print target
                #print input_pos, abs_pos, rel_pos, repeat_rel_pos_temp, end_repeat_rel_pos_temp, target_length

                if target_length == 0:
                    nother += 1
                    #print read
                    if target == 'var':                        
                        print 'misclassified variant insertion in input_bam file'
                        print repeat_rel_pos, end_repeat_rel_pos,repeat_start,repeat_end
                        print input_line
                        print read
                        
                else:
                    if target == 'var':
                        nvar += 1
                        if target_length == 1:
                            temp_seq = read.query_sequence[repeat_rel_pos:end_repeat_rel_pos]
                        else:
                            print 'unexpected result in target == var'
                            print input_line
                            sys.exit(1)               

                        if temp_seq in var_seq:
                            continue
                        else:
                            var_seq.append(temp_seq)

                    elif target == 'no_var':
                        nref+=1
                        if target_length == 1:
                            
                            #print repeat_rel_pos,end_repeat_rel_pos
                            #print input_line
                            #print read
                            temp_seq1.append(read.query_sequence[repeat_rel_pos:end_repeat_rel_pos])
                            temp_seq2.append(temp_seq1)
                            #show_read.append(read.reference_start)
                        elif target_length == 2:
                            #print read.query_sequence[0:read.query_alignment_start]
                            #print ref_fasta.fetch(input_chr,(input_pos-read.query_alignment_start),input_pos)
                            if read.query_sequence[0:read.query_alignment_start] ==                                         ref_fasta.fetch(input_chr,(input_pos-read.query_alignment_start),input_pos) and len(ref_fasta.fetch(input_chr,(input_pos-read.query_alignment_start),input_pos))>0:
                                #print 'Need to check target_length==2'
                                #print read.reference_start
                                #print input_line
                                #print read
                                
                                temp_seq1.append(read.query_sequence[read.query_alignment_start:end_repeat_rel_pos])
                                temp_seq2.append(temp_seq1)
                            else:
                                'blank'
                        elif target_length == 3:
                            if read.query_sequence[read.query_alignment_end:151] ==                                         ref_fasta.fetch(input_chr,end_repeat_rel_pos,end_repeat_rel_pos+151-read.query_alignment_end) and len(ref_fasta.fetch(input_chr,end_repeat_rel_pos,end_repeat_rel_pos+151-read.query_alignment_end)) > 0:
                                #print 'Need to check target_length==3'
                                #print read.reference_start
                                #print input_line
                                #print read
                                
                                temp_seq1.append(read.query_sequence[repeat_rel_pos:read.query_alignment_end])
                                temp_seq2.append(temp_seq1)
                            else:
                                'blank'
                        elif target_length == 4:
                            'blank'

                        else:
                            print 'unexpected result in target == no_var'
                            print input_line
                            sys.exit(1)    
                    else:
                        print input_line
                        print 'unexpected target'
                        print read
                        sys.exit(1)

    #print temp_num
    #print var_seq
    #print nvar,nref,nother
    return [nvar,nref,nother,var_seq,temp_seq2,initial_ru,call_ru,ref_rc]
    

    
input_fn = sys.argv[1]    
input_file = file(input_fn)
output_file = file(input_fn.replace('.vcf','_removeN1S1.vcf'),'w')
#input_file = file("S1-0Gy-1.strelka_varscan_union_indel_clonal.vcf")
#output_file = file("S1-0Gy-1.strelka_varscan_union_indel_clonal_removeN1S1.vcf",'w')


t_bam_fn = sys.argv[2]
n_bam_fn = sys.argv[3]
t_bam = pysam.AlignmentFile(t_bam_fn,'rb')
n_bam = pysam.AlignmentFile(n_bam_fn,'rb')
#t_bam = pysam.AlignmentFile('/home/users/jhyouk/06_mm10_SNUH_radiation/03_bam/S1-0Gy-1.s.md.ir.br.rg.bam','rb')
#n_bam = pysam.AlignmentFile('/home/users/jhyouk/06_mm10_SNUH_radiation/03_bam/N1-S1.s.md.ir.br.rg.bam','rb')
ref_fasta = pysam.FastaFile("/home/users/jhyouk/99_reference/mouse/mm10/GRCm38.fa")

input_line = input_file.readline().strip()
while input_line[0:1] == '#':
    output_file.write(input_line + '\t' + 'N1S1_version' + '\n')
    input_line = input_file.readline().strip()
#input_line = '17\t19189972\t.\tT\tTAG'
#input_line = '3\t81870660\t.\tT\tTTTC'
#input_line = '13\t77020483\t.\tT\tTTTTCTTTC'

prev_chr = '0'

while input_line:
    input_chr = input_line.split('\t')[0]
    if input_chr != prev_chr:
        print input_chr
        prev_chr = input_chr
    
    #if input_line.split('\t')[1] != '76924370':
        #input_line = input_file.readline().strip()
        #continue       
    tdup = 0
    ndup = 0
    info = ''
    
    if len(input_line.split('\t')[3]) != len(input_line.split('\t')[4]):
        var_list = indel_bam(input_line,t_bam,ref_fasta)
        #print var_list
        ref_list = indel_bam(input_line,n_bam,ref_fasta)
        #print ref_list
        for j in ref_list[4]:
            for m in j:
                if m in var_list[3]:
                    #print m
                    ndup+=1
                    break

        for jj in var_list[4]:
            for mm in jj:
                if mm in var_list[3]:
                    tdup+=1
                    break
        info = str(var_list[0]+tdup) + ';' + str(var_list[1]-tdup) + ';' + str(var_list[2]) +';'+ str(tdup)+';'+ str(ref_list[0]+ndup) +';'+ str(ref_list[1]-ndup)                 +';'+ str(ref_list[2]) +';'+ str(ndup)+';'+str(round(float(var_list[0]+tdup)/float(var_list[0]+var_list[1]),2))+';'+str(var_list[5])+';'+str(var_list[6])+';'+str(var_list[7])                   
        
        if (ref_list[0]+ndup) < 2:
            output_file.write(input_line +'\t' + info + '\n')
        
    else:
        print 'call SNP'
        
    input_line = input_file.readline().strip()
    
    
print 'The End'

