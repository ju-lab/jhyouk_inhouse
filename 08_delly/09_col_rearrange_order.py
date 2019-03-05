
# coding: utf-8

# In[8]:


import sys
input_fn = sys.argv[1]
#input_fn = 'HBIR1-1'
input_file = file(input_fn+'.delly.somatic.vcf.BPinfo4.filter1')
output_fn = input_fn + '.delly.somatic.vcf.BPinfo4.filter1.rearrange'
output_file = file (output_fn,'w')

input_line = input_file.readline()
output_file.write('#CHR1'+'\t'+'POS1'+'\t'+'CHR2'+'\t'+'POS2'+'\t'+ 'MH' + '\t'+'Terminal'+'\t'+'SVtype'+ input_line[1:])
input_line=input_file.readline()

while input_line:
    input_split=input_line.split('\t')
    input_somatic = input_split[15]
    if input_somatic == 'NA':
        chr1 = input_split[0]
        pos1 = input_split[1]
        chr2 = input_split[11].split(';')[3].split('=')[1]
        pos2 = input_split[11].split(';')[4].split('=')[1]
        try:
            mh = input_split[11].split(';')[11].split('=')[1]
        except:
            mh = '0'
        terminal =input_split[11].split(';')[7].split('=')[1]
        SVtype = input_split[11].split(';')[1].split('=')[1]

        output_file.write(chr1+'\t'+pos1+'\t'+chr2+'\t'+pos2+'\t'+mh+'\t'+terminal+'\t'+SVtype+'\t'+input_line)
        
    else:
        input_somatic_list=input_split[15].split(',')
        
        for i in input_somatic_list:

            chr1 = i.split('_')[0].split(':')[0]
            try:
                pos1 = i.split('_')[0].split(':')[1]
            except:
                continue
                
            chr2 = i.split('_')[1].split(':')[0]
            try:
                pos2 = i.split('_')[1].split(':')[1]
            except:
                continue
                
            mh = i.split('_')[2]
            terminal = i.split('_')[4].split('(')[0].replace('-','to')
            SVtype = i.split('_')[3]

            temp_pos1 = ''
            temp_pos2 = ''
            temp_terminal = ''
            
            if SVtype == 'DEL' and long(pos1) > long(pos2):
                temp_pos1 = pos1
                temp_pos2 = pos2
                temp_terminal = terminal

                pos1 = temp_pos2
                pos2 = temp_pos1
                terminal = temp_terminal[3:4] + 'to' + temp_terminal[0:1]
                
            output_file.write(chr1+'\t'+pos1+'\t'+chr2+'\t'+pos2+'\t'+mh+'\t'+terminal+'\t'+SVtype+'\t'+input_line)
            
    input_line = input_file.readline()
    
print 'The End'

