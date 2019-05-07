
# coding: utf-8

# In[3]:


import sys

input_fn = sys.argv[1]
#input_fn = 'male_panc_L3SO4.delly.somatic.annotated.filter1.vcf'
input_file = file(input_fn)
output_file = file(input_fn.replace('.vcf','.reviewed.vcf'),'w')

input_line = input_file.readline().strip()
input_split = input_line.split('\t')
output_file.write('\t'.join(input_split[0:11]) + '\t' + "Decision_denovo" + '\t' + '\t'.join(input_split[11:13]) + '\tMother_Ref1;Ref2;AllDiscordantFragments;SplitFragments;SATagFragments;Vaf1;Vaf2\tRemarks' + '\n')
input_line = input_file.readline().strip()

sv_cut = 0.8 #(cutoff = 0.5*0.6*sv_cut)

while input_line:
    input_split = input_line.split('\t')
    input_type = input_split[6]
    input_t_vaf = float(input_split[10])
    denovo = '.'
    
    if input_type == 'INS':
        if input_t_vaf >= 0.5*0.6*sv_cut:
            denovo = 'insertion_clonal'
        else:
            denovo = 'insertion_subclonal'
    else:                
        if input_split[9] == 'short_indel':
            if input_t_vaf >= 0.5*0.6*sv_cut:
                denovo = 'denovo_clonal_short_indel'
            else:              
                denovo = 'denovo_?_short_indel'
        elif input_type == 'DUP' and input_t_vaf >=0.33*0.6*sv_cut:
            denovo = 'denovo_clonal'
        elif input_t_vaf >= 0.5*0.6*sv_cut:
            denovo = 'denovo_clonal'   
        else:
            denovo = 'denovo_subclonal' 

    if input_split[7] == 'T1':   
        output_file.write('\t'.join(input_split[0:11]) + '\t' + denovo + '\t' + '\t'.join(input_split[11:13])  + '\t.\t.' + '\n')
    else:
        if input_split[9] == 'short_indel' or input_t_vaf < 0.1:
            'blank'
        else:
            output_file.write('\t'.join(input_split[0:11]) + '\t' + denovo + '\t' + '\t'.join(input_split[11:13])  + '\t.\t.' + '\n')
    input_line = input_file.readline().strip()

output_file.close()
print 'THE END'

