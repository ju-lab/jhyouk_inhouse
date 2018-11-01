
# coding: utf-8

# In[ ]:


import sys

input_fn = sys.argv[1]
input_file = file(input_fn)
output_file = file(input_fn.replace(".vcf","_vaf_distribution.vcf"),'w')
#input_file = file("S1-0Gy-1.strelka_varscan_union_indel.vcf")
#output_file = file("S1-0Gy-1.strelka_varscan_union_indel_clonal.vcf",'w')


input_line = input_file.readline().strip()
input_line = input_file.readline().strip()   

while input_line:
    input_split = input_line.split('\t')
    info = input_split[17]
    germline_var = int(info.split(';')[4])
    vaf = round(float(info.split(';')[8]),2)
    
    if germline_var < 2:
        output_file.write(str(vaf) + '\n')
    else:
        'blank'
        
    input_line = input_file.readline().strip()

print 'The End'

