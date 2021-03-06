#!/bin/bash
sampleID=$1
motherID=$2
germlineID=$3

outDir=$(dirname $1)
log=$outDir/$1.indel.annot.log

echo $1 > $log

if false; then
echo "start: union of pass call in varscan2 somatic & strelka2"
(python 00_vcf_combination_by_Youk_indel.py $1 mouse 2 /home/users/jhyouk/06_mm10_SNUH_radiation/14_Strelka2/$1/results/variants/somatic.indels.vcf.gz /home/users/jhyouk/06_mm10_SNUH_radiation/09_varscan/$1.varscan.indel.somatic.vcf) &>> $log || { c=$?;echo "Error";exit $c; }
echo "done"
echo "annotation"
(sh sypark_PointMt_annot_filter/PointMt_annot.sh $1_indel_union_2.vcf /home/users/team_projects/Radiation_signature/02_bam/$1.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/$3.s.md.ir.br.bam sypark_PointMt_annot_filter/src) &>> $log || { c=$?;echo "Error";exit $c; }
echo "done"
echo "panel of normal annotation" #mouse b6_4
(python 02_AddNpanelToVCF_indel.py $1_indel_union_2.readinfo.readc.rasmy.vcf ../31_1_PanelOfNormal_SPark/mm10_b6_4_190226.4s.q0Q0.chr1.mpileup.indel.edit.gz pon) &>> $log || { c=$?;echo "Error";exit $c; }
#(python 02_AddNpanelToVCFsnp_vaf.py $1_indel_union_2.vcf.readinfo.readc.rasmy ../31_1_PanelOfNormal_SPark/mm10_balbc_7_190226.4s.q0Q0.chr1.mpileup.indel.edit.gz pon) &>> $log || { c=$?;echo "Error";exit $c; }
echo "done"
echo "filter1 using sample and germline information" 
(python 03_indel_filter1.py $1_indel_union_2.readinfo.readc.rasmy.vcf.pon) &>> $log || { c=$?;echo "Error";exit $c; } #b6
echo "done"
#from here, invitro culture only"
echo "annotation of mother cell info"
(sh sypark_PointMt_annot_filter/motherinfo_PointMt_annot.sh $1_indel_union_2.readinfo.readc.rasmy.pon.filter1.vcf /home/users/team_projects/Radiation_signature/02_bam/$1.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/$2.s.md.ir.br.bam sypark_PointMt_annot_filter/src) &>> $log || { c=$?;echo "Error";exit $c; }
echo "done"
fi

echo "filter2 using mother information"
(python 05_indel_filter2_motherinfo.py $1_indel_union_2.readinfo.readc.rasmy.pon.filter1.readc.rasmy.vcf /home/users/team_projects/Radiation_signature/02_bam/$1.s.md.ir.br.bam $1.mpileup.100kbcov.covstat /home/users/team_projects/Radiation_signature/02_bam/$2.s.md.ir.br.bam $2.mpileup.100kbcov.covstat) &>> $log || { c=$?;echo "Error";exit $c; }
echo "done"
