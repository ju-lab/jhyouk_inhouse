
# coding: utf-8

# In[5]:


import sys

input_fn = sys.argv[1]
#input_fn = 'S1N2P15_1-2a_union_2.readinfo.readc.rasmy_pon.filter1.mreadc.mrasmy.filter2.vcf'
input_file = file(input_fn)
output_fn = input_fn.replace('.vcf','') + '.none_to_clonal.vcf'
output_fn1 = input_fn.replace('.vcf','') + '.clonal_to_clonal.vcf'
output_file= file(output_fn,'w')
output_file1= file(output_fn1,'w')

input_line = input_file.readline().strip()
while input_line[0:1]=='#':
    input_split = input_line.split('\t')
    output_file.write('\t'.join(input_split[0:10]) + '\n')
    input_line = input_file.readline().strip()
    
while input_line:
    input_split = input_line.split('\t')
    input_decision = input_split[41]
    
    if input_decision == 'none_to_clonal':
        output_file.write('\t'.join(input_split[0:10]) + '\n')
    elif input_decision == 'clonal_to_clonal':
        output_file1.write('\t'.join(input_split[0:10]) + '\n')
    else:
        'blank'
    
    input_line = input_file.readline().strip()
print 'THE END'

