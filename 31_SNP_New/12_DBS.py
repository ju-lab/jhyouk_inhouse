
# coding: utf-8

# In[10]:


import sys

cluster_size = 20

input_fn = sys.argv[1]
#input_fn = 'S1-8Gy-1_union_2.readinfo.readc.rasmy_pon.filter1.mreadc.mrasmy.filter2.none_to_clonal.vcf'
input_file = file(input_fn)

output_file = file(input_fn.replace(".vcf","dbs.vcf"),'w')
output_file1 = file(input_fn.replace(".vcf",".cluster.vcf"),'w')
input_line = input_file.readline().strip()


while input_line[0:1]=='#':
    input_split = input_line.split('\t')
    output_file.write('\t'.join(input_split[0:10]) + '\n')
    output_file1.write('\t'.join(input_split[0:10]) + '\n')


    input_line = input_file.readline().strip()

prev_line = ''
prev_info = ''
dbs = {}
clu = {}

prev_chr = '0'
prev_pos = 0
while input_line:
    input_split = input_line.split('\t')
    input_chr = input_split[0]
    input_pos = long(input_split[1])
    info = '\t'.join(input_split[0:4])
    
    if input_chr == prev_chr:
        if input_pos - prev_pos <=cluster_size:            
            if prev_info in clu:
                'blank'
            else:
                clu[prev_info] = prev_line
                output_file1.write(prev_line + '\n')
                
            clu[info] = input_line
            output_file1.write(input_line + '\n')
            
            if input_pos - prev_pos == 1:                
                if prev_info in dbs:
                    'blank'
                else:
                    dbs[prev_info] = prev_line
                    output_file.write(prev_line + '\n')
                dbs[info] = input_line
                output_file.write(input_line + '\n')
                
        else:
            'blank'
    else:
        prev_chr = input_chr    
        prev_line = ''
        prev_info=''
        prev_pos = 0
        
    prev_pos = input_pos
    prev_line = input_line
    prev_info = info
    
    input_line = input_file.readline().strip()

    
print 'The End'

