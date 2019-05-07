
# coding: utf-8

# In[45]:


import sys

input_fn = sys.argv[1]
input_file = file(input_fn + '.delly.vcf.somatic.annotated')

output_file = file(input_fn +'.delly.somatic.annotated.filter1.vcf' , 'w')

input_line = input_file.readline().strip()
while input_line[0:2] == '##':
    input_line = input_file.readline().strip()
while input_line[0:1] == '#':
    input_split = input_line.split('\t')
    info = '%s\t%s\t%s\t%s\t%s\t%s\t%s\n' %('\t'.join(input_split[14:21]), 'Decision', 'Size', 'Small_deletion', "max_T_BP_vaf",input_split[26], input_split[27])
    output_file.write('#' + info)
    input_line = input_file.readline().strip()
t1=[]
t2=[]

input_factor = 1
if input_fn == 'B3S100':
    input_factor = 2
    
while input_line:
    dec = '.'
    input_split = input_line.split('\t')
    input_si = '.'

    if input_split[20] == 'INS' and input_split[9].split(':')[0] == '0/1':
        input_dv = float(input_split[9].split(':')[9])
        input_rv = float(input_split[9].split(':')[11])
        input_size = 'NA'
        input_vaf = round((input_dv + input_rv) / (input_dv + input_rv + float(input_split[9].split(':')[8]) + float(input_split[9].split(':')[10])),2)
        if input_dv + input_rv >= (5*input_factor) and input_rv >= (2*input_factor):
            dec = 'T1'
        elif input_rv >=(2*input_factor) or (input_rv > 0 and input_rv < (2*input_factor) and (input_dv + input_rv) >=(3*input_factor)):
            dec = 'T2'
        elif input_dv + input_rv >= (10*input_factor):
            dec = 'T2'
        else:
            dec = 'F'    
    elif input_split[26] == '.' or int(input_split[26].split(';')[2]) == 0:
        input_line = input_file.readline().strip()
        continue
    else:
        input_tumor = input_split[26].split(';')
        input_normal = input_split[27].split(';')
        input_discor = int(input_tumor[2])
        input_SA = int(input_tumor[4])
        
        input_t_max_read = input_discor + max(int(input_tumor[0]),int(input_tumor[1]))
        input_vaf1 = round(float(input_tumor[5].split('%')[0])/100,2)
        input_vaf2 = round(float(input_tumor[6].split('%')[0])/100,2)
        
        if input_discor + int(input_tumor[0]) < 10 and input_discor + int(input_tumor[1]) >= 10:
            input_vaf = input_vaf2
        elif input_discor + int(input_tumor[0]) >= 10 and input_discor + int(input_tumor[1]) < 10:
            input_vaf = input_vaf1
        else:
            input_vaf = max(input_vaf1,input_vaf2)
        
        input_nor_f1 = int(input_normal[2])
        input_nor_f2 = int(input_normal[3])

        input_nor_discor = int(input_normal[0])
        input_nor_sa = int(input_normal[1])
        #input_pon_total = int(input_split[11].split(';')[0])
        input_pon_sample = int(input_split[11].split(';')[1])
        
        input_bg_n1 = int(input_split[34].split(';')[6])
        input_bg_n2 = int(input_split[35].split(';')[6])
        
        if input_split[20] == 'TRA':
            input_size = 'NA'
        else:
            input_size = long(input_split[17]) - long(input_split[15])
        if input_split[20] == 'DEL' and input_size <100:
            input_si = 'short_indel'
        else:
            input_si = '.'
            
        if input_nor_f1 >= 200 or input_nor_f2 >= 200:
            dec='F'
        elif input_nor_sa >= 2:
            dec='F'
        elif input_pon_sample >=2:
            dec='F'
        elif input_bg_n1 >=3 or input_bg_n2 >=3:
            dec='F'        
        elif input_SA >= (2*input_factor):
            if input_discor >= (5*input_factor):
                dec='T1'
            elif input_t_max_read >= (10*input_factor) and input_discor > 2:
                dec='T2'
            else:
                dec='F'
        elif input_nor_discor > 10:
            dec = 'F'
        elif input_discor < (10*input_factor) and input_SA == 0:
            dec = 'F'
        elif input_discor < (3*input_factor) and input_SA > 0 and input_SA < (2*input_factor) :
            dec = 'F'
        #elif input_split[20] == 'DEL' and input_size >400 and input_size <1000 and input_SA == 0: #delete after 92 samples
            #dec = 'F'      
        elif input_split[20] == 'DEL' and input_vaf < 0.2 and input_SA == 0:
            dec = 'F'              
        elif input_split[20] == 'DEL' and input_size >400 and input_size <1000 and input_SA > 0 and input_SA < (2*input_factor) and input_discor < (10*input_factor):
            dec = 'F'
        elif input_split[20] == 'DUP' and input_size >400 and input_size <1000 and input_SA == 0:
            dec = 'F'        
        elif input_split[20] == 'TRA' and input_vaf < 0.2 and input_SA == 0:
            dec = 'F' 
        else:
            dec = 'T2'

    info = '%s\t%s\t%s\t%s\t%s\t%s\t%s\n' %('\t'.join(input_split[14:21]), dec, str(input_size), input_si, input_vaf,input_split[26], input_split[27])
        
    if dec =='T1':
        t1.append(info)
    elif dec == 'T2':
        t2.append(info)
    else:
        'blank'
    input_line = input_file.readline().strip()
for i in t1:
    output_file.write(i)
for j in t2:
    output_file.write(j)
print 'filter1 done'

