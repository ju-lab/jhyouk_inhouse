java -Xmx12g -jar /home/users/tools/varscan2.4.2/VarScan.v2.4.2.jar somatic ../06_mpileup/dirams_8by1Gy_germline.mpileup ../06_mpileup/C3SO3.mpileup C3SO3_dirams8.varscan --min-var-freq 0.01 --output-vcf 1 &> /dev/null
java -Xmx12g -jar /home/users/tools/varscan2.4.2/VarScan.v2.4.2.jar somatic ../06_mpileup/dirams_20Gy_germline.mpileup ../06_mpileup/C3SO3.mpileup C3SO3_dirams20.varscan --min-var-freq 0.01 --output-vcf 1 &> /dev/null
java -Xmx12g -jar /home/users/tools/varscan2.4.2/VarScan.v2.4.2.jar somatic ../06_mpileup/dirams_8by4Gy_germline.mpileup ../06_mpileup/C3SO3.mpileup C3SO3_dirams2.varscan --min-var-freq 0.01 --output-vcf 1 &> /dev/null
java -Xmx12g -jar /home/users/tools/varscan2.4.2/VarScan.v2.4.2.jar somatic ../06_mpileup/dirams_lowdose_germline.mpileup ../06_mpileup/C3SO3.mpileup C3SO3_diramslow.varscan --min-var-freq 0.01 --output-vcf 1 &> /dev/null
java -Xmx12g -jar /home/users/tools/varscan2.4.2/VarScan.v2.4.2.jar somatic ../06_mpileup/Panc_8Gy1_BO.mpileup ../06_mpileup/C3SO3.mpileup C3SO3_Panc8.varscan --min-var-freq 0.01 --output-vcf 1 &> /dev/null
java -Xmx12g -jar /home/users/tools/varscan2.4.2/VarScan.v2.4.2.jar somatic ../06_mpileup/male_panc_L3BO.mpileup ../06_mpileup/C3SO3.mpileup C3SO3_male_low.varscan --min-var-freq 0.01 --output-vcf 1 &> /dev/null
