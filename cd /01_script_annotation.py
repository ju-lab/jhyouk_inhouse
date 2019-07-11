
# coding: utf-8

# In[2]:


#preparation of run_script for annotation
#python 01_script_annotation.py <list file> <date>

import sys
input_fn = sys.argv[1]
input_date = sys.argv[2]
#input_fn = "union_list_190220.txt"
#input_date = '190220'

input_file = open(input_fn)
output_fn = '01_1_run_annotation_' + input_date +  '.sh'
output_file = file(output_fn,'w')

input_line = input_file.readline().strip()
while input_line:
    input_split = input_line.split(' ')
    input_ID = input_split[-1].split('.varscan')[0]
    file_name = input_ID + '_union_2.vcf'
    output_file.write('sh sypark_PointMt_annot_filter/PointMt_annot.sh %s /home/users/team_projects/Radiation_signature/02_bam/%s.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/N1spleen.s.md.ir.br.bam sypark_PointMt_annot_filter/src &> %s.annotation.out && mv %s.annotation.out %s.annotation.success\n' %(file_name,input_ID,input_ID,input_ID,input_ID))
        
    input_line = input_file.readline().strip()

#sh PointMt_annot.sh <input file> <tumor bam> <normal bam> </path/to/scripts>

