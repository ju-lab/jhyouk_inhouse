
# coding: utf-8

# In[5]:


import sys
    
input_fn = sys.argv[1]
input_file = file(input_fn)
output_file = file(input_fn.replace(".vcf","_pattern.vcf"),'w')

#input_file = file("S1-0Gy-1.strelka_varscan_union_indel_clonal_removeN1S1_nonrepeat.vcf")
#output_file = file("S1-0Gy-1.strelka_varscan_union_indel_clonal_removeN1S1_nonrepeat_pattern.vcf",'w')

input_line = input_file.readline().strip()
input_line = input_file.readline().strip()

while input_line:
    input_split = input_line.split('\t')

    if len(input_split[3]) < len(input_split[4]):                        
        output_file.write(str(len(input_split[4])-1)+'\n')
    elif len(input_split[3]) > len(input_split[4]):
        output_file.write(str((len(input_split[3])-1)*-1)+'\n')
    
    input_line = input_file.readline().strip()

