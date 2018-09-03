import sys
input_fn = sys.argv[1]
input_file = file(input_fn)
output_fn = input_fn.replace(".vcf",".somatic.vcf")
output_file = file(output_fn,'w')

input_line = input_file.readline()
while input_line[0:1] == '#':
	output_file.write(input_line)
	input_line = input_file.readline()

while input_line:
    input_split = input_line.split('\t')
    input_somatic = int(input_split[10].split(':')[4])
    input_germline = int(input_split[9].split(':')[4])
    if input_somatic >=3 and input_germline <2:
        output_file.write(input_line)
    input_line = input_file.readline()
