
# coding: utf-8

# In[2]:


import sys

input_fn = sys.argv[1]
#input_fn = 'S1N2P15_0-3.delly.somatic.annotated.filter1.motherinfo.vcf'
input_file = file(input_fn)
output_file = file(input_fn.replace('.vcf','.filter2.vcf'),'w')

input_line = input_file.readline().strip()
input_split = input_line.split('\t')
output_file.write('\t'.join(input_split[0:11]) + '\t' + "Decision_denovo" + '\t' + '\t'.join(input_split[11:14]) + '\tRemarks' + '\n')
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
        input_m_sa = int(input_split[13].split(';')[4])
        
        if input_split[13].split(';')[5] == 'NA':
            input_vaf1=0
        else:
            input_vaf1 = float(input_split[13].split(';')[5].split('%')[0])/100 
            
        if input_split[13].split(';')[6] == 'NA':
            input_vaf2=0
        else:
            input_vaf2= float(input_split[13].split(';')[6].split('%')[0])/100 
            
        
        input_m_vaf = max(input_vaf1,input_vaf2)

            
        if input_m_sa >=1:
            if input_type == 'DUP' and input_m_vaf >=0.33*0.6*sv_cut:
                denovo = 'mother_clonal'
            elif input_m_vaf >=0.5*0.6*sv_cut:
                denovo = 'mother_clonal'
            else:
                denovo = 'mother_subclonal'
        else:
            if input_split[9] == 'short_indel':
                if input_type == 'DUP' and input_t_vaf >=0.33*0.6*sv_cut:
                    denovo = 'denovo_clonal_short_indel'
                elif input_t_vaf >= 0.5*0.6*sv_cut:
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
        output_file.write('\t'.join(input_split[0:11]) + '\t' + denovo + '\t' + '\t'.join(input_split[11:14])  + '\t.' + '\n')
    else:
        if input_split[9] == 'short_indel' or input_t_vaf < 0.1:
            'blank'
        else:
            output_file.write('\t'.join(input_split[0:11]) + '\t' + denovo + '\t' + '\t'.join(input_split[11:14]) + '\t.' +'\n')
        
        
    input_line = input_file.readline().strip()

print 'filter2 done'

