
# coding: utf-8

# In[5]:


import sys

input_fn = sys.argv[1]
#input_fn = 'Panc_C3_SO1_snp_union_2.readinfo.readc.rasmy_PanelofNormal.filter1.coverage.vcf'
input_file = file(input_fn)

output_file = file(input_fn.replace('.vcf','.clonal.vcf'),'w')

input_line = input_file.readline().strip()
while input_line[0:1] == '#':
    output_file.write('\t'.join(input_line.split('\t')[0:10])+ '\n')
    input_line = input_file.readline().strip()
i=0
j=0
while input_line:
    input_split = input_line.split('\t')
    input_decision = input_split[34]
    input_portion = input_split[36]
    
    if input_decision == 'T':
        if float(input_split[33])>=0.3:
            i+=1
            
        if float(input_portion) >= 0.6:
            output_file.write('\t'.join(input_split[0:10])+'\n')
            j+=1
    input_line = input_file.readline().strip()

