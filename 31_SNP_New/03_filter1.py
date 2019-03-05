
# coding: utf-8

# In[13]:


#Arg1 = vcf_filename
#Arg2 = 'b6' or 'balbc'

import sys

input_fn = sys.argv[1]
#input_fn = 'S1-0Gy-1_union_2_normalpanel1_11.readinfo.readc.rasmy_pon_b6_4_pon_balbc_7.vcf'

input_strain = sys.argv[2]
#input_strain = 'b6'

input_file = file(input_fn)
output_file = file(input_fn.replace('.vcf','.filter1.vcf'),'w')

input_line = input_file.readline().strip()
prev_chr = '0'

while input_line[0:1] == '#':
    output_file.write(input_line + '\tpairedN_read\tPON\tT_vaf\tfilter1\n')
    input_line = input_file.readline().strip()

while input_line:
    input_split = input_line.split('\t')
    
    if input_split[0] != prev_chr:
        print input_split[0]
        prev_chr = input_split[0]
    
    #if input_split[1] != '3487989':
        #input_line = input_file.readline().strip()
        #continue
    
        
    t_var_cor = input_split[30].split(';')[10]
    info = '\tNA\tNA\tNA\tU'
    filter1='F'
    
    if t_var_cor =='.' or t_var_cor == '0':
        info = '\tNA\tNA\tNA\tF'
        output_file.write(input_line + info + '\n')
        input_line = input_file.readline().strip()       
        continue
    else:
        if input_strain == 'b6':
            if input_split[31] == 'NA':
                input_pon = 9
            else:
                input_pon = round(float(input_split[31].split(';')[6])/100,2)
        elif input_strain == 'balbc':
            if input_split[31] == 'NA':
                input_pon = 9
            else:           
                input_pon = round(float(input_split[32].split(';')[6])/100,2)
        else:
            print 'unexpected'
            sys.exit(1)
        input_caller = input_split[6]
        t_var_cor = float(t_var_cor)
        n_read = max(int(input_split[29].split(';')[1]),int(input_split[30].split(';')[8]))
        t_ref_cor = float(input_split[30].split(';')[9])
        t_vaf = round(float(t_var_cor)/(float(t_var_cor)+t_ref_cor),2)
        var_NM = input_split[28]
        
        if n_read >= 2:
            filter1='F'
        elif input_pon >=0.04:
            filter1='F'
        elif n_read == 1 and t_var_cor <=9:
            filter1='F'
        elif n_read == 0 and t_var_cor < 3:
            filter1='F'
        elif float(var_NM) > 4 and input_pon > 0:
            filter1='F'
        elif input_caller == '01':
            if input_pon >=0.05:
                filter1='F'
            elif t_ref_cor + t_var_cor >=100:
                filter1='F'
            elif input_split[24] == '0;0.0;0;0.0' and input_split[25] == '0;0.0;0;0.0' and input_split[26] == '0;0.0;0;0.0':
                filter1='T'
            else:
                filter1='F'
        else:
            filter1='T'
                
        info = '\t%s\t%s\t%s\t%s' %(n_read,input_pon,t_vaf,filter1)
        output_file.write(input_line + info + '\n')
        
    input_line = input_file.readline().strip()

print 'The END'

