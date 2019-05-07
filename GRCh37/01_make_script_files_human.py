import sys
input_fn = sys.argv[1]
input_date = sys.argv[2] # 6digits ex>181120 for making run_script file
#input_fn = "181120_bam.txt"
#input_date = "181120"
input_file = file(input_fn)
output_06 = file("06_mpileup/00_1_run_mpileup_" + input_date + "_human_b37.sh",'w')
output_07 = file("07_sequenza/01_1_run_sequenza_" + input_date + "_human_b37.sh",'w')
output_08 = file("08_delly/01_run_Delly_" + input_date + "_human_b37.sh",'w')
output_09 = file("09_varscan/00_1_run_varscan_" + input_date + "_human_b37.sh",'w')
output_14 = file("14_Strelka2/00_1_run_strelka2_" + input_date + "_human_b37.sh",'w')
#output_15 = file("15_MuTect2/00_1_run_Mutect2_"+ input_date + "_human_b37.sh",'w')

input_line = input_file.readline().strip()
while input_line:
    input_somatic_bam = input_line.split('\t')[0]
    input_somatic = input_somatic_bam.split('.s')[0]
    input_germline_bam = input_line.split('\t')[1]
    input_germline = input_germline_bam.split('.s')[0]
    
    output_06.write("sh 00_human_b37_script_mpileup.sh " + input_somatic + '\n')  # Need to add new_germline
    output_07.write("sh 01_human_b37_flow_sequenza.sh /home/users/jhyouk/06_mm10_SNUH_radiation/GRCh37/06_mpileup " + input_somatic + " " + input_germline + '\n')
    output_08.write("sh 00_human_b37_Delly.sh /home/users/team_projects/Radiation_signature/05_bam_human_sample_GRCh37 " + input_somatic + " " + input_germline + '\n')
    output_09.write("sh 00_human_b37_varscan.sh /home/users/jhyouk/06_mm10_SNUH_radiation/GRCh37/06_mpileup "+ input_somatic + " " + input_germline + '\n')
    output_14.write("sh 00_human_b37_script.sh /home/users/team_projects/Radiation_signature/05_bam_human_sample_GRCh37/"+ input_germline_bam + " /home/users/team_projects/Radiation_signature/05_bam_human_sample_GRCh37/" + input_somatic_bam + " " + input_somatic + '\n')
    #output_15.write("sh 00_human_b37_script_Mutect2.sh " + input_somatic + " " + input_germline + '\n')
    
    input_line = input_file.readline().strip()


print 'The End'
    
    

