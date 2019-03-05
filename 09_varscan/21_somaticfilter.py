
# coding: utf-8

# In[2]:


import sys
input_fn = sys.argv[1]
#input_fn = 'S1-2Gy-1.varscan.snp.vcf'
input_file = file(input_fn)
output_fn = input_fn.replace(".vcf",".somatic.vcf")
output_file = file(output_fn,'w')

input_line = input_file.readline()
while input_line:
    if input_line[0:2] == '##':
        'blank'
    elif input_line[0:6] == '#CHROM':
        output_file.write(input_line)
    else:
        input_split = input_line.split('\t')
        input_germline = input_split[9].split(':')[0]
        input_somatic = input_split[10].split(':')[0]        
        input_decision = input_split[6]
        
        var_germline = int(input_split[9].split(':')[4])
        var_somatic = int(input_split[10].split(':')[4])
        
        vaf_germline = float(input_split[9].split(':')[5].replace('%',''))
        vaf_somatic = float(input_split[10].split(':')[5].replace('%',''))
        if input_decision == 'PASS':
            if input_germline == '0/0' and input_somatic == '0/1' and var_germline<2 and var_somatic>=3:
                output_file.write(input_line)
            elif input_germline == '0/0' and input_somatic == '1/1' and var_germline<2 and var_somatic>=3:
                output_file.write(input_line)        
            elif input_germline == '0/1' and input_somatic == '0/0' and vaf_germline>=25 and var_somatic<2:
                output_file.write(input_line)   
            elif input_germline == '0/1' and input_somatic == '1/1' and vaf_germline>=25:
                output_file.write(input_line) 
            elif input_germline == '1/1' and input_somatic == '0/1' and vaf_somatic>=25:
                output_file.write(input_line)
            elif input_germline == '1/1' and input_somatic == '0/0' and var_somatic<2:
                output_file.write(input_line)
            else:
                'blank'
        else:
            'blank'
    input_line = input_file.readline()
print 'The End'

