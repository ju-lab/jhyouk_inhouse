
# In[26]:


import sys, pysam
input_fn = sys.argv[1]
#input_fn = "S1-0Gy-1.combination.Mutect_Strelka_union.vcf.readinfo.filtered.vcf"
output_fn = input_fn + "N1S1_read>=2.vcf"
input_file = file(input_fn)
output_file = file(output_fn,'w')
output1_file = file((output_fn+'N1S1_excluded.vcf'),'w')
bam_file = pysam.AlignmentFile('/home/users/jhyouk/06_mm10_SNUH_radiation/03_bam/N1-S1.s.md.ir.br.rg.bam','rb')

input_line = input_file.readline().strip()
output_file.write(input_line + '\t'+ 'N1S1_var_read_N' +'\n')
output1_file.write(input_line+ '\t'+ 'N1S1_var_read_N' +'\n')
input_line = input_file.readline().strip()

while input_line:
    tf=0
    input_split = input_line.split('\t')
    input_chr = input_split[0]
    input_pos = long(input_split[1])
    alt_nt = input_split[4][0]
    
    for read1 in bam_file.pileup(input_chr,input_pos-1,input_pos):
        if long(read1.pos)==input_pos-1:
            for pileupread in read1.pileups:
                if pileupread.query_position == None:
                    continue
                elif pileupread.alignment.query_sequence[pileupread.query_position] == alt_nt:
                    tf+=1
                else:
                    'blank'
    
    if tf>=2:
        output1_file.write(input_line+'\t'+str(tf) +'\n')
    else:
        output_file.write(input_line+'\t'+str(tf)+'\n')
    
    input_line = input_file.readline().strip()

