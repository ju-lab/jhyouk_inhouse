
# coding: utf-8

# In[14]:


import sys
input_fn = sys.argv[1]
#info_fn = sys.argv[2]
#input_fn = "S1-0Gy-1.combination.Mutect_Strelka_union.vcf.readinfo.filtered.vcf"
info_fn = "N1-S1.combination.Mutect_Strelka_union.vcf.readinfo"
output_fn = input_fn.replace(".vcf",".net_clonal.vcf")
input_file = file(input_fn)
info_file = file(info_fn)
output_file = file(output_fn,'w')
output1_file = file(output_fn.replace(".vcf",".excluded.vcf"),'w')

input_line = input_file.readline()
output_file.write(input_line)
input_line = input_file.readline()
info_line = info_file.readline()
info_line = info_file.readline()

while input_line:
    new=0
    input_split = input_line.split('\t')
    #print input_split[0].replace("X",20).replace("Y",21).replace("MT",22)
    input_chr = int(input_split[0].replace("X",'20').replace("Y",'21').replace("MT",'22'))
    input_pos = long(input_split[1])
    
    while info_line:
        info_split = info_line.split('\t')
        info_chr = int(info_split[0].replace("X",'20').replace("Y",'21').replace("MT",'22'))
        info_pos = long(info_split[1])
        
        if input_chr < info_chr:
            new=1
            break
        elif input_chr >info_chr:
            info_line = info_file.readline()
            continue
        else:
            if input_pos < info_pos:
                new=1
                break
            elif input_pos > info_pos:
                info_line = info_file.readline()
                continue
            else:
                new=2  
                break
                
    if new == 1:
        output_file.write(input_line)
    elif new == 2:
        output1_file.write(input_line)
    else:
		print input_line
    input_line = input_file.readline()
        

