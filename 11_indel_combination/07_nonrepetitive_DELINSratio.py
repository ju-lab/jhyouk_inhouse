
# coding: utf-8

# In[3]:


import sys
    
input_fn = sys.argv[1]
input_file = file(input_fn)
#output_file = file(input_fn.replace(".vcf","_nonrepeat.vcf"),'w')

#input_file = file("S1-0Gy-1.strelka_varscan_union_indel_clonal_removeN1S1_nonrepeat.vcf")
#output_file = file("S1-0Gy-1.strelka_varscan_union_indel_clonal_removeN1S1_nonrepeat.vcf",'w')

input_line = input_file.readline().strip()
input_line = input_file.readline().strip()
nins = 0
ndel = 0

while input_line:
    input_split = input_line.split('\t')

    if len(input_split[3]) < len(input_split[4]):                        
        nins += 1
    elif len(input_split[3]) > len(input_split[4]):
        ndel += 1
    
    input_line = input_file.readline().strip()

print 'INS =' + str(nins) + ', DEL ='+str(ndel)

