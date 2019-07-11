sampleID=$1
germlineID=$2

sh sypark_PointMt_annot_filter/PointMt_annot.sh $1_union_2.vcf /home/users/team_projects/Radiation_signature/02_bam/$1.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/$2.s.md.ir.br.bam sypark_PointMt_annot_filter/src &> $1.annotation.out && mv $1.annotation.out $1.annotation.success
