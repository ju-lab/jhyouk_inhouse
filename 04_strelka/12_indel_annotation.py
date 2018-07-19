import sys
pwd_fn = sys.argv[1]
input_fn = sys.argv[2]

input_file = file(pwd_fn + '/' + input_fn + '/results/passed.somatic.indels.vcf')
output_file = file(pwd_fn + '/' + input_fn + '/results/passed.somatic.indels.vaf_annotated.vcf',"w")

input_line = input_file.readline()
while input_line[0:2] == '##':
    input_line = input_file.readline()

output_file.write(input_line.rstrip() + '\t' + 'length_indel' + '\t' + 'RU_indel' + '\t' + 'RC_indel' + '\t' + 'Vaf_tier1' + '\t' + 'Vaf_tier2' + '\n')
input_line = input_file.readline()
while input_line:
    input_split = input_line.split('\t')
    length_indel = 0
    length_indel = str(len(input_split[4]) - len(input_split[3]))
    RU_indel = 'error'
    RU_indel = input_split[7].split(';')[6][3:]
    RC_indel = input_split[7].split(';')[5][3:]
    Vaf_tier1 = 999
    Vaf_tier2 = 998
    Vaf_tier1 = float(input_split[10].split(':')[3].split(',')[0]) / (float(input_split[10].split(':')[2].split(',')[0]) + float(input_split[10].split(':')[3].split(',')[0]))
    Vaf_tier2 = float(input_split[10].split(':')[3].split(',')[1]) / (float(input_split[10].split(':')[2].split(',')[1]) + float(input_split[10].split(':')[3].split(',')[1]))

    if length_indel == 0 or RU_indel == 'error' or Vaf_tier1 == 999 or Vaf_tier2 == 998:
        print input_line
        break
    else:
        output_file.write(input_line.rstrip() + '\t' + length_indel + '\t'+ RU_indel +'\t' + RC_indel + '\t' + str(round(Vaf_tier1,2)) + '\t' + str(round(Vaf_tier2,2)) + '\n')

    input_line = input_file.readline()

print 'done'
