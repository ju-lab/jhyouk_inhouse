
# coding: utf-8

# In[7]:


import sys

input_fn = sys.argv[1]
#input_fn = 'S1N2P15_1-4a'
input_file = file(input_fn + '.mpileup')

output_file = file(sys.argv[1] + '_callable.bed','w')
output_file.write('##callable region, depth of which is 10 or more\n')
i=0
this_chr = '0'
this_start = '0'
this_end = '0'
input_ing = 'no'
input_line = input_file.readline().strip()

while input_line:
    input_split = input_line.split('\t')
    input_chr = input_split[0]
    input_pos = input_split[1]
    input_depth = int(input_split[3])
        
    if this_chr != '0' and input_chr != this_chr:
        if input_ing == 'yes':
            input_ing = 'no'
            output_file.write('%s\t%s\t%s\n' %(this_chr, this_start, this_end))
            this_chr = '0'
            this_start = '0'
            this_end = '0'
        else:
            'blank'
    elif input_depth >=10:
        if input_ing == 'yes':
            this_end = input_pos
            i+=1
        else:
            input_ing = 'yes'
            this_chr = input_chr
            this_start = input_pos
            this_end = input_pos
            i+=1
    else:
        if input_ing == 'yes':
            input_ing = 'no'
            output_file.write('%s\t%s\t%s\n' %(this_chr, this_start, this_end))
            #print '%s\t%s\t%s\n' %(this_chr, this_start, this_end)
            this_chr = '0'
            this_start = '0'
            this_end = '0'
        else:
            'blank'
        
    if input_chr =='MT':
        break
        
    #print input_depth
    
    input_line = input_file.readline().strip()
        
print 'Total region>=10 is ', i
    

