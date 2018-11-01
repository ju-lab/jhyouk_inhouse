
# coding: utf-8

# In[6]:


import sys

input_fn = sys.argv[1]
input_file = file(input_fn)
output_file = file(input_fn.replace(".vcf","_signature.vcf"),'w')

#input_file = file("S1-0Gy-1.strelka_varscan_union_indel_clonal_removeN1S1_nonrepeat_2-bpdeletion.vcf")
#output_file = file("S1-0Gy-1.strelka_varscan_union_indel_clonal_removeN1S1_nonrepeat_2-bpdeletion_signature.vcf",'w')

input_line = input_file.readline().strip()
output_file.write('x-axis\tnumber\n')

while input_line[0] == '#':
    input_line = input_file.readline().strip()

xcomponent = ['20','21','30','31','32','40','41','42','43','50','51','52','53','54','55']
#xcomponent = ['21','31','32','41','42','43','51','52','53','54','55']
ycomponent = []

for i in xcomponent:
    ycomponent.append(0)

while input_line:
    temp = ''
    input_split = input_line.split('\t')
    length_del = len(input_split[3][1:])
    mh = int(input_split[20])
    if length_del > 5:
        length_del = 5
    if mh > 5:
        mh = 5
    temp = str(length_del) + str(mh)
    
    if temp in xcomponent:
        ycomponent[xcomponent.index(temp)] += 1
    else:
        'blank'
    input_line = input_file.readline().strip()

for j in xcomponent:
    output_file.write(j + '\t' + str(ycomponent[xcomponent.index(j)]) + '\n')
    

