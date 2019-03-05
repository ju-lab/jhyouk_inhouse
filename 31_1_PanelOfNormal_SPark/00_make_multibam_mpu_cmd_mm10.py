#Arg1: bam_list
#Arg2: cohort name

#181107 add option -A
#181203 add -d 3000

import sys,os
fn_file=open(sys.argv[1]) # bam list
cohort_name=sys.argv[2]  
out_file=open('run.'+cohort_name+'.mpu.sh','w')
mapq=0
baseq=0

n=0
fn_line=fn_file.readline().strip()
while fn_line:
	n=n+1
	fn_line=fn_file.readline().strip()
fn_file.seek(0)
input_n=str(n)
print('No. of input files: %s' % input_n)
	
reffa='/home/users/jhyouk/99_reference/mouse/mm10/GRCm38.fa'
chr_list=['5','6','7','8','9','10','11','12','13','4','14','15','16','17','3','18','19','2','X','Y','MT','1']
for chr1 in chr_list:
	out_file.write('(samtools mpileup -AB -d 3000 -q %s -Q %s -f %s -r %s' % (mapq, baseq, reffa, chr1))
	fn_line=fn_file.readline().strip()
	while fn_line:
		out_file.write(' %s' % fn_line)
		fn_line=fn_file.readline().strip()
	fn_file.seek(0)
	out_file.write(' -o %s.%ss.q%sQ%s.chr%s.mpileup) 2> %s.mpu.chr%s.out && mv %s.mpu.chr%s.out %s.mpu.chr%s.success\n' % (cohort_name, input_n, mapq, baseq, chr1,cohort_name, chr1, cohort_name, chr1, cohort_name, chr1))
out_file.close()


