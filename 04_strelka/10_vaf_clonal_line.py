import sys
pwd_fn = sys.argv[1]
input_fn = sys.argv[2]

input_file = file(pwd_fn + '/' + input_fn + '/results/passed.somatic.snvs.vcf')
output_file = file(pwd_fn + '/' + input_fn + '/results/passed.somatic.snvs.vaf_annotated.vcf',"w")

input_line = input_file.readline()
while input_line[:2] == '##':
	input_line = input_file.readline()

output_file.write(input_line.rstrip()[1:] + '\t' + 'VaF' + '\n')
input_line = input_file.readline()
i=0
j=0

while input_line:
	i=0
	j=0

	input_split = input_line.split('\t')
        if input_split[3] == 'A':
		i=4
	elif input_split[3] == 'C':
		i=5
        elif input_split[3] == 'G':
		i=6
	elif input_split[3] == 'T':
		i=7
	else:
		print input_line
		break

        if input_split[4][0:1] == 'A':
                j=4
        elif input_split[4][0:1] == 'C':
                j=5
        elif input_split[4][0:1] == 'G':
                j=6
        elif input_split[4][0:1] == 'T':
                j=7
        else:
                print input_line
                break

	input_info=input_split[10].rstrip().split(':')
	ref = float(input_info[i].rstrip().split(',')[1])
	alt = float(input_info[j].rstrip().split(',')[1])
	Vaf = round(alt/(alt+ref),2)
	
	output_file.write(input_line.rstrip() + '\t' + str(Vaf) + '\n')
	input_line = input_file.readline()
