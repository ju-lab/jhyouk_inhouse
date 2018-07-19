import sys
input_fn = sys.argv[1]
input_file = file(input_fn)
output_fn = input_fn.replace(".vcf",".somatic.vcf")
output_file = file(output_fn,'w')

input_line = input_file.readline()
while input_line[0:2] == '##':
    input_line = input_file.readline()
output_file.write(input_line)
input_line = input_file.readline()

while input_line:
    input_split = input_line.split('\t')
    input_somatic = input_split[9].split(':')[0]
    input_germline = input_split[10].split(':')[0]
    dvrv = int(input_split[10].split(':')[9]) + int(input_split[10].split(':')[11].rstrip())
    if input_somatic =='0/1' and input_germline == '0/0' and dvrv == 0:
        output_file.write(input_line)
    input_line = input_file.readline()
