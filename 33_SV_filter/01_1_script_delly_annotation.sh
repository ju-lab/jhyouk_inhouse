sampleID=$1
germlineID=$2

outputDir=$(dirname $1)
log=$outputDir/$1.sv.annotation.out

echo "Start annotation"
sh 01_Delly_annotation.sh $1.delly.vcf 10 /home/users/team_projects/Radiation_signature/02_bam/$1.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/$2.s.md.ir.br.bam 190225_delly_panelofnormal_1_9.vcf Delly_annotation_scripts &>> $log || { c=$?;echo "Error";exit $c; }
echo "done"

