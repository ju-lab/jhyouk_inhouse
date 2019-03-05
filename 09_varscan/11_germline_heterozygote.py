
# coding: utf-8

# In[7]:


import sys

input_fn = sys.argv[1]
input_file = file(input_fn)
output_file = file(input_fn.replace(".vcf","") + 'swapdecision.vcf', 'w')
#input_file = file("C3SO3_dirams8.varscan.snp.vcf")
#output_file = file("C3SO3_dirams8.varscan.snp.swapdecision.vcf",'w')
input_line = input_file.readline().strip()

while input_line[0:2] == '##':
    input_line = input_file.readline().strip()

while input_line[0:1] == '#':
    output_file.write(input_line + '\t' + 'Vaf' + '\n')
    input_line = input_file.readline().strip()

while input_line:
    input_split = input_line.split('\t')
    input_germline = float(input_split[9].split(':')[3])
    input_somatic = float(input_split[9].split(':')[4])
    input_vaf = round(input_somatic/(input_germline+input_somatic),2)
    
    if input_germline > 8 and input_somatic > 8 and input_vaf > 0.4:
        output_file.write(input_line + '\t'+ str(input_vaf) + '\n')
    
    input_line = input_file.readline().strip()


print 'The end'

