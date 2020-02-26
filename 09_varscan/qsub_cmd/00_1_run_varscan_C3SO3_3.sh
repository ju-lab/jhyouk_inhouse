#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/09_varscan/qsub_sdout/00_1_run_varscan_C3SO3_3.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/09_varscan
java -Xmx12g -jar /home/users/tools/varscan2.4.2/VarScan.v2.4.2.jar somatic ../06_mpileup/dirams_8by4Gy_germline.mpileup ../06_mpileup/C3SO3.mpileup C3SO3_dirams2.varscan --min-var-freq 0.01 --output-vcf 1 &> /dev/null