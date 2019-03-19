
# coding: utf-8

# In[51]:


#Arg1 = vcf_filename
#Arg2 = tumor_bam
#Arg3 = mpileup.100kb.mpileup.100kbcov.covstat
#Arg4 = mother_bam
#Arg5 = mother mpileup.100kb.mpileup.100kbcov.covstat

def both_coverage(input_line,t_bam):
    input_split = input_line.split('\t')
    input_chr = input_split[0]
    input_pos = long(input_split[1])
    
    lt_coverage = []
    for pileupcolumn in t_bam.pileup(input_chr,input_pos-1000,input_pos,min_mapping_quality=0,min_base_quality=10):
        if input_pos-1000 <= pileupcolumn.pos and pileupcolumn.pos <= input_pos-1:
            lt_coverage.append(pileupcolumn.n)
            
    rt_coverage = []    
    for pileupcolumn in t_bam.pileup(input_chr,input_pos,input_pos+1000,min_mapping_quality=0,min_base_quality=10):
        if input_pos <= pileupcolumn.pos and pileupcolumn.pos <= input_pos+1000:
            rt_coverage.append(pileupcolumn.n)            

    return [numpy.mean(lt_coverage),numpy.mean(rt_coverage)]


import sys, pysam, gzip, numpy

input_fn = sys.argv[1]
#input_fn = 'N1-S1_union_2_normalpanel1_11.readinfo.readc.rasmy_pon_b6_4_pon_balbc_7.filter1.mreadc.rasmy.vcf'
input_file = file(input_fn)

t_bam_fn = sys.argv[2]
#t_bam_fn='/home/users/team_projects/Radiation_signature/02_bam/S1-0Gy-2.s.md.ir.br.bam'
t_bam = pysam.AlignmentFile(t_bam_fn,'rb')


info_fn = sys.argv[3]
#info_fn = "N1-S1.mpileup.100kbcov.covstat"
info_file = file("/home/users/jhyouk/06_mm10_SNUH_radiation/07_sequenza/"+info_fn)
info_line = info_file.readline().strip()
info_line = info_file.readline().strip()
info_coverage = float(info_line.split('\t')[3])

n_bam_fn = sys.argv[4]
#n_bam_fn='/home/users/team_projects/Radiation_signature/02_bam/N1-S1.s.md.ir.br.bam'
n_bam = pysam.AlignmentFile(n_bam_fn,'rb')

m_fn = sys.argv[5]
#m_fn = "N1-S1.mpileup.100kbcov.covstat"
m_file = file("/home/users/jhyouk/06_mm10_SNUH_radiation/07_sequenza/"+info_fn)
m_line = info_file.readline().strip()
m_line = info_file.readline().strip()
m_coverage = float(info_line.split('\t')[3])


output_file = file(input_fn.replace('.vcf','')+'.filter2.vcf','w')

input_line = input_file.readline().strip()
prev_chr = '0'

j=0
while input_line[0:1] == '#':
    output_file.write(input_line + '\tlt_nor_CN\trt_nor_CN\tMother_var_cell_portion\tT_var_cell_portion\tClass\n')
    input_line = input_file.readline().strip()
    
cc=0
cs=0
sc=0
ss=0
nc=0
ns=0

if input_fn[0:2] == 'B3':
    clonal_mother_cutoff=0.078 * 2 #Mother Clonality (not vaf, corrected by copy number)
else:
    clonal_mother_cutoff=0.30 * 2 #Mother Clonality (not vaf, corrected by copy number)

print 'clonal_mother_cutoff = %s' % clonal_mother_cutoff
clonal_cutoff=0.30 * 2 #Clonality (not vaf, corrected by copy number)

while input_line:
    input_split = input_line.split('\t')
    
    if input_split[0] != prev_chr:
        print input_split[0]
        prev_chr = input_split[0]
    
    #if input_split[1] != '3487989':
        #input_line = input_file.readline().strip()
        #continue

    info = '\tNA\tNA\tNA\tNA\tNA\n'
    if input_split[34] == 'F':
        output_file.write(input_line + info)
        
    else:
        input_tvaf = float(input_split[33])
        input_mother_consensus = float(input_split[36].split(';')[8])
        input_mother_ref = float(input_split[36].split(';')[7])
        
        mean_coverage = both_coverage(input_line,t_bam)
        lt_mean = mean_coverage[0]*2 / info_coverage
        rt_mean = mean_coverage[1]*2 / info_coverage
        mean_cnv = max(round((lt_mean + rt_mean)/2),1)
        tvar_cor = input_tvaf * mean_cnv
                
        input_mother_var = max(input_mother_consensus,float(input_split[35].split(';')[1]))
        input_mvaf = input_mother_var / (input_mother_consensus+input_mother_ref)
        
        mother_coverage = both_coverage(input_line,n_bam)
        mother_mean_cnv = max(round((mother_coverage[0] + mother_coverage[1])/info_coverage),1)
        input_mvar_cor = round(input_mvaf * mother_mean_cnv,2)
        
        #input_t_info = input_split[29].split(';')
        #input_depth = int(input_t_info[9]) + int(input_t_info[10]) + int(input_t_info[11])
        input_class=''

        if input_mvar_cor >=clonal_mother_cutoff:
            if tvar_cor>=clonal_cutoff:
                input_class='clonal_to_clonal'
                cc+=1
            else:
                input_class='clonal_to_subclonal'
                cs+=1
        elif input_mother_var >=1:
            if tvar_cor>=clonal_cutoff:
                input_class='subclonal_to_clonal'
                sc+=1
            else:
                input_class='subclonal_to_subclonal'
                ss+=1
        else:
            if tvar_cor>=clonal_cutoff:
                input_class='none_to_clonal'
                nc+=1
            else:
                input_class='none_to_subclonal'
                ns+=1
                
        
        info = '\t%s\t%s\t%s\t%s\t%s\n' % (round(lt_mean,2), round(rt_mean,2), input_mvar_cor, tvar_cor, input_class)
        output_file.write(input_line + info)
    input_line = input_file.readline().strip()

print 'clonal_to_clonal=%s' % cc
print 'clonal_to_subclonal=%s' % cs
print 'subclonal_to_clonal=%s' % sc
print 'subclonal_to_subclonal=%s' % ss
print 'none_to_clonal=%s' % nc
print 'none_to_subclonal=%s' % ns
print 'Total = %s' % (cc+cs+sc+ss+nc+ns)

print 'The END'

#output_
#output_file = file(input_fn.replace('.vcf','')+'.filter2.vcf','w')



            

