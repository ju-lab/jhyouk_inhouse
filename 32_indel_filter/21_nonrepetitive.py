
# coding: utf-8

# In[14]:


import sys

#input_fn = 'B3-0_P19_4Gy-5_indel_union_2.readinfo.readc.rasmy.pon.filter1.readc.rasmy.filter2.vcf'
input_fn = sys.argv[1] + '_indel_union_2.readinfo.readc.rasmy.pon.filter1.readc.rasmy.filter2.vcf'
input_file = file(input_fn)
output_file = file(input_fn.replace('.vcf','.nonrepeat.vcf'),'w')

input_line = input_file.readline().strip()

while input_line[0:1]=='#':
    output_file.write(input_line + '\n')
    input_line = input_file.readline().strip()
    
input_cutoff = 1
lt=0
rt=0
both=0
total =0
while input_line:
    input_split = input_line.split('\t')
    try:
        input_repeat_lt = int(input_split[29].split(';')[12].replace('.','0'))
        input_repeat_rt = int(input_split[29].split(';')[13].replace('.','0'))
    except:
        print input_split[29]
        break
        
    if input_split[34] =='T' and input_split[41] == 'none_to_clonal':
        total+=1
        if input_repeat_rt <input_cutoff:
            if input_repeat_lt < input_cutoff:
                both+=1
                output_file.write(input_line+'\n')
                #print input_split[29]
            else:
                rt+=1
                
        elif input_repeat_lt <input_cutoff:
            lt+=1
    
    input_line = input_file.readline().strip()

#print lt,rt,both,total

