
# coding: utf-8

# In[8]:


#python 21_1_script.py <vcf file list from ls -lhtr>

import sys
input_fn = sys.argv[1]
#input_fn = 'union_list_190220.txt'
input_file = file(input_fn)
output_file = file('21_2_run_' + input_fn.replace('.txt','.sh'),'w')

input_line = input_file.readline().strip()
while input_line:
    input_split = input_line.split(' ')
    input_filename = input_split[-1]
    
    output_file.write('python 21_somaticfilter.py %s\n'%(input_filename))
    
    input_line = input_file.readline().strip()

print 'The END'

