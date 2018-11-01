
# coding: utf-8

# In[3]:


import sys

input_fn = sys.argv[1]
input_file = file(input_fn)
output_file = file(input_fn.replace(".vcf","_clonal.vcf"),'w')
#input_file = file("S1-0Gy-1.strelka_varscan_union_indel.vcf")
#output_file = file("S1-0Gy-1.strelka_varscan_union_indel_clonal.vcf",'w')


input_line = input_file.readline().strip()

while input_line[0] == '#':
    output_file.write(input_line + '\n')
    input_line = input_file.readline().strip()

while input_line:
    input_split = input_line.split('\t')
    info = input_split[17]
    germline_var = int(info.split(';')[4])
    vaf = float(info.split(';')[8])
    
    if germline_var < 2 and vaf >= 0.3:
        output_file.write(input_line + '\n')
    else:
        'blank'
        
    input_line = input_file.readline().strip()

print 'The End'

