
# coding: utf-8

# In[3]:


import sys
input_fn = sys.argv[1]
#input_fn = 'S1-8Gy-1.combination.Mutect_Strelka_union.vcf.readinfo.filtered.vcfN1S1_read>=2.vcf'
input_file = file(input_fn)
output_fn = input_fn[0:8] + '.DBS.vcf'
output_file = file(output_fn,'w')

input_line = input_file.readline()
output_file.write(input_line)
input_line = input_file.readline()
previous_chr = 0
previous_pos = 0
previous_line = ''
while input_line:
    input_split = input_line.split('\t')
    input_chr = int(input_split[0].replace('X','20').replace('Y','21').replace('MT','22'))
    input_pos = long(input_split[1])
    
    if input_chr == previous_chr:
        if input_pos == previous_pos+1:
            output_file.write(previous_line)
            output_file.write(input_line)
    
    previous_chr = input_chr
    previous_pos = input_pos
    previous_line = input_line
    
    input_line = input_file.readline()
    
    

