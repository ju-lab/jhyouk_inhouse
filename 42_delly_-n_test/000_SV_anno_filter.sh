sampleID=$1
sample_bam=$2 #(/home/users/team_projects/Radiation_signature/02_bam/$1.s.md.ir.br.bam)
germline_bam=$3
delly_pon=$4
mother_bam=$5

outputDir=$(dirname $1)
log=$outputDir/$1.sv.annotation.out

echo $1 $2 > $log
echo "Start annotation"
(sh /home/users/jhyouk/06_mm10_SNUH_radiation/33_SV_filter/01_Delly_annotation.sh $1.delly.vcf 10 $2 $3 $4 /home/users/jhyouk/06_mm10_SNUH_radiation/33_SV_filter/Delly_annotation_scripts) &>> $log || { c=$?;echo "Error";exit $c; }
echo "done"

echo "filter1 start"
(python /home/users/jhyouk/06_mm10_SNUH_radiation/33_SV_filter/02_SV_filter1.py $1 ) &>> $log || { c=$?;echo "Error";exit $c; }
echo "filter1 done"

if false; then
#from here for invitro culture
echo "mother_info annotation"
(python /home/users/jhyouk/06_mm10_SNUH_radiation/33_SV_filter/Delly_annotation_scripts/21.mother_count_frag_find_newBP.py $1.delly.somatic.annotated.filter1.vcf $5 $3) &>> $log || { c=$?;echo "Error";exit $c; }
echo "mother_info done"
echo "filter2"
(python /home/users/jhyouk/06_mm10_SNUH_radiation/33_SV_filter/03_filter2_mother_info.py $1.delly.somatic.annotated.filter1.motherinfo.vcf ) &>> $log || { c=$?;echo "Error";exit $c; }
echo "filter2 done"
echo "Need mother_subtraction using 04_mother_subtraction.ipynb"
fi

#from there for invivo culture
echo "06_invivo_column_Rearrange_afterfilter1"
(python /home/users/jhyouk/06_mm10_SNUH_radiation/33_SV_filter/06_invivo_rearrange.py $1.delly.somatic.annotated.filter1.vcf) &>> $log || { c=$?;echo "Error";exit $c; }
echo "06 done"
