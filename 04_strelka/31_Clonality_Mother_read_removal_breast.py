
# coding: utf-8

# In[ ]:


import sys, pysam
input_fn = sys.argv[1]
output_fn = input_fn + "_mother_read_removal.vcf"

#input_fn = "S1P12_0-3"
#output_fn = "S1P12_0-3_mother_read_removal.vcf"
input_file = file(input_fn +'/results/passed.somatic.snvs.vaf_annotated.vcf')
output_file = file(input_fn +'/results/' + output_fn,'w')

#bam_file = pysam.AlignmentFile('/home/users/team_projects/Radiation_signature/02_bam/N1-S1.s.md.ir.br.bam','rb')
bam_file = pysam.AlignmentFile('/home/users/team_projects/Radiation_signature/02_bam/Spleen_m3.s.md.ir.br.bam','rb')

input_line = input_file.readline().strip()
output_file.write(input_line + '\t'+ 'N1S1_var_read_N' +'\n')
input_line = input_file.readline().strip()

prev_chr = 0

while input_line:
    tf=0
    input_split = input_line.split('\t')
    input_chr = input_split[0]
    input_pos = long(input_split[1])
    alt_nt = input_split[4][0]
    
    if input_chr != prev_chr:
        print input_chr
        prev_chr = input_chr

    for read1 in bam_file.pileup(input_chr,input_pos-1,input_pos):
        if long(read1.pos)==input_pos-1:
            for pileupread in read1.pileups:
                if pileupread.query_position == None:
                    continue
                elif pileupread.alignment.query_sequence[pileupread.query_position] == alt_nt:
                    tf+=1
                else:
                    'blank'

    if tf<2:
        output_file.write(input_line+'\t'+str(tf)+'\n')

    input_line = input_file.readline().strip()

print 'The End'



