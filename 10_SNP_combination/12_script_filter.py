import sys
input_fn = sys.argv[1]
input_file = file(input_fn)
output_fn = input_fn + '.filtered'
output_file = file(output_fn,'w')
output_file_sig = file(output_fn+'.vcf','w')

def modify_line(in_line,tf1,vaf1):
	in_split = in_line.split('\t')
	in_split[2] = tf1
	in_split[5] = vaf1
	in_split[-1] = in_split[-1]+'\n'
	return '\t'.join(in_split)


input_line = input_file.readline().strip()
output_file.write(input_line + '\n')
output_file_sig.write(input_line + '\n')
input_line = input_file.readline().strip()

false_read = []
t2_position = []
false_germline_var = []
false_indel_somatic_low = []
t2_indel_somatic_low = []
t2_indel_somatic_low_gray = []
t2_indel_somatic_high = []
true_all = []

while input_line:
	tf = '.'
	input_split = input_line.split('\t')
	input_somatic_read = int(input_split[17].split(';')[0]) + int(input_split[17].split(';')[1])
	input_var_position_lt = float(input_split[19].split(';')[1])
	input_var_position_rt = float(input_split[19].split(';')[4])
	input_germline_var = float(input_split[24].split(';')[1])
	input_somatic_ins_var = float(input_split[21].split(';')[3])
	input_somatic_ins_var_read = float(input_split[21].split(';')[2])
	input_somatic_del_var = float(input_split[22].split(';')[3])
	input_somatic_del_var_read = float(input_split[22].split(';')[2])
	try:
		input_somatic_ins_ref = float(input_split[21].split(';')[1])
		input_somatic_ins_ref_read = float(input_split[21].split(';')[0])
	except:
		input_somatic_ins_ref = 0.0
		input_somatic_ins_ref_read = 0.0
	try:
		input_somatic_del_ref = float(input_split[22].split(';')[1])
		input_somatic_del_ref_read = float(input_split[22].split(';')[0])
	except:
		input_somatic_del_ref = 0.0
		input_somatic_del_ref_read = 0.0
	try:
		input_germline_ins_ref = float(input_split[28].split(';')[1])
		input_germline_ins_ref_read = float(input_split[28].split(';')[0])
	except:
		input_germline_ins_ref = 0.0
		input_germline_ins_ref_read = 0.0
	try:
		input_germline_del_ref = float(input_split[29].split(';')[1])
		input_germline_del_ref_read = float(input_split[29].split(';')[0])
	except:
		input_germline_del_ref = 0.0
		input_germline_del_ref_read = 0.0
	input_vaf = str(round(float(input_split[17].split(';')[1])/(float(input_split[17].split(';')[0])+float(input_split[17].split(';')[1])),2))
	delta_ins = max([abs(input_somatic_ins_var - input_somatic_ins_ref),abs(input_somatic_ins_var - input_germline_ins_ref)])
	delta_del = max([abs(input_somatic_del_var - input_somatic_del_ref),abs(input_somatic_del_var - input_germline_del_ref)])
	
	if input_somatic_read < 10:
		tf = 'F_read'
		false_read.append(modify_line(input_line,tf,input_vaf))
	elif input_germline_var >=2:
		tf = 'F_germline_var'
		false_germline_var.append(modify_line(input_line,tf,input_vaf))
	elif input_somatic_ins_var < 5 and (input_somatic_ins_ref_read >5 or input_germline_ins_ref_read >5):
		tf = 'F_indel_low'
		false_indel_somatic_low.append(modify_line(input_line,tf,input_vaf))
	elif input_somatic_del_var < 5 and (input_somatic_del_ref_read >5 or input_germline_del_ref_read >5):
		tf = 'F_indel_low'
		false_indel_somatic_low.append(modify_line(input_line,tf,input_vaf))
	elif input_somatic_ins_var == input_somatic_del_var == input_somatic_ins_ref == input_somatic_del_ref == input_germline_ins_ref == input_germline_del_ref == 0:
		tf = 'T'
		true_all.append(modify_line(input_line,tf,input_vaf))	
		if float(input_vaf) >=0.3:
			output_file_sig.write(modify_line(input_line,tf,input_vaf))
	elif input_somatic_ins_var < 5 and ((input_somatic_ins_ref > 15 and input_somatic_ins_ref_read >3) or (input_germline_ins_ref>15 and input_germline_ins_ref_read > 3)):
		tf = 'T2_indel_low_gray'
		t2_indel_somatic_low_gray.append(modify_line(input_line,tf,input_vaf))
	elif input_somatic_del_var < 5 and ((input_somatic_del_ref >15 and input_somatic_del_ref_read >3) or (input_germline_del_ref >15 and input_germline_del_ref_read > 3)):
		tf = 'T2_indel_low_gray'
		t2_indel_somatic_low_gray.append(modify_line(input_line,tf,input_vaf))
	elif 5 <= input_somatic_ins_var and input_somatic_ins_var <=25 and delta_ins > 15:
		tf = 'T2_indel_low'
		t2_indel_somatic_low.append(modify_line(input_line,tf,input_vaf))
	elif 5 <= input_somatic_del_var and input_somatic_del_var <=25 and delta_del > 15:
		tf = 'T2_indel_low'
		t2_indel_somatic_low.append(modify_line(input_line,tf,input_vaf))
	elif input_somatic_ins_var > 25 or input_somatic_del_var > 25:
		tf = 'T2_indel_high'
		t2_indel_somatic_high.append(modify_line(input_line,tf,input_vaf))
	elif input_var_position_lt > 130 or input_var_position_lt < 20 or input_var_position_rt > 130 or input_var_position_rt < 20:
		tf = 'T2_position'
		t2_position.append(modify_line(input_line,tf,input_vaf))
	else:
		tf = 'T'
		true_all.append(modify_line(input_line,tf,input_vaf))
		if float(input_vaf) >=0.3:
			output_file_sig.write(modify_line(input_line,tf,input_vaf))

	input_line = input_file.readline().strip()

for i1 in true_all:
	output_file.write(i1)
for i7 in t2_indel_somatic_low_gray:
	output_file.write(i7)
for i2 in t2_indel_somatic_low:
	output_file.write(i2)
for i4 in t2_indel_somatic_high:
	output_file.write(i4)
for i6 in t2_position:
	output_file.write(i6)
for i5 in false_read:
	output_file.write(i5)
for i8 in false_germline_var:
	output_file.write(i8)
for i3 in false_indel_somatic_low:
	output_file.write(i3)

