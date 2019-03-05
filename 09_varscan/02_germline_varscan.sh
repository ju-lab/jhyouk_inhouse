pwd_mpileup=$1
tumor=$2

java -Xmx12g -jar /home/users/tools/varscan2.4.2/VarScan.v2.4.2.jar mpileup2snp $1/$2.mpileup --min-var-freq 0.01 --output-vcf 1 1> $2.varscan.snp.germline.vcf 2> $2.varscan.snp.germline.out &
java -Xmx12g -jar /home/users/tools/varscan2.4.2/VarScan.v2.4.2.jar mpileup2indel $1/$2.mpileup --min-var-freq 0.01 --output-vcf 1 1> $2.varscan.indel.germline.vcf 2> $2.varscan.indel.germline.out
