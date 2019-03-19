
# coding: utf-8

# In[5]:


# vcf union written by J.Youk 2019-02-19
# filter == 'PASS' option included
# python ~~.py <ID> <species:human or mouse> <number of files for union> <file1_path&name> <file2_path&name> <file3_path&name> ...

import sys, gzip
from operator import itemgetter

input_id = sys.argv[1]
input_species = sys.argv[2]
input_num = int(sys.argv[3])
output_file = file(input_id + '_indel_union_' + str(input_num) + '.vcf','w')

input_file = ['','','','']
info_list = ['','','','']

for i in range(4,4+input_num):
    try:
        if sys.argv[i][-3:] == '.gz':
            input_file.append(gzip.open(sys.argv[i],'rb'))
        else:
            input_file.append(open(sys.argv[i]))
    except:
        print 'Error occured'
        print 'Please confirm the number of file lists in previous command line'
        sys.exit(1)

    info_list.append({})
    
if input_species == 'human':
    chr_list=['1','2','3','4','5','6','7','8','9','10','11','12','13','14','15','16','17','18','19','20','21','22','X','Y','MT']
elif input_species == 'mouse':
    chr_list=['1','2','3','4','5','6','7','8','9','10','11','12','13','14','15','16','17','18','19','X','Y','MT']
else:
    print 'This file supports only human and mouse'
    sys.exit(1)

total_list = []

for i in range(4,4+input_num):
    input_line = ''
    input_chr = '0'
    input_line = input_file[i].readline().strip()
    while input_line:
        if input_line[0:1] =='#':
            'blank'
        else:
            input_split = input_line.split('\t')
            if input_split[6] == 'PASS':
                if input_split[0] in chr_list:
                    input_index = input_split[0] + '\t' + input_split[1] + '\t' + input_split[3] + '\t' + input_split[4]
                    input_chr = input_split[0].replace('X','23').replace('Y','24').replace('MT','25')
                    info_list[i][input_index] = ['\t'.join(input_split[0:6]),'\t'.join(input_split[6:11])]
                    total_list.append([int(input_chr),int(input_split[1]),input_index])
                else:
                    'blank'
            else:
                'blank'
        input_line = input_file[i].readline().strip()

total_list.sort(key=itemgetter(0,1))

output_file.write('#CHROM\tPOS\tID\tREF\tALT\tQUAL\tcaller')
for i in range(4,4+input_num):
    temp_i = i-3
    output_file.write('\tFILTER_%d\tINFO_%d\tFORMAT_%d\tGermline_%d\tSomatic_%d' %(temp_i,temp_i,temp_i,temp_i,temp_i))
output_file.write('\n')

empty_content='.\t.\t.\t.\t.'
prev_index = ''
out_list = ['','','','']

for [temp_chr,temp_pos,temp_index] in total_list:
    temp_caller = []
    out_list = ['','','','']
    temp_decision = 0
    if temp_index == prev_index:
        'blank'
    else:
        for i in range(4,4+input_num):
            temp_caller.append('0')
            out_list.append('')
            if temp_index in info_list[i].keys():
                out_list[i] = info_list[i][temp_index][1]
                temp_caller[i-4] = '1'
                if temp_decision == 0:
                    output_file.write(info_list[i][temp_index][0])
                    temp_decision = 1
                else:
                    'blank'
            else:
                out_list[i] = empty_content
        output_file.write('\t' + ''.join(temp_caller) + '\t' +'\t'.join(out_list[4:4+input_num]) + '\n')
        prev_index = temp_index
        
print 'The End'

