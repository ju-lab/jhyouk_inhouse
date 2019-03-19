
# coding: utf-8

# In[12]:


#vcf union of Strelka2 and Varscan2
#python 00_1_script_vcf_combination.py <list file> <date> <species:human or mouse>

import sys
input_fn = sys.argv[1]
input_date = sys.argv[2]
input_species = sys.argv[3]
#input_fn = "union_list_190220.txt"
#input_date = '190220'
#input_species = "mouse"
#input_num = 3
input_file = open(input_fn)
output_fn = '00_2_run_union_' + input_date +  '.sh'
output_file = file(output_fn,'w')

input_line = input_file.readline().strip()
while input_line:
    input_split = input_line.split(' ')
    input_ID = input_split[-1].split('.')[0]
    output_file.write('python 00_vcf_combination_by_Youk.py %s %s 2 /home/users/jhyouk/06_mm10_SNUH_radiation/14_Strelka2/%s/results/variants/somatic.snvs.vcf.gz /home/users/jhyouk/06_mm10_SNUH_radiation/09_varscan/%s.varscan.snp.somatic.vcf &> %s.union.out\n' % (input_ID,input_species,input_ID,input_ID,input_ID))
    input_line = input_file.readline().strip()

print 'The End'
# python 00_vcf_combination_by_Youk.py <ID> <species:human or mouse> <number of files for union> <file1_path&name> <file2_path&name> <file3_path&name> ...

