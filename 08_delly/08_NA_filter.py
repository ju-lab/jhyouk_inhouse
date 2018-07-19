#2018.07.18 DV+RV>=5 with somatic 'NA' => classify it as 'T2'
import sys
input_fn = sys.argv[1]
input_file = file(input_fn)
output_fn = input_fn + '.filter1'
output_file = file (output_fn,'w')

input_line = input_file.readline()
output_file.write('#CHROM'+'\t'+'POS'+'\t'+'Decision'+'\t'+'DV,RV,()'+'\t'+ input_line[1:])
input_line=input_file.readline()

tp = []
fp = []
gray = []
t2 = []
while input_line:
    output_line=''
    temp = ''
    temp1 = ''
    sum_SA = 0
    input_split=input_line.split('\t')
    input_somatic = input_split[11]
    input_somatic_softclip = []
    input_normal = input_split[12].rstrip()
    if input_normal !='NA':
        input_line = input_file.readline()
        continue
    else:
        if input_somatic == 'NA':
            temp1 = '0'
        else:
            input_somatic_list=input_split[11].split(',')
            for i in input_somatic_list:
                temp = i.split('(')[1].split(')')[0]
                sum_SA += int(temp)
                input_somatic_softclip.append(temp)
                temp1 = temp1 + temp + ':'

    input_somatic_DV = int(input_split[9].split(':')[9])
    input_somatic_RV = int(input_split[9].split(':')[11])

    input_type = input_split[2][0:3]
    tf = '.'

    if input_somatic_DV + input_somatic_RV >= 5:
        if input_somatic =='NA':
            tf='T2'
            output_line = input_split[0] + '\t' + input_split[1] + '\t' + tf + '\t' + str(input_somatic_DV)+','+str(input_somatic_RV)+','+ temp1 +'\t'+input_line
            t2.append(output_line)
        elif input_somatic_DV + input_somatic_RV >=10:
            tf = 'T'       
            output_line = input_split[0] + '\t' + input_split[1] + '\t' + tf + '\t' + str(input_somatic_DV)+','+str(input_somatic_RV)+','+ temp1 +'\t'+input_line
            tp.append(output_line)
        else:
            tf = 'T2'
            output_line = input_split[0] + '\t' + input_split[1] + '\t' + tf + '\t' + str(input_somatic_DV)+','+str(input_somatic_RV)+','+ temp1 +'\t'+input_line
            t2.append(output_line)

    elif input_type != 'DEL' and input_somatic_DV + input_somatic_RV >=2:
        tf = '?'
        output_line = input_split[0] + '\t' + input_split[1] + '\t' + tf + '\t' + str(input_somatic_DV)+','+str(input_somatic_RV)+','+temp1 +'\t'+input_line
        gray.append(output_line)
    elif input_type =='DEL' and input_somatic_DV + input_somatic_RV >=4:
        tf = '?'
        output_line = input_split[0] + '\t' + input_split[1] + '\t' + tf + '\t' + str(input_somatic_DV)+','+str(input_somatic_RV)+','+temp1 +'\t'+input_line
        gray.append(output_line)
    else:
        if sum_SA >= 2:
            tf = '?'
            output_line = input_split[0] + '\t' + input_split[1] + '\t' + tf + '\t' + str(input_somatic_DV)+','+str(input_somatic_RV)+','+temp1 +'\t'+input_line
            gray.append(output_line)
        else:
            tf = 'F' 
            output_line = input_split[0] + '\t' + input_split[1] + '\t' + tf + '\t' + str(input_somatic_DV)+','+str(input_somatic_RV)+','+temp1 +'\t'+input_line
            fp.append(output_line)
    
    input_line = input_file.readline()

for j in tp:
    output_file.write(j)
for m in t2:
    output_file.write(m)
for k in gray:
    output_file.write(k)
for l in fp:
    output_file.write(l)

