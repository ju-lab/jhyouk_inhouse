import sys
input_fn = sys.argv[1]
input_file = file(input_fn)
output_file = file(input_fn.replace('.vcf','.reformat.vcf'),'w')
output_file.write(' '+'\t'+input_fn.split('.')[0] + '\n')
input_line = input_file.readline()
if input_line[0:1] == '#':
    input_line = input_file.readline()

prev_chr = 0
prev_pos = 0
prev_ref = ''
prev_alt = ''

#DBS_ref_type = ['AC','AT','CC','CG','CT','GC','TA','TC','TG','TT']
DBS_type = ['AC>CA','AC>CG','AC>CT','AC>GA','AC>GG','AC>GT','AC>TA','AC>TG','AC>TT','AT>CA','AT>CC','AT>CG','AT>GA','AT>GC','AT>TA','CC>AA','CC>AG','CC>AT','CC>GA','CC>GG','CC>GT','CC>TA','CC>TG','CC>TT'
			,'CG>AT','CG>GC','CG>GT','CG>TA','CG>TC','CG>TT','CT>AA','CT>AC','CT>AG','CT>GA','CT>GC','CT>GG','CT>TA','CT>TC','CT>TG','GC>AA','GC>AG','GC>AT','GC>CA','GC>CG','GC>TA','TA>AT','TA>CG','TA>CT','TA>GC','TA>GG','TA>GT'
			,'TC>AA','TC>AG','TC>AT','TC>CA','TC>CG','TC>CT','TC>GA','TC>GG','TC>GT','TG>AA','TG>AC','TG>AT','TG>CA','TG>CC','TG>CT','TG>GA','TG>GC','TG>GT','TT>AA','TT>AC','TT>AG','TT>CA','TT>CC','TT>CG','TT>GA','TT>GC','TT>GG']
DBS_num = []
for i in range(0,78):
    DBS_num.append(0)
    
def complementary_base(input_base):
    if input_base == 'A':
        return 'T'
    elif input_base == 'C':
        return 'G'
    elif input_base == 'G':
        return 'C'
    elif input_base =='T':
        return 'A'
    else:
        print 'unpredicted input'
        sys.exit(1)
        
while input_line:
    input_split = input_line.split('\t')
    input_chr = int(input_split[0].replace('X','20').replace('Y','21').replace('MT','22'))
    input_pos = long(input_split[1])
    input_ref = input_split[3]
    input_alt = input_split[4][0:1]
    
    if input_chr == prev_chr:
        if input_pos == prev_pos + 1:
            new_ref = prev_ref+input_ref
            new_alt = prev_alt+input_alt
            try:
                temp_index = DBS_type.index(new_ref + '>' + new_alt)
            except:
                new_ref = complementary_base(input_ref) + complementary_base(prev_ref)
                new_alt = complementary_base(input_alt) + complementary_base(prev_alt)
                temp_index = DBS_type.index(new_ref + '>' + new_alt)

            DBS_num[temp_index] += 1  
    
    prev_chr = input_chr
    prev_pos = input_pos
    prev_ref = input_ref
    prev_alt = input_alt
    
    input_line = input_file.readline()
    
for j in range(0,78):
    output_file.write(DBS_type[j] + '\t' + str(DBS_num[j])+'\n')

