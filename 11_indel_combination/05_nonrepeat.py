
# coding: utf-8

# In[11]:


import sys, pysam

def microhomology(input_line):
    i = 1
    mh = 0
    input_split = input_line.split('\t')    
    input_chr = input_split[0]
    input_pos = long(input_split[1])
    initial_rlen = len(input_split[3][1:])
    
    temp_pos1 = input_pos
    temp_pos2 = input_pos + initial_rlen
    
    while 1:
        if ref_fasta.fetch(input_chr,temp_pos1-i,temp_pos1) == ref_fasta.fetch(input_chr,temp_pos2,temp_pos2+i):
            mh += 1
            i+=1
        else:
            break
    
    #print input_line
    #print mh
    return mh  
    
input_fn = sys.argv[1]
input_file = file(input_fn)
output_file = file(input_fn.replace(".vcf","_nonrepeat.vcf"),'w')
output_file1 = file(input_fn.replace(".vcf","_nonrepeat_2-bpdeletion.vcf"),'w')
ref_fasta = pysam.FastaFile("/home/users/jhyouk/99_reference/mouse/mm10/GRCm38.fa")

#input_file = file("S1-0Gy-1.strelka_varscan_union_indel_clonal_removeN1S1.vcf")
#output_file = file("S1-0Gy-1.strelka_varscan_union_indel_clonal_removeN1S1_nonrepeat.vcf",'w')

input_line = input_file.readline().strip()

while input_line[0] == '#':
    output_file.write(input_line + '\t' + 'indel' + '\t' + 'MH in deletion' + '\n')
    output_file1.write(input_line + '\t' + 'indel' + '\t' + 'MH in deletion' + '\n')
    input_line = input_file.readline().strip()

while input_line:
    info = ''
    input_split = input_line.split('\t')
    repeat_num = int(input_split[17].split(';')[11])
    if repeat_num<=1:
        if len(input_split[3]) < len(input_split[4]) and repeat_num == 0:                        
            info = 'INS\tINS'
            output_file.write(input_line + '\t'+ info + '\n')

        elif len(input_split[3]) > len(input_split[4]):
            mh = microhomology(input_line)
            info = 'DEL' + '\t' + str(mh)
            output_file.write(input_line +'\t'+ info + '\n')
            if len(input_split[3]) > (len(input_split[4])+1):
                output_file1.write(input_line +'\t'+ info + '\n')
    
    input_line = input_file.readline().strip()

print 'The End'

