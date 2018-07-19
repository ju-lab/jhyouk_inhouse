pwd_mpileup=$1
normal=$2
tumor=$3

java -Xmx12g -jar /home/users/tools/varscan2.4.2/VarScan.v2.4.2.jar somatic $1/$2.mpileup $1/$3.mpileup $3.varscan --min-var-freq 0.01 --output-vcf 1 &> $3.varscan.out
