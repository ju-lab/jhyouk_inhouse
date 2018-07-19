#2018.07.18 cut off values of ref1 and ref2 were raised to 100
import sys

input_fn = sys.argv[1]
input_file = open(input_fn)
input_line = input_file.readline()

output_file=file(input_fn+'.dellyVaf','w')
input_line = input_file.readline().strip()
tp=[]
t2=[]
gray=[]
fp=[]
while input_line:
    tf='0'
    input_split = input_line.split('\t')
    input_somatic = input_split[20].split(':')
    
    input_delly = round(100*(float(input_somatic[-1])+float(input_somatic[-3]))/(float(input_somatic[-1])+float(input_somatic[-2])+float(input_somatic[-3])+float(input_somatic[-4])),2)
    
    try:
        input_ref1 = int(input_split[24])
    except:
        input_ref1=0
    try:
        input_ref2 = int(input_split[25])
    except:
        input_ref2 = 0

    if input_ref1 >=100 or input_ref2 >=100:
        input_split[9] = 'F'
    else:
        'blank'
    
    if input_split[9] =='T':
        output_line = '\t'.join(input_split[0:7]) + '\t' + '\t'.join(input_split[9:11]) + '\t' + '\t'.join(input_split[16:]) + '\t' +  str(input_delly) + '\n'
        tp.append(output_line)
    elif input_split[9] == 'T2':
        output_line = '\t'.join(input_split[0:7]) + '\t' + '\t'.join(input_split[9:11]) + '\t' + '\t'.join(input_split[16:]) + '\t' +  str(input_delly) + '\n'
        t2.append(output_line)
    elif input_split[9] == '?':
        output_line = '\t'.join(input_split[0:7]) + '\t' + '\t'.join(input_split[9:11]) + '\t' + '\t'.join(input_split[16:]) + '\t' +  str(input_delly) + '\n'
        gray.append(output_line)
    elif input_split[9] == 'F':
        output_line = '\t'.join(input_split[0:7]) + '\t' + '\t'.join(input_split[9:11]) + '\t' + '\t'.join(input_split[16:]) + '\t' +  str(input_delly) + '\n'
        fp.append(output_line)
    else:
        print 'exception'
        break
        
    input_line = input_file.readline().strip()

for i in tp:
    output_file.write(i)
for j in t2:
    output_file.write(j)
for k in gray:
    output_file.write(k)
for l in fp:
    output_file.write(l)

